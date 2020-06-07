function [module_S21, module_S11] =  LowPassPrototipeChebychevFilter(n, pulsation, epsilon)
%LOWPASSPROTOTIPECHEBYCHEVFILTER Generates the theorycal m points
%response of a given n order and epsilon Chebychev filter.

% The theorical response of a Butterwirth filter is
T = cosh(n*acosh(pulsation));
module_S21 = 1 ./ ( 1 + ( (epsilon^2).*(T.^2) ) );
module_S11 = ( (epsilon^2).*(T.^2) )./( 1 + ((epsilon^2).*(T.^2)) );

end