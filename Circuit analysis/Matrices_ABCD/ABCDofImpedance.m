function ABCD = ABCDofImpedance(Z)
%ABCDOFIMPEDANCE This function calculates de ABCD matrix of a given impedance
% Pozar p. 185


% Compose de solution
ABCD = [1 Z; 0 1];
