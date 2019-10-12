function Z = ABCDtoZ(ABCD)
%ABCDTOY Converts the given transmision coefficients matrix ABCD to the
%impedance coefficients matrix Z

% Retrieve information
A=ABCD(1,1); B=ABCD(1,2); C=ABCD(2,1); D=ABCD(2,2);

% Conversion
det =  A * D - C * B;
Z11 =    A / C;
Z12 =  det / C;
Z21 =    1 / C;
Z22 =    D / C;

% Compose result
Z = [Z11 Z12; Z21 Z22];