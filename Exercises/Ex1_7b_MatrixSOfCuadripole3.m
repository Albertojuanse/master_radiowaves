clc; clear all; %close all; 
%% Exercise 7b
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
% concatenando matrices S y dibujar su respuesta en frecuencia.

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

for i_f = 1:numel(vf) 
    
    %% Primera borna
    Zb = Z0;
    lb = l0;
    beta_b = beta0;
    S11 = (1j*((Zb^2) - (Z0^2))*sin(beta_b(i_f)*lb))/(2*Zb*Z0*cos(beta_b(i_f)*lb) + 1j*(Zb^2 + Z0^2)*sin(beta_b(i_f)*lb));
    S21 = (2*Zb*Z0)/(2*Zb*Z0*cos(beta_b(i_f)*lb) + 1j*(Zb^2 + Z0^2)*sin(beta_b(i_f)*lc));
    S22 = S11;
    S12 = S21;

    Sa = [S11 S12; S21 S22];

    %% Primer stub
    Zx = Z1*(ZL1 + 1j*Z1*tan(beta1(i_f)*l1))/(Z1 + 1j*ZL1*tan(beta1(i_f)*l1));
    Yx = 1/Zx;

    S11 = (-Yx)/(2*Y0 + Yx);
    S21 = (2*Y0)/(Yx + 2*Y0);
    S12 = S21;
    S22 = S11;

    Sb = [S11 S12; S21 S22];

    %% Línea central
    S11 = (1i*((Zc^2) - (Z0^2))*sin(beta_c(i_f)*lc))/(2*Zc*Z0*cos(beta_c(i_f)*lc) + 1j*(Zc^2 + Z0^2)*sin(beta_c(i_f)*lc));
    S21 = (2*Zc*Z0)/(2*Zc*Z0*cos(beta_c(i_f)*lc) + 1j*(Zc^2 + Z0^2)*sin(beta_c(i_f)*lc));
    S22 = S11;
    S12 = S21;

    Sc = [S11 S12; S21 S22];

    %% Segundo stub
    Zx = Z2*(ZL2 + 1j*Z2*tan(beta2(i_f)*l2))/(Z2 + 1j*ZL2*tan(beta2(i_f)*l2));
    Yx = 1/Zx;

    S11 = (-Yx)/(2*Y0 + Yx);
    S21 = (2*Y0)/(Yx + 2*Y0);
    S12 = S21;
    S22 = S11;

    Sd = [S11 S12; S21 S22];

    %% Segunda borna    
    Zb = Z0;
    lb = l0;
    beta_b = beta0;
    S11 = (1j*((Zb^2) - (Z0^2))*sin(beta_b(i_f)*lb))/(2*Zb*Z0*cos(beta_b(i_f)*lb) + 1j*(Zb^2 + Z0^2)*sin(beta_b(i_f)*lb));
    S21 = (2*Zb*Z0)/(2*Zb*Z0*cos(beta_b(i_f)*lb) + 1j*(Zb^2 + Z0^2)*sin(beta_b(i_f)*lc));
    S22 = S11;
    S12 = S21;

    Se = [S11 S12; S21 S22];
    
    %% Total
    S1 = cascadeS(Sa, Sb);
    S2 = cascadeS(S1, Sc);
    S3 = cascadeS(S2, Sd);
    STotal = cascadeS(S3, Se);

    S11T(i_f) = STotal(1,1); 
    S12T(i_f) = STotal(1,2); 
    S21T(i_f) = STotal(2,1); 
    S22T(i_f) = STotal(2,2); 
end

figure(1);
plot(vf, 20*log10(abs(S11T)));
hold on;
plot(vf, 20*log10(abs(S12T)));
hold off;
title("Parámetros S11 y S12")
xlabel("Frecuencia")
ylabel("Valor absoluto de los parámetros (dB)")
legend("S11", "S12")

figure(2);
plot(vf, 20*log10(abs(S21T)));
hold on;
plot(vf, 20*log10(abs(S22T)));
hold off;
title("Parámetros S21 y S22")
xlabel("Frecuencia")
ylabel("Valor absoluto de los parámetros (dB)")
legend("S21", "S22")