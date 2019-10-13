function Y = OpenCircuitedStubAdmitance(Z0, longitude, beta)
%OPENCIRCUITEDSTUBADMITANCE Synthesizes a open circuit stub admitance given
%the characteristic impedance of the line, the coefficient of propagation 
%and the longitude
Y = 1i * Z0 * cot(longitude * beta);
end