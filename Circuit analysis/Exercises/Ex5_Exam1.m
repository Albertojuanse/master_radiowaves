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
Z_C = 50;

% Ports impedances
Z01 = 50;
Z02 = 50;

%% Define the isolated element

% ZL1
ZL1_admitance = ShortCircuitedStubAdmitance(ZL1, L1_electrical_longitude, 1);
ZL1_ABCD = ABCDofAdmitance(ZL1_admitance);
 
% ZL2
ZL2_admitance = ShortCircuitedStubAdmitance(ZL2, L2_electrical_longitude, 1);
ZL2_ABCD = ABCDofAdmitance(ZL2_admitance);

% Zc line
Zc_ABCD = ABCDofLine(Zc, Lc_electrical_longitude, 1);

%% Second case. Compose them
circuit_ABCD = cascadeABCD(ZL1_ABCD, Zc_ABCD);
circuit_ABCD = cascadeABCD(circuit_ABCD, Zc_ABCD);
circuit_S = ABCDtoS(circuit_ABCD, Z0, Z0);

% Retrieve final calculus for drawing purposes
module_S11 = zeros(1, size(frequency, 2));
module_S12 = zeros(1, size(frequency, 2));
module_S12 = zeros(1, size(frequency, 2));
module_S22 = zeros(1, size(frequency, 2));
for i_freq = 1:size(frequency, 2)
    shift_circuit_S = shiftInterfacesToS(circuit_S, beta0(i_freq), longitude0, 1, beta0(i_freq), longitude0, 1);
    module_S11(i_freq) = abs(shift_circuit_S(1, 1));
    module_S12(i_freq) = abs(shift_circuit_S(1, 2));
    module_S21(i_freq) = abs(shift_circuit_S(2, 1));
    module_S22(i_freq) = abs(shift_circuit_S(2, 2));
end

%% Second case. Verify properties.
fprintf('The matrix S obteined is reciprocal: %s\n',mat2str(isReciprocal(circuit_S)));
fprintf('The matrix S obteined is lossless: %s\n',mat2str(isLossless(circuit_S)));

%% Second case. Plot
plot(frequency, module_S11);


