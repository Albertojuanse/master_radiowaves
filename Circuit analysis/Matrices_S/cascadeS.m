function S = cascadeS(Sa, Sb)
%CASCADES This function compose in cascade two S matrices

% function S = cascadeS(S1, Z011, Z012, S2, Z021, Z022)
% % Conversion into ABCD matrices
% ABCD1 = StoABCD(S1, Z011, Z012);
% ABCD2 = StoABCD(S2, Z021, Z022);
% 
% % Calculus
% ABCD = cascadeABCD(ABCD1, ABCD2);
% 
% % Final conversion
% S = ABCDtoS(ABCD, Z011, Z022);

S = zeros(2,2);

s11 = Sa(1,1) + (Sa(1,2)*Sb(1,1)*Sa(2,1))/(1 - Sb(1,1)*Sa(2,2));
s12 = (Sa(1,2)*Sb(1,2))/(1-Sb(1,1)*Sa(2,2));
s21 = (Sa(2,1)*Sb(2,1))/(1-Sb(1,1)*Sa(2,2));
s22 = Sb(2,2) + (Sb(1,2)*Sa(2,2)*Sb(2,1))/(1 - Sb(1,1)*Sa(2,2));

S = [s11 s12; s21 s22];
end