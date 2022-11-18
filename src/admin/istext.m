function y = istext(x)
if ischar(x) || isstring(x) || iscellstr(x)
    y = true;
else
    y = false;
end
