% Solve day 1 part 1
% https://adventofcode.com/2024/day/1

function [sorted_col1, sorted_col2] = readAndSortColumns()
    fileID = fopen("input.txt", 'r');
    data = fscanf(fileID, '%d %d', [2 Inf])';
    fclose(fileID);
    
    col1 = data(:,1);
    col2 = data(:,2);
    
    sorted_col1 = sort(col1);
    sorted_col2 = sort(col2);
end

function freq_map = arrayToFrequencyMap(sorted_array)
    freq_map = containers.Map('KeyType', 'double', 'ValueType', 'double');
    
    if isempty(sorted_array)
        return;
    end
    
    current_num = sorted_array(1);
    count = 1;
    
    for i = 2:length(sorted_array)
        if sorted_array(i) == current_num
            count = count + 1;
        else
            freq_map(current_num) = count;

            current_num = sorted_array(i);
            count = 1;
        end
    end
    
    freq_map(current_num) = count;
end

function [value] = partA()
    [col1, col2] = readAndSortColumns();
    value = 0;

    for i = 1:length(col1)
        value = value + abs(col1(i) - col2(i));
    end
end

function [value] = partB()
    value = 0;
    [col1, col2] = readAndSortColumns();
    col2Dict = arrayToFrequencyMap(col2);

    for i = 1:length(col1)
        if isKey(col2Dict, col1(i))

            col2Reps = col2Dict(col1(i));
            value = value + col2Reps * col1(i);
        end
    end
end
% partA()
partB()
