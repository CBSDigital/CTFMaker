classdef CTF < handle
    %CTFProcess Summary of this class goes here
    %   Detailed explanation goes here
    
    % Private constant properties
    properties (Constant, GetAccess = private)
        xmlVersion = '<?xml version="1.0" encoding="UTF-8"?>';
    end
    
    % Private properties
    properties (SetAccess = private, GetAccess = private)

    end
    
    % Concrete functions that could be overriden
    methods
        function id = getUniqueID(obj)
            id = sprintf('%s-%s', obj.getCTFName(), num2hex(now));
        end
        
        function name = getCTFName(obj)
            name = '';
        end
        
        function description = getDescription(obj)
            description = '';
        end
        
        function inputDescriptor = getInputDescriptor(obj)
            inputDescriptor = '';
        end
        
        function outputDescriptor = getOutputDescriptor(obj)
            outputDescriptor = '';
        end
        
        function operators = getOperators(obj)
            operators = {};
        end
    end
    
    % Public interface
    methods
        function writeToFile(obj, filename)
            % open the file pointer
            f = fopen(filename, 'w');

            % write the contents of the file
            obj.writeXMLVersion(f);
            obj.writeOptionalTags(f);
            obj.writeProcessList(f);
            
            fclose(f);
        end
    end
    
    methods (Access = private)
        function writeXMLVersion(obj, fid)
            fprintf(fid, '%s\n', CTF.xmlVersion);
        end
        
        function writeOptionalTags(obj, fid)
            description = obj.getDescription();
            inputDescriptor = obj.getInputDescriptor();
            outputDescriptor = obj.getOutputDescriptor();
            
            if ~isempty(description)
                fprintf('<Description>%s</Description>\n', description);
            end
            if ~isempty(inputDescriptor)
                fprintf('<InputDescriptor>%s</InputDescriptor>\n', inputDescriptor);
            end
            if ~isempty(outputDescriptor)
                fprintf('<OutputDescriptor>%s</OutputDescriptor>\n', outputDescriptor);
            end
        end
        
        function writeProcessList(obj, fid)
            % get a cell array of Operators
            operators = obj.getOperators();
            
            % write the process list opener
            opener = ['<ProcessList id="' obj.getUniqueID() '" version="1.3">\n'];
            fprintf(fid, opener);
            
            % write each of the operators
            for o = 1:numel(operators)
                thisOperator = operators{o};
                thisOperator.writeOperator(fid);
            end
            
            % write the process list closer
            fprintf(fid, '</ProcessList>\n');
        end
    end
end