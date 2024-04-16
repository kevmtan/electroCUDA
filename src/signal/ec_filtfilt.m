function x = ec_filtfilt(x,b,o)
%% [ec_filtfilt] Filter timeseries with no phase distortiion (zero-phase)
% Modification of Matlab's filtfilt() for threadpools, gpuArrays & CUDA MEX

% Input validation
arguments
    x {mustBeFloat}
    b {isfloat,isa(b,"digitalFilter")}
    o.single (1,1) logical = false
    o.gpu (1,1) string {mustBeMember(o.gpu,["no" "matlab" "cuda"])} = "no"
    o.mem double = []
end

%% Prep
if isgpuarray(x); o.gpu=true; end
if isa(b,"digitalFilter") && o.gpu; b=b.Coefficients; end
if o.single; x=single(x); end % Convert to single if needed
sz = cast(size(x),like=x);
if numel(sz)>2; x=x(:,:); end % Reshape to 2D
fin = 0;

%% Get initial variables
if ~isa(b,"digitalFilter")
    [b,a,z,nf,L] = getInit_lfn(b,1,sz(1));
    b=cast(b,like=x); a=cast(a,like=x); z=cast(z,like=x); nf=cast(nf,like=x);
    L=cast(L,like=x);
end

%% Run compiled CUDA binary
if o.gpu=="cuda"
    try
        if isa(x,"single")
            x = ec_filtfilt1_fp32(x,b,a,z,nf,L);
        else
            x = ec_filtfilt1_fp64(x,b,a,z,nf,L);
        end
        fin = 1;
    catch ME; getReport(ME)
    end
end

%% Run as gpuArrayFun
if ~fin && o.gpu~="no"
    try
        x = gpuArrayFun_lfn(x,b,a,z,nf,L);
        fin = 1;
    catch ME; getReport(ME)
    end
end

%% Run as CPU threadpool
if ~fin
    if isa(b,"digitalFilter")
        x = filtfilt(b,x);
    else
        parfor ch = 1:width(x)
            x(:,ch) = ec_filtfilt_fp(x(:,ch),b,a,z,nf,L);
        end
    end
end

if numel(sz)>2
    x = reshape(x,sz);
end




%% getInit_lfn %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [b1,a1,z1,nf,L] = getInit_lfn(b,a,nFrames)
[L, ncols] = size(b);
na = numel(a);

% Rules for the first two inputs to represent an SOS filter: b is an
% Lx6 matrix with L>1 or, b is a 1x6 vector, its 4th element is equal
% to 1 and a has less than 2 elements.
if ncols==6 && L==1 && na<=2
    if b(4)==1
        coder.internal.warning('signal:filtfilt:ParseSOS', 'SOS', 'G');
    else
        coder.internal.warning('signal:filtfilt:ParseB', 'a01', 'SOS');
    end
end
issos = ncols==6 && (L>1 || (b(4)==1 && na<=2));

cdt = zeros('like',b)+zeros('like',a);
z1 = coder.nullcopy(zeros(2,L,'like',cdt));
coder.varsize('b1','a1');

if issos
    %------------------------------------------------------------------
    % b is an SOS matrix, a is a vector of scale values
    %------------------------------------------------------------------
    g = a(:);
    ng = na;

    coder.internal.assert(ng <= L+1,'signal:filtfilt:InvalidDimensionsScaleValues', L + 1)

    sosMat = cast(b,'like',cdt);

    if ng == L+1
        % Include last scale value in the numerator part of the SOS
        % Matrix
        sosMat(L,1:3) = g(L+1)*b(L,1:3);
        ng = ng-1;
    end

    for ii=1:ng
        % Include scale values in the numerator part of the SOS Matrix
        sosMat(ii,1:3) = g(ii)*b(ii,1:3);
    end
    ord = filtord(sosMat);

    % Get second order section coefficients. Ensure a0 for each filter
    % is normalized to 1
    coder.internal.errorIf(any(sosMat(:,4) == 0),'signal:filtfilt:ZeroA0CoeffsSOS');

    a0 = sosMat(:,4:6).';
    b0 = sosMat(:,1:3).';
    s = a0([1 1 1],:);
    a1 = a0./s;
    b1 = b0./s;

    % length of edge transients
    nf = max(1,3*ord);

    % input data too short
    coder.internal.errorIf(nFrames <= nf(1,1),'signal:filtfilt:InvalidDimensionsDataShortForFiltOrder', nf(1,1));

    % Compute initial conditions to remove DC offset at beginning and
    % end of filtered sequence.  Use sparse matrix to solve linear
    % system for initial conditions zi, which is the vector of states
    % for the filter b(z)/a(z) in the state-space formulation of the
    % filter.
    for ii=1:L
        rhs  = (b1(2:3,ii) - b1(1,ii)*a1(2:3,ii));
        z1(:,ii) = ( eye(2,'like',cdt) - [-a1(2:3,ii),[1;0]] ) \ rhs;
    end
else
    %------------------------------------------------------------------
    % b & a are vectors that define the transfer function of the filter
    %------------------------------------------------------------------

    coder.internal.errorIf((~isvector(a) || ~isvector(b)),'signal:filtfilt:InputNotSupported');
    L = 1;
    % Check coefficients - ensure a0 is 1
    coder.internal.errorIf(a(1) == 0,'signal:filtfilt:ZeroA0Coeffs');

    nb = numel(b);
    nfilt = max(nb,na);
    nf = max(1,3*(nfilt-1));  % length of edge transients

    % input data too short
    coder.internal.errorIf(nFrames <= nf(1,1),'signal:filtfilt:InvalidDimensionsDataShortForFiltOrder', nf(1,1));

    if coder.target('MATLAB')
        b1 = b(:)/a(1,1);
        a1 = a(:)/a(1,1);

        % Zero pad shorter coefficient vector as needed
        if nb < nfilt
            b1 = [b1; zeros(nfilt-nb,1)];
        elseif na < nfilt
            a1 = [a1; zeros(nfilt-na,1)];
        end
    else

        b1 = zeros(nfilt, 1, 'like', cdt);
        a1 = zeros(nfilt, 1, 'like', cdt);

        for k = 1:coder.internal.indexInt(numel(b))
            b1(k) = b(k)/a(1,1);
        end

        for k = 1:coder.internal.indexInt(numel(a))
            a1(k) = a(k)/a(1,1);
        end
    end

    % Compute initial conditions to remove DC offset at beginning and
    % end of filtered sequence.  Use sparse matrix to solve linear
    % system for initial conditions zi, which is the vector of states
    % for the filter b(z)/a(z) in the state-space formulation of the
    % filter.
    if nfilt>1
        useSparse = coder.target('MATLAB') || ~coder.internal.isCompiled || ...
            strcmp(eml_option('UseMalloc'),'VariableSizeArrays');
        if useSparse
            % The sparse solution makes use of dynamic memory
            % allocation during code generation
            rows = [1:nfilt-1, 2:nfilt-1, 1:nfilt-2];
            cols = [ones(1,nfilt-1), 2:nfilt-1, 2:nfilt-1];
            vals = [1+a1(2,1), a1(3:nfilt,1).', ones(1,nfilt-2), -ones(1,nfilt-2)];
            rhs  = b1(2:nfilt,1) - b1(1,1)*a1(2:nfilt,1);
            % sparse function does not support single precision hence
            % casting to double
            z1 = sparse(rows,cols,double(vals)) \ double(rhs);
            z1 = cast(z1,'like',cdt);
        else
            % The non-sparse solution to zi may be computed using:
            z1 = ( eye(nfilt-1,'like',cdt) - [-a1(2:nfilt,1), [eye(nfilt-2,'like',cdt); ...
                zeros(1,nfilt-2,'like',cdt)]] ) \ ( b1(2:nfilt,1) - b1(1,1)*a1(2:nfilt,1) );
        end
    else
        z1 = zeros(0,1,'like',cdt);
    end
end



%% filtfilt_lfn %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function x = gpuArrayFun_lfn(x,b,a,z,nf,L)
x = num2cell(x,1);

% Transfer to GPU
x = cellfun(@gpuArray,x,UniformOutput=false);
b=gpuArray(b); a=gpuArray(a); z=gpuArray(z); nf=gpuArray(nf); L=gpuArray(L);

% Run
x = arrayfun(@(xx) ec_filtfilt_fp(xx{:},b,a,z,nf,L), x,UniformOutput=false);

% Finalize
x = cellfun(@gather,x,UniformOutput=false);
x = horzcat(x{:});

%% Depreciated
% function [b,a,z,nfact,L] = getInit_lfn(b,a,nFrames)
% [L, ncols] = size(b);
% na = numel(a);
% cdt = zeros('like',b)+zeros('like',a);
% z = coder.nullcopy(zeros(2,L,'like',cdt));
%
% % Rules for the first two inputs to represent an SOS filter: b is an
% % Lx6 matrix with L>1 or, b is a 1x6 vector, its 4th element is equal
% % to 1 and a has less than 2 elements.
% if ncols==6 && L==1 && na<=2
%     if b(4)==1
%         coder.internal.warning('signal:filtfilt:ParseSOS', 'SOS', 'G');
%     else
%         coder.internal.warning('signal:filtfilt:ParseB', 'a01', 'SOS');
%     end
% end
% issos = ncols==6 && (L>1 || (b(4)==1 && na<=2));
%
%
% if issos
%     %% b is SOS matrix, a is vector of scale values
%     a = a(:);
%     coder.internal.assert(na<=L+1,'signal:filtfilt:InvalidDimensionsScaleValues',L+1)
%
%     % Include last scale value in the numerator part of the SOS matrix
%     sosMat = cast(b,'like',cdt);
%     if na == L+1
%         sosMat(L,1:3) = a(L+1)*b(L,1:3);
%         na = na-1;
%     end
%
%     % Include scale values in the numerator part of the SOS Matrix
%     for ii = 1:na
%         sosMat(ii,1:3) = a(ii)*b(ii,1:3);
%     end
%     ord = filtord(sosMat);
%
%     % Get second order section coefficients. Ensure a0 for each filter is normalized to 1
%     coder.internal.errorIf(any(sosMat(:,4) == 0),'signal:filtfilt:ZeroA0CoeffsSOS');
%
%     a0 = sosMat(:,4:6).';
%     b0 = sosMat(:,1:3).';
%     s = a0([1 1 1],:);
%     a = a0./s;
%     b = b0./s;
%
%     % length of edge transients
%     nfact = max(1,3*ord);
%
%     % input data too short
%     coder.internal.errorIf(nFrames <= nfact(1,1),'signal:filtfilt:InvalidDimensionsDataShortForFiltOrder', nfact(1,1));
%
%     % Compute initial conditions to remove DC offset at beginning and
%     % end of filtered sequence.  Use sparse matrix to solve linear
%     % system for initial conditions zi, which is the vector of states
%     % for the filter b(z)/a(z) in the state-space formulation of the
%     % filter.
%     for ii = 1:L
%         rhs  = (b(2:3,ii) - b(1,ii)*a(2:3,ii));
%         z(:,ii) = (eye(2,'like',cdt) - [-a(2:3,ii),[1;0]]) \ rhs;
%     end
% else
%     %% b & a are vectors that define transfer function
%     L = 1;
%     nb = numel(b);
%     nfilt = max(nb,na);
%     nfact = max(1,3*(nfilt-1));  % length of edge transients
%
%     % Check for errors
%     coder.internal.errorIf((~isvector(a) || ~isvector(b)),'signal:filtfilt:InputNotSupported');
%     coder.internal.errorIf(a(1)==0,'signal:filtfilt:ZeroA0Coeffs'); % Check coefficients - ensure a0 is 1
%     coder.internal.errorIf(nFrames<=nfact(1,1),... % Input data too oshort
%         'signal:filtfilt:InvalidDimensionsDataShortForFiltOrder',nfact(1,1));
%
%     if coder.target('MATLAB')
%         b = b(:)/a(1,1);
%         a = a(:)/a(1,1);
%
%         % Zero pad shorter coefficient vector as needed
%         if nb < nfilt
%             b = [b; zeros(nfilt-nb,1)];
%         elseif na < nfilt
%             a = [a; zeros(nfilt-na,1)];
%         end
%     else
%         b = zeros(nfilt, 1, 'like', cdt);
%         a = zeros(nfilt, 1, 'like', cdt);
%
%         for k = 1:coder.internal.indexInt(numel(b))
%             b(k) = b(k)/a(1,1);
%         end
%
%         for k = 1:coder.internal.indexInt(numel(a))
%             a(k) = a(k)/a(1,1);
%         end
%     end
%
%     % Compute initial conditions to remove DC offset at beginning and
%     % end of filtered sequence.  Use sparse matrix to solve linear
%     % system for initial conditions zi, which is the vector of states
%     % for the filter b(z)/a(z) in the state-space formulation of the
%     % filter.
%     if nfilt>1
%         useSparse = coder.target('MATLAB') || ~coder.internal.isCompiled || ...
%             strcmp(eml_option('UseMalloc'),'VariableSizeArrays');
%         if useSparse
%             % The sparse solution makes use of dynamic memory
%             % allocation during code generation
%             rows = [1:nfilt-1, 2:nfilt-1, 1:nfilt-2];
%             cols = [ones(1,nfilt-1), 2:nfilt-1, 2:nfilt-1];
%             vals = [1+a(2,1), a(3:nfilt,1).', ones(1,nfilt-2), -ones(1,nfilt-2)];
%             rhs  = b(2:nfilt,1) - b(1,1)*a(2:nfilt,1);
%             % sparse function does not support single precision hence
%             % casting to double
%             z = sparse(rows,cols,double(vals)) \ double(rhs);
%             z = cast(z,'like',cdt);
%         else
%             % The non-sparse solution to zi may be computed using:
%             z = (eye(nfilt-1,'like',cdt) - [-a(2:nfilt,1), [eye(nfilt-2,'like',cdt); ...
%                 zeros(1,nfilt-2,'like',cdt)]]) \ (b(2:nfilt,1) - b(1,1)*a(2:nfilt,1));
%         end
%     else
%         z = zeros(0,1,'like',cdt);
%     end
% end

