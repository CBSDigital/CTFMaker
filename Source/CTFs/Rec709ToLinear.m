classdef Rec709ToLinear < CTF
    
    methods
        function name = getCTFName(obj)
            name = 'Rec709ToLinear';
        end
        
        function operators = getOperators(obj)
            gamma = Rec709ToLinearGamma;
            operators = {gamma};
        end
    end
    
end

