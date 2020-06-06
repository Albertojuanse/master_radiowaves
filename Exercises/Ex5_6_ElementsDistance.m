clc; clear all; close all;
%% Exercise 6
% ¿Qué pasa al aumentar la separación entre los elementos del array?

clear all;

%% General variables
number_of_antennas = 7;
distance_between_elements = 0.8; % Wave longitudes
d = distance_between_elements;
distances = [-3*d, -2*d, -1*d, 0*d, 1*d, 2*d, 3*d];
excitations = [1 1 1 1 1 1 1];
progressive_phase = pi/8 ;
samples = 1000;

%% Array factor
[array_factor, lim_inf, lim_sup] = ArrayFactorProgressivePhase(number_of_antennas,distances,excitations,progressive_phase);

%% Plot
module = abs(array_factor);
phase = angle(array_factor);
psi = linspace(-2*pi, 2*pi, samples);

figure(1)
plot(psi,20*log10(module));
hold on;
xline(lim_inf, '--r');
xline(lim_sup, '--r');
title({'Respuesta teórica del factor de array', 'Elementos en el eje z'});
xlim([-2*pi, 2*pi]);
ylim([-60 0]);
xlabel('Elevación (rad)');
ylabel('Módulo (dB)');
hold off;

%% Nulos en
nulos_en_psi = [-1.4, -0.509, 0.3962, 1.289, 2.182];
nulos_en_theta = real(acos((nulos_en_psi)/(distance_between_elements*2*pi)))