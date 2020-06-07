function [module_S21, module_S11] = LowPassPrototipeButterworthFilter(n, pulsation)
%LOWPASSPROTOTIPEBUTTERWORTHFILTER Generates the theorycal m points
%response of a given n order Butterworth filter.

% The theorical response of a Butterwirth filter is
module_S21 = 1 ./ ( 1 + (pulsation.^(2*n)) );
module_S11 = (pulsation.^(2*n))./(1+(pulsation.^(2*n)));

end