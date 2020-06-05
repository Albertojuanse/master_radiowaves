clc; clear all; %close all; 
%% Exercise 7a
% Sea un circuito del ejercicio 1 formado por
% -> una línea de longitud l_0, impedancia 50 Ω y c. de propagación beta_0;
% -> una admitancia en paralelo ZL1 conectada por una línea de longitud λ/8
%    impedancia característica 50 Ω y c. de propagación beta_1;
% -> una línea en serie de longitud λ/4, impedancia Z_c y c. de propagación
%    beta_c;
% -> una admitancia en paralelo ZL2 conectada por una línea de longitud l_2
%    impedancia característica 50 Ω y c. de propagación beta_2; y
% -> una línea en serie de longitud l_0, impedancia 50 Ω y c. de propagación
%    beta_0.
% Se sabe que en términos de admitancias Z0² = (YL1)² + Y_c²
%
% Calcular la matriz S del conjunto para
% -> ZL1 = ZL2 = 0 y 
% -> ZL1 = ZL2 = infinito,
% de manera teórica y dibujar su respuesta en frecuencia.

c0 = 3*10^8;
f0 = 1*10^9;
lambda0 = c0/f0;

fmin = 1*10^9;
fmax = 3.5*10^9;
vf=linspace(fmin,fmax,5000);
lambda = c0./vf;

Z0 = 50;                % Carga de las bornas
Y0 = 1/Z0;
c = 0.7;                % Relación para las impedancias de los stub
Zr = Z0/c;
Yr = 1/Zr;
Yc = sqrt(Y0^2 - Yr^2); % Línea centra
Zc = 1/Yc;
Z1 = Zr;                % Primer stub
Z2 = Zr;                % Segundo stub              a   b
ZL1 = 0;                % Carga del primer stub     0   100000000
ZL2 = 0;                % Carga del segundo stub    0   100000000

beta_c = 2*pi./lambda;  % Constantes de propagación línea central
beta0 = 2*pi./lambda;   % Constantes de propagación de las bornas
beta1 = 2*pi./lambda;   % Constantes de propagación del primer stub
beta2 = 2*pi./lambda;   % Constantes de propagación del segundo stub
lc = lambda0/4;         % Longitud de la línea central
l0 = lambda0/4;         % Longitud de las bornas
l1 = lambda0/8;         % Longitud del primer stub
l2 = 3*lambda0/8;       % Longitud del segundo stub

theta1 = beta0.*l0;     % Longitudes de la primera borna
theta2 = beta0.*l0;     % Longitudes de la segunda borna

% Impedancia y admitancia de los stub
Zx1 = Z1.*(ZL1 + 1j*Z1*tan(beta1*l1))./(Z1 + 1j*ZL1*tan(beta1*l1));
Y1 = 1./Zx1;
Zx2 = Z2.*(ZL2 + 1j*Z2*tan(beta2*l2))./(Z2 + 1j*ZL2*tan(beta2*l2));
Y2 = 1./Zx2;

% Resolución teórica del cuadripolo central
V2divV1 = -1j*Yc./(Y0+Y2);

Yin1 = Y1 + (Yc^2)./(Y0 + Y2);
S11p = (Y0-Yin1)./(Y0+Yin1);
S21p = (2*Y0./(Y0 + Yin1)).*(V2divV1);
S12p = S21p;
S22p = ((Y0 + Y1).*(Y0 - Y2) - Yc^2)./((Y0 + Y1).*(Y0 + Y2) + Yc^2);

S11 = 0.*S11p;
S12 = 0.*S12p;
S21 = 0.*S21p;
S22 = 0.*S22p;

% Desplazamiento de los planos para las bornas
for i_f = 1:numel(vf)
    MatrizExp(1,1,i_f) = exp(-1j.*theta1(i_f));
    MatrizExp(2,2,i_f) = exp(-1j.*theta2(i_f));
    Sp = [S11p(i_f) S12p(i_f); S21p(i_f) S22p(i_f)];
    S = MatrizExp(:,:,i_f)*Sp*MatrizExp(:,:,i_f);

    S11(i_f) = S(1,1);
    S12(i_f) = S(1,2);
    S21(i_f) = S(2,1);
    S22(i_f) = S(2,2);

end

figure(1);
plot(vf, 10*log10(abs(S11)));
hold on;
plot(vf, 10*log10(abs(S12)));
hold off;
title("Parámetros S11 y S12")
xlabel("Frecuencia")
ylabel("Valor absoluto de los parámetros")
legend("S11", "S12")

figure(2);
plot(vf, 10*log10(abs(S21)));
hold on;
plot(vf, 10*log10(abs(S22)));
hold off;
title("Parámetros S21 y S22")
xlabel("Frecuencia")
ylabel("Valor absoluto de los parámetros")
legend("S21", "S22")