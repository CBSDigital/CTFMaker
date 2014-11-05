classdef LUT1D < Operator
    %LUT1D Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function dim = getLUTDimensions(obj)
            dim = [2 1];
        end
        
        function value = getLUTValueAtIndex(obj, row, col)
            if row == 1
                value = 0.0;
            else
                value = 1.0;
            end
        end
    end
    
    methods
        function tag = getTagName(obj)
            tag = 'LUT1D';
        end
        
        function writeOperatorData(obj, fid)
            % make sure the dimensions are correct
            dim = obj.getLUTDimensions();
            if numel(dim) ~= 2
                throw(MException('LUT:IncorrectDimensions', 'The LUT should have only 2 dimensions specified.'));
            end
            rows = dim(1);
            cols = dim(2);
            
            % write opener
            fprintf(fid, '<Array dim="%d %d">\n', rows, cols);
            
            % write the LUT data
            for r = 1:rows
                thisRow = zeros(1, cols);
                for c = 1:cols
                    thisRow(c) = obj.getLUTValueAtIndex(r, c);
                end
                thisRowString = sprintf('%.20f ', thisRow);
                fprintf(fid, '%s\n', thisRowString);
            end
            
            % write closer
            fprintf(fid, '</Array>\n');
        end
    end
    
end

