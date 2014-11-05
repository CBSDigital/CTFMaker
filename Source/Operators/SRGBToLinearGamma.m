classdef SRGBToLinearGamma < LUT1DHalfDomain
    %SRGBToLinearGamma Summary of this class goes here
    %   Detailed explanation goes here
    
    methods
        function value = getLUTValueForFloat(obj, floatVal, channel)
            a = 0.055;
            if floatVal <= 0.04045
                value = floatVal / 12.92;
            else
                value = ((floatVal + a) / (1 + a)) ^ 2.4;
            end
        end
    end
    
end

