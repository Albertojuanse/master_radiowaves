function [normalized_module, phase] = ArrayFactor(number_of_antennas,distances,excitations)
%ARRAYFACTOR This function returns the normalized array factor in dB given 
% as arguments the number of antennas, the distance between them in lambdas
% and its excitations.

% Error control
if number_of_antennas ~= size(distances,2)
    if number_of_antennas ~= size(excitations,2)
        fprintf('[ERROR] The input arguments must be equal sized.\r\n')
        return;
    end
end

%% General variables
x_distances = distances(1,:);
y_distances = distances(2,:);
z_distances = distances(3,:);
samples = 1000;

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

module = abs(array_factor);
phase = angle(array_factor);

normalized_module = module / max(module);
end