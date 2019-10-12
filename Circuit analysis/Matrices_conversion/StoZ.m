function Z = StoZ(S, Z01, Z02)
%STOZ Converts the given scattering coefficients matrix S to the
%impedance coefficients matrix Z

% Retrieve information
S11=S(1,1); S12=S(1,2); S21=S(2,1); S22=S(2,2);

% Conversion
denom =        ( 1 - S11 ) * ( 1 - S22 ) - S12 * S21;
Z11   = Z01 * (( 1 + S11 ) * ( 1 - S22 ) + S12 * S21) / denom;
Z12   =   2 * S12 * sqrt( Z01 * Z02 )                 / denom;
Z21   =   2 * S21 * sqrt( Z01 * Z02 )                 / denom;
Z22   = Z02 * (( 1 - S11 ) * ( 1 + S22 ) + S12 * S21) / denom;

% Compose result
Z = [Z11 Z12; Z21 Z22];