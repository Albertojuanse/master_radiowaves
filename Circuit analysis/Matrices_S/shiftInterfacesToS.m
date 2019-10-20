function Sout = shiftInterfacesToS(S, beta1, long1, Z1, beta2, long2, Z2)
    %SHIFTINTERFACESTOS This function desplaces the interfaces in a cuadripole
    % given the patameters of the lines atached
    
    P = [exp(-1j*beta1*long1) 0
         0                    exp(-1j*beta2*long2)];
    Sout = P.*S.*P;
     
end