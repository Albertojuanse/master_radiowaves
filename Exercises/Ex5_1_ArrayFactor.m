clc; clear all; close all;
%% Exercise 1
% Programar  una  función  que  tome  como  argumentos  el  número  de  
% antenas,  la  distancia  en longitudes de onda entre las mismas y las 
% excitaciones de cada una y devuelva/dibuje el factor de array normalizado
% en dB.

%% General variables
number_of_antennas = 5;
distance_between_elements = 0.4; % Wave longitudes
d = distance_between_elements;
distances = [-2*d, -1*d, 0, d, 2*d];
excitations = [1 1 1 1 1];
progressive_phase = 22.5*pi/180;
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
nulos_en_psi = [-2.15, -0.8617, 0.3962, 1.654, 2.9];
nulos_en_theta = real(acos((nulos_en_psi)/(distance_between_elements*2*pi)))