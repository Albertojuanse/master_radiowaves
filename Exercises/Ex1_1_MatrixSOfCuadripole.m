clc; clear all; close all;
%% Exercise 1
% Sea un circuito formado por
% -> una línea de longitud l_0, impedancia 50 Ω y c. de propagación beta_0;
% -> una admitancia en paralelo ZL1 conectada por una línea de longitud λ/8
%    impedancia característica 50 Ω y c. de propagación beta_1;
% -> una línea en serie de longitud λ/4, impedancia Z_c y c. de propagación
%    beta_c;
% -> una admitancia en paralelo ZL2 conectada por una línea de longitud l_2
%    impedancia característica 50 Ω y c. de propagación beta_2; y
% -> una línea en serie de longitud l_0, impedancia 50 Ω y c. de propagación
%    beta_0.
%
% Calcular la matriz S del conjunto

c0 = 3*10^8;
f0 = 1*10^9;
lambda0 = c0/f0;

Zc = 50;                % Línea central
Yc = 1/Zc;
Z1 = 50;                % Primer stub
Z2 = 50;                % Segundo stub              a   b
ZL1 = 50;               % Carga del primer stub     0   100000000
ZL2 = 50;               % Carga del segundo stub    0   100000000
Z0 = 50;                % Carga de las bornas
Y0 = 1/Z0;
beta_c = 2*pi/lambda0;  % Constante de propagación línea central
beta0 = 2*pi/lambda0;   % Constante de propagación de las bornas
beta1 = 2*pi/lambda0;   % Constante de propagación del primer stub
beta2 = 2*pi/lambda0;   % Constante de propagación del segundo stub
lc = lambda0/4;         % Longitud de la línea central
l0 = lambda0/4;         % Longitud de las bornas
l1 = lambda0/4;         % Longitud del primer stub
l2 = lambda0/4;         % Longitud del segundo stub

theta1 = beta0*l0;      % Longitud de la primera borna
theta2 = beta0*l0;      % Longitud de la segunda borna

% Impedancia y admitancia de los stub
Zx1 = Z1*(ZL1 + 1j*Z1*tan(beta1*l1))/(Z1 + 1j*ZL1*tan(beta1*l1));
Y1 = 1/Zx1;
Zx2 = Z2*(ZL2 + 1j*Z2*tan(beta2*l2))/(Z2 + 1j*ZL2*tan(beta2*l2));
Y2 = 1/Zx2;

% Resolución teórica del cuadripolo central
V2divV1 = -1j*Yc/(Y0+Y2);

Yin1 = Y1 + (Yc^2)/(Y0 + Y2);
S11p = (Y0-Yin1)/(Y0+Yin1);
S21p = (2*Y0/(Y0 + Yin1))*(V2divV1);
S12p = S21p;
S22p = S11p;

% Desplazamiento de los planos para las bornas
MatrizExp = zeros(2,2);
MatrizExp(1,1) = exp(-1j*theta1);
MatrizExp(2,2) = exp(-1j*theta2);
Sp = [S11p S12p; S21p S22p];

S = MatrizExp*Sp*MatrizExp
