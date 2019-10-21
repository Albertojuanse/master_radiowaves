function res = isLossless(S)
%ISLOSSLESS Return true if tyhe given S matrix's system is lossless

% If it is lossless, S-parameter matrix will be equal to its conjugate transpose
    S_ctranspose = S';
    S_ctranspose_S = S_ctranspose.*S;
    if (S_ctranspose_S == eye(size(S_ctranspose,1)))
        res = true;
    else
        res = false;
    end
end

