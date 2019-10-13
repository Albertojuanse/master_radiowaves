function Z = ShortCircuitedStubImpedance(Z0, longitude, beta)
%SHORTCIRCUITEDSTUBIMPEDANCE Synthesizes a open circuit stub impedance given
%the characteristic impedance of the line, the coefficient of propagation 
%and the longitude
Z = 1i * Z0 * tan(longitude * beta);
end