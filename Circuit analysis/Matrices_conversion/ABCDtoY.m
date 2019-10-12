function Y = ABCDtoY(ABCD)
%ABCDTOY Converts the given transmision coefficients matrix ABCD to the
%admitance coefficients matrix Y

% Retrieve information
A=ABCD(1,1); B=ABCD(1,2); C=ABCD(2,1); D=ABCD(2,2);

% Conversion
det =  A * D - C * B;
Y11 =    D / B;
Y12 = -det / B;
Y21 =   -1 / B;
Y22 =    A / B;

% Compose result
Y = [Y11 Y12; Y21 Y22];