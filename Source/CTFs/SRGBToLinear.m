classdef SRGBToLinear < CTF
    
    methods
        function name = getCTFName(obj)
            name = 'SRGBToLinear';
        end
        
        function operators = getOperators(obj)
            gamma = SRGBToLinearGamma;
            operators = {gamma};
        end
    end
    
end

