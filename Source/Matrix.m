classdef Matrix < Operator
    %Matrix Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        colorMatrix = [1 0 0; 0 1 0; 0 0 1];
    end
    
    methods
        function tag = getTagName(obj)
            tag = 'Matrix';
        end
        
        function writeOperatorData(obj, fid)
            % verify the colorMatrix is correctly specified
            matrixSize = size(obj.colorMatrix);
            if numel(matrixSize) ~= 2
                throw(MException('ColorMatrix:IncorrectSpecifications', 'Color matrix should be 2 dimensional.'));
            end
            if matrixSize(1) ~= matrixSize(2)
                throw(MException('ColorMatrix:IncorrectSpecifications', 'Color matrix should be a square matrix.'));
            end
            if matrixSize(1) < 3 || matrixSize(1) > 4
                throw(MException('ColorMatrix:IncorrectSpecifications', 'Color matrix should be 3x3 or 4x4'));
            end
            actualSize = matrixSize(1);
            
            % write opener
            fprintf(fid, '<Array dim="%d %d 3">\n', actualSize, actualSize);
            
            % write matrix
            for r = 1:actualSize
                fprintf(fid, '%f ', obj.colorMatrix(r,:));
                fprintf(fid, '\n');
            end
            
            % write closer
            fprintf(fid, '</Array>\n');
        end
    end
    
end

