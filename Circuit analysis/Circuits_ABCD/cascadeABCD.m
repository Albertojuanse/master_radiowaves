function ABCDout = cascadeABCD(ABCDin1, ABCDin2)
    %CASCADEABCD This function compose in cascade two ABCD matrices
    
    ABCDout = [1 1; 1 1];
    for i = 1:2
        for j = 1:2
            ABCDout(i,j) = ABCDin1(i,j)*ABCDin2(i,j);
        end
    end
    
end