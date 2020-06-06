clc; clear all; close all;
%% Exercise 4
% Utilizando el polinomio característico, hallar las direcciones de campo
% nulo en ψ en los casos anteriores.

%% General variables
number_of_antennas = 7;
distance_between_elements = 0.4; % Wave longitudes
d = distance_between_elements;
distances = [0*d, 1*d, 2*d, 3*d, 4*d, 5*d, 6*d];
excitations = [1 1 1 1 1 1 1];
progressive_phase = pi/8 ;

% The characteristic polynomial is, for 7 elements
number_of_elements = 7;
zeros = roots(ones(1,number_of_elements));
zeros_real = real(zeros);
zeros_imag = imag(zeros);
zeros_module = abs(zeros);
zeros_angle = angle(zeros);
%zeros_angle_with_shift = zeros_angle + progressive_phase;
zeros_en = zeros_angle%.*180./pi

hold on;
axis equal
plot(zeros,'x');
title("Ceros en \psi")
xlabel("R")
ylabel("I")
% Draw a circle for visual porpuses,
r = 1;
theta = linspace(0,2*pi,360);
x = r * cos(theta);
y = r * sin(theta);
h = plot(x, y);
hold off;