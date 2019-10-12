function S = ABCDtoS(ABCD, Z01, Z02)
%ABCDtoS Converts the given scattering coefficients matrix S to the
%transmision coefficients matrix ABCD

% Retrieve information
A=ABCD(1,1); B=ABCD(1,2); C=ABCD(2,1); D=ABCD(2,2);

% Conversion
denom =   A * Z02 + B + C *      Z01  * Z02 + D * Z01;
S11   = (( A * Z02 + B - C * conj(Z01) * Z02 - D * conj(Z01))) / denom;
S12   = (  2 * sqrt( real(Z01) * real(Z02)) * (A*D-B*C)      ) / denom;
S21   = (  2 * sqrt( real(Z01) * real(Z02))                  ) / denom;
S22   = ((-A * conj(Z02) + B - C * conj(Z02) * Z01 + D * Z01)) / denom;

% Compose result
S = [S11 S12; S21 S22];