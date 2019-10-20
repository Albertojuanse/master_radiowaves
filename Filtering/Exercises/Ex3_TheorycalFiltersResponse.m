%% Exercise 3
% Representar como en el ejercicio 1) las respuestas teóricas (la expresión
% teórica del parámetro S21 en dB en función del polinomio correspondiente)
% de un filtro paso bajo normalizado de Chebychev de 0.1dB de rizado de 
% transmisión para N=3, N=4 y N=5.

%% First draw
% S21 response is equals to S12 since it is LTI and lossless
m = 1000;                               % Number of samples
n = 3:5;                                % Order
pulsation_max = 2 ;                     % Max pulsation in arraysn = 1:5;

epsilon = sqrt(10^(0.1/10) -1);         % Epsilon for 0.1 dB ripple

for i_n = n

    [pulsation, module, phase] = LowPassPrototipeChebychevFilter(i_n, m, pulsation_max, epsilon);
    plot(pulsation/2*pi, 20*log(module))
    hold on;

end

% Plot configuration
title('Respuesta teórica equirizada de órdenes 3 a 5');
xlim([0 pulsation_max/2*pi]);
ylim([-60 0]);
xlabel('Frecuencia (Hz)');
ylabel('Módulo (dB)');
hold off;

%% Second draw
% S21 response is equals to S12 since it is LTI and lossless
m = 1000;                               % Number of samples
n = 3:5;                                % Order
pulsation_max = 2 ;                     % Max pulsation in arraysn = 1:5;

epsilon = sqrt(10^(0.1/10) -1);         % Epsilon for 0.1 dB ripple

for i_n = n

    [pulsation, module, phase] = LowPassPrototipeChebychevFilter(i_n, m, pulsation_max, epsilon);
    plot(pulsation/2*pi, 20*log(module))
    hold on;

end

% Plot configuration
%cut_amplitude = 1+epsilon^2;
%cut_amplitude_str = strcat('1+k²=', num2str(cut_amplitude));
% annotation('textarrow',[1/pulsation_max 1/pulsation_max], [1/pulsation_max 1/pulsation_max],'String',cut_amplitude_str)
title({'Respuesta teórica equirizada de órdenes 3 a 5', 'Detalle de la banda de paso.'});
xlim([0 pulsation_max/2*pi-1.3]);
ylim([-0.5 0]);
xlabel('Frecuencia (Hz)');
ylabel('Módulo (dB)');
hold off;