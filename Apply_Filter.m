function output = Apply_Filter(img, filter)
    filtered_img = zeros(size(img));
    
    for i = 1:size(img, 1)
        for q = 1:size(img, 2)
            filtered_img(i, q) = img(i, q) * filter(i, q);
        end
    end
    
    output = filtered_img;
end