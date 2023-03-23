function eh=drawEllipse2D(M,m)
%Draws a 2D ellipse given by %(x-m)'*M*(x-m)=1 on current axes. M bust be a
%postivie semi-definite matrix for it to work properly.
if nargin<1 || isempty(M)
    M=eye(2);
end
if nargin<2 || isempty(m)
    m=zeros(2,1);
end
th=[0:.01:2*pi,0];
x=sin(th);
y=cos(th);
a=sqrt(1./sum([x;y].*(M*[x;y])));
eh=plot(a.*x+m(1),a.*y+m(2));
end