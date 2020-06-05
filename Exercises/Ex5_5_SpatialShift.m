%% Exercise 5
% ¿Qué pasa si las antenas se sitúan desde z=‐3d hasta z=3d?

clear all;

%% General variables
number_of_antennas = 7;
x_distances = [0    0    0    0    0    0    0  ];
y_distances = [0    0    0    0    0    0    0  ];
z_distances = [-1.2 -0.8 -0.4 0    0.4  0.8  1.2];
excitations = [1    1    1    1    1    1    1  ];
progresive_phase = pi/8;
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
        %shift = exp( 1j * i_antenna * (2*pi * 0.4 * cos(theta(i_sample)) + progresive_phase) );
        array_factor(i_sample,1) = array_factor(i_sample,1) + excitations(i_antenna) * shift;
    end
end

module = abs(array_factor);
normalized_module = module / max(module);

%% Psi
psi = linspace(-2*pi,2*pi,samples);
r_unitary = zeros(samples,3);
for i_sample = 1:samples       
    r_unitary(i_sample,1) = sin(psi(i_sample))*cos(phi(i_sample));
    r_unitary(i_sample,2) = sin(psi(i_sample))*sin(phi(i_sample));
    r_unitary(i_sample,3) = cos(psi(i_sample));
end
array_factor_psi = zeros(samples,1);
for i_sample = 1:samples
    for i_antenna = 1:number_of_antennas
        shift = exp( 1j * i_antenna * psi(i_sample));
        array_factor_psi(i_sample,1) = array_factor_psi(i_sample,1) + abs(excitations(i_antenna)) * shift;
    end
end

module_psi = abs(array_factor_psi);
normalized_module_psi = module_psi/max(module_psi);

%% Plot
hold on;
subplot(2,1,1); 
plot(theta,20*log10(normalized_module));
title({'Respuesta teórica del factor de array', 'Elementos en el eje z'});
xlim([0 pi]);
ylim([-20 0]);
xlabel('Elevación (rad)');
ylabel('Módulo (dB)');
subplot(2,1,2,'replace'); 
plot(psi,20*log10(normalized_module_psi));
title({'Respuesta teórica del factor de array', 'Elementos en el eje z'});
xlim([-2*pi 2*pi]);
ylim([-20 0]);
xlabel('Fase \psi (rad)');
ylabel('Módulo (dB)');
hold off;
