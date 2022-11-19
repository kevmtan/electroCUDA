function x = ecu_filtfilt(x,coef)
% Add kernelfun pragma to trigger kernel creation
coder.gpu.kernelfun;
nCh = size(x,2);
ii = 1:size(x,1);
%xx = coder.nullcopy(zeros(size(x)));

%% Zero-phase filtering
for ch = 1:nCh
   x(ii,ch) = filtfilt(coef,1,x(ii,ch));
end
%xx = filtfilt(coef,1,x);


