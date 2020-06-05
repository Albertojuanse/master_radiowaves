function res = isLossless(S)
%ISLOSSLESS Return true if tyhe given S matrix's system is lossless

% If it is lossless, S-parameter matrix will be equal to its conjugate transpose
%     S_ctranspose = S';
%     S_ctranspose_S = S_ctranspose.*S;
%     if (S_ctranspose_S == eye(size(S_ctranspose,1)))
%         res = true;
%     else
%         res = false;
%     end

filas_sin_perdidas = 0;
for i_fila = 1:size(S,1)
    x = sum(abs(S(i_fila,:).^2));
    if (x>0.999)
        filas_sin_perdidas = filas_sin_perdidas + 1;
    end
end
if filas_sin_perdidas == i_fila
    res = true;
else
    res = false;
end

end

