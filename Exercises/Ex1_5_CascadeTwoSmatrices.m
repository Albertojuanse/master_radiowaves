%% Exercise 1
% Implemente una función que tome como entrada dos matrices de parámetros
% S de dos cuadripolos referidas a la misma impedancia, y devuélva la
% matriz S de la concatenación de ambos cuadripolos.

% Declarations
S1 = [0.5 0.5; 0.5 0.5];    % First matrix
Z011 = 50;
Z012 = 50;
S2 = [0.5 0.5; 0.5 0.5];    % Second matrix
Z021 = 50;
Z022 = 50;

% Call the function
S = cascadeS(S1, Z011, Z012, S2, Z021, Z022)