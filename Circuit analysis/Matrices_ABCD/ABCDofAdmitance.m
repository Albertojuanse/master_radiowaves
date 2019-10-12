function ABCD = ABCDofAdmitance(Y)
%ABCDOFADMITANCE This function calculates de ABCD matrix of a given impedance

% Compose de solution
ABCD = [1 0; Y 1];

