function S = Ex1_()
%EX1_CascadeTwoSmatrices
%   Implemente una función que tome como entrada dos matrices de parámetros
%   S de dos cuadripolos referidas a la misma impedancia, y devuélva la 
%   matriz S de la concatenación de ambos cuadripolos.

% Declarations
S1 = [1 0; 0 1];
Z011 = 50;
Z012 = 50;
S2 = [1 0; 0 1];
Z021 = 50;
Z022 = 50;
S = cascadeS(S1, Z011, Z012, S2, Z021, Z022);
end