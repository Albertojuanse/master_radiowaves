function res = isPasive(S)
%ISPASIVE Return true if tyhe given S matrix's system is pasive

    S_conj_traspose = conj(S.');
    Q = eye(size(S,2)) - S*S_conj_traspose;
    if (Q >= 0)
        res = true;
    else
        res = false;
    end
end

