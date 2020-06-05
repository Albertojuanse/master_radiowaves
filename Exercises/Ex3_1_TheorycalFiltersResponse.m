clc; clear all; close all;
%% Exercise 1
% Representar sobre una misma figura las respuestas teóricas (la expresión
% teórica del parámetro S21 en dB en función del polinomio correspondiente)
% de un filtro paso bajo normalizado de orden N=5:
% a. Para un filtro de Butterworth.
% b. Para un filtro de Chebychev de 0.1dB de rizado de tx.
% c. Para un filtro de Chebychev de 0.01dB de rizado de tx.
% En el informe, se presentará una figura donde se vea un rango de 
% atenuación de 60dB, y otra figura obtenida de la anterior con un zoom, 
% simplemente mostrando el detalle de la banda de paso con un rango de 0.5 
% dB. El eje de abscisas en los dos casos siempre será la frecuencia en Hz.

%% Fisrt Draw
% Butterworth filters
m = 1000;               % Number of samples
n = 5;                  % Orders
pulsation_max = 2;      % Max pulsation in arrays

for i_n = n
    
    [pulsation, module, phase] = LowPassPrototipeButterworthFilter(i_n, m, pulsation_max);
    plot(pulsation/2*pi, 20*log(module))
    hold on;

end

% Chebychev filters
m = 1000;                               % Number of samples
n = 5;                                  % Order
pulsation_max = 2 ;                     % Max pulsation in arraysn = 1:5;

epsilon = sqrt(10^(0.1/10) -1);         % Epsilon for 0.1 dB ripple

for i_n = n

    [pulsation, module, phase] = LowPassPrototipeChebychevFilter(i_n, m, pulsation_max, epsilon);
    plot(pulsation/2*pi, 20*log(module))
    hold on;

end

epsilon = sqrt(10^(0.01/10) -1);         % Epsilon for 0.01 dB ripple

for i_n = n

    [pulsation, module, phase] = LowPassPrototipeChebychevFilter(i_n, m, pulsation_max, epsilon);
    plot(pulsation/2*pi, 20*log(module))
    hold on;

end

% Plot configuration
%cut_amplitude = 1+epsilon^2;
%cut_amplitude_str = strcat('1+k²=', num2str(cut_amplitude));
% annotation('textarrow',[1/pulsation_max 1/pulsation_max], [1/pulsation_max 1/pulsation_max],'String',cut_amplitude_str)
title('Respuesta teórica maximalmente plana y equirizada de orden 5');
xlim([0 pulsation_max/2*pi]);
ylim([-60 0]);
xlabel('Frecuencia (Hz)');
ylabel('Módulo (dB)');
hold off;

%% Second draw
% Butterworth filters
m = 1000;               % Number of samples
n = 5;                  % Orders
pulsation_max = 2;      % Max pulsation in arrays

for i_n = n
    
    [pulsation, module, phase] = LowPassPrototipeButterworthFilter(i_n, m, pulsation_max);
    plot(pulsation/2*pi, 20*log(module))
    hold on;

end

% Chebychev filters
m = 1000;                               % Number of samples
n = 5;                                  % Order
pulsation_max = 2 ;                     % Max pulsation in arraysn = 1:5;

epsilon = sqrt(10^(0.1/10) -1);         % Epsilon for 0.1 dB ripple

for i_n = n

    [pulsation, module, phase] = LowPassPrototipeChebychevFilter(i_n, m, pulsation_max, epsilon);
    plot(pulsation/2*pi, 20*log(module))
    hold on;

end

epsilon = sqrt(10^(0.01/10) -1);         % Epsilon for 0.01 dB ripple

for i_n = n

    [pulsation, module, phase] = LowPassPrototipeChebychevFilter(i_n, m, pulsation_max, epsilon);
    plot(pulsation/2*pi, 20*log(module))
    hold on;

end

% Plot configuration
%cut_amplitude = 1+epsilon^2;
%cut_amplitude_str = strcat('1+k²=', num2str(cut_amplitude));
% annotation('textarrow',[1/pulsation_max 1/pulsation_max], [1/pulsation_max 1/pulsation_max],'String',cut_amplitude_str)
title({'Respuesta teórica maximalmente plana y equirizada de orden 5', 'Detalle de la banda de paso.'});
xlim([0 pulsation_max/2*pi-1.3]);
ylim([-0.5 0]);
xlabel('Frecuencia (Hz)');
ylabel('Módulo (dB)');
hold off;