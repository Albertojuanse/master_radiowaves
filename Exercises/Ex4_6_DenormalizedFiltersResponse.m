%% Exercise 6
% Utilizando los valores gi, sintetizar un filtro de Chebychev de 0.1dB de 
% rizado de tx y N = 5 y representar la respuesta de ese circuito (S11, S21
% en dB y retardo de grupo en seg.) cuando la frecuencia de transformación
% a paso banda es 1,8 GHz, el ancho de banda porcentual es un 15% (270 MHz)
% y las impedancias de fuente y carga son 50 ohms. Representar el circuito
% con los valores en sus componentes.

%% General parameters
m = 1000;                                   % Number of samples
n = 5;                                      % Order
norm_pulsation_max = 2;                     % Max pulsation in arrays
frequency_cut = 1.8e9;                      % Denormalized cut frequency
pulsation_cut = frequency_cut * 2 * pi;     % Denormalized cut pulsation
pulsation_max = 2 * pulsation_cut;          % Pulsation for representation
pulsation = linspace(0, pulsation_max, m);  % Pulsation
porcentual_bandwidth = 0.15;                % Bandwidth
generator_impedance = 50;                   % Denormalized impedance
load_impedance = generator_impedance;

%% Chebychev filter elements synthesis

% Pulsation transformation
transformed_pulsation = 1/(porcentual_bandwidth).*(pulsation./pulsation_cut - pulsation_cut./pulsation)
plot(transformed_pulsation);

% Coefficients
epsilon = sqrt(10^(0.1/10) -1);         % Epsilon for 0.1 dB ripple
RL = -10*log10(1+1/(epsilon)^2);        % For coefficients
[Chebychev_coefficients, Chebychev_norm_impedance, Chebychev_textodis] = LowPassCoefficients('Chebychev',n,RL);

Chebychev_S11_module = zeros(1, size(pulsation, 2));
Chebychev_S11_phase = zeros(1, size(pulsation, 2));
Chebychev_S12_module = zeros(1, size(pulsation, 2));
Chebychev_S12_phase = zeros(1, size(pulsation, 2));

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
    
    Chebychev_S11_module(1, i_pulsation) = abs(S(1,1));
    Chebychev_S11_phase(1, i_pulsation) = angle(S(1,1));
    Chebychev_S12_module(1, i_pulsation) = abs(S(1,2));
    Chebychev_S12_phase(1, i_pulsation) = angle(S(1,2));
    
end

Chebychev_S11_delay = diff(unwrap(Chebychev_S11_phase))/(pulsation_max/m);
Chebychev_S12_delay = diff(unwrap(Chebychev_S12_phase))/(pulsation_max/m);

%% Plot

figure;
title({'S11 and S12 coefficients of a Chebychev filter', 'f = 1,8 GHz N = 5'});
subplot(2,1,1);
plot(transformed_pulsation, Chebychev_S11_module);
subplot(2,1,2); 
hold on;
plot(transformed_pulsation, Chebychev_S12_module);

subplot(2,1,1);
plot(transformed_pulsation(1:end-1), Chebychev_S11_delay);
hold on;
subplot(2,1,2); 
plot(transformed_pulsation(1:end-1), Chebychev_S12_delay);

