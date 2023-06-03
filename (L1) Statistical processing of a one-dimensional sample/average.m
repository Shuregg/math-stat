function [aver] = average(X)
    n = max(size(X));

    aver = 0;
    for i = 1:1:n
        aver = aver + X(i);
    end
    aver = aver / n;
end