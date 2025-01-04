% Solve day 2 part 1
% https://adventofcode.com/2024/day/2
addpath('../helpers');
import helpers.*;

function [isSafe, isAscending, isDescending, hasProperJumps] = checkSafety(value, nextValue, isAscending, isDescending, hasProperJumps)
    if nextValue > value
        isDescending = false;
    end
    if nextValue < value
        isAscending = false;
    end
    if (abs(nextValue - value) < 1) || (abs(nextValue - value) > 3)
        hasProperJumps = false;
    end

    isSafe = ~((~isDescending & ~isAscending) | ~hasProperJumps);
end

function [answer] = partA()
    input = FileReaderHelper.read_input("input.txt");
    answer = 0;

    for i=1:size(input, 1)
        list = List(input(i, :));

        list = list.checkList();
        
        if list.isSafe
            answer = answer + 1;
        end
    end
end

function [answer] = partB()
    input = FileReaderHelper.read_input("test.txt");
    answer = 0;

    for i=1:size(input, 1)
        list = List(input(i, :));

        list = list.checkList(true);
        
        if list.isSafe
            answer = answer + 1;
        end
    end
end


disp(partA());
disp(partB());