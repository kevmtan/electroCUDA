function x = ecc_filtfilt(x,coef)
% arguments
%     x (:,:) double
%     coef(1,:) double
% end
coder.gpu.kernelfun; % Add kernelfun pragma to trigger kernel creation
%nChs = width(x);

x = filtfilt(coef,1,x);


% % filtfilt
% coder.gpu.kernel(nChs,-1)
% for ch = 1:nChs
%      x(:,ch) = filtfilt(coef,1,x(:,ch));
% end