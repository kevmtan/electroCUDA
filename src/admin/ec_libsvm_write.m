function ec_libsvm_write(fn,x,y)
arguments
    fn string
    x (:,:) single
    y (:,1) single = zeros(height(x),1,"single");   
end

sz = size(x);
xx = string(1:sz(2))+":";
xx = repmat(xx,sz(1),1);
xx = xx+x;
xx = horzcat(string(y),xx);
writematrix(xx,fn,Delimiter="space",QuoteStrings="none");