clc; clear all; close all;

% Se desea diseñar una red de alimentación para 3 antenas con el siguiente 
% esquema: 
% 
% ->|       |--> (1)
%   |       |--> (2)
%   |       |--> (3)
%   |       |--> (test)
% 
% La salida de test debe proporcionar el 4% de la potencia de entrada. 
% Las salidas principales (1, 2, 3),  han  de proporcionar la misma 
% potencia, y han de estar desfasadas 90º entre cada una de ellas.
% 
% Criterios para realizar el diseño: 
% -Acopladores con acoplamiento menor de ‐11 dB: irrealizables 
% -Acopladores con acoplamiento menor de ‐6 dB: obligatoriamente con líneas
%  acopladas
% -Acopladores con acoplamiento mayor de ‐6 dB: obligatoriamente con branch 
% o anillo
% -Frecuencia de diseño: 4 GHz 
% Para el diseño siga el siguiente esquema, donde cada caja corresponde a 
% un acoplador que Vd. habrá de decidir de qué tipo es y calcular sus 
% parámetros de diseño. Indique claramente en sus diseños basados en este 
% esquema cuál es la entrada, las salidas principales y la salida de test,
% así como cuáles son las puertas aisladas.
% 
% --|    |---------------------
% --|    |----|    |-----------
% ------------|    |---|    |--
% ---------------------|    |--
% 
% 1.Diseño teórico:Calcule la longitud eléctrica y la impedancia 
% característica, así como las impedancias de los modos par e impar si 
% procede, de la(s) línea(s) de transmisión ideales del diseño.

%% General variables
frequency = 4e9;
wavelength = 3e8/frequency;

%% Diseño
% Para conseguir que en la rama de test salga el 4% de la potencia, y que
% en el resto de salidas se tenga el mismo acoplo, no se puede seguir la
% estructura en cascada
% >-| ┬> |-------------------------> 0.32
% --| └> |-0.68-| ┬> |-------------> 0.32
% --------------| └> |-0.36-| ┬> |-> 0.32
% --------------------------| └> |-> 0.04
p_test = 0.04;
p_salidas = (1 - p_test) / 3;
% Primer dispositivo
p_salida_1_1 = p_salidas;
p_salida_1_resto = 1 - p_salida_1_1;
% Segundo acoplador
p_salida_2_1 = p_salidas;
p_salida_2_resto = p_salida_1_resto - p_salida_2_1;
% Tercer acoplador
p_salida_3_1 = p_salidas;
p_salida_3_test = p_salida_2_resto - p_salida_3_1;
% Cuyos acoplos deseados en dB son
c_1_1 = p_salida_1_1/1;
c_1_resto = p_salida_1_resto/1;
c_2_1 = p_salida_2_1/p_salida_1_resto;
c_2_resto = p_salida_2_resto/p_salida_1_resto;
c_3_1 = p_salida_3_1/p_salida_2_resto;
c_3_test = 0.04/p_salida_2_resto;
C_1_1 = -20*log10(c_1_1);
C_1_resto = -20*log10(c_1_resto);
C_2_1 = -20*log10(c_2_1);
C_2_resto = -20*log10(c_2_resto);
C_3_1 = -20*log10(c_3_1);
C_3_test = -20*log10(c_3_test);

% Se decide entrar por el acoplador del centro
% 0.32<--| <┐ |--------------------------
% 0.32<--| <┴ |-0.64-| <┐ |--------------
%     >--------------|  ┴>|-0.36-| ┬> |--> 0.32
%     ---------------------------| └> |--> 0.04
% pero el acoplo vuelve a ser mayor que -11 dB
p_test = 0.04;
p_salidas = (1 - p_test) / 3;
% Primer dispositivo
p_salida_1_1 = p_salidas;
p_salida_1_resto = p_salidas;
% Segundo acoplador
p_salida_2_1 = 2*p_salidas;
p_salida_2_resto = 1-p_salida_2_1;
% Tercer acoplador
p_salida_3_1 = p_salidas;
p_salida_3_test = p_salida_2_resto - p_salida_3_1;
% Cuyos acoplos deseados en dB son
c_1_1 = p_salida_1_1/p_salida_2_1;
c_1_resto = p_salida_1_resto/p_salida_2_1;
c_2_1 = p_salida_2_1/1;
c_2_resto = p_salida_2_resto/1;
c_3_1 = p_salida_3_1/p_salida_2_resto;
c_3_test = p_salida_3_test/p_salida_2_resto;
C_1_1 = -20*log10(c_1_1);
C_1_resto = -20*log10(c_1_resto);
C_2_1 = -20*log10(c_2_1);
C_2_resto = -20*log10(c_2_resto);
C_3_1 = -20*log10(c_3_1);
C_3_test = -20*log10(c_3_test);


%% Implementación
% Primer acoplador: branch line de -3dB
electric_longitude_1_1 = pi/2;
electric_longitude_2_1 = pi/2;
Z0_1 = 50;
Zc1_1 = Z0_1/sqrt(2);
Zc2_1 = Z0_1;

% Segundo acoplador: branch line de -4.9975
c_2_1;
c_2_resto;
C_2_1 = -20*log10(c_2_1);
C_2_resto = -20*log10(c_2_resto);
electric_longitude_1_2= pi/2;
electric_longitude_2_2 = pi/2;

Z0_2 = 50;
Y0_2 = 1/Z0_2;
Y2_2 = Y0_2/c_2_1;
Z2_2 = 1/Y2_2;
Y1_2 = c_2_resto*Y2_2;
Z1_2 = 1/Y1_2;
sqrt(Y2_2*Y2_2-Y1_2*Y1_2);

Zc1_1 = Z0_1/sqrt(2);
Zc2_1 = Z0_1;
theta1_1 = pi/2;
theta2_1 = pi/2;

% Para un acoplo menor que -11dB es necesario que haya pérdidas
% C_2 = -20*log10(0.14/0.04) = -10.8814;
% 0.30<--| <┐ |--------------------------
% 0.30<--| <┴ |-0.60-| <┐ |--------------
%     >--------------|  ┴>|-0.40-| ┬> |--> 0.30
%     ---------------------------| └> |--> 0.04