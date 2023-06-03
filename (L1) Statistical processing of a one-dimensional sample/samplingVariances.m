function [S2_n, S2_0] = samplingVariances(X, P)
    X_size = size(X);
    P_size = size(P);
    
    if(X_size(1) == P_size(1) && X_size(2) == P_size(2))
       n = max(X_size);
       x_average = average(X);
       S2_n = 0;
       
       for i = 1:1:n
          S2_n = S2_n + (X(i) - x_average)^2;
       end
       S2_0 = S2_n / (n-1);
       S2_n = S2_n / n;
    else
        disp('Wrong size of matrix!')
        size(X)
        size(P)
        S2_n = 'err';
        S2_0 = 'err';
    end
end
