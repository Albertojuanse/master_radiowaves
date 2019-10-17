function [pulsation, module, phase] =  LowPassPrototipeChebychevFilter(n, m, epsilon)
%LOWPASSPROTOTIPECHEBYCHEVFILTER Generates the theorycal m points
%response of a given n order and epsilon Chebychev filter.

% Input varialbles
pulsation_max = 1;
pulsation = linspace(0, pulsation_max, m);

% The theorical response of a Butterwirth filter is
phase = zeros(size(pulsation, 2));
module = 1 ./ ( 1 + epsilon^2 * cosh( n * acosh(pulsation) ) );

end