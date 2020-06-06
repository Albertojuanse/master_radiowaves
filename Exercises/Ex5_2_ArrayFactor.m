clc; clear all; close all;
%% Exercise 2
% Se tiene un array de 7 antenas situadas sobre el eje z en 
%               z=0,d,2d,3d,4d,5d,6d, donde d/λo=0.4.
% Cuando el array está uniformemente alimentado (todas las antenas tienen 
% la misma alimentación que es la unidad), representar el factor de array 
% (FA) en función de ψ (entre ‐2π y 2π) y θ (entre 0 y π) en dB 
% (20log10(|FA|)). Con esa representación, identificar la posición de los 
% nulos del diagrama de radiación en el margen visible, y el nivel entre el
% máximo del FA y el máximo lóbulo secundario.

%% General variables
number_of_antennas = 7;
distance_between_elements = 0.4; % Wave longitudes
d = distance_between_elements;
distances = [0*d, 1*d, 2*d, 3*d, 4*d, 5*d, 6*d];
excitations = [1 1 1 1 1 1 1];
progressive_phase = 0;
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
nulos_en_psi = [-1.793, -0.899, 0, 0.899, 1.793];
nulos_en_theta = real(acos((nulos_en_psi)/(distance_between_elements*2*pi)))