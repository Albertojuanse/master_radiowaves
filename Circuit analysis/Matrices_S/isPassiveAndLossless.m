function res = isPassiveAndLossless(S)
%ISPASSIVEANDLOSSLESS Return true if tyhe given S matrix's system is
%lossless and passive
S_ctraspose_S = S'.*S;
    if (eye(size(S_ctraspose_S,1)) == S_ctraspose_S)
        res = true;
    else
        res = false;
    end
end

