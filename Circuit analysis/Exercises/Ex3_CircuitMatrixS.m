%CIRCUITMATRIXS 
%% Exercise 3
% Sea un circuito formado por
% -> una línea de longitud l_0, impedancia 50 Ω y c. de propagación beta_0;
% -> una admitancia en paralelo ZL1 conectada por una línea de longitud λ/8
%    impedancia característica 35 Ω y c. de propagación beta_1;
% -> una línea en serie de longitud λ/4, impedancia Z_c y c. de propagación
%    beta_c;
% -> una admitancia en paralelo ZL2 conectada por una línea de longitud l_2
%    impedancia característica 35 Ω y c. de propagación beta_2; y
% -> una línea en serie de longitud l_0, impedancia 50 Ω y c. de propagación
%    beta_0.
% Se sabe que en términos de admitancias Z0² = (YL1)² + Y_c²
%
% Calcular la matriz S del conjunto para
% -> ZL1 = ZL2 = 0 y 
% -> ZL1 = ZL2 = infinito,
% 

%% First case. Parameters
% Z0 -> ZL1 -> Zc -> ZL2 -> Z0

% Zo lines 
Z0 = 50;                         % Charasteristic impedance
Z0_electrical_longitude = pi/2;  % Electrical distance

% ZL1
L1_electrical_longitude = pi/4;
ZL1 = 35;
YL1 = 1/ZL1;

% ZL2
L2_electrical_longitude = pi/4;
ZL2 = 35;
YL2 = 1/ZL2;

% Zc line
Lc_electrical_longitude = pi/2;
Zc = sqrt( (1/50)^2 - (1/35)^2 );
Yc = 1/Zc;

%% First case. Define the isolated elements

% ZL1
%As 'OpenCircuitedStubAdmitance()' needs both beta and longitude, as the 
% electrical longitude is provided, one of the parameters is set 1.
ZL1_admitance = OpenCircuitedStubAdmitance(ZL1, L1_electrical_longitude, 1);
ZL1_ABCD = ABCDofAdmitance(ZL1_admitance);

% ZL2
ZL2_admitance = OpenCircuitedStubAdmitance(ZL2, L2_electrical_longitude, 1);
ZL2_ABCD = ABCDofAdmitance(ZL2_admitance);

% Zc line
Zc_ABCD = ABCDofLine(Zc, Lc_electrical_longitude, 1);

%% First case. Compose them
circuit_ABCD = cascadeABCD(ZL1_ABCD, Zc_ABCD);
circuit_ABCD = cascadeABCD(circuit_ABCD, Zc_ABCD);
circuit_S = ABCDtoS(circuit_ABCD, Z0, Z0);
shift_circuit_S = shiftInterfacesToS(circuit_S, Z0_electrical_longitude, 1, 1, Z0_electrical_longitude, 1, 1)

%% Second case. Parameters
% Z0 -> ZL1 -> Zc -> ZL2 -> Z0

% Zo lines 
Z0 = 50;                         % Charasteristic impedance
Z0_electrical_longitude = pi/2-0.1;  % Electrical distance

% ZL1
L1_electrical_longitude = pi/4;
ZL1 = 35;
YL1 = 1/ZL1;

% ZL2
L2_electrical_longitude = pi/4;
ZL2 = 35;
YL2 = 1/ZL2;

% Zc line
Lc_electrical_longitude = pi/2;
Zc = sqrt( (1/50)^2 - (1/35)^2 );
Yc = 1/Zc;

%% Second case. Define the isolated elements

% ZL1
%As 'OpenCircuitedStubAdmitance()' needs both beta and longitude, as the 
% electrical longitude is provided, one of the parameters is set 1.
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

shift_circuit_S = shiftInterfacesToS(circuit_S, Z0_electrical_longitude, 1, 1, Z0_electrical_longitude, 1, 1)


