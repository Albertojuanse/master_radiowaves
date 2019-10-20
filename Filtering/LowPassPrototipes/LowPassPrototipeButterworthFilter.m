function [pulsation, module, phase] = LowPassPrototipeButterworthFilter(n, m, pulsation_max)
%LOWPASSPROTOTIPEBUTTERWORTHFILTER Generates the theorycal m points
%response of a given n order Butterworth filter.

% Input varialbles
pulsation = linspace(0, pulsation_max, m);

% The theorical response of a Butterwirth filter is
phase = zeros(size(pulsation, 2));
module = 1 ./ ( 1 + pulsation.^(2*n) );

end