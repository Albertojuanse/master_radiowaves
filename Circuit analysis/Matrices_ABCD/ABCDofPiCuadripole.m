function ABCD = ABCDofPiCuadripole(Y1, Y2, Y3)
%ABCDOFPICUADIPOLE This function calculates de ABCD matrix of a Pi type
% cuadripole, given its admitances
% Pozar p. 185

% Compose de solution
ABCD = [(1+Y2/Y3) (1/Y3); (Y1+Y2+Y1*Y2/Y3) (1+Y1/Y4)];
