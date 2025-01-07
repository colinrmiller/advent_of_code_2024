% Solve day 4 part 1
% https://adventofcode.com/2024/day/4
addpath('../helpers');
import helpers.*;

function [solution] = partA()
    input = FileReaderHelper.read_input_chars_to_array("input.txt");
    solution = 0;
    r = size(input, 1);
    c = size(input, 2);
    searchArray = zeros(r, c, 4);

    % build search array
    for i = 1:r 
        for j = 1:c
            if input(i, j) == 'X'
                searchArray(i, j, 1) = 1;
            elseif input(i, j) == 'M'
                searchArray(i, j, 2) = 1;
            elseif input(i, j) == 'A'
                searchArray(i, j, 3) = 1;
            elseif input(i, j) == 'S'
                searchArray(i, j, 4) = 1;
            end
        end
    end

    for i = 1:r
        for j = 1:c
            if searchArray(i, j, 1) == 1
                % search for length 4 arrays in any of the 8 directions
                for k = 0:8
                    if k == 4
                        continue; % skip direction 0,0
                    end

                    dir = [1-fix(k/3),1-rem(k, 3)];

                    % check if the direction is valid
                    if (i+dir(1) > 0 && i+dir(1) <= r) && (j+dir(2) > 0 && j+dir(2) <= c)
                        if searchArray(i+dir(1), j+dir(2), 2) == 1
                            % check if the next letter is M
                            if (i+2*dir(1) > 0 && i+2*dir(1) <= r) && (j+2*dir(2) > 0 && j+2*dir(2) <= c)
                                if searchArray(i+2*dir(1), j+2*dir(2), 3) == 1
                                    % check if the next letter is A
                                    if (i+3*dir(1) > 0 && i+3*dir(1) <= r) && (j+3*dir(2) > 0 && j+3*dir(2) <= c)
                                        if searchArray(i+3*dir(1), j+3*dir(2), 4) == 1
                                            % check if the next letter is S
                                            solution = solution + 1;
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

function [solution] = partB()
    input = FileReaderHelper.read_input_chars_to_array("input.txt");
    solution = 0;
    r = size(input, 1);
    c = size(input, 2);
    searchArray = zeros(r, c, 3);

    % build search array
    for i = 1:r 
        for j = 1:c
            if input(i, j) == 'M'
                searchArray(i, j, 1) = 1;
            elseif input(i, j) == 'A'
                searchArray(i, j, 2) = 1;
            elseif input(i, j) == 'S'
                searchArray(i, j, 3) = 1;
            end
        end
    end

    for i = 2:r-1
        for j = 2:c-1
            % search for length 3 lines in any of the 4 directions starting at the middle array
            if searchArray(i, j, 2) == 1
                count = 0;
                for k = 0:3
                    dir = [1-2*fix(k/2),1-2*rem(k, 2)];

                    % check for 'M'
                    if searchArray(i-dir(1), j-dir(2), 1) == 1
                        % check for 'S'
                        if searchArray(i+dir(1), j+dir(2), 3) == 1
                            count = count + 1;
                        end
                    end
                end
                % if 2 of the 4 directions contains 'MAS' increment
                % solution
                if count > 1
                    solution = solution + 1;
                end
            end
        end
    end
end



disp(partA());
disp(partB());