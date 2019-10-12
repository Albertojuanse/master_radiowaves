function Z = YtoZ(Z)
%YTOZ Converts the given admitance coefficients matrix Y to the
%impedance coefficients matrix Z

% Retrieve information
Y11=Y(1,1); Y12=Y(1,2); Y21=Y(2,1); Y22=Y(2,2);

% Conversion
denom =  Y22* Y22 - Y21 * Y12;
Z11   =  Y22 / denom;
Z12   = -Y12 / denom;
Z21   = -Y21 / denom;
Z22   =  Y11 / denom;

% Compose result
Z = [Z11 Z12; Z21 Z22];


