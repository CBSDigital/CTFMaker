classdef CTFTemplate < CTF
    %CTFProcess Summary of this class goes here
    %   Detailed explanation goes here
    
    methods
        %{
        Override this method to specify the string that is placed in the
        'id' attribute of the CTF. If you do not override it, the default
        implementation is to append the CTFName (see below) to a hex string
        representing the time this CTF was written to a file.
        
        function id = getUniqueID(obj)
            id = 'myIDHere';
        end
        %}
        
        %{
        Override this method to specify a name for this CTF to be used by
        the default implementation of the getUniqueID method.
        
        function name = getCTFName(obj)
            name = '';
        end
        %}
        
        %{
        The following self-explanatory methods are used to fill out
        attributes in the CTF's main XML tag. If they are not implemented
        or return an empty string, the optional attributes will be ommited.
        
        function description = getDescription(obj)
            description = '';
        end
        
        function inputDescriptor = getInputDescriptor(obj)
            inputDescriptor = '';
        end
        
        function outputDescriptor = getOutputDescriptor(obj)
            outputDescriptor = '';
        end
        
        %}
        
        %{
        This is the main function to override. Here you should instantiate
        and initialize whatever Operators will be present in this CTF. Then
        create a cell array containing these operators in the order they
        should be specified in the CTF.
        
        For example, assuming there is a Matrix operator and a Gamma
        operator with appropriate methods, you could write:
        
        mat = Matrix;
        mat.setMatrix(Matrix.SRGBTo709);
        
        gam = Gamma;
        gam.setGamma(1.8);
        
        operators = {mat, gam};
        
        See the Operator template for information on subclassing Operators.
        %}
        
        function operators = getOperators(obj)
            operators = {};
        end
    end
    
end

