clc; clear all; close all;
% Repetir el ejercicio 7 usando sólo resonadores en al rama paralelo e
% inversores ideales. Representar el circuito con los valores de sus
% componentes.

%% General parameters
m = 1000;                                   % Number of samples
n = [5];                                    % Orders
generator_impedance = 50;                   % Denormalized impedance
generator_admitance = 1/generator_impedance;
load_impedance = generator_impedance;
load_admitance = generator_admitance;
frequency_central = 1.8e9;                  % Denormalized central frequency
pulsation_central = frequency_central*2*pi; % Denormalized central pulsation
percentual_band_width = 0.15;               % Ancho de banda porcentual
pulsation = linspace(0,2*pulsation_central,m);% Pulsation
frequency = pulsation/(2*pi);

%% Chebychev filter elements synthesis

% Coefficients
epsilon = sqrt(10^(0.1/10) -1);             % Epsilon for 0.1 dB ripple
RL = -10*log10(1+1/(epsilon)^2);            % For coefficients
[Chebychev_coefficients, Chebychev_norm_impedance, Chebychev_textodis] = LowPassCoefficients('Chebychev',n,RL);

g0 = Chebychev_norm_impedance;
g1 = Chebychev_coefficients(1);
g2 = Chebychev_coefficients(2);
g3 = Chebychev_coefficients(3);
g4 = Chebychev_coefficients(4);
g5 = Chebychev_coefficients(5);
gL = Chebychev_norm_impedance;

Chebychev_S11 = zeros(1, m);
Chebychev_S12 = zeros(1, m);
Chebychev_S21 = zeros(1, m);
Chebychev_S22 = zeros(1, m);

% Arbitrary
x0i = 1;
L01 = x0i/pulsation_central;
C01 = 1/(x0i*pulsation_central);
L02 = x0i/pulsation_central;
C02 = 1/(x0i*pulsation_central);
L03 = x0i/pulsation_central;
C03 = 1/(x0i*pulsation_central);
L04 = x0i/pulsation_central;
C04 = 1/(x0i*pulsation_central);
L05 = x0i/pulsation_central;
C05 = 1/(x0i*pulsation_central);

K1 = sqrt((percentual_band_width*generator_impedance*x0i)/(g0*g1));
K2 = percentual_band_width*sqrt((x0i*x0i)/(g1*g2));
K3 = percentual_band_width*sqrt((x0i*x0i)/(g2*g3));
K4 = percentual_band_width*sqrt((x0i*x0i)/(g3*g4));
K5 = percentual_band_width*sqrt((x0i*x0i)/(g4*g5));
K6 = sqrt((percentual_band_width*x0i*load_impedance)/(g5*gL));

ABCD_K1 = ABCDofInversor(K1);
ABCD_K2 = ABCDofInversor(K2);
ABCD_K3 = ABCDofInversor(K3);
ABCD_K4 = ABCDofInversor(K4);
ABCD_K5 = ABCDofInversor(K5);
ABCD_K6 = ABCDofInversor(K6);

for i_pulsation = 1:m

    Z1 = 1./(1j*pulsation(1,i_pulsation)*C01) + (1j*pulsation(1,i_pulsation)*L01);
    Z2 = 1./(1j*pulsation(1,i_pulsation)*C02) + (1j*pulsation(1,i_pulsation)*L02);
    Z3 = 1./(1j*pulsation(1,i_pulsation)*C03) + (1j*pulsation(1,i_pulsation)*L03);
    Z4 = 1./(1j*pulsation(1,i_pulsation)*C04) + (1j*pulsation(1,i_pulsation)*L04);
    Z5 = 1./(1j*pulsation(1,i_pulsation)*C05) + (1j*pulsation(1,i_pulsation)*L05);
    
    ABCD_Z1 = ABCDofImpedance(Z1);
    ABCD_Z2 = ABCDofImpedance(Z2);
    ABCD_Z3 = ABCDofImpedance(Z3);
    ABCD_Z4 = ABCDofImpedance(Z4);
    ABCD_Z5 = ABCDofImpedance(Z5);
    
    ABCD12 = cascadeABCD(ABCD_K1, ABCD_Z1);
    ABCD13 = cascadeABCD(ABCD12, ABCD_K2);
    ABCD14 = cascadeABCD(ABCD13, ABCD_Z2);
    ABCD15 = cascadeABCD(ABCD14, ABCD_K3);
    ABCD16 = cascadeABCD(ABCD15, ABCD_Z3);
    ABCD17 = cascadeABCD(ABCD16, ABCD_K4);
    ABCD18 = cascadeABCD(ABCD17, ABCD_Z4);
    ABCD19 = cascadeABCD(ABCD18, ABCD_K5);
    ABCD110 = cascadeABCD(ABCD19, ABCD_Z5);
    ABCD111 = cascadeABCD(ABCD110, ABCD_K6);
    
    S = ABCDtoS(ABCD111, generator_impedance, load_impedance);
    
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