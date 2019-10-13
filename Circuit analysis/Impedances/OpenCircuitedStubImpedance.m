function Z = OpenCircuitedStubImpedance(Z0, longitude, beta)
%OPENCIRCUITEDSTUBIMPEDANCE Synthesizes a open circuit stub impedance given
%the characteristic impedance of the line, the coefficient of propagation 
%and the longitude
Z = -1i * Z0 * cot(longitude * beta);
end