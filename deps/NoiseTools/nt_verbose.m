function previous=nt_verbose(new)
%previous=nt_verbose(new) - set/get global verbose flag
%
%  previous: flag value currently stored
%
%  new: new flag value to store [default: same as previous]
%
% Usage:
%   if nt_verbose; display('feedback'); end % display feedback if flag on
% 
%   nt_verbose(1); % set flag to 1
%
%   previous=nt_verbose(1); % set flag after storing previous value
%   nt_verbose(previous); % restore previous value
%
% NoiseTools.

persistent verbose_flag;
if isempty(verbose_flag); verbose_flag=0; end

previous=verbose_flag;
if nargin==1
    verbose_flag=new;
end