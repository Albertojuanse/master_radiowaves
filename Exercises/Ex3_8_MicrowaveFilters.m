clc; clear all; close all;
%% Exercise 8
% Repetir el ejercicio 6 usando sólo bobinas en al rama paralelo e
% inversores ideales. Representar el circuito con los valores de sus
% componentes.

%% General parameters
m = 1000;                                   % Number of samples
n = [5];                                    % Orders
generator_impedance = 50;                   % Denormalized impedance
generator_admitance = 1/generator_impedance;
load_impedance = generator_impedance;
load_admitance = generator_admitance;
frequency_cut = 1.8e9;                      % Denormalized central frequency
pulsation_cut = frequency_cut*2*pi;         % Denormalized central pulsation
pulsation = linspace(0, 2*pulsation_cut, m);% Pulsation
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
L01 = 1;
L02 = 1;
L03 = 1;
L04 = 1;
L05 = 1;

J1 = sqrt(generator_admitance/(pulsation_cut*L01*g0*g1));
J2 = (1/pulsation_cut)*sqrt(1/(L01*L02*g1*g2));
J3 = (1/pulsation_cut)*sqrt(1/(L02*L03*g2*g3));
J4 = (1/pulsation_cut)*sqrt(1/(L03*L04*g3*g4));
J5 = (1/pulsation_cut)*sqrt(1/(L04*L05*g4*g5));
J6 = sqrt(load_admitance/(pulsation_cut*L05*g5*gL));

K1 = 1/J1;
K2 = 1/J2;
K3 = 1/J3;
K4 = 1/J4;
K5 = 1/J5;
K6 = 1/J6;

ABCD_J1 = ABCDofInversor(K1);
ABCD_J2 = ABCDofInversor(K2);
ABCD_J3 = ABCDofInversor(K3);
ABCD_J4 = ABCDofInversor(K4);
ABCD_J5 = ABCDofInversor(K5);
ABCD_J6 = ABCDofInversor(K6);

for i_pulsation = 1:m

    ZL01 = 1j*pulsation(1,i_pulsation)*L01;
    ZL02 = 1j*pulsation(1,i_pulsation)*L02;
    ZL03 = 1j*pulsation(1,i_pulsation)*L03;
    ZL04 = 1j*pulsation(1,i_pulsation)*L04;
    ZL05 = 1j*pulsation(1,i_pulsation)*L05;
    
    ABCD_L01 = ABCDofAdmitance(1/ZL01);
    ABCD_L02 = ABCDofAdmitance(1/ZL02);
    ABCD_L03 = ABCDofAdmitance(1/ZL03);
    ABCD_L04 = ABCDofAdmitance(1/ZL04);
    ABCD_L05 = ABCDofAdmitance(1/ZL05);
    
    ABCD12 = cascadeABCD(ABCD_J1, ABCD_L01);
    ABCD13 = cascadeABCD(ABCD12, ABCD_J2);
    ABCD14 = cascadeABCD(ABCD13, ABCD_L02);
    ABCD15 = cascadeABCD(ABCD14, ABCD_J3);
    ABCD16 = cascadeABCD(ABCD15, ABCD_L03);
    ABCD17 = cascadeABCD(ABCD16, ABCD_J4);
    ABCD18 = cascadeABCD(ABCD17, ABCD_L04);
    ABCD19 = cascadeABCD(ABCD18, ABCD_J5);
    ABCD110 = cascadeABCD(ABCD19, ABCD_L05);
    ABCD111 = cascadeABCD(ABCD110, ABCD_J6);
    
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
title({'S11 and S21 of a high pass Chebychev filter'});
ylabel('Module (dB)');
xlabel('Frequency (Hz)');
xlim([0 max(frequency)]);
ylim([-100 0]);
legend('|S11|', '|S21|');
subplot(2,1,2); 
plot(frequency(1:end-1), Chebychev_group_delay);
title({'Group delay of a high pass Chebychev filter'});
ylabel('Delay (s)');
xlabel('Frequency (Hz)');
xlim([0 max(frequency)]);
