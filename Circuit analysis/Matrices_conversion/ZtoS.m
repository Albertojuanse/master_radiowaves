function S = ZtoS(Z, Z01, Z02)
%ZTOS Converts the given impedance coefficients matrix Z to the
%scattering coefficients matrix S

% Retrieve information
Z11=Z(1,1); Z12=Z(1,2); Z21=Z(2,1); Z22=Z(2,2);

% Conversion
denom =  ( Z11 + Z01 ) * ( Z22 + Z02 ) - Z12 * Z21;
S11   = (( Z11 - Z01 ) * ( Z22 + Z02 ) - Z12 * Z21) / denom;
S12   =  sqrt( Z02 / Z01 ) * 2 * Z12 * Z01          / denom;
S21   =  sqrt( Z01 / Z02 ) * 2 * Z21 * Z02          / denom;
S22   = (( Z11 + Z01 ) * ( Z22 - Z02 ) - Z12 * Z21) / denom;

% Compose result
S = [S11 S12; S21 S22];