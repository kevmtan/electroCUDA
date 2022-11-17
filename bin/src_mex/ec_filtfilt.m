function xx = ec_filtfilt(x,coef)
% Add kernelfun pragma to trigger kernel creation
coder.gpu.kernelfun;
%nCh = size(x,2);
%xx = coder.nullcopy(zeros(size(x)));

%% Zero-phase filtering
xx = filtfilt(coef,1,x);

% coder.gpu.kernel();
% for ch = 1:nCh
%    xx(:,ch) = filtfilt(coef,1,x(:,ch));
% end
