function I =  make_binary(I_in)
I = I_in;
%imtool(I, 'DisplayRange', []);
% change to black & white outline
bg_color = 136;
threshold = 10;
for(i=1:size(I,1))
    for(j=1:size(I,2))
        if(I(i,j) < (bg_color + threshold) && I(i,j) > (bg_color-threshold))
        %if(I(i,j) == bg_color)
            I(i,j) = 255;
        else
            I(i,j) = 0;
        end
    end
end
% remove stray background pixels
for(i=2:size(I,1)-1)
    for(j=2:size(I,2)-1)
        if(I(i,j) && I(i-1,j) == 0 && I(i+1,j) == 0 && I(i,j+1) == 0 && ...
                I(i,j-1) == 0) % if surronded by black pixels
            I(i,j) = 0;
        end
    end
end
%imtool(I, 'DisplayRange', []);
area_t = 55;
% remove stray background pixels
for(i=2:size(I,1)-1)
    for(j=(area_t+1):size(I,2)-1)
        if(I(i,j) && ~I(i,j-1)) % background pixel bordered by black pixel, find area
            area = 0;
            max_prev = j;
            I2 = I;
            for(k=i:size(I,1)-1) % move down
                hit = 0;
                for(l=j:size(I,2)-1) % move to right
                    if ~I(k,l) && l > max_prev
                        max_prev = l;
                        hit = 1;
                        break;
                    end
                    area = area + 1;
                    %opennings = 1;
                    I2(k,l) = 0;
                end
                if ~hit
                    area = inf;
                    break;
                end
                if  k > i
                    break;
                end
            end
            % if small area, remove it
            if area < area_t
                I = I2;
            end
        end
    end
end
%imtool(I, 'DisplayRange', []);
