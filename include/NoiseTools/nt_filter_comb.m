function [B,A] = nt_filter_comb(T,sign)
%[B,A] = nt_filter_comb(T,sign) - simple comb filter
%
% T: lag in samples (can be fractionary)
% sign: sign of second pulse, +1 or -1 [default: +1]
%
% NoiseTools

if nargin<1; error('!'); end
if nargin<2||isempty(sign); sign=1; end

A=1;
B=zeros(ceil(T),1);
B(1)=1;
frac=T-floor(T);
B(floor(T))=(1-frac)*sign;
if frac;
    B(floor(T)+1)=frac*sign;
end
