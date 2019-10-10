function ABCD = ABCDofLine(Z0, beta, longitude)
%ABCDOFLINE This function calculates de ABCD matrix of a line of
%transmision given its charasteristic impedance, propagation constant and
%longitude.

% Compose de solution
ABCD = [cos(beta*longitude)            1j*Z0*sin(beta*longitude);
        1j*(1/Z0)*sin(beta*longitude)  cos(beta*longitude)     ];