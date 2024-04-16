function [y]=nt_3Dmat2cell(x) 
%[y]=3Dmat2cell(x) - convert 3D matrix to trial cell array
%
%  y: trial array (each trial is samples*trials)
%
%  x: matrix (samples * channels * trials)

if ~ndims(x)==3; error('!'); end

[nsamples,nchans,ntrials]=size(x);
y={};
for k=1:ntrials
    y{k}=x(:,:,k);
end
