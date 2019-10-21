function ABCD = ABCDofAdmitance(Y)
%ABCDOFADMITANCE This function calculates de ABCD matrix of a given impedance
% Pozar p. 185

% Compose de solution
ABCD = [1 0; Y 1];

