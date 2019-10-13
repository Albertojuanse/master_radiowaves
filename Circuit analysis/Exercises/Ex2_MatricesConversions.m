function S = Ex2_MatricesConversions()
%EX2_MATRICESCONVERSIONS Summary of this function goes here
%   Implemente una función que tome como entrada dos matrices de parámetros
%   S de un cuadripolo y su impedancia de referencia, y devuelva la matriz 
%   de parámetros ABCD. Implemente la función inversa.

% Declaration
S0 = [1 0, 0 1];
Z01 = 50;
Z02 = 50;

% Conversions
ABCD = StoABCD(S0, Z01, Z02);
S = ABCDtoS(ABCD, Z01, Z02);
end