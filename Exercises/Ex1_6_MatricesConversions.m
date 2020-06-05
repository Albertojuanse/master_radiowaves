clc; clear all; close all;
%% Exercise 6
% Implemente una función que tome como entrada una matriz de parámetros S
% de un cuadripolo y su impedancia de referencia, y devuelva la matriz de
% parámetros ABCD. Implemente la función inversa.

% Declaration
S0 = [-1j*0.5 0.5; 0.5 1j*0.5]
Z01 = 50;
Z02 = 50;

% Conversions
ABCD = StoABCD(S0, Z01, Z02)
S = ABCDtoS(ABCD, Z01, Z02)
