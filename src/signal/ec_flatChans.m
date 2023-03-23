function flatChs = ec_flatChans(x,fs,max_flatline_duration,max_allowed_jitter)
% Remove (near-) flat-lined channels.
% Signal = clean_flatlines(Signal,MaxFlatlineDuration,MaxAllowedJitter)
%
% This is an automated artifact rejection function which ensures that
% the data contains no flat-lined channels.
%
% In:
%   Signal : continuous data set, assumed to be appropriately high-passed (e.g. >0.5Hz or
%            with a 0.5Hz - 2.0Hz transition band)
%
%   MaxFlatlineDuration : Maximum tolerated flatline duration. In seconds. If a channel has a longer
%                         flatline than this, it will be considered abnormal. Default: 5
%
%   MaxAllowedJitter : Maximum tolerated jitter during flatlines. As a multiple of epsilon.
%                      Default: 20
%
% Out:
%   Signal : data set with flat channels removed
%
% Examples:
%   % use with defaults
%   eeg = clean_flatlines(eeg);
%
%                                Christian Kothe, Swartz Center for Computational Neuroscience, UCSD
%                                2012-08-30

% Copyright (C) Christian Kothe, SCCN, 2012, ckothe@ucsd.edu
%
% This program is free software; you can redistribute it and/or modify it under the terms of the GNU
% General Public License as published by the Free Software Foundation; either version 2 of the
% License, or (at your option) any later version.
%
% This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without
% even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
% General Public License for more details.
%
% You should have received a copy of the GNU General Public License along with this program; if not,
% write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
% USA

if ~exist('max_flatline_duration','var') || isempty(max_flatline_duration); max_flatline_duration = 5; end
if ~exist('max_allowed_jitter','var') || isempty(max_allowed_jitter); max_allowed_jitter = 20; end

if height(x) > width(x)
    x = x';
end

% flag channels
flatChs = false(height(x),1);
for c=1:height(x)
    zero_intervals = reshape(find(diff([false abs(diff(x(c,:)))<(max_allowed_jitter*eps) false])),2,[])';
    if max(zero_intervals(:,2) - zero_intervals(:,1)) > max_flatline_duration*fs
        flatChs(c) = true;
    end
end

% Marking
if all(flatChs)
    disp('Warning: all channels have a flat-line portion');
elseif any(flatChs)
    disp('Marking flat-line channels...');
end