function res = isReciprocal(S)
%ISRECIPROCAL Return true if tyhe given S matrix's system is reciprocal

% If it is reciprocal, S-parameter matrix will be equal to its transpose
    S_traspose = S.';
    if (S == S_traspose)
        res = true;
    else
        res = false;
    end
end

