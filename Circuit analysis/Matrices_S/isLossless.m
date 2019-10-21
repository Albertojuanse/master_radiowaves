function res = isLossless(S)
%ISLOSSLESS Return true if tyhe given S matrix's system is lossless

% If it is reciprocal, S-parameter matrix will be equal to its transpose
    S_ctraspose = S';
    if (S == S_ctraspose)
        res = true;
    else
        res = false;
    end
end

