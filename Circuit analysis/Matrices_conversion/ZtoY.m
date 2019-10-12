function Y = ZtoY(Z)
%ZTOY Converts the given impedance coefficients matrix Z to the
%admitance coefficients matrix Y

% Retrieve information
Z11=Z(1,1); Z12=Z(1,2); Z21=Z(2,1); Z22=Z(2,2);

% Conversion
denom =  Z11 * Z22 - Z21 * Z12;
Y11   =  Z11 / denom;
Y12   = -Z12 / denom;
Y21   = -Z21 / denom;
Y22   =  Z22 / denom;

% Compose result
Y = [Y11 Y12; Y21 Y22];
