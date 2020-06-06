function [] = dibuja_FA_normalizado(N, L, a, beta)
%ARGUMENTOS
% N = número de antenas
% L = distancia en longitudes de onda entre las mismas
% a = excitaciones de cada una

c = 3e8;
f = 3e9;

lambda0 = c/f;

zn = L;
d = 0.4;

k0 = 2*pi/lambda0;

phi = linspace(-2*pi, 2*pi, 5000);
% theta =  linespace(0, pi, 5000);

theta = acos((phi-beta)/(0.4*2*pi));

FA = [];

for i = 1:numel(phi)
    FA_aux = 0;
    for k=1:N
        FA_aux = FA_aux + a(k).*exp(j*2*pi*zn(k)*cos(theta(i)) + beta);
    end
    
    FA(i) = FA_aux; 
    
end

limiteMV_inf = -2*pi*d + beta;
limiteMV_sup = 2*pi*d + beta;

FA_norm = FA/max(FA);

figure;
plot(phi, 20*log10(abs(FA_norm)))
xlim([limiteMV_inf limiteMV_sup])


end