function [y,tw]=nt_wpwr(x,w)
%[y,tweight]=nt_wpwr(x,w) - weighted power
%
%  y: weighted ssq of x
%  tweight: total weight
%
%  x: data
%  w: weight
%

if nargin<2; w=[]; end

if iscell(x);
    if ~isempty(w); error('not implemented'); end
    y=0; tw=0;
    for iTrial=1:numel(x)
        y=y+nt_wpwr(x{iTrial});
        tw=tw+size(x{iTrial},1);
    end
    return;
end

x=nt_unfold(x);
w=nt_unfold(w);

if isempty(w)
    y=sum(x(:).^2);
    tw=numel(x);
else
    x=nt_vecmult(x,w);
    y=sum(x(:).^2);
    tw=sum(w(:));
end

if nargout==0; 
    disp(num2str(y));
    clear y tweight
end