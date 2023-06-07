clc; clear;
X = [13.2412291533284 22.7459361740644 -0.205363009592022 1.05828227443028 -2.72985099725213 10.094231465859 3.47582202566441 4.18025412642885 13.7517283035358 -6.60887647365981 11.489240445001 21.3341359873376 -0.0382875129856135 -4.94976364017314 18.1234877946281 -1.98581279197455 9.65941365588863 13.9442486241863 5.91862991795089 -6.26383153173474 -4.1523902031996 15.7951427334884 9.85479078979673 8.67518658005299 -9.38753013869102 23.6937791323226 -4.69729867111843 6.07388413875055 24.7182564746056 9.59763924989031 7.23660263618077 2.8674007012321 -3.61512853717142 18.6428576378922 -1.06868932457706 -0.70955887246984 4.49343431276244 1.92639851154489 2.10151312286222 -1.56049919172551 7.50830251663972 6.34241338328046 13.2629862553959 -2.71171564866184 8.8702810051634 9.61773883716106 5.66425091377702 8.48840434611646 7.74645207795784 17.7499427207833];
X_sort = sort(X);
alpha = 0.05;
n = max(size(X_sort)); 
n_points = 8; %количество точек. кол-во интервалов = кол-во точек - 1;
X_linspaced = linspace(X_sort(1), X_sort(n), n_points);
absFreq = zeros(1, n_points-1);
nLoopEnd = n_points-1;
for i = 1:1:length(absFreq)
    absFreq(i) = countInRange(X_linspaced(i), X_linspaced(i+1), X_sort);
    if(absFreq(i) < 5)
        flag = 1;
    end
end
absFreqOld = absFreq;
absFreq
if(flag)
    disp('На одном из отрезков значение частоты q < 5, необходимо объединить отрезок с соседним.')
     % absFreq = 5    10     7    15     5     4     4
end

X_linspacedNew = X_linspaced; 
len = length(absFreq);
flag = 1;
while(flag)
    absFreq = zeros(1, len);
    counter = 0;

    %for i = 1:1:len
    i = 1;
    while(i <= len)
        absFreq(i) = countInRange(X_linspacedNew(i), X_linspacedNew(i+1), X_sort);
        if(absFreq(i) < 5)
            if(i ~= len)
                X_linspacedNew(i+1) = [];
                
                len = len - 1;
                flag = 1;
                i = 0;
            else
                X_linspacedNew(i) = [];
                len = len - 1;
                flag = 1;
                i = 0;
            end
        else
            counter = counter + 1;
        end
        i = i + 1;
    end
    if(counter >= len)
        flag = 0;
    end
    
end

for i = 1:1:length(absFreq)
    if(absFreq(i) == 0)
        absFreq(i) = [];
    end
end
disp('Получаем новый ряд частот:')
absFreq
disp('С интервалами:')
X_linspacedNew
%С помощью таблицы значений функции Лапласа вычислим вероятности p(i) попадания случайной
%величины в каждый из интервалов выбранного разбиения, предположив, что она имеет нормальное распределение.

x_ = average(X)
s = sqrt(var(X, 1))

P =  zeros(1, length(X_linspacedNew)+1);
for i=1:1:length(P)
    if(i == 1)
        P(i) = normcdf(X_linspacedNew(i), x_, s);
    elseif (i == length(P))
        P(i) = 1 - normcdf(X_linspacedNew(i-1), x_, s);
    else
        i;
        if(i==7)
        end
        P(i) = normcdf(X_linspacedNew(i), x_, s) - normcdf(X_linspacedNew(i-1), x_, s);
    end
    
end
P %P = 0.030933757487691   0.067514310964656   0.139274893041471   0.207852739312484   0.224438166584471   0.175350025521182   0.139645863945967   0.014990243142078
sum(P) % ans = 1
%Найдём теоретические частоты q_(i) = n * P(i) = 50 * P(i)
q_ = zeros(1, length(P));
for i = 1:1:length(q_)
    q_(i) = n * P(i);
end
q_ % q_ = 1.546687874384575   3.375715548232787   6.963744652073574  10.392636965624181  11.221908329223544   8.767501276059109   6.982293197298356   0.749512157103877

Xi2s = 0;
for i = 1:1:length(absFreqOld)
    Xi2s = Xi2s + (absFreqOld(i) - q_(i))^2 / (q_(i));
end
Xi2s %Xi2s = 30.068012839319298
Xi2_095 = chi2inv(1-alpha, n) % Xi2 = 67.504806549541186
%Xi2s < Xi2_095 => X ~ N (Нет оснований отвергать гепотезу)
