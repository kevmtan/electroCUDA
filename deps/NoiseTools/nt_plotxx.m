function [bstats,wstats]=nt_plotxx(fname,bounds,chans,imageflag)
%nt_plotxx(fname,bounds,chans) - plot using index file
%
%  fname: name of file to plot (or of its index file)
%  bounds: [start,stop] (s) range to plot [default: all]
%  chans: channels to plot [default: all]
% 
% Data are plotted using cheap data representation in index file.
% All channels are plotted unless specified. 
% The entire file is plotted unless specified.
% The mean of each channel (over entire data) is removed before plotting.
%
% A limited form of zooming and navigation is available using the arrow keys.
%
% NoiseTools

nt_greetings;

assert(nargin>0, '!');
if nargin<2; bounds=[]; end
if nargin<3; chans=[]; end
if nargin<4; imageflag=false; end

if ischar(fname) % file name
    [FILEPATH,NAME,EXT]=fileparts(fname);
    
    if isempty(FILEPATH) 
        FILEPATH='./'; 
        fname=[FILEPATH,filesep,fname];
    end
    
    disp(EXT)
    if ~strcmp(EXT,'.idxx') % must be data file, find index
        fname_data=fname;
        fname=[FILEPATH,filesep,'idxx',filesep,NAME,EXT,'.idxx'];
    end
    
    if 2~=exist(fname)
        disp('No index file found.  Create one.');
        if 2~=exist(fname_data)
            error('No data file either...');
        end
        disp('This may take a while...');
        tic;
        nt_idxx(fname);
        toc;
    end
    disp('read from file...'); tic;
    load(fname, '-mat', 'bstats', 'wstats'); % ignores 'cstats' and 'sstats'
    disp('done'); toc
    i=bstats;
    ii=wstats;
elseif iscell(fname) %  index struct
    i=fname{1};
    ii=fname{2};
else
    error('!');
end

if 2==exist('get_axes_width')  % tbd: replicate to remove dependency
    % estimate how many pixels fit within a window
    axes_width=get_axes_width(gca);
else
    warning('get_axes_width() not found');
    disp('Download https://www.mathworks.com/matlabcentral/fileexchange/40790-plot-big');
    axes_width=500;
end

% decode from int structure
if isempty(chans); chans=1:i.nchans; end
mn=nt_double2int(ii.min,{[],chans});
mx=nt_double2int(ii.max,{[],chans});
mnn=nt_double2int(ii.mean,{[],chans});

% remove mean from min and max for each channel
mn=bsxfun(@minus,mn,mean(mnn));
mx=bsxfun(@minus,mx,mean(mnn));

srr=i.sr/i.dsr;     % sampling rate

% select data within requested bounds (in seconds)
maxbound=(size(mn,1)-1)/srr;    % s, end of file
if ~maxbound;
    disp('warning: empty file');
    return
end
if isempty(bounds); bounds=[0,maxbound]; end
start=1+max(0,min(size(mn,1)-1, round(bounds(1)*srr)));
stop=1+max(0,min(size(mn,1)-1, round(bounds(2)*srr)));
mn=mn(start:stop,:);
mx=mx(start:stop,:);

% first display using 'plot'
if size(mx,1)<axes_width
    % running into the limits of the resolution of the index, we should go
    % to data file - tbd
end
if imageflag
    dsr=round(size(mx,1)/(axes_width));
    mmx=dsmmx(cat(3,mn,mx),dsr);
    mn=mmx(:,:,1); mx=mmx(:,:,2);
    srr=srr/dsr;
    % plot max-min range as image
    imagesc((mx-mn)');
else
    if size(mx,1)>axes_width*50
        % coalesce first if really big
        dsr=round(size(mx,1)/(axes_width*50));
        mmx=dsmmx(cat(3,mn,mx),dsr);
        mn=mmx(:,:,1); mx=mmx(:,:,2);
        srr=srr/dsr;
    end

    % plot as waveform
    zz1=mn; zz1(1:2:end,:)=mx(1:2:end,:);
    zz2=mn; zz2(2:2:end,:)=mx(2:2:end,:);
    yy=[mn; flipud(mx); zz1; flipud(zz2)]; 
    xx=[(0:size(mn,1)-1)' ; (size(mn,1)-1:-1:0)'; (0:size(mn,1)-1)' ; (size(mn,1)-1:-1:0)'];
    if bounds(1)+max(xx/srr)<3600
        plot(bounds(1)+xx/srr , yy); % plot min forward & max backward
        xlabel('time (s)');
        xlim(bounds);
    else 
        plot((bounds(1)+xx/srr)/3600 , yy); % plot min forward & max backward
        xlabel('time (h)');
        xlim(bounds/3600);
    end
    a=min(mn(:));
    b=max(mx(:));
    if b>a; ylim([a-(b-a)*0.1,b+(b-a)*0.1]); end

end
    
drawnow;

if 0
    % then write over with fill, better aspect, in principle, but slow
    hold on;
    if size(mx,1)>axes_width
        dsr=round(size(mx,1)/(axes_width));
        mmx=dsmmx(cat(3,mn,mx),dsr);
        mn=mmx(:,:,1); mx=mmx(:,:,2);
        srr=srr/dsr;
    end
    npoints=size(mn,1);
    X=bounds(1)+(0:npoints-1)'/srr;
    h=fill([X;flipud(X)],[mn;flipud(mx)], 'k', 'LineStyle', 'none');
    colororder=get(gca,'colororder');
    for iPatch=1:numel(h);
        h(iPatch).FaceColor=colororder(1+rem(iPatch-1,7),:);
        %h(iPatch).EdgeColor=colororder(1+rem(iPatch-1,7),:);
    end
    hold off
end
% 
% a=min(mn(:));
% b=max(mx(:));
% ylim([a-(b-a)*0.1,b+(b-a)*0.1])

% GUI
userdata.i=i;
userdata.ii=ii;
userdata.bounds=bounds;
set(gcf,'UserData',userdata);
%set(gcf, 'KeyPressFcn',@keyfunction)
end

function keyfunction(fig,eventDat) 
userdata=get(fig,'UserData');
b=userdata.bounds;
i=userdata.i;
ii=userdata.ii;
fname=i.fname; 
switch eventDat.Key
    case 'rightarrow'
        newbounds=[b(1)+(b(2)-b(1))*.5, b(1)+(b(2)-b(1))*1.5];
        disp(round([newbounds, diff(newbounds)]))
        nt_plotxx({i,ii},newbounds);
    case 'leftarrow'
        newbounds=[b(1)-(b(2)-b(1))*.5, b(1)+(b(2)-b(1))*.5];
         disp(round([newbounds, diff(newbounds)]))
        nt_plotxx({i,ii},newbounds);
    case 'uparrow'
        newbounds=[b(1)+(b(2)-b(1))*.25, b(1)+(b(2)-b(1))*.75];
         disp(round([newbounds, diff(newbounds)]))
       nt_plotxx({i,ii},newbounds);
    case 'downarrow'
        newbounds=[b(1)-(b(2)-b(1))*.5, b(1)+(b(2)-b(1))*1.5];
        disp(round([newbounds, diff(newbounds)]))
        nt_plotxx({i,ii},newbounds);
    otherwise
end
if nargout==0; 
    %just return stats
    clear bstats wstats; 
end
end



function y=dsmmx(mmx,dsr) % downsample min-max array
    assert(dsr<size(mmx,1), '!');
    assert(size(mmx,3)==2, '!');
    n=floor(size(mmx,1)/dsr);
    xtra=mmx(n*dsr+1:end,:,:); 
    mmx=mmx(1:n*dsr,:,:);
    [nsamples,nchans,~]=size(mmx);
    mmx=permute(mmx,[3 1 2]); % --> 2 X nsamples X nchans
    mmx=reshape(mmx, [dsr*2,nsamples/dsr, nchans]);
    mn=min(mmx); 
    mx=max(mmx);
    y=cat(3,shiftdim(mn,1),shiftdim(mx,1));
    % process xtra tbd
end
