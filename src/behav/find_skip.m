function [skip_onset, skip_offset] = find_skip(diod, thresh_dur, samp_rate)
%   If the default skip pulses are incorrect, find the right number.
%   -----------------------------------------
%   =^._.^=     Su Liu
%
%   suliu@standord.edu
%   -----------------------------------------


diod = diod/max(diod);
tmp = zeros(length(diod),1);
tmp(diod>0.3) = 1;

xx = diff(tmp);
onsets = find(xx==1); %onsets, no filtering
offsets = find(xx==-1);



onn_offsets = diff(offsets);
onn_onsets = diff(onsets);

n_initpulse_offset = find(onn_offsets<0.5*median(onn_offsets));
n_initpulse_offset = n_initpulse_offset(find(diff(n_initpulse_offset)<3)+1);

n_initpulse_onset = find(onn_onsets<0.5*median(onn_onsets));
n_initpulse_onset =  n_initpulse_onset(find(diff(n_initpulse_onset)<3)+1);

try
    skip_offset = n_initpulse_offset(end)+1;
    skip_onset = n_initpulse_onset(end)+1;
    if skip_offset >20 || skip_onset >20
        skip_offset = 0;
        skip_onset = 0;
    end
catch
    skip_offset = 0;
    skip_onset = 0;
end


% diod = diod/max(diod);
% tmp = zeros(length(diod),1);
% tmp(diod>0.3) = 1;
% 
% xx = diff(tmp);
% onsets = find(xx==1); %onsets, no filtering
% offsets = find(xx==-1);
% dur = offsets - onsets;
% ind = dur>=thresh_dur*samp_rate;
% onsets= onsets(ind);
% if length(onsets) ~= length(offsets)
%     if onsets(end) < offsets(end)
%         onsets(end) = [];
%     elseif onsets(1) < offsets(1)
%         offsets(1) = [];
%     end
% end
% onn = diff(onsets);
% 
% before = find(onn<0.5*median(onn));
% try
%     skip_before = before(end)+1;
%     if skip_before >20
%         skip_before = 0;
%     end
% catch
%     skip_before = 0;
% end










% ind = dur>=thresh_dur*samp_rate;
% onsets= onsets(ind);

% 
% while length(onsets) ~= length(offsets)
%     if onsets(end) > offsets(end)
%         onsets(end) = [];
%     elseif offsets(1) < onsets(1)
%         offsets(1) = [];
%     end
%     [length(onsets) length(offsets)]
% end
% 
% 
% dur = offsets - onsets;
% ind = dur>=thresh_dur*samp_rate;
% onsets= onsets(ind);
% 
% onn = diff(offsets);
% 
% before = find(onn<0.5*median(onn));
% before = before(diff(before)<3);





end
