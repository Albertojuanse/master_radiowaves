function S = cascadeS(S1, Z011, Z012, S2, Z021, Z022)
%CASCADES This function compose in cascade two S matrices

% Conversion into ABCD matrices
ABCD1 = StoABCD(S1, Z011, Z012);
ABCD2 = StoABCD(S2, Z021, Z022);

% Calculus
ABCD = cascadeABCD(ABCD1, ABCD2);

% Final conversion
S = ABCDtoS(ABCD, Z011, Z022);
end