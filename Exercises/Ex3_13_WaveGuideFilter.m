clc; clear all; %close all;
%% Exercise 13
% Filtro en guía de onda
% Especificaciones: Banda de paso de 9,8 GHz a 10,2 GHz, con adaptación
% mejor o igual a 20 dB y pérdidas de inserción mejores de 0,1 dB. Rechazos
% de: 40 dB de 8 a 9,25 GHz, de 30 dB de 11 a 11,5 GHz y de 40 dB de 11,5 a
% 12 GHz.

% Implementar el diseño con resonadores serie en la rama serie utilizando
% líneas en lambda/2 e inversores ideales. Representar el circuito con los
% valores de sus componentes. Para las líneas de transmisión, se puede usar
% una impedancia normalizada de 1 ohm.

%% General parameters
m = 1000;                                   % Number of samples
generator_impedance = 50;                   % Denormalized impedance
generator_admitance = 1/generator_impedance;
load_impedance = generator_impedance;
load_admitance = generator_admitance;
frequency_central = 10e9;                   % Denormalized central frequency
frequency_min = 9.8e9;                      % Band pass minimum frequency
frequency_max = 10.2e9;                     % Band pass maximum frequency
pulsation_central = frequency_central*2*pi; % Denormalized central pulsation
pulsation_min = frequency_min*2*pi;         % Band pass minimum pulsation
pulsation_max = frequency_max*2*pi;         % Band pass maximum pulsation
percentual_band_width = (frequency_max-frequency_min)/frequency_central;
frequency = linspace(7.8e9, 12.2e9, m);
pulsation = frequency*2*pi;

c0 = 3e8;
lambda = c0./frequency;                     % Longitudes de onda para el diseño
lambda0 = c0/frequency_central;             % Longitud de onda de trabajo
beta = 2*pi./lambda;                        % Constante de propagación

n = 4;                                      % Order

%% Chebychev filter elements synthesis

% Coefficients
% epsilon = sqrt(10^(0.1/10) -1);             % Epsilon for 0.1 dB ripple
% RL = -10*log10(1+1/(epsilon)^2);            % For coefficients
RL = -22;
[Chebychev_coefficients, Chebychev_norm_impedance, Chebychev_textodis] = LowPassCoefficients('Chebychev',n,RL);

g0 = 1;
g1 = Chebychev_coefficients(1);
g2 = Chebychev_coefficients(2);
g3 = Chebychev_coefficients(3);
g4 = Chebychev_coefficients(4);
% g5 = Chebychev_coefficients(5);
gL = Chebychev_norm_impedance;

Chebychev_S11 = zeros(1, m);
Chebychev_S12 = zeros(1, m);
Chebychev_S21 = zeros(1, m);
Chebychev_S22 = zeros(1, m);

Zc = 1;
K1 = Zc*sqrt((percentual_band_width*pi)/(2*g0*g1));
K2 = Zc*(percentual_band_width*pi/2)/sqrt(g1*g2);
K3 = Zc*(percentual_band_width*pi/2)/sqrt(g2*g3);
K4 = Zc*(percentual_band_width*pi/2)/sqrt(g3*g4);
% K5 = Zc*(percentual_band_width*pi/2)/sqrt(g4*g5);
% K6 = Zc*sqrt((percentual_band_width*pi)/(2*g5*g6));
K5 = Zc*sqrt((percentual_band_width*pi)/(2*g4*gL));

ABCDK1 = ABCDofInversor(K1);
ABCDK2 = ABCDofInversor(K2);
ABCDK3 = ABCDofInversor(K3);
ABCDK4 = ABCDofInversor(K4);
ABCDK5 = ABCDofInversor(K5);
% ABCDK6 = ABCDofInversor(K6);

for i_pulsation = 1:m

    ABCD_LT1 = ABCDofLine(Zc, beta(i_pulsation), lambda0/2);
    ABCD_LT2 = ABCDofLine(Zc, beta(i_pulsation), lambda0/2);
    ABCD_LT3 = ABCDofLine(Zc, beta(i_pulsation), lambda0/2);
    ABCD_LT4 = ABCDofLine(Zc, beta(i_pulsation), lambda0/2);
%     ABCD_LT5 = ABCDofLine(Zc, beta(i_pulsation), lambda0/2);
    
    ABCD12 = cascadeABCD(ABCDK1, ABCD_LT1);
    ABCD13 = cascadeABCD(ABCD12, ABCDK2);
    ABCD14 = cascadeABCD(ABCD13, ABCD_LT2);
    ABCD15 = cascadeABCD(ABCD14, ABCDK3);
    ABCD16 = cascadeABCD(ABCD15, ABCD_LT3);
    ABCD17 = cascadeABCD(ABCD16, ABCDK4);
    ABCD18 = cascadeABCD(ABCD17, ABCD_LT4);
    ABCD19 = cascadeABCD(ABCD18, ABCDK5);
%     ABCD110 = cascadeABCD(ABCD19, ABCD_LT5);
%     ABCD111 = cascadeABCD(ABCD111, ABCDK6);
    
    S = ABCDtoS(ABCD19, Zc, Zc);
    
    Chebychev_S11(1, i_pulsation) = S(1,1);
    Chebychev_S12(1, i_pulsation) = S(1,2);
    Chebychev_S21(1, i_pulsation) = S(2,1);
    Chebychev_S22(1, i_pulsation) = S(2,2);
    
end

Chebychev_group_delay = -(1/(2*pi))*(diff(unwrap(angle(Chebychev_S21)))./(diff(frequency)));
Chebychev_group_delay(find(isnan(Chebychev_group_delay)) == 1) = 0;

figure(1);
%subplot(2,1,1);
plot(frequency, 20*log10(abs(Chebychev_S11)));
hold on;
plot(frequency, 20*log10(abs(Chebychev_S21)));
title({'S11 and S21 of band pass Chebychev filter designed with concentrated elements'});
ylabel('Module (dB)');
xlabel('Frequency (Hz)');
xlim([min(frequency) max(frequency)]);
ylim([-100 0]);

% subplot(2,1,2); 
% plot(frequency(1:end-1), Chebychev_group_delay);
% title({'Group delay of a band pass Chebychev filter'});
% ylabel('Delay (s)');
% xlabel('Frequency (Hz)');
% xlim([0 max(frequency)]);

% Recuadro 1 sin rellenar
fk1 = 9.8e9 ; fk2 = 10.2e9 ; val = -20   ; tolk =  20 ; 
h1=plot([ fk1 fk1 fk2 fk2 fk1] , [ val+tolk val val val+tolk val+tolk] , 'k' , 'Linewidth' , 1 );
% Recuadro 2 sin rellenar
fk1 = 8e9   ; fk2 = 9.25e9 ; val = -40   ; tolk =  40 ; 
h2=plot([ fk1 fk1 fk2 fk2 fk1] , [ val+tolk val val val+tolk val+tolk] , 'k' , 'Linewidth' , 1 );
% Recuadro 3 sin rellenar
fk1 = 11e9   ; fk2 = 11.5e9 ; val = -30   ; tolk =  30 ; 
h3=plot([ fk1 fk1 fk2 fk2 fk1] , [ val+tolk val val val+tolk val+tolk] , 'k' , 'Linewidth' , 1 );
% Recuadro 4 sin rellenar
fk1 = 11.5e9   ; fk2 = 12e9 ; val = -40   ; tolk =  40 ; 
h4=plot([ fk1 fk1 fk2 fk2 fk1] , [ val+tolk val val val+tolk val+tolk] , 'k' , 'Linewidth' , 1 );

legend('|S11|', '|S21|', 'Banda de paso', 'Banda lateral 1', 'Banda lateral 2', 'Banda lateral 3', 'Location', 'Southeast');

hold off;