function [z,b] = ec_regw(y,x,w)
%[b,z]=nt_regw(y,x,w) - weighted regression
%
%  b: regression matrix (apply to x to approximate y)
%  z: regression (x*b)
%
%  y: data
%  x: regressor
%  w: weight to apply to y
%
%  w is either a matrix of same size as y, or a column vector to be applied
%  to each column of y
%
% NoiseTools

thr_PCA = 0.0000001; % discard dimensions of x with eigenvalue lower than this

if nargin<3; w = []; end
if nargin<2; error('!'); end

%% check/fix sizes
m = size(y,1);
x = ec_unfold(x);
y = ec_unfold(y);
if size(x,1) ~= size(y,1)
    disp(size(x)); disp(size(y)); error('!'); 
end

%% save weighted mean
mn = y - ec_demean(y,w);


%% Fit basis function
if isempty(w)
    % simple regression
    xx = ec_demean(x);
    yy = ec_demean(y);
    [V,D] = eig(xx'*xx);
    V = real(V);
    D = real(D);
    topcs = V(:,D/max(D) > thr_PCA); % discard weak dims
    xxx = xx*topcs;
    b = ((yy'*xxx) / (xxx'*xxx))';
    z = ec_demean(x,w)*topcs*b;
    z = z + mn;
else
    % weighted regression
    if size(w,1)~=size(x,1); error('!'); end
    if size(w,2)==1
        % same weight for all channels
        if sum(w(:))==0
            error('weights all zero');
        end
        yy = ec_demean(y,w).*repmat(w,1,size(y,2));
        xx = ec_demean(x,w).*repmat(w,1,size(x,2));
        [V,D] = eig(xx'*xx);
        V = real(V);
        D = real(D);
        D = diag(D);
        topcs = V(:,D/max(D) > thr_PCA); % discard weak dims
        xxx = xx*topcs;
        b = ((yy'*xxx) / (xxx'*xxx))';
        z = ec_demean(x,w)*topcs*b;
        z = z + mn;
    else
        % each channel has own weight
        if size(w,2) ~= size(y,2); error('!'); end
        z = zeros(size(y));
        b = zeros(flip(size(y)));
        for ch = 1:size(y,2)
            if sum(w(:,ch))==0; warning("All weights zero: ch"+ch); continue; end
            yy = ec_demean(y(:,ch),w(:,ch)) .* w(:,ch);
            x = ec_demean(x,w(:,ch)); % remove channel-specific-weighted mean from regressor
            xx = x .* repmat(w(:,ch),1,size(x,2));
            [V,D] = eig(xx'*xx);
            V = real(V);
            D = real(diag(D));
            topcs = V(:,D/max(D) > thr_PCA); % discard weak dims
            xxx = xx*topcs;
            b(ch,1:size(topcs,2)) = (yy'*xxx) / (xxx'*xxx);
            z(:,ch) = x*(topcs*b(ch,1:size(topcs,2))') + mn(:,ch);
        end

    end
end

z = ec_fold(z,m);
end


%% Subfunctions
% function [x,b,z] = regw_lfn(x,w,y,mn,thr_PCA)
% yy = ec_demean(y,w).*w;
% x = ec_demean(x,w); % remove channel-specific-weighted mean from regressor
% xx = x.*repmat(w,1,size(x,2));
% [V,D] = eig(xx'*xx);
% V = real(V);
% D = real(diag(D));
% topcs = V(:,D/max(D) > thr_PCA); % discard weak dims
% xxx = xx*topcs;
% b = ((yy'*xxx) / (xxx'*xxx))';
% z = x*topcs*b + mn;
% end
