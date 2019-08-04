function output = Apply_Filter(img, filter)
    img = im2uint8(img);
    u_filter = uint8(filter);
    filtered_img = zeros(size(img));
    
    for i = 1:size(img, 1)
        for q = 1:size(img, 2)
            filtered_img(i, q) = img(i, q) * u_filter(i, q);
        end
    end
    
    output = filtered_img;
end



%Shawn's filter
%function output = Apply_Filter(img, filter)
%    u_filter = uint8(filter);
    
%    filtered_img = zeros(size(img));
    
%    for i = 1:size(img, 1)
%        for q = 1:size(img, 2)
%            filtered_img(i, q) = img(i, q) * u_filter(i, q);
%        end
%    end
    
%    output = filtered_img;
%end
