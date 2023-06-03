function [Mx] = mathExpect(X, P)
    X_size = size(X);
    P_size = size(P);
    
    if(X_size(1) == P_size(1) && X_size(2) == P_size(2))
        Mx = 0;
       for i = 1:1:max(X_size)
           Mx = Mx + X(i) * P(i);
       end
       
    else
        disp('Wrong size of matrixes!')
        size(X)
        size(P)
        Mx = 'err';
    end
end