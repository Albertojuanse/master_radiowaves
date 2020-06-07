clc; clear all; close all;
%% Exercise 7
% Utilizando los valores gi, sintetizar un filtro de Chebychev de 0.1dB de 
% rizado de tx y N = 5 y representar la respuesta de ese circuito (S11, S21
% en dB y retardo de grupo en seg.) cuando la frecuencia de transformación
% a paso banda es 1,8 GHz, el ancho de banda porcentual es un 15% (270 MHz)
% y las impedancias de fuente y carga son 50 ohms. Representar el circuito
% con los valores en sus componentes.

%% General parameters
m = 1000;                                   % Number of samples
n = [5];                                    % Orders
generator_impedance = 50;                   % Denormalized impedance
load_impedance = generator_impedance;
frequency_central = 1.8e9;                  % Denormalized central frequency
pulsation_central = frequency_central*2*pi; % Denormalized central pulsation
percentual_band_width = 0.15;               % Ancho de banda porcentual
pulsation = linspace(0, 2*pulsation_central, m);% Pulsation
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

% Components for band pass
% Serial
C1 = percentual_band_width./(pulsation_central*Chebychev_coefficients(1)*generator_impedance);
L1 = Chebychev_coefficients(1)*generator_impedance/(pulsation_central*percentual_band_width);

C3 = percentual_band_width./(pulsation_central*Chebychev_coefficients(3)*generator_impedance);
L3 = Chebychev_coefficients(3)*generator_impedance/(pulsation_central*percentual_band_width);

C5 = percentual_band_width./(pulsation_central*Chebychev_coefficients(5)*generator_impedance);
L5 = Chebychev_coefficients(5)*generator_impedance/(pulsation_central*percentual_band_width);

% Parallel
C2 = Chebychev_coefficients(2)./(pulsation_central*percentual_band_width*generator_impedance);
L2 = percentual_band_width*generator_impedance/(pulsation_central*Chebychev_coefficients(2));

C4 = Chebychev_coefficients(4)./(pulsation_central*percentual_band_width*generator_impedance);
L4 = percentual_band_width*generator_impedance/(pulsation_central*Chebychev_coefficients(4));

for i_pulsation = 1:m

    Z1 = 1./(1j*pulsation(1,i_pulsation)*C1) + 1j*pulsation(1,i_pulsation)*L1;
    Z2 = ((1j*pulsation(1,i_pulsation)*L2).*(1./(1j*pulsation(1,i_pulsation)*C2)))./((1j*pulsation(1,i_pulsation)*L2)+(1./(1j*pulsation(1,i_pulsation)*C2)));
    Z3 = 1./(1j*pulsation(1,i_pulsation)*C3) + 1j*pulsation(1,i_pulsation)*L3;
    Z4 = ((1j*pulsation(1,i_pulsation)*L4).*(1./(1j*pulsation(1,i_pulsation)*C4)))./((1j*pulsation(1,i_pulsation)*L4)+(1./(1j*pulsation(1,i_pulsation)*C4)));
    Z5 = 1./(1j*pulsation(1,i_pulsation)*C5) + 1j*pulsation(1,i_pulsation)*L5;
    
    ABCD_Z1 = ABCDofImpedance(Z1);
    ABCD_Z2 = ABCDofAdmitance(1/Z2);
    ABCD_Z3 = ABCDofImpedance(Z3);
    ABCD_Z4 = ABCDofAdmitance(1/Z4);
    ABCD_Z5 = ABCDofImpedance(Z5);
    ABCD12 = cascadeABCD(ABCD_Z1, ABCD_Z2);
    ABCD34 = cascadeABCD(ABCD_Z3, ABCD_Z4);
    ABCD14 = cascadeABCD(ABCD12, ABCD34);
    ABCD15 = cascadeABCD(ABCD14, ABCD_Z5);
    
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
title({'S11 and S21 of a band pass Chebychev filter'});
ylabel('Module (dB)');
xlabel('Frequency (Hz)');
xlim([0 max(frequency)]);
ylim([-100 0]);
legend('|S11|', '|S21|');
subplot(2,1,2); 
plot(frequency(1:end-1), Chebychev_group_delay);
title({'Group delay of a band pass Chebychev filter'});
ylabel('Delay (s)');
xlabel('Frequency (Hz)');
xlim([0 max(frequency)]);
