function numOfElements = valueCounter(array)
 
unique_arr = unique(array);%массив содержащий уникальные элементы исходного
buff = zeros(size(unique_arr));%буфер для определения кол-ва каждого из уник. эл-ов
 
    for i = 1:1:length(unique_arr)
        counter = 0;  %счётчик текущего i-го элемента
        for j = 1:1:length(array)
            if(array(j) == unique_arr(i)) %если есть совпадение, счётчик увеличивается
                counter = counter + 1;
            end
        end
        buff(i) = counter; %записываем в буффер кол-во i-го элемента
    end
 
    numOfElements = buff; % вывод массива с количеством уникальных элементов (по возрастанию)
end