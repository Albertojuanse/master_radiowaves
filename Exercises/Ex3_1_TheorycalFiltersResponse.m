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
m = 1000;                           % Number of samples
n = [5];                            % Orders
pulsation = linspace(0, pi, m);     % Pulsation
frequency = pulsation/(2*pi);

figure(1);
hold on;
for i_n = n
    
    [module_S21, module_S11] = LowPassPrototipeButterworthFilter(i_n, pulsation);
    plot(frequency, 10*log10(module_S21));
    %plot(frequency, 10*log10(module_S11));

end

epsilon = sqrt(10^(0.1/10) -1);     % Epsilon for 0.1 dB ripple
for i_n = n

    [module_S21, module_S11] = LowPassPrototipeChebychevFilter(i_n, pulsation, epsilon);
    plot(frequency, 10*log10(module_S21));
    %plot(frequency, 10*log10(module_S11));

end

epsilon = sqrt(10^(0.01/10) -1);    % Epsilon for 0.01 dB ripple
for i_n = n

    [module_S21, module_S11] = LowPassPrototipeChebychevFilter(i_n, pulsation, epsilon);
    plot(frequency, 10*log10(module_S21));
    %plot(frequency, 10*log10(module_S11));

end

title('Respuesta teórica maximalmente plana y equirizada de orden 5');
xlim([0 max(frequency)]);
ylim([-60 0]);
xlabel('Frecuencia (Hz)');
ylabel('Módulo (dB)');
hold off;

%% Second draw

figure(2);
hold on;
for i_n = n
    
    [module_S21, module_S11] = LowPassPrototipeButterworthFilter(i_n, pulsation);
    plot(frequency, 10*log10(module_S21));
    %plot(frequency, 10*log10(module_S11));

end

epsilon = sqrt(10^(0.1/10) -1);     % Epsilon for 0.1 dB ripple
for i_n = n

    [module_S21, module_S11] = LowPassPrototipeChebychevFilter(i_n, pulsation, epsilon);
    plot(frequency, 10*log10(module_S21));
    %plot(frequency, 10*log10(module_S11));

end

epsilon = sqrt(10^(0.01/10) -1);    % Epsilon for 0.01 dB ripple
for i_n = n

    [module_S21, module_S11] = LowPassPrototipeChebychevFilter(i_n, pulsation, epsilon);
    plot(frequency, 10*log10(module_S21));
    %plot(frequency, 10*log10(module_S11));

end

title('Respuesta teórica maximalmente plana y equirizada de orden 5');
xlim([0 max(frequency)]);
ylim([-0.5 0]);
xlabel('Frecuencia (Hz)');
ylabel('Módulo (dB)');
hold off;