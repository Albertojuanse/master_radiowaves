clc; clear all; close all;
%% Exercise 4
% Representar como en el ejercicio 3) las respuestas teóricas (la expresión
% teórica del parámetro S11 en dB en función del polinomio correspondiente)
% de un filtro paso bajo normalizado de Chebychev de 0.1dB de rizado de 
% transmisión para N=3, N=4 y N=5.

%% Fisrt Draw
% Butterworth filters
m = 1000;                           % Number of samples
n = [3 4 5];                        % Orders
pulsation = linspace(0, pi, m);     % Pulsation
frequency = pulsation/(2*pi);

figure(1);
hold on;

epsilon = sqrt(10^(0.1/10) -1);     % Epsilon for 0.1 dB ripple
for i_n = n

    [module_S21, module_S11] = LowPassPrototipeChebychevFilter(i_n, pulsation, epsilon);
    %plot(frequency, 10*log10(module_S21));
    plot(frequency, 10*log10(module_S11));

end

title('Respuesta teórica de filtros equirrizados de orden 3, 4 y 5');
xlim([0 max(frequency)]);
ylim([-60 0]);
xlabel('Frecuencia (Hz)');
ylabel('Módulo (dB)');
hold off;

%% Second draw

figure(2);
hold on;

epsilon = sqrt(10^(0.1/10) -1);     % Epsilon for 0.1 dB ripple
for i_n = n

    [module_S21, module_S11] = LowPassPrototipeChebychevFilter(i_n, pulsation, epsilon);
    %plot(frequency, 10*log10(module_S21));
    plot(frequency, 10*log10(module_S11));

end

title('Respuesta teórica de filtros equirrizados de orden 3, 4 y 5');
xlim([0 max(frequency)]);
ylim([-0.5 0]);
xlabel('Frecuencia (Hz)');
ylabel('Módulo (dB)');
hold off;