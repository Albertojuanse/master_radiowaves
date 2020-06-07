clc; clear all; close all;

%% Coupled lines
Z0 = 50;
c = 1/3; %en unidades naturales

C_dB = -20*log(c);

Z0e = Z0*sqrt((1+c)/(1-c)); % La que excita
Z0o = Z0*sqrt((1-c)/(1+c)); % Excitada

%% Branchline
Z0 = 50;

P2P3 = 36/32;

Z01 = Z0*sqrt(P2P3/(1 + P2P3)); % Horizontal
Z02 = Z0*sqrt(P2P3);            % Vetical

%% Hybrid ring
Z0 = 50;

P4P2 = 32/36;

Z01H = Z0*sqrt((1+P4P2)/(P4P2));    % Lambda 3/4 y opuesta
Z02H = Z0*sqrt(1+P4P2);             % Las otras dos