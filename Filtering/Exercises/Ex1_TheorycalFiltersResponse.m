
%% Exercise 1
%

m = 1000;
n = 1;

[pulsation, module, phase] = LowPassPrototipeButterworthFilter(n, m);

plot(pulsation, module)
hold on;

m = 1000;
n = 2;

[pulsation, module, phase] = LowPassPrototipeButterworthFilter(n, m);

plot(pulsation, module)
hold on;

m = 1000;
n = 3;

[pulsation, module, phase] = LowPassPrototipeButterworthFilter(n, m);

plot(pulsation, module)
hold on;

m = 1000;
n = 4;

[pulsation, module, phase] = LowPassPrototipeButterworthFilter(n, m);
plot(pulsation, module)
hold on;

m = 1000;
n = 5;
[pulsation, module, phase] = LowPassPrototipeButterworthFilter(n, m);

plot(pulsation, module)
hold on;


m = 1000;
n = 6;

[pulsation, module, phase] = LowPassPrototipeButterworthFilter(n, m);


plot(pulsation, module)
hold on;

m = 1000;
n = 1;
epsilon = 1;

[pulsation, module, phase] = LowPassPrototipeChebychevFilter(n, m, epsilon);

plot(pulsation, module)
hold on;

m = 1000;
n = 2;
epsilon = 1;

[pulsation, module, phase] = LowPassPrototipeChebychevFilter(n, m, epsilon);

plot(pulsation, module)
hold on;

m = 1000;
n = 3;
epsilon = 1;

[pulsation, module, phase] = LowPassPrototipeChebychevFilter(n, m, epsilon);

plot(pulsation, module)
hold on;

m = 1000;
n = 4;
epsilon = 1;

[pulsation, module, phase] = LowPassPrototipeChebychevFilter(n, m, epsilon);

plot(pulsation, module)
hold on;

m = 1000;
n = 5;
epsilon = 1;

[pulsation, module, phase] = LowPassPrototipeChebychevFilter(n, m, epsilon);

plot(pulsation, module)

xlim([0 1]);
ylim([0 3]);
hold off;
