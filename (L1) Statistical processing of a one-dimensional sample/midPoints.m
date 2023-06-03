function [mids] = midPoints(x)
    size_x = size(x);
    n = max(size_x);   
    array = zeros(1, (n-1));
    for i = 1:1:n-1
        array(i) = (x(i) + x(i+1)) / 2;
    end
    mids = array;

end