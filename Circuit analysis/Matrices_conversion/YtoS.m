function S = YtoS(Y, Z01, Z02)
%YTOS Converts the given admitance coefficients matrix Y to the
%scattering coefficients matrix S

% Retrieve information
Y11=Y(1,1); Y12=Y(1,2); Y21=Y(2,1); Y22=Y(2,2);

% Conversion
denom =  ( 1 + Y11 * Z01 ) * ( 1 + Y22 * Z02 ) - Y12 * Z01 * Y21 * Z02;
S11   = (( 1 - Y11 * Z01 ) * ( 1 + Y22 * Z02 ) + Y12 * Z01 * Y21 * Z02) / denom;
S12   = (-2 * Y12 * sqrt( Z01 * Z02 )                                 ) / denom;
S21   = (-2 * Y21 * sqrt( Z01 * Z02 )                                 ) / denom;
S22   = (( 1 + Y11 * Z01 ) * ( 1 - Y22 * Z02 ) + Y12 * Z01 * Y21 * Z02) / denom;

% Compose result
S = [S11 S12; S21 S22];
