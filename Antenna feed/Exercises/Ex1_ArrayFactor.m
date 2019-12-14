%% Exercise 1
% Programar  una  función  que  tome  como  argumentos  el  número  de  
% antenas,  la  distancia  en longitudes de onda entre las mismas y las 
% excitaciones de cada una y devuelva/dibuje el factor de array normalizado
% en dB.

clear all;

%% General variables
number_of_antennas = 5;
x_distances = [0 0 0 0 0];
y_distances = [0 0 0 0 0];
z_distances = [0 1 2 3 4];
excitations = [1 1 1 1 1];
progresive_phase = 22.5*pi/180;
samples = 1000;

%% Excitations
for i_antenna = 1:number_of_antennas
    excitations(i_antenna) = excitations(i_antenna)*exp(1j*i_antenna*progresive_phase);
end

%% Antennas location
theta = linspace(0,pi,samples);
phi = linspace(0,2*pi,samples);

r_unitary = zeros(samples,3);
for i_sample = 1:samples       
    r_unitary(i_sample,1) = sin(theta(i_sample))*cos(phi(i_sample));
    r_unitary(i_sample,2) = sin(theta(i_sample))*sin(phi(i_sample));
    r_unitary(i_sample,3) = cos(theta(i_sample));
end

r_antennas = zeros(number_of_antennas,3);
for i_antenna = 1:number_of_antennas
    r_antennas(i_antenna,1) = x_distances(i_antenna);
    r_antennas(i_antenna,2) = y_distances(i_antenna);
    r_antennas(i_antenna,3) = z_distances(i_antenna);
end

%% Array factor

array_factor = zeros(samples,1);
for i_sample = 1:samples
    for i_antenna = 1:number_of_antennas
        shift = exp( 1j * 2*pi * dot( r_unitary(i_sample,:), r_antennas(i_antenna,:) ) );
        array_factor(i_sample,1) = array_factor(i_sample,1) + excitations(i_antenna) * shift;
    end
end

%% Plot
module = abs(array_factor);
phase = angle(array_factor);

normalized_module = module / max(module);

plot(theta,20*log10(normalized_module));
title({'Respuesta teórica del factor de array', 'Elementos en el eje z'});
xlim([0 pi]);
ylim([-30 0]);
xlabel('Elevación (rad)');
ylabel('Módulo (dB)');
