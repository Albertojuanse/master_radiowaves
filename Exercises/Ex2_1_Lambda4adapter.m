clc; clear all; close all;
%% Exercise 1
% Diseñar un adaptador de impedancias de 50 a 120 ohmnios, con una
% frecuencia de trabajo de 4 GHz, con un nivel de adaptación mínimo de 18
% dB entre 2 y 6 GHz y minimizando su tamaño.
% Hágase con un transformador en lambda/4

c0 = 3e8;

Z0 = 50;                % Impedancia de la red
ZL = 120;               % Impedancia de la carga
epsilon = 4;            % Permitividad eléctrica relativa
c = c0/sqrt(epsilon);   % Velocidad de propagación
f0 = 4*10^9;            % Frecuencia de trabajo
lambda0 = c/f0;
fmin = 2*10^9;          % Rango de trabajo con adaptación de 18 dB
fmax = 6*10^9;
vf=linspace(fmin,fmax,1001);
lambda = c./vf;

% Cálculos de la línea de tranmisión
Z_lambda4 = sqrt(ZL*Z0);% Impedancia característica de la línea
d_lambda0 = lambda0/4;  % Longitud de la línea
beta = 2*pi./lambda;    % Constante de propagación de la línea

Zin = Z_lambda4.*(ZL + 1i*Z_lambda4*tan(d_lambda0*beta))./(Z_lambda4 + 1i*ZL*tan(d_lambda0*beta));
S11 = (Zin-Z0)./(Zin+Z0);

figure;
subplot(2,1,1);
plot(vf,10*log10(abs(S11)));
ylim([-60 0])
title("Parámetro S11 del adaptador en \lambda/4");
xlabel("Frecuencia");
ylabel("Módulo (dB)");
subplot(2,1,2);
plot(vf,angle(S11));
xlabel("Frecuencia");
ylabel("Fase");