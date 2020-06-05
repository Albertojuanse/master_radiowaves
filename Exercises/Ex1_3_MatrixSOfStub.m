clc; clear all; close all;
%% Exercise 3
% Calcular de forma teórica la matriz de parámetros S de un stub de 
% impedancia Zc, longitud eléctrica beta_c*longitud_c, y carga Zl

c0 = 3*10^8;
f0 = 2.5*10^9;
lambda0 = c0/f0;

% Parámetros
Zc = 71.4286;           % Impedancia característica de la línea
Z0 = 50;                % Impedancia de la carga en bornas
Y0 = 1/Z0;
ZL = 0;                 % Impedancia de la carga del stub
beta_c = 2*pi/lambda0;  % Constante de propagación de la línea
lc = 3*lambda0/8;       % Longitud de la línea

% Cálculo teórico de la matriz S
Zx = Zc*(ZL + 1j*Zc*tan(beta_c*lc))/(Zc + 1j*ZL*tan(beta_c*lc));
Yx = 1/Zx;

S11 = (-Yx)/(2*Y0 + Yx);
% s11 = -(Zc + j*ZL*tan(beta_c*lc))/(Zc + 2*Y0*Zc*ZL + (2*Y0*(Zc^2) + ZL)*j*tan(beta_c*lc)); %Esto es por comprobar más que nada
S21 = (2*Y0)/(Yx + 2*Y0);
S12 = S21;
S22 = S11;

S = [S11 S12; S21 S22]
