function res = isLossless(S)
%ISLOSSLESS Return true if tyhe given S matrix's system is lossless

% If it is lossless, S-parameter matrix will be equal to its conjugate transpose
    S_ctraspose = S';
    if (S == S_ctraspose)
        res = true;
    else
        res = false;
    end
end

