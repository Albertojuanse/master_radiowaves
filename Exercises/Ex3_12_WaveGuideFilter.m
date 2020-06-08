clc; clear all; close all;
%% Exercise 12
% Filtro en guía de onda
% Especificaciones: Banda de paso de 9,8 GHz a 10,2 GHz, con adaptación
% mejor o igual a 20 dB y pérdidas de inserción mejores de 0,1 dB. Rechazos
% de: 40 dB de 8 a 9,25 GHz, de 30 dB de 11 a 11,5 GHz y de 40 dB de 11,5 a
% 12 GHz.

% Calcular la respuesta del apartado 11 para Q = {100, 1000, 10 000},
% modelando las pérdidas en los resonadores concentrados con resistencias
% de manera y valor adecuados, y pintar el detalle de las pérdidas de
% inserción entre los 9,7 y 10,3 GHz, con abscisas entre -0,5 y 0 dB,
% toddas sobre la misma gráfica. ¿Con qué valor de Q se cumplen las 
% especificaciones?

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
pulsation_central = sqrt(pulsation_min*pulsation_max);
percentual_band_width = (frequency_max-frequency_min)/frequency_central;
frequency = linspace(7.8e9, 12.2e9, m);
pulsation = frequency*2*pi;

c0 = 3e8;
lambda = c0./frequency;                     % Longitudes de onda para el diseño
lambda0 = c0/frequency_central;             % Longitud de onda de trabajo
beta = 2*pi./lambda;                        % Constante de propagación

n = 4;                                      % Order

Q = [100, 1000, 10000];                     % Quality factor

%% Chebychev filter elements synthesis

% Coefficients
% epsilon = sqrt(10^(0.1/10) -1);             % Epsilon for 0.1 dB ripple
% RL = -10*log10(1+1/(epsilon)^2);            % For coefficients
RL = -22;
[Chebychev_coefficients, Chebychev_norm_impedance, Chebychev_textodis] = LowPassCoefficients('Chebychev',n,RL);

Chebychev_S11 = zeros(1, m);
Chebychev_S12 = zeros(1, m);
Chebychev_S21 = zeros(1, m);
Chebychev_S22 = zeros(1, m);

figure();
hold on;
for each_Q = Q
    % Components for band pass
    % Serial
    C1 = percentual_band_width./(pulsation_central*Chebychev_coefficients(1)*generator_impedance);
    L1 = Chebychev_coefficients(1)*generator_impedance/(pulsation_central*percentual_band_width);
    x=sqrt(L1/C1);
    R1 = x/each_Q;

    C3 = percentual_band_width./(pulsation_central*Chebychev_coefficients(3)*generator_impedance);
    L3 = Chebychev_coefficients(3)*generator_impedance/(pulsation_central*percentual_band_width);
    x=sqrt(L3/C3);
    R3 = x/each_Q;

    % C5 = percentual_band_width./(pulsation_central*Chebychev_coefficients(5)*generator_impedance);
    % L5 = Chebychev_coefficients(5)*generator_impedance/(pulsation_central*percentual_band_width);
    % x=sqrt(L3/C3);
    % R3 = x/each_Q;
    
    % Parallel
    C2 = Chebychev_coefficients(2)./(pulsation_central*percentual_band_width*generator_impedance);
    L2 = percentual_band_width*generator_impedance/(pulsation_central*Chebychev_coefficients(2));
    b=sqrt(C2/L2);
    G2 = b/each_Q;

    C4 = Chebychev_coefficients(4)./(pulsation_central*percentual_band_width*generator_impedance);
    L4 = percentual_band_width*generator_impedance/(pulsation_central*Chebychev_coefficients(4));
    b=sqrt(C4/L4);
    G4 = b/each_Q;
    
    for i_pulsation = 1:m

        Z1 = 1./(1j*pulsation(1,i_pulsation)*C1) + 1j*pulsation(1,i_pulsation)*L1 + R1;
        Z2 = ((1j*pulsation(1,i_pulsation)*L2).*(1./(1j*pulsation(1,i_pulsation)*C2)))./((1j*pulsation(1,i_pulsation)*L2)+(1./(1j*pulsation(1,i_pulsation)*C2))) + G2;
        Z3 = 1./(1j*pulsation(1,i_pulsation)*C3) + 1j*pulsation(1,i_pulsation)*L3 + R3;
        Z4 = ((1j*pulsation(1,i_pulsation)*L4).*(1./(1j*pulsation(1,i_pulsation)*C4)))./((1j*pulsation(1,i_pulsation)*L4)+(1./(1j*pulsation(1,i_pulsation)*C4))) + G4;
    %     Z5 = 1./(1j*pulsation(1,i_pulsation)*C5) + 1j*pulsation(1,i_pulsation)*L5 + R5;

        ABCD_Z1 = ABCDofImpedance(Z1);
        ABCD_Z2 = ABCDofAdmitance(1/Z2);
        ABCD_Z3 = ABCDofImpedance(Z3);
        ABCD_Z4 = ABCDofAdmitance(1/Z4);
    %     ABCD_Z5 = ABCDofImpedance(Z5);
        ABCD12 = cascadeABCD(ABCD_Z1, ABCD_Z2);
        ABCD34 = cascadeABCD(ABCD_Z3, ABCD_Z4);
        ABCD14 = cascadeABCD(ABCD12, ABCD34);
    %     ABCD15 = cascadeABCD(ABCD14, ABCD_Z5);

        S = ABCDtoS(ABCD14, generator_impedance, load_impedance*Chebychev_norm_impedance);

        Chebychev_S11(1, i_pulsation) = S(1,1);
        Chebychev_S12(1, i_pulsation) = S(1,2);
        Chebychev_S21(1, i_pulsation) = S(2,1);
        Chebychev_S22(1, i_pulsation) = S(2,2);
    end

    Chebychev_group_delay = -(1/(2*pi))*(diff(unwrap(angle(Chebychev_S21)))./(diff(frequency)));
    Chebychev_group_delay(find(isnan(Chebychev_group_delay)) == 1) = 0;
    
    % subplot(2,1,1);
    % plot(frequency, 20*log10(abs(Chebychev_S11)));
    plot(frequency, 20*log10(abs(Chebychev_S21)));
    
    % subplot(2,1,2); 
    % plot(frequency(1:end-1), Chebychev_group_delay);
    

end
%subplot(2,1,1);
title({'S21 of band pass Chebychev filter designed with concentrated elements for Q = 100, 1000, 10000'});
ylabel('Module (dB)');
xlabel('Frequency (Hz)');
% xlim([min(frequency) max(frequency)]);
% ylim([-100 0]);
xlim([9.7e9 10.3e9])
ylim([-4 0])

% subplot(2,1,2); 
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

legend('|S21| Q=100', '|S21| Q=1000', '|S21| Q=10000', 'Location', 'Southeast');

hold off;