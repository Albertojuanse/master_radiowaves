%% Exercise 5
% tilizando los valores gi, calcular y representar la respuesta de ese
% circuito (S11, S21 en dB y retardo de grupo en seg. de un filtro paso 
% bajo normalizado de orden N=5:
% a. Para un filtro de Butterworth.
% b. Para un filtro de Chebychev de 0.1dB de rizado de tx.
% c. Para un filtro de Bessel.

%% Coefficients
% Get the filter coefficients
% [Bessel_coefficients, Bessel_norm_impedance, Bessel_textodis] = LowPassCoefficients('Bessel',5);

%% General parameters
m = 1000;                                   % Number of samples
n = 5;                                      % Order
pulsation_max = 2;                          % Max pulsation in arrays
pulsation = linspace(0, pulsation_max, m);  % Pulsation

%% Butterworth filter elements synthesis

% Coefficients
[Butterworth_coefficients, Butterworth_norm_impedance, Butterworth_textodis] = LowPassCoefficients('Butterworth',5);

butterworth_S11_module = zeros(1, size(pulsation, 2));
butterworth_S11_phase = zeros(1, size(pulsation, 2));
butterworth_S12_module = zeros(1, size(pulsation, 2));
butterworth_S12_phase = zeros(1, size(pulsation, 2));

for i_pulsation = 1:size(pulsation, 2)
    ABCD1 = ABCDofAdmitance(1j*pulsation(i_pulsation)*Butterworth_coefficients(1));
    ABCD2 = ABCDofImpedance(1j*pulsation(i_pulsation)*Butterworth_coefficients(2));
    ABCD3 = ABCDofAdmitance(1j*pulsation(i_pulsation)*Butterworth_coefficients(3));
    ABCD4 = ABCDofImpedance(1j*pulsation(i_pulsation)*Butterworth_coefficients(4));
    ABCD5 = ABCDofAdmitance(1j*pulsation(i_pulsation)*Butterworth_coefficients(5));
    ABCD12 = cascadeABCD(ABCD1, ABCD2);
    ABCD34 = cascadeABCD(ABCD3, ABCD4);
    ABCD14 = cascadeABCD(ABCD12, ABCD34);
    ABCD15 = cascadeABCD(ABCD14, ABCD5);
    
    S = ABCDtoS(ABCD15, 1, Butterworth_norm_impedance);
    
    butterworth_S11_module(1, i_pulsation, 1) = abs(S(1,1));
    butterworth_S11_phase(1, i_pulsation, 1) = angle(S(1,1));
    butterworth_S12_module(1, i_pulsation, 1) = abs(S(1,2));
    butterworth_S12_phase(1, i_pulsation, 1) = angle(S(1,2));
    
end

butterworth_S11_delay = diff(unwrap(butterworth_S11_phase))/(pulsation_max/m);
butterworth_S12_delay = diff(unwrap(butterworth_S12_phase))/(pulsation_max/m);
    
%% Chebychev filter elements synthesis

% Coefficients
epsilon = sqrt(10^(0.1/10) -1);         % Epsilon for 0.1 dB ripple
RL = -10*log10(1+1/(epsilon)^2);
[Chebychev_coefficients, Chebychev_norm_impedance, Chebychev_textodis] = LowPassCoefficients('Chebychev',6,RL);

chebychev_S11_module = zeros(1, size(pulsation, 2));
chebychev_S11_phase = zeros(1, size(pulsation, 2));
chebychev_S12_module = zeros(1, size(pulsation, 2));
chebychev_S12_phase = zeros(1, size(pulsation, 2));

for i_pulsation = 1:size(pulsation, 2)
    ABCD1 = ABCDofAdmitance(1j*pulsation(i_pulsation)*Chebychev_coefficients(1));
    ABCD2 = ABCDofImpedance(1j*pulsation(i_pulsation)*Chebychev_coefficients(2));
    ABCD3 = ABCDofAdmitance(1j*pulsation(i_pulsation)*Chebychev_coefficients(3));
    ABCD4 = ABCDofImpedance(1j*pulsation(i_pulsation)*Chebychev_coefficients(4));
    ABCD5 = ABCDofAdmitance(1j*pulsation(i_pulsation)*Chebychev_coefficients(5));
    ABCD12 = cascadeABCD(ABCD1, ABCD2);
    ABCD34 = cascadeABCD(ABCD3, ABCD4);
    ABCD14 = cascadeABCD(ABCD12, ABCD34);
    ABCD15 = cascadeABCD(ABCD14, ABCD5);
    
    S = ABCDtoS(ABCD15, 1, Chebychev_norm_impedance);
    
    chebychev_S11_module(1, i_pulsation, 1) = abs(S(1,1));
    chebychev_S11_phase(1, i_pulsation, 1) = angle(S(1,1));
    chebychev_S12_module(1, i_pulsation, 1) = abs(S(1,2));
    chebychev_S12_phase(1, i_pulsation, 1) = angle(S(1,2));
    
end

subplot(2,1,2); 
plot(pulsation, unwrap(chebychev_S11_phase));
hold on;
plot(pulsation, unwrap(chebychev_S12_phase));

%% Plot
figure;
title({'S11 and S12 coefficients of a Butterworth filter'});
subplot(2,1,1);
plot(pulsation, butterworth_S11_module);
hold on;
plot(pulsation, butterworth_S12_module);

subplot(2,1,2); 
plot(pulsation(1:end-1), butterworth_S11_delay);
hold on;
plot(pulsation(1:end-1), butterworth_S12_delay);

figure;
title({'S11 and S12 coefficients of a Chebychev filter'});
subplot(2,1,1);
plot(pulsation(1:end-1), chebychev_S11_module);
hold on;
plot(pulsation(1:end-1), chebychev_S12_module);

subplot(2,1,2); 
plot(pulsation, unwrap(chebychev_S11_phase));
hold on;
plot(pulsation, unwrap(chebychev_S12_phase));
