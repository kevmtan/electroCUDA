function clim=nt_same_clim(h, clim)
%nt_same_clim(h,clim) - harmonize color limits of plots within figure
%
%  h: figure handle [default: current]
%  clim: color limits to impose

if nargin<1||isempty(h); h=gcf; end
if nargin<2; clim=[]; end

c=get(h,'children');

if isempty(clim)
    clims=[];
    for iC=1:numel(c)    
        cc=c(iC);
        try
            if ~isempty(get(cc,'clim'));
                clims=[clims; (get(cc,'clim'))];
            end
        end
    end
    clim=[min(clims(:)),max(clims(:))];
end

for iC=1:numel(c)    
    cc=c(iC);
    try
        set(cc,'clim',clim);
    end
end

        