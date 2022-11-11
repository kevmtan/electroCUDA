function x = ec_filtfilt(x,coef)
% Add kernelfun pragma to trigger kernel creation
coder.gpu.kernelfun;
%nCh = size(x,2);
%nFrames = size(x,1);
%x = x(:);
%xx = coder.nullcopy(zeros(size(x)));

%% Zero-phase filtering
x = filtfilt(coef,1,x);
%coder.gpu.kernel();
%parfor ch = 1:nCh
%    x(:,ch) = filtfilt(coef,1,x(:,ch));
%end
