clc; clear all; close all;
%% Exercise 3
% Diseñar un adaptador de impedancias de 50 a 120 ohmnios, con una
% frecuencia de trabajo de 4 GHz, con un nivel de adaptación mínimo de 18
% dB entre 2 y 6 GHz y minimizando su tamaño.
% Hágase con un transformador equirrizado multisección

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

% Cálculos de las secciones
d_lambda0 = lambda0/4;  % Longitud de las secciones
beta = 2*pi./lambda;    % Constante de propagación de la línea
theta = beta.*d_lambda0;% Longitud eléctrica de las secciones

BW_ideal = 2*(f0 - fmin)/f0; % Ancho de banda ideal

Ro_m_dB = -18;          % Coeficiente de adaptación objetivo en dB
Ro_m = 10^(Ro_m_dB/20); % Coeficiente de adaptación objetivo en unidades naturales

A = Ro_m;               % Ya que el valor máximo del polinomio de Chebyshev
                        %  es 1 en la región paso-banda

%% Cálculos para N=2
sec_theta_m_2 = cosh((1/2)*acosh((log(ZL/Z0))/(2*Ro_m)));
theta_m_2 = asec(sec_theta_m_2);

Ro_0 = (A/2)*(sec(theta_m_2))^2;
Ro_1 = A*((sec(theta_m_2))^2 - 1);

Z1_N2 = exp(log(Z0) + 2*Ro_0);
Z2_N2 = exp(log(Z1_N2) + 2*Ro_1);


Ro_N2 = 2*exp(-1j*2.*theta) .* (Ro_0*cos(2.*theta) + (1/2)*Ro_1);   

BW_f_N2 = 2 - (4*theta_m_2/pi); %ancho de banda fraccional

if(BW_f_N2 > BW_ideal)
    N2_valido = 1
end
%% N=3

sec_theta_m_3 = cosh((1/3)*acosh((log(ZL/Z0))/(2*Ro_m)));
theta_m_3 = asec(sec_theta_m_3);

Ro_0 = (A/2)*(sec(theta_m_3))^3;
Ro_1 = (3*A/2)*((sec(theta_m_3))^3 - sec(theta_m_3));
Ro_2 = Ro_1; %por simetría
Ro_3 = Ro_0; %por simetría

Z1_N3 = exp(log(Z0) + 2*Ro_0);
Z2_N3 = exp(log(Z1_N3) + 2*Ro_1);
Z3_N3 = exp(log(Z2_N3) + 2*Ro_2);

Ro_N3 = 2*exp(-1j*3.*theta) .* (Ro_0*cos(3.*theta) + Ro_1*cos(theta));   

BW_f_N3 = 2 - (4*theta_m_3/pi); %ancho de banda fraccional

if(BW_f_N3 > BW_ideal)
    N3_valido = 1
end

%% N=4

sec_theta_m_4 = cosh((1/4)*acosh((log(ZL/Z0))/(2*Ro_m)));
theta_m_4 = asec(sec_theta_m_4);

Ro_0 = (A/2)*(sec(theta_m_4))^4;
Ro_1 = 2*A*((sec(theta_m_4))^2)*((sec(theta_m_4))^2 - 1);
Ro_2 = 3*A*((sec(theta_m_4))^4) - 4*A*((sec(theta_m_4))^2) + A;
Ro_3 = Ro_1; %por simetría

Z1_N4 = exp(log(Z0) + 2*Ro_0);
Z2_N4 = exp(log(Z1_N4) + 2*Ro_1);
Z3_N4 = exp(log(Z2_N4) + 2*Ro_2);
Z4_N4 = exp(log(Z3_N4) + 2*Ro_3);

Ro_N4 = 2*exp(-1j*4.*theta) .* (Ro_0*cos(4.*theta) + Ro_1*cos(2.*theta) + (1/2)*Ro_2);   

BW_f_N4 = 2 - (4*theta_m_4/pi); %ancho de banda fraccional

if(BW_f_N2 > BW_ideal)
    N4_valido = 1
end

%% Parámetros S
for i_f = 1:numel(vf)
    
    Zc = Z1_N3;
    lc = d_lambda0;
    ABCDZ01 = ABCDofLine(Zc, beta(i_f), lc);

    Zc = Z2_N3;
    lc = d_lambda0;
    ABCDZ02 = ABCDofLine(Zc, beta(i_f), lc);

    Zc = Z3_N3;
    lc = d_lambda0;
    ABCDZ03 = ABCDofLine(Zc, beta(i_f), lc);

    ABCDTotal = ABCDZ01*ABCDZ02*ABCDZ03;
    STTotal = ABCDtoS(ABCDTotal, Z0, ZL);

    S11(i_f) = STTotal(1,1); 
    S12(i_f) = STTotal(1,2); 
    S21(i_f) = STTotal(2,1); 
    S22(i_f) = STTotal(2,2);
end

%% Representación
N = 3;

figure;
subplot(3,1,1);
plot(vf,20*log10(abs(S11)));
ylim([-150 0])
title("Respuesta del adaptador equirrizado de "+N+" secciones");
xlabel("Frecuencia");
ylabel("Respuesta |S11| (dB)");

subplot(3,1,2);
plot(vf,10*log10(abs(Ro_N2)));
hold on
plot(vf,10*log10(abs(Ro_N3)));
plot(vf,10*log10(abs(Ro_N4)));
xlabel("Frecuencia");
ylabel("Respuesta |\rho_0| (dB)");
legend('N=2', 'N=3', 'N=4');
ylim([-100 0])

subplot(3,1,3);
plot(vf,angle(Ro_N2));
hold on
plot(vf,angle(Ro_N3));
plot(vf,angle(Ro_N4));
legend('N=2', 'N=3', 'N=4');
xlabel("Frecuencia");
ylabel("Fase \rho_0");