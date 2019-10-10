% Dadas dos líneas de transmisión en serie
% - una de Z0 = 50 que hace las veces de generador
% - y otra que se interpone entre el generador y la
%   carga de Zc, distancia d; Zin entre las dos líneas
% A Zl = 100, f = 3GHz y Epsilon_r = 4, calcular
% - 1) La matriz de parámetros S referida a Z0 a la 
%      entrada y a Zl a la salida de la línea
% - 2) Los parámetros d y Zc para Zin = Zo
%      entrada y a Zl a la salida
% - 3) Representar el módulo de S11 para obtener la
%      que se aprecie la banda de paso a los 3 GHz.
% Landa cuartos Zc = Zo*sqrt(Zl) (o al reves) pero ojo
% a la Epsilon_r

% En la misma composición, calcular el coeficiente de
% reflexión a la entrada si se conocen Zl y Zc, pero no
% la distancia.

%% Variables de diseño
Z0 = 50;
Zc = 100;
f = 3e9;
epsilon_r = 4;

%% Variables
Zin = Z


%% 1) La matriz de parámetros S referida a Z0 a la entrada y a Zl a la salida de la línea


line_load = ABCDofLine()