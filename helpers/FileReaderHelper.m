classdef FileReaderHelper 
    methods(Static)
        function [rowLen, colLen] = readFileLength(filename)
            fileID = fopen(filename, 'r');
            rowLen = 0;
            colLen = 0;
        
            while ~feof(fileID)
                % TODO: overcounting by each char of line instead of by each number
                line = fgetl(fileID);
                    
                rowLen = rowLen + 1;
                colLen = max(colLen, strlength(line));
            end
        
            fclose(fileID);
        end
        
        function [array] = updateArrayRow(array, row, value)
            arrayColLen = size(array, 2);
            newValue = value;
            for i=1:(arrayColLen - size(value,2))
                newValue = [newValue 0];
            end
            array(row, :) = newValue;
        end
        
        function [input] = read_input(filename)
            [rowLen, colLen] = FileReaderHelper.readFileLength(filename);
        
            fileID = fopen(filename, 'r');
        
            input = zeros(rowLen, colLen);
            rowIndex = 1;
        
            while ~feof(fileID)
                line = fgetl(fileID);
        
                newLine = str2num(line);
                input = FileReaderHelper.updateArrayRow(input, rowIndex, newLine);
            
                rowIndex = rowIndex + 1;
            end
        
            fclose(fileID);
        end        
    end
end