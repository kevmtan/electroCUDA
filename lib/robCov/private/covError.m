function [e] = covError(covTrue,covEstim)
e=sqrt(sum(sum((covTrue-covEstim).^2,1),2))/norm(covTrue,'fro');
end

