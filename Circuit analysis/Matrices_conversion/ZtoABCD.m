function ABCD = ZtoABCD(Z)
%ZTOABCD Converts the given impedance coefficients matrix Z to the
%transmision coefficients matrix ABCD

% Retrieve information
Z11=Z(1,1); Z12=Z(1,2); Z21=Z(2,1); Z22=Z(2,2);

% Conversion
det =  Z11 * Z22 - Z21 * Z12;
A   =  Z11 / Z21;
B   =  det / Z21;
C   =    1 / Z21;
D   =  Z22 / Z21;

% Compose result
ABCD = [A B; C D];

