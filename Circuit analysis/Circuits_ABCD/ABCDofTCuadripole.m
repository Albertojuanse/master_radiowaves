function ABCD = ABCDofTCuadripole(Z1, Z2, Z3)
%ABCDOFTCUADRIPOLE This function calculates de ABCD matrix of a T type
%cuadripole, given its impedances

% Compose de solution
ABCD = [(1+Z1/Z3) (Z1+Z2+Z1*Z2/Z3); (1/Z3) (1+Z2/Z3)];
