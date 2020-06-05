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
m = 1000;                                   % Number of samples
n = 5;                                      % Order
pulsation_max = 2;                          % Max pulsation in arrays
pulsation = linspace(0, pulsation_max, m);  % Pulsation

%% Butterworth filter elements synthesis

% Coefficients
[Butterworth_coefficients, Butterworth_norm_impedance, Butterworth_textodis] = LowPassCoefficients('Butterworth',n);

Butterworth_S11_module = zeros(1, size(pulsation, 2));
Butterworth_S11_phase = zeros(1, size(pulsation, 2));
Butterworth_S21_module = zeros(1, size(pulsation, 2));
Butterworth_S21_phase = zeros(1, size(pulsation, 2));

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
    
    Butterworth_S11_module(1, i_pulsation) = abs(S(1,1));
    Butterworth_S11_phase(1, i_pulsation) = angle(S(1,1));
    Butterworth_S21_module(1, i_pulsation) = abs(S(2,1));
    Butterworth_S21_phase(1, i_pulsation) = angle(S(2,1));
    
end

Butterworth_S11_delay = -(1/2*pi)*diff(unwrap(Butterworth_S11_phase))/(pulsation_max/m);
Butterworth_S11_delay(1) = Butterworth_S11_delay(2);
Butterworth_S21_delay = -(1/2*pi)*diff(unwrap(Butterworth_S21_phase))/(pulsation_max/m);
    
%% Chebychev filter elements synthesis

% Coefficients
epsilon = sqrt(10^(0.1/10) -1);         % Epsilon for 0.1 dB ripple
RL = -10*log10(1+1/(epsilon)^2);        % For coefficients
[Chebychev_coefficients, Chebychev_norm_impedance, Chebychev_textodis] = LowPassCoefficients('Chebychev',n,RL);

Chebychev_S11_module = zeros(1, size(pulsation, 2));
Chebychev_S11_phase = zeros(1, size(pulsation, 2));
Chebychev_S21_module = zeros(1, size(pulsation, 2));
Chebychev_S21_phase = zeros(1, size(pulsation, 2));

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
    Chebychev_S21_module(1, i_pulsation) = abs(S(2,1));
    Chebychev_S21_phase(1, i_pulsation) = angle(S(2,1));
    
end

Chebychev_S11_delay = -(1/2*pi)*diff(unwrap(Chebychev_S11_phase))/(pulsation_max/m);
Chebychev_S21_delay = -(1/2*pi)*diff(unwrap(Chebychev_S21_phase))/(pulsation_max/m);
for i_sample = 1:size(Chebychev_S11_delay,2)
    if abs(Chebychev_S11_delay(i_sample)) > 100
        if i_sample == 1
            Chebychev_S11_delay(i_sample) = 0;
        else
            Chebychev_S11_delay(i_sample) = Chebychev_S11_delay(i_sample - 1);
        end
    end
end
for i_sample = 1:size(Chebychev_S21_delay,2)
    if abs(Chebychev_S21_delay(i_sample)) > 100
        if i_sample == 1
            Chebychev_S21_delay(i_sample) = 0;
        else
            Chebychev_S21_delay(i_sample) = Chebychev_S21_delay(i_sample - 1);
        end
    end
end

%% Bessel filter elements synthesis

% Coefficients
[Bessel_coefficients, Bessel_norm_impedance, Bessel_textodis] = LowPassCoefficients('Bessel',n);

Bessel_S11_module = zeros(1, size(pulsation, 2));
Bessel_S11_phase = zeros(1, size(pulsation, 2));
Bessel_S21_module = zeros(1, size(pulsation, 2));
Bessel_S21_phase = zeros(1, size(pulsation, 2));

for i_pulsation = 1:size(pulsation, 2)
    ABCD1 = ABCDofAdmitance(1j*pulsation(i_pulsation)*Bessel_coefficients(1));
    ABCD2 = ABCDofImpedance(1j*pulsation(i_pulsation)*Bessel_coefficients(2));
    ABCD3 = ABCDofAdmitance(1j*pulsation(i_pulsation)*Bessel_coefficients(3));
    ABCD4 = ABCDofImpedance(1j*pulsation(i_pulsation)*Bessel_coefficients(4));
    ABCD5 = ABCDofAdmitance(1j*pulsation(i_pulsation)*Bessel_coefficients(5));
    ABCD12 = cascadeABCD(ABCD1, ABCD2);
    ABCD34 = cascadeABCD(ABCD3, ABCD4);
    ABCD14 = cascadeABCD(ABCD12, ABCD34);
    ABCD15 = cascadeABCD(ABCD14, ABCD5);
    
    S = ABCDtoS(ABCD15, 1, Butterworth_norm_impedance);
    
    Bessel_S11_module(1, i_pulsation) = abs(S(1,1));
    Bessel_S11_phase(1, i_pulsation) = angle(S(1,1));
    Bessel_S21_module(1, i_pulsation) = abs(S(2,1));
    Bessel_S21_phase(1, i_pulsation) = angle(S(2,1));
    
end

Bessel_S11_delay = -(1/2*pi)*diff(unwrap(Bessel_S11_phase))/(pulsation_max/m);
Bessel_S21_delay = -(1/2*pi)*diff(unwrap(Bessel_S21_phase))/(pulsation_max/m);
for i_sample = 1:size(Bessel_S11_delay,2)
    if abs(Bessel_S11_delay(i_sample)) > 100
        if i_sample == 1
            Bessel_S11_delay(i_sample) = 0;
        else
            Bessel_S11_delay(i_sample) = Bessel_S11_delay(i_sample - 1);
        end
    end
end
for i_sample = 1:size(Bessel_S21_delay,2)
    if abs(Bessel_S21_delay(i_sample)) > 100
        if i_sample == 1
            Bessel_S21_delay(i_sample) = 0;
        else
            Bessel_S21_delay(i_sample) = Bessel_S21_delay(i_sample - 1);
        end
    end
end

%% Plot
figure;
subplot(2,1,1);
plot(pulsation, Butterworth_S11_module);
title({'S11 and S21 module coefficients of a Butterworth filter'});
ylabel('Module (dB)');
xlabel('Pulsation (rad)');
hold on;
plot(pulsation, Butterworth_S21_module);

subplot(2,1,2); 
plot(pulsation(1:end-1), Butterworth_S11_delay);
title({'S11 and S21 delay coefficients of a Butterworth filter'});
ylabel('Delay (s)');
xlabel('Pulsation (rad)');
hold on;
plot(pulsation(1:end-1), Butterworth_S21_delay);

figure;
subplot(2,1,1);
plot(pulsation, Chebychev_S11_module);
title({'S11 and S21 module coefficients of a Chebychev filter'});
ylabel('Module (dB)');
xlabel('Pulsation (rad)');
hold on;
plot(pulsation, Chebychev_S21_module);

subplot(2,1,2); 
plot(pulsation(1:end-1), Chebychev_S11_delay);
title({'S11 and S21 delay coefficients of a Chebychev filter'});
ylabel('Delay (s)');
xlabel('Pulsation (rad)');
hold on;
plot(pulsation(1:end-1), Chebychev_S21_delay);


figure;
subplot(2,1,1);
plot(pulsation, Bessel_S11_module);
title({'S11 and S21 module coefficients of a Bessel filter'});
ylabel('Module (dB)');
xlabel('Pulsation (rad)');
hold on;
plot(pulsation, Bessel_S21_module);

subplot(2,1,2); 
plot(pulsation(1:end-1), Bessel_S11_delay);
title({'S11 and S21 delay coefficients of a Bessel filter'});
ylabel('Delay (s)');
xlabel('Pulsation (rad)');
hold on;
plot(pulsation(1:end-1), Bessel_S21_delay);
