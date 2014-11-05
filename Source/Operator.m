classdef Operator < handle
    %Operator Summary of this class goes here
    %   Detailed explanation goes here
    
    methods
        function inBitDepth = getInBitDepth(obj)
            inBitDepth = '16f';
        end
        
        function outBitDepth = getOutBitDepth(obj)
            outBitDepth = '16f';
        end
        
        function attrs = getAdditionalAttributes(obj)
            attrs = {};
        end
    end
    
    methods
        function writeOperator(obj, fid)
            % write the opener
            attributes = {'inBitDepth', obj.getInBitDepth(); ...
                          'outBitDepth', obj.getOutBitDepth();};
            additionalAttributes = obj.getAdditionalAttributes();
            if ~isempty(additionalAttributes) && size(additionalAttributes, 2) == 2
                attributes = vertcat(attributes, additionalAttributes);
            end
            attributeString = '';
            for a = 1:size(attributes, 1)
                attributeString = [attributeString ' ' attributes{a, 1} ...
                    '="' attributes{a,2} '"'];
            end
            
            opener = ['<' obj.getTagName() attributeString '>\n'];
            fprintf(fid, opener);
            
            % write the actual operator data
            obj.writeOperatorData(fid);
            
            % write the closer
            fprintf(fid, ['</' obj.getTagName() '>\n']);
        end
    end
    
    methods (Abstract)
        getTagName(obj)
        writeOperatorData(obj, fid)
    end
    
end