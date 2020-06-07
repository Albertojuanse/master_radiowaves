function ABCD = ABCDofLossyLine(Z0, beta, longitude, alpha)
%ABCDOFLOSSYLINE 

gamma = alpha + 1j*beta;

A = cosh(gamma*longitude);
B = Z0*sinh(gamma*longitude);
C = (1/Z0)*sinh(gamma*longitude);
D = cosh(gamma*longitude);

ABCD = [A B; C D];