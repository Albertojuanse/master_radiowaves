
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

% Butterworth filters
m = 1000;               % Number of samples
n = 1:5;                % Order
pulsation_max = 2 * pi; % Max pulsation in arrays

for i_n = n
    
    [pulsation, module, phase] = LowPassPrototipeButterworthFilter(i_n, m, pulsation_max);
    plot(pulsation, module)
    hold on;

end

% Chebychev filters
m = 1000;               % Number of samples
n = 1:5;                % Order
pulsation_max = 2 * pi; % Max pulsation in arraysn = 1:5;
epsilon = 1;            % Epsilon for ripple

for i_n = n

    [pulsation, module, phase] = LowPassPrototipeChebychevFilter(i_n, m, epsilon, pulsation_max);
    plot(pulsation, module)
    hold on;

end

% Plot configurationliou

xlim([0 1]);
ylim([0 3]);
hold off;
