function [res, matches] = isMatched(S)
%ISMATCHED Return true if tyhe given S matrix's system is matched in
%any port

% If it is matched, some Sii parameter is equals to cero
res = false;
matches = {};
for i_s = 1:size(S, 2)
    if abs(S(i_s, i_s)) == 0
        matches{1, end+1} = i_s;
    end
end
if size(matches,2) == i_s
    res = true;
else
    res = false;
end
end