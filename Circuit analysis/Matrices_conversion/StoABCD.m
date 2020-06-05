function [ABCD] = StoABCD(S, Z01, Z02)

%StoABCD Converts the given scattering coefficients matrix S to the
%transmision coefficients matrix ABCD

% Retrieve information
S11=S(1,1); S12=S(1,2); S21=S(2,1); S22=S(2,2);

% Conversion
denom = 2 * S21 * sqrt( real(Z01) * real(Z02) );
det = S11 * S22 - S21 * S12;
A = (conj(Z01) + Z01 * S11 - conj(Z01) * S22 - Z01 * det) / denom ;
B = (conj(Z01) * conj(Z02) + Z01 * conj(Z02) * S11 + conj(Z01) * Z02 * S22 + Z01 * Z02 * det) / denom ;
C = (1 - S11 - S22 + det) / denom ;
D = (conj(Z02) - conj(Z02) * S11 + Z02 * S22 - Z02 * det) / denom ;

% Z0 = Z01;
% A = ((1+S(1,1))*(1-S(2,2)) + S(1,2)*S(2,1))/(2*S(2,1));
% B = Z0*((1+S(1,1))*(1+S(2,2)) - S(1,2)*S(2,1))/(2*S(2,1));
% C = (1/Z0)*((1-S(1,1))*(1-S(2,2)) - S(1,2)*S(2,1))/(2*S(2,1));
% D = ((1-S(1,1))*(1+S(2,2)) + S(1,2)*S(2,1))/(2*S(2,1));

% Compose result
ABCD = [A B; C D];
