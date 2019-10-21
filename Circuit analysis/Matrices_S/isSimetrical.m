function res = isSimetrical(S)
%ISSIMETRICAL Return true if tyhe given S matrix's system is simetrical in
%any port

% If it is simetrical, some Sii parameter is equals to other Sjj
res = false;
for i_s = 1:size(S, 2)
    for j_s = 1:size(S, 2)
        
        % If not itself
        if i_s ~= j_s
            
            % Compare each S parameter with others
            if S(i_s, i_s) == S(j_s, j_s)
                res = true;                
            end
            
        end
        
    end
end
end

