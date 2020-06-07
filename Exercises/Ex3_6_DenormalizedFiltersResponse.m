 clc; clear all; close all;
%% Exercise 6
% Utilizando los valores gi, sintetizar un filtro de Chebychev de 0.1dB de 
% rizado de tx y N = 5 y representar la respuesta de ese circuito (S11, S21
% en dB y retardo de grupo en seg.) cuando la frecuencia de transformación
% a paso alto es 1,8 GHz, y las impedancias de fuente y carga son 50 ohms. 
% Representar el circuito con los valores en sus componentes.

%% General parameters
m = 1000;                                   % Number of samples
n = [5];                                    % Orders
generator_impedance = 50;                   % Denormalized impedance
load_impedance = generator_impedance;
frequency_cut = 1.8e9;                      % Denormalized cut frequency
pulsation_cut = frequency_cut*2*pi;         % Denormalized cut pulsation
pulsation = linspace(0, 2*pulsation_cut, m);% Pulsation
frequency = pulsation/(2*pi);

%% Chebychev filter elements synthesis

% Coefficients
epsilon = sqrt(10^(0.1/10) -1);             % Epsilon for 0.1 dB ripple
RL = -10*log10(1+1/(epsilon)^2);            % For coefficients
[Chebychev_coefficients, Chebychev_norm_impedance, Chebychev_textodis] = LowPassCoefficients('Chebychev',n,RL);

Chebychev_S11 = zeros(1, m);
Chebychev_S12 = zeros(1, m);
Chebychev_S21 = zeros(1, m);
Chebychev_S22 = zeros(1, m);

for i_pulsation = 1:m
    % Components for high pass
    C1 = 1./(pulsation_cut*Chebychev_coefficients(1)*generator_impedance);
    L2 = generator_impedance./(pulsation_cut*Chebychev_coefficients(2));
    C3 = 1./(pulsation_cut*Chebychev_coefficients(3)*generator_impedance);
    L4 = generator_impedance./(pulsation_cut*Chebychev_coefficients(4));
    C5 = 1./(pulsation_cut*Chebychev_coefficients(5)*generator_impedance);
    ZL1 = 1./(1j*pulsation(1,i_pulsation)*C1);
    ZC2 = 1j*pulsation(1,i_pulsation)*L2;
    ZL3 = 1./(1j*pulsation(1,i_pulsation)*C3);
    ZC4 = 1j*pulsation(1,i_pulsation)*L4;
    ZL5 = 1./(1j*pulsation(1,i_pulsation)*C5);
    ABCD_ZL1 = ABCDofImpedance(ZL1);
    ABCD_ZC2 = ABCDofAdmitance(1/ZC2);
    ABCD_ZL3 = ABCDofImpedance(ZL3);
    ABCD_ZC4 = ABCDofAdmitance(1/ZC4);
    ABCD_ZL5 = ABCDofImpedance(ZL5);
    ABCD12 = cascadeABCD(ABCD_ZL1, ABCD_ZC2);
    ABCD34 = cascadeABCD(ABCD_ZL3, ABCD_ZC4);
    ABCD14 = cascadeABCD(ABCD12, ABCD34);
    ABCD15 = cascadeABCD(ABCD14, ABCD_ZL5);
    
    S = ABCDtoS(ABCD15, generator_impedance, load_impedance);
    
    Chebychev_S11(1, i_pulsation) = S(1,1);
    Chebychev_S12(1, i_pulsation) = S(1,2);
    Chebychev_S21(1, i_pulsation) = S(2,1);
    Chebychev_S22(1, i_pulsation) = S(2,2);
    
end

Chebychev_group_delay = -(1/(2*pi))*(diff(unwrap(angle(Chebychev_S21)))./(diff(frequency)));
Chebychev_group_delay(find(isnan(Chebychev_group_delay)) == 1) = 0;

figure(1);
subplot(2,1,1);
plot(frequency, 20*log10(abs(Chebychev_S11)));
hold on;
plot(frequency, 20*log10(abs(Chebychev_S21)));
title({'S11 and S21 of a high pass Chebychev filter'});
ylabel('Module (dB)');
xlabel('Frequency (Hz)');
xlim([0 max(frequency)]);
ylim([-120 0]);
legend('|S11|', '|S21|');
subplot(2,1,2); 
plot(frequency(1:end-1), Chebychev_group_delay);
title({'Group delay of a high pass Chebychev filter'});
ylabel('Delay (s)');
xlabel('Frequency (Hz)');
xlim([0 max(frequency)]);