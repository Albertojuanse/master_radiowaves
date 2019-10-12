function Y = StoY(S, Z01, Z02)
%STOY Converts the given scattering coefficients matrix S to the
%admitance coefficients matrix Y

% Retrieve information
S11=S(1,1); S12=S(1,2); S21=S(2,1); S22=S(2,2);

% Conversion
denom =                ( 1 + S11 ) * ( 1 + S22 ) - S12 * S21;
Y11   = ( 1 / Z01 ) * (( 1 - S11 ) * ( 1 + S22 ) + S12 * S21) / denom;
Y12   = sqrt( 1 / ( Z01 * Z02 ))   * (-2 * S12 )              / denom;
Y21   = sqrt( 1 / ( Z01 * Z02 ))   * (-2 * S21 )              / denom;
Y22   = ( 1 / Z02 ) * (( 1 + S11 ) * ( 1 - S22 ) + S12 * S21) / denom;

% Compose result
Y = [Y11 Y12; Y21 Y22];
