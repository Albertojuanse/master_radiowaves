clc; clear all; close all;
%% Exercise 5
% Utilizando los valores gi, calcular y representar la respuesta de ese
% circuito (S11, S21 en dB y retardo de grupo en seg. de un filtro paso 
% bajo normalizado de orden N=5:
% a. Para un filtro de Butterworth.
% b. Para un filtro de Chebychev de 0.1dB de rizado de tx.
% c. Para un filtro de Bessel.

%% Coefficients
% Get the filter coefficients
% [Bessel_coefficients, Bessel_norm_impedance, Bessel_textodis] = LowPassCoefficients('Bessel',5);

%% General parameters
m = 1000;                           % Number of samples
n = [5];                            % Orders
pulsation = linspace(0, pi, m);     % Pulsation
frequency = pulsation/(2*pi);

epsilon = sqrt(10^(0.1/10) -1);     % Epsilon for 0.1 dB ripple

%% Butterworth filter elements synthesis

% Coefficients
[Butterworth_coefficients, Butterworth_norm_impedance, Butterworth_textodis] = LowPassCoefficients('Butterworth',n);

Butterworth_S11 = zeros(1, m);
Butterworth_S12 = zeros(1, m);
Butterworth_S21 = zeros(1, m);
Butterworth_S22 = zeros(1, m);

for i_pulsation = 1:m
    % Components
    ABCD_ZL1 = ABCDofImpedance(1j*pulsation(1,i_pulsation)*Butterworth_coefficients(1));
    ABCD_ZC2 = ABCDofAdmitance(1j*pulsation(1,i_pulsation)*Butterworth_coefficients(2));
    ABCD_ZL3 = ABCDofImpedance(1j*pulsation(1,i_pulsation)*Butterworth_coefficients(3));
    ABCD_ZC4 = ABCDofAdmitance(1j*pulsation(1,i_pulsation)*Butterworth_coefficients(4));
    ABCD_ZL5 = ABCDofImpedance(1j*pulsation(1,i_pulsation)*Butterworth_coefficients(5));
    ABCD12 = cascadeABCD(ABCD_ZL1, ABCD_ZC2);
    ABCD34 = cascadeABCD(ABCD_ZL3, ABCD_ZC4);
    ABCD14 = cascadeABCD(ABCD12, ABCD34);
    ABCD15 = cascadeABCD(ABCD14, ABCD_ZL5);
    
    S = ABCDtoS(ABCD15, 1, Butterworth_norm_impedance);
    
    Butterworth_S11(1, i_pulsation) = S(1,1);
    Butterworth_S12(1, i_pulsation) = S(1,2);
    Butterworth_S21(1, i_pulsation) = S(2,1);
    Butterworth_S22(1, i_pulsation) = S(2,2);
    
end

Butterworth_group_delay = -(1/(2*pi))*(diff(unwrap(angle(Butterworth_S21)))./(diff(frequency)));
Butterworth_group_delay(find(isnan(Butterworth_group_delay)) == 1) = 0;

figure(1);
subplot(2,1,1);
plot(frequency, 20*log10(abs(Butterworth_S21)));
hold on;
plot(frequency, 20*log10(abs(Butterworth_S11)));
title({'S11 and S21 module coefficients of a Butterworth filter'});
ylabel('Module (dB)');
xlabel('Frequency (Hz)');
xlim([0 max(frequency)]);
ylim([-60 0]);
subplot(2,1,2); 
plot(frequency(1:end-1), Butterworth_group_delay);
title({'Group delay of a Butterworth filter'});
ylabel('Delay (s)');
xlabel('Frequency (Hz)');
xlim([0 max(frequency)]);

%% Chebychev filter elements synthesis

% Coefficients
epsilon = sqrt(10^(0.1/10) -1);         % Epsilon for 0.1 dB ripple
RL = -10*log10(1+1/(epsilon)^2);        % For coefficients
[Chebychev_coefficients, Chebychev_norm_impedance, Chebychev_textodis] = LowPassCoefficients('Chebychev',n,RL);

Chebychev_S11 = zeros(1, m);
Chebychev_S12 = zeros(1, m);
Chebychev_S21 = zeros(1, m);
Chebychev_S22 = zeros(1, m);

for i_pulsation = 1:m
    % Components
    ABCD_ZL1 = ABCDofImpedance(1j*pulsation(1,i_pulsation)*Chebychev_coefficients(1));
    ABCD_ZC2 = ABCDofAdmitance(1j*pulsation(1,i_pulsation)*Chebychev_coefficients(2));
    ABCD_ZL3 = ABCDofImpedance(1j*pulsation(1,i_pulsation)*Chebychev_coefficients(3));
    ABCD_ZC4 = ABCDofAdmitance(1j*pulsation(1,i_pulsation)*Chebychev_coefficients(4));
    ABCD_ZL5 = ABCDofImpedance(1j*pulsation(1,i_pulsation)*Chebychev_coefficients(5));
    ABCD12 = cascadeABCD(ABCD_ZL1, ABCD_ZC2);
    ABCD34 = cascadeABCD(ABCD_ZL3, ABCD_ZC4);
    ABCD14 = cascadeABCD(ABCD12, ABCD34);
    ABCD15 = cascadeABCD(ABCD14, ABCD_ZL5);
    
    S = ABCDtoS(ABCD15, 1, Chebychev_norm_impedance);
    
    Chebychev_S11(1, i_pulsation) = S(1,1);
    Chebychev_S12(1, i_pulsation) = S(1,1);
    Chebychev_S21(1, i_pulsation) = S(2,1);
    Chebychev_S22(1, i_pulsation) = S(2,1);
    
end

Chebychev_group_delay = -(1/(2*pi))*(diff(unwrap(angle(Chebychev_S21)))./(diff(frequency)));
Chebychev_group_delay(find(isnan(Chebychev_group_delay)) == 1) = 0;

figure(2);
subplot(2,1,1);
plot(frequency, 20*log10(abs(Chebychev_S11)));
hold on;
plot(frequency, 20*log10(abs(Chebychev_S21)));
title({'S11 and S21 module coefficients of a Chebychev filter'});
ylabel('Module (dB)');
xlabel('Frequency (Hz)');
xlim([0 max(frequency)]);
ylim([-60 0]);
subplot(2,1,2); 
plot(frequency(1:end-1), Chebychev_group_delay);
title({'Group delay of a Chebychev filter'});
ylabel('Delay (s)');
xlabel('Frequency (Hz)');
xlim([0 max(frequency)]);

%% Bessel filter elements synthesis
% New pulsation because of bad showing.
pulsation = linspace(0, 6*pi, m);     % Pulsation
frequency = pulsation/(2*pi);

% Coefficients
[Bessel_coefficients, Bessel_norm_impedance, Bessel_textodis] = LowPassCoefficients('Bessel',n);

Bessel_S11 = zeros(1, m);
Bessel_S12 = zeros(1, m);
Bessel_S21 = zeros(1, m);
Bessel_S22 = zeros(1, m);

for i_pulsation = 1:m
    ABCD_ZL1 = ABCDofImpedance(1j*pulsation(1,i_pulsation)*Bessel_coefficients(1));
    ABCD_ZC2 = ABCDofAdmitance(1j*pulsation(1,i_pulsation)*Bessel_coefficients(2));
    ABCD_ZL3 = ABCDofImpedance(1j*pulsation(1,i_pulsation)*Bessel_coefficients(3));
    ABCD_ZC4 = ABCDofAdmitance(1j*pulsation(1,i_pulsation)*Bessel_coefficients(4));
    ABCD_ZL5 = ABCDofImpedance(1j*pulsation(1,i_pulsation)*Bessel_coefficients(5));
    ABCD12 = cascadeABCD(ABCD_ZL1, ABCD_ZC2);
    ABCD34 = cascadeABCD(ABCD_ZL3, ABCD_ZC4);
    ABCD14 = cascadeABCD(ABCD12, ABCD34);
    ABCD15 = cascadeABCD(ABCD14, ABCD_ZL5);
    
    S = ABCDtoS(ABCD15, 1, Bessel_norm_impedance);
    
    Bessel_S11(1, i_pulsation) = S(1,1);
    Bessel_S12(1, i_pulsation) = S(1,2);
    Bessel_S21(1, i_pulsation) = S(2,1);
    Bessel_S22(1, i_pulsation) = S(2,2);
    
end

Bessel_group_delay = -(1/(2*pi))*(diff(unwrap(angle(Bessel_S21)))./(diff(frequency)));
Bessel_group_delay(find(isnan(Bessel_group_delay)) == 1) = 0;

figure(3);
subplot(2,1,1);
plot(frequency, 20*log10(abs(Bessel_S11)));
hold on;
plot(frequency, 20*log10(abs(Bessel_S12)));
title({'S11 and S21 module coefficients of a Bessel filter'});
ylabel('Module (dB)');
xlabel('Pulsation (rad)');
xlim([0 max(frequency)]);
ylim([-60 0]);
subplot(2,1,2);
plot(frequency(1:end-1), Bessel_group_delay);
title({'Group delay of a Bessel filter'});
ylabel('Delay (s)');
xlabel('Pulsation (rad)');
xlim([0 max(frequency)]);