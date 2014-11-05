classdef Rec709ToLinearGamma < LUT1DHalfDomain
    %SRGBToLinearGamma Summary of this class goes here
    %   Detailed explanation goes here
    
    methods
        function value = getLUTValueForFloat(obj, floatVal, channel)
            a = 0.099;
            if floatVal <= 0.081
                value = floatVal / 4.5;
            else
                value = ((floatVal + a) / (1 + a)) ^ (1/0.45);
            end
        end
    end
    
end

