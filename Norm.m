function output = Norm(array)
    minVal = min(min(array));
    maxVal = max(max(array));
    
    output = (array - minVal) ./ (maxVal - minVal);
end