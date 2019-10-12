function ABCD = YtoABCD(Y)
%YTOABCD Converts the given admitance coefficients matrix Y to the
%transmision coefficients matrix ABCD

% Retrieve information
Y11=Y(1,1); Y12=Y(1,2); Y21=Y(2,1); Y22=Y(2,2);

% Conversion
det =  Y11 * Y22 - Y21 * Y12;
A   = -Y22 / Y21;
B   =   -1 / Y21;
C   = -det / Y21;
D   = -Y11 / Y21;

% Compose result
ABCD = [A B; C D];
