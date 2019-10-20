function Y = ShortCircuitedStubAdmitance(Z0, longitude, beta)
%SHORTCIRCUITEDSTUBADMITANCE Synthesizes a open circuit stub admitance given
%the characteristic impedance of the line, the coefficient of propagation 
%and the longitude
Y = -1i * Z0 * tan(longitude * beta);
end