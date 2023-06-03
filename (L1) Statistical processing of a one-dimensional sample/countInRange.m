function [n] = countInRange(x1, x2, arr)
    n = 0;
    for i = 1:1:size(arr)
       if( x1 <= arr(i) && arr(i) <= x2 )
          n = n + 1;
       end
    end
end