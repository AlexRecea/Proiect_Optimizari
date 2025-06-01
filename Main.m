clc;
clear;
close all;

% ===============================
% Parametrii de optimizare
% ===============================

w = 0.1;  % pondere energie vs cost (0 = doar cost, 1 = doar energie)
fun = @(x) functie_multiobiectiv(x, w);

% Punct de pornire
x0 = [1; 1; 1];  % [NPV, NWT, HUR]

% Limite pentru variabilele de decizie
lb = [0; 0; 0];
ub = [3000; 200; 40];

% Setări optimizare
options = optimoptions('fmincon', 'Display', 'iter');

% Optimizare
[x_opt, fval] = fmincon(fun, x0, [], [], [], [], lb, ub, @constr_energie_minima, options);

% ===============================
% Afișare rezultate
% ===============================

E_final = functie_energie(x_opt);
C_final = functie_cost(x_opt);
E_final_GW = E_final / 1000000;
C_final_Mil = C_final / 1000000;
fprintf('\n--- Rezultat Multi-Obiectiv (w = %.2f) ---\n', w);
fprintf('Număr panouri PV     : %.0f\n', x_opt(1));
fprintf('Număr turbine WIND   : %.0f\n', x_opt(2));
fprintf('Înălțime rezervor PHES: %.2f m\n', x_opt(3));
fprintf('Energie produsă      : %.2f GWh\n', E_final_GW);
fprintf('Cost total           : %.4f Mil_USD\n', C_final_Mil);