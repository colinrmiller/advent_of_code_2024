classdef List
    properties
        list
        value
        nextValue
        isAscending = true
        isDescending = true
        hasProperJumps = true
        hasRemovedValue = false
        isSafe = true
    end
    methods
        function obj = List(list)
            obj.list = list;
        end

        function obj = checkSafety(obj)
            if obj.nextValue > obj.value
                obj.isDescending = false;
            end
            if obj.nextValue < obj.value
                obj.isAscending = false;
            end
            if (abs(obj.nextValue - obj.value) < 1) || (abs(obj.nextValue - obj.value) > 3)
                obj.hasProperJumps = false;
            end
        
            obj.isSafe = ~((~obj.isDescending & ~obj.isAscending) | ~obj.hasProperJumps);
        end

        function obj = checkList(obj, allowSkip)
            arguments
                obj
                allowSkip (1,1) logical = false
            end

            % isSafe = true;
            
            for j=1:size(obj.list, 2)  
                if ~obj.isSafe && ~allowSkip
                    return
                end

                obj.value = obj.list(j);
                obj.nextValue = obj.list(j+1);
                if obj.nextValue == 0
                     break;
                end
    
                obj = obj.checkSafety();

                if obj.isSafe == false && allowSkip == true && obj.hasRemovedValue == false
                    obj.hasRemovedValue = true;

                    listFirstItemRemoved = List(obj.list);
                    listFirstItemRemoved.list(j) = [];
                    listFirstItemRemoved = listFirstItemRemoved.checkList(false);

                    listSecondItemRemoved = List(obj.list);
                    listSecondItemRemoved.list(j+1) = [];
                    listSecondItemRemoved = listSecondItemRemoved.checkList();

                    obj.isSafe = listFirstItemRemoved.isSafe || listSecondItemRemoved.isSafe;

                    break;
                end
            end
        end
    end
end
