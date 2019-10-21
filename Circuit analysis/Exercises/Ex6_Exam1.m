%CIRCUITMATRIXS 
%% Exercise 3
% Sea una red formada por
% -> una admitancia en paralelo Z_L conectada por una línea de longitud l_c
%    impedancia característica Z_C y longitud eléctrica beta_C · long_C;
% representar los parámetros |S11| y |S21| en decibelios del circuito entre
% 0,9 GHz y 3,1 GHz para los valores l_C = 7,5 cm, Z_C = Z01 = Z02 = 50 Ω,
% constante dieléctrica de la línea 4, y Z_L infinita (circuito abierto).
% Indicar el valor de |S11| y |S21| en dB a 2 y 2,5 GHz.
% ¿Cambian los valores de la matriz S si se pone Z02 = 75 Ω? ¿Cuáles?

%% Parameters

% General
frequency = linspace(0.9e9,3.1e9,1000);
pulsation = 2*pi*frequency;
velocity_0 = 3e8;
permeability_r = 4;
permittibity_r = 1;
wavelength = velocity_0 ./ frequency * sqrt(permeability_r * permittibity_r);

% Zc line
longitude_c = 0.075;
beta = 2*pi./wavelength;
Z_C = 50;

% Z_L
Z_L = 10e9;

% Ports impedances
Z01 = 50;
Z02 = 50;

%% Define the isolated element for each wavelenght

% Its ABCD matrix
ZLC_ABCD = cell(1, size(beta, 2));
for i_beta = 1:size(beta, 2)
    Z_num = Z_C * (Z_L + 1i*Z_C*tan( beta(i_beta) * longitude_c ) );
    Z_den = Z_C + 1i*Z_C*tan( beta(i_beta) * longitude_c );
    Z = Z_num ./ Z_den;
    ZLC_ABCD{1, i_beta} = ABCDofImpedance(Z);
end
 
% Get the S-matrix of each
ZLC_S11 = zeros(size(ZLC_ABCD, 2));
ZLC_S12 = zeros(size(ZLC_ABCD, 2));
ZLC_S21 = zeros(size(ZLC_ABCD, 2));
ZLC_S22 = zeros(size(ZLC_ABCD, 2));
for i_ABCD = 1:size(ZLC_ABCD, 2)
    ZLC_S = ABCDtoS(ZLC_ABCD{1, i_ABCD}, Z01, Z02);
    ZLC_S11(i_ABCD) = 20*log(abs(ZLC_S(1, 1)));
    ZLC_S12(i_ABCD) = 20*log(abs(ZLC_S(1, 2)));
    ZLC_S21(i_ABCD) = 20*log(abs(ZLC_S(2, 1)));
    ZLC_S22(i_ABCD) = 20*log(abs(ZLC_S(2, 2)));
end

%% Plot
plot(frequency, ZLC_S11);
plot(frequency, ZLC_S12);


