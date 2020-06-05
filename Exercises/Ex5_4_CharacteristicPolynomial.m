%% Exercise 4
% Utilizando el polinomio característico, hallar las direcciones de campo
% nulo en ψ en los casos anteriores.

% The characteristic polynomial is, for 7 elements
number_of_elements = 7;
zeros = roots(ones(1,number_of_elements));
zeros_module = abs(zeros);
zeros_angle = angle(zeros);
zeros_en = zeros_angle.*180./pi
zeros_real = real(zeros);
zeros_imag = imag(zeros);

hold on;
axis equal
plot(zeros,'x');
% Draw a circle for visual porpuses,
r = 1;
theta = linspace(0,2*pi,360);
x = r * cos(theta);
y = r * sin(theta);
h = plot(x, y);
hold off;