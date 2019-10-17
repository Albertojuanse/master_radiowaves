function [ABCD] = Lambda_4_adapter_ABCD(Z0,Z1,Z2,f,BW)
    %LAMBDA_4_ADAPTER_ABCD This function creates a lambda/4 adapter
    %    This function returns the S a lambda/4 adapter given the ports impedances
    %    and the electric charasteristics of the line
    ABCD = ABCDofLine(Z0,beta,longitude);
end

