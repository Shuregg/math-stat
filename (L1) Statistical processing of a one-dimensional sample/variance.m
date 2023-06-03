function [Dx] = variance(X, P)
    X_size = size(X);
    P_size = size(P);
    
    if(X_size(1) == P_size(1) && X_size(2) == P_size(2))
       Mx = mathExpect(X, P);
       Dx = 0;
       for i = 1:1:max(X_size)
            Dx = Dx + (X(i)^2) * (P(i));
       end
       
       Dx = Dx - Mx;
    else
        disp('Wrong size of matrixes!')
        size(X)
        size(P)
        Dx = 'err';
    end
end