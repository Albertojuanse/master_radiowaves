clc; clear all; close all;
%% Exercise 2
% Calcular de forma teórica la matriz de parámetros S de un cuadripolo
% formado por una línea de transmisión de impedancia Zc y longitud
% eleéctrica beta_c*longitud_c

c0 = 3*10^8;
f0 = 2.5*10^9;
lambda0 = c0/f0;

% Parámetros
Zc = 70.0140;           % Impedancia característica de la línea
Z0 = 50;                % Impedancia de la carga en bornas
beta_c = 2*pi/lambda0;  % Constante de propagación de la línea
lc = lambda0/4;         % Longitud de la línea

% Cálculo teórico de la matriz S
S11 = (1i*((Zc^2) - (Z0^2))*sin(beta_c*lc))/(2*Zc*Z0*cos(beta_c*lc) + 1j*(Zc^2 + Z0^2)*sin(beta_c*lc));
S21 = (2*Zc*Z0)/(2*Zc*Z0*cos(beta_c*lc) + 1j*(Zc^2 + Z0^2)*sin(beta_c*lc));
S22 = S11;
S12 = S21;

S = [S11 S12; S21 S22]