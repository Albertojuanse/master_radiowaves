
%% Exercise 1
%

m = 1000;
n = 1;
frequency_max = 1/2*pi;

[pulsation, module, phase] = LowPassPrototipeButterworthFilter(n, frequency_max, m);

plot(pulsation, module)
hold on;

m = 1000;
n = 2;
frequency_max = 1/2*pi;

[pulsation, module, phase] = LowPassPrototipeButterworthFilter(n, frequency_max, m);

plot(pulsation, module)
hold on;

m = 1000;
n = 3;
frequency_max = 1/2*pi;

[pulsation, module, phase] = LowPassPrototipeButterworthFilter(n, frequency_max, m);

plot(pulsation, module)
hold on;

m = 1000;
n = 4;
frequency_max = 1/2*pi;

[pulsation, module, phase] = LowPassPrototipeButterworthFilter(n, frequency_max, m);

plot(pulsation, module)
hold on;

m = 1000;
n = 5;
frequency_max = 1/2*pi;

[pulsation, module, phase] = LowPassPrototipeButterworthFilter(n, frequency_max, m);

plot(pulsation, module)
hold on;


m = 1000;
n = 6;
frequency_max = 1/2*pi;

[pulsation, module, phase] = LowPassPrototipeButterworthFilter(n, frequency_max, m);


plot(pulsation, module)
hold off;

