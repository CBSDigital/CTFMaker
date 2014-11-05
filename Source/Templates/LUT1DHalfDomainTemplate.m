classdef LUT1DHalfDomainTemplate < LUT1DHalfDomain
    %LUT1DHalfDomain Summary of this class goes here
    %   Detailed explanation goes here
    
    %{
    Override numChannels if your LUT specifies a separate 1D LUT per
    channel
    properties
        numChannels = 1
    end
    %}
    
    %{
    This is the main method where the mathematical operation takes place.
    floatVal will contain a single representing the input color value,
    and channel will be a 1-based integer representing the color channel.
    
    Perform whatever operations are necessary, and set value to a floating
    point output value.
    %}
    methods
        function value = getLUTValueForFloat(obj, floatVal, channel)
            % Just a passthrough, for now...
            value = floatVal;
        end
    end
    
end

