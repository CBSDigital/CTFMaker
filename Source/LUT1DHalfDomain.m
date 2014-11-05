classdef LUT1DHalfDomain < LUT1D
    %LUT1DHalfDomain Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        numChannels = 1
    end
    
    methods
        function value = getLUTValueForFloat(obj, floatVal, channel)
            value = floatVal;
        end
        
        % TODO: allow for multiple channels if necessary
        function plotLUT(obj)
            domain = zeros(65536, 1);
            range = zeros(65536, 1);
            for i = 0:65535
                domain(i+1) = LUT1DHalfDomain.halfToSingle(i);
                range(i+1) = obj.getLUTValueForFloat(domain(i+1), 1);
            end
            
            figure;
            plot(domain, range);
            axis([0 1 0 1]);
        end
    end
    
    methods
        function attrs = getAdditionalAttributes(obj)
            attrs = {'halfDomain', 'true'};
        end
        
        function dim = getLUTDimensions(obj)
            dim = [65536 obj.numChannels];
        end
        
        function value = getLUTValueAtIndex(obj, row, col)
            half = LUT1DHalfDomain.halfToSingle(row);
            value = obj.getLUTValueForFloat(half, col);
        end
    end
    
    methods(Static)
        function half = halfToSingle(unsigned)
            exponentMask = 31744; %bin2dec('0111110000000000');
            fractionMask = 1023; %bin2dec('0000001111111111');

            % get the sign bit
            signBit = single(bitget(unsigned, 16));

            % get the exponent bits and remove offset
            exponentBits = bitand(unsigned, exponentMask) / (2^10);
            exponent = single(exponentBits) - 15;

            % get the fraction bits
            fraction = bitand(unsigned, fractionMask);

            % check for special enumerated conditions
            if exponentBits == 0
                if fraction == 0
                    half = 0;
                else
                    decimalFraction = single(fraction) / (2^10);
                    half = (-1) ^ signBit * decimalFraction * (2^exponent);
                end
            elseif exponentBits > 0 && exponentBits < 31 %bin2dec('11111')
                decimalFraction = single(fraction) / (2^10);
                decimalFraction = decimalFraction + 1.0;
                half = (-1) ^ signBit * decimalFraction * (2^exponent);
            else
                if fraction == 0
                    half = (-1) ^ signBit * Inf;
                else
                    half = NaN;
                end
            end
        end
    end
end

