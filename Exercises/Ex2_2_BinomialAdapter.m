clc; clear all; close all;
%% Exercise 2
% Diseñar un adaptador de impedancias de 50 a 120 ohmnios, con una
% frecuencia de trabajo de 4 GHz, con un nivel de adaptación mínimo de 18
% dB entre 2 y 6 GHz y minimizando su tamaño.
% Hágase con un transformador binomial multisección

c0 = 3e8;

N = 4;                  % Número de secciones
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

% Cálculos de las secciones
d_lambda0 = lambda0/4;  % Longitud de las secciones
beta = 2*pi./lambda;    % Constante de propagación de la línea
theta = beta.*d_lambda0;% Longitud eléctrica de las secciones

Ro_m_dB = -18;          % Coeficiente de adaptación objetivo en dB
Ro_m = 10^(Ro_m_dB/20); % Coeficiente de adaptación objetivo en unidades naturales

A = 2^(-N)*(ZL-Z0)/(ZL+Z0);
C = zeros(1,N);         % Coeficientes binomiales
Z = zeros(1,N);         % Impedancias características de cada sección

Ro = A*(1 + exp(-2*1j.*theta)).^N;
modulo = (2^N) * abs(A) .* (abs(cos(theta))).^N;

theta_m = acos(0.5*(Ro_m/abs(A))^(1/N));
BW_f = 2 - (4*theta_m/pi); % Ancho de banda fraccional

for i = 1:N
    C(i) = nchoosek(N, i-1);
end

for n = 1:N
    if n == 1
        Z(1) = exp(log(Z0) + 2^(-N)*C(n)*log(ZL/Z0));
    else
        Z(n) = exp(log(Z(n-1)) + 2^(-N)*C(n)*log(ZL/Z0));
    end
end

figure;
subplot(2,1,1);
plot(vf,10*log10(abs(Ro)));
ylim([-150 0])
title("Respuesta del adaptador binomial de "+N+" secciones");
xlabel("Frecuencia");
ylabel("Respuesta |\rho_0| (dB)");
% subplot(3,1,2);
% plot(vf,modulo);
% xlabel("Frecuencia");
% ylabel("Respuesta modulo");
subplot(2,1,2);
plot(vf,angle(Ro));
xlabel("Frecuencia");
ylabel("Fase \rho_0");