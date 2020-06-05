clc; clear all; close all;

%% Coupled lines
Z0 = 50;
c = 1/3; %en unidades naturales

C_dB = -20*log(c);

Z0e = Z0*sqrt((1+c)/(1-c));
Z0o = Z0*sqrt((1-c)/(1+c));

%% Branchline
Z0 = 50;

P2P3 = 36/32;

Z01 = Z0*sqrt(P2P3/(1 + P2P3));
Z02 = Z0*sqrt(P2P3);

%% Hybrid ring
Z0 = 50;

P4P2 = 32/36;

Z01H = Z0*sqrt((1+P4P2)/(P4P2));
Z02H = Z0*sqrt(1+P4P2);