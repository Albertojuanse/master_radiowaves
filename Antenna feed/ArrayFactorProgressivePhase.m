function [array_factor, lim_inf, lim_sup] = ArrayFactorProgressivePhase(number_of_antennas,distances,excitations,progresive_phase)
%ARRAYFACTOR This function returns the normalized array factor given 
% as arguments the number of antennas, the distance between them in lambdas
% its amplitude excitations and its relative progressive phase.

% Error control
if number_of_antennas ~= size(distances,2)
    if number_of_antennas ~= size(excitations,2)
        fprintf('[ERROR] The input arguments must be equal sized.\r\n')
        return;
    end
end

samples = 1000;

%% Phase
distance_between_elements = distances(1,2) - distances(1,1);
psi = linspace(-2*pi, 2*pi, samples);
theta = acos((psi-progresive_phase)/(distance_between_elements*2*pi));

%% Array factor
array_factor = zeros(samples,1);

for i_sample = 1:samples
    for i_antenna = 1:number_of_antennas
        shift = exp(1j*2*pi*distances(i_antenna)*cos(theta(i_sample)));
        array_factor(i_sample,1) = array_factor(i_sample,1) + excitations(i_antenna) * shift;
    end
end

%% Normalization and visible limits
array_factor = array_factor / max(array_factor);
lim_inf = -2*pi*distance_between_elements + progresive_phase;
lim_sup = 2*pi*distance_between_elements + progresive_phase;

end