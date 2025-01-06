% Solve day 3 part 1
% https://adventofcode.com/2024/day/3
addpath('../helpers');
import helpers.*;

function [tokens, digits, positions] = find_mult_patterns(input)
    pattern = 'mul\((\d*),(\d*)\)';
    [~, positions] = regexp(input, pattern, 'match', 'start');
    [~,~,~,~,tokens] = regexp(input, pattern, 'match');
    digits = str2double(vertcat(tokens{:}));
end

function total = sum_cell_products(vec)
    total = 0;
    for i = 1:length(vec)
        total = total + str2double(vec{i}(1)) * str2double(vec{i}(2));
    end
end

function start_stops = build_start_stops(do_positions, dont_positions, length)
    start_stops = zeros(length, 1);
    state = 1;
    for i = 1:length
        if any(do_positions == i)
            state = 1;
        elseif any(dont_positions == i)
            state = 0;
        end

        start_stops(i) = state;
    end
end

function [solution] = partA()
    input = FileReaderHelper.read_input_to_list("input.txt");

    [matches, digits, ~] = find_mult_patterns(input);
    solution = sum_cell_products(matches);
end

function [solution] = partB()
    input = FileReaderHelper.read_input_to_list("test.txt");
    
    solution = 0;
    
    [matches, digits, mul_positions] = find_mult_patterns(input);

    do_regex_pattern = 'do\(\)';
    dont_regex_pattern = 'don\''t\(\)';
        
    [~,do_positions] = regexp(input, do_regex_pattern, 'match', 'start');
    [~,dont_positions] = regexp(input, dont_regex_pattern, 'match', 'start');

    start_stops = build_start_stops(do_positions, dont_positions, length(input));

    for i = 1:length(mul_positions)
        if start_stops(mul_positions(i)) == 1
            solution = solution + sum_cell_products(matches(i))
        end
    end
end


disp(partA());
disp(partB());