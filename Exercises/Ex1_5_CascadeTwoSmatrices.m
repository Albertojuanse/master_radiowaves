clc; clear all; close all;
%% Exercise 5
% Implemente una función que tome como entrada dos matrices de parámetros
% S de dos cuadripolos referidas a la misma impedancia, y devuélva la
% matriz S de la concatenación de ambos cuadripolos.

% Declarations
S1 = [1 1; 2 2];    % First matrix
Z011 = 50;
Z012 = 50;
S2 = [1j 1; 2 4j];    % Second matrix
Z021 = 50;
Z022 = 50;

% Call the function
S = cascadeS(S1, S2)