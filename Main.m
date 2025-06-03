clc; clear; close all;

% === Parametri ===
E_cerut = 10.5e6;      % cerere anuală în kWh
w = 0.5;            % 0 = doar cost, 1 = doar energie

% === Funcție obiectiv ===
fun = @(x) functie_multiobiectiv_LM(x, E_cerut, w);

% === Limite variabile ===
lb = [0; 0; 0];           % [NPV, NWT, HUR]
ub = [3000; 30; 100];     % maxime realiste

% === Opțiuni GA ===
options = optimoptions('ga', 'Display', 'iter', ...
    'MaxGenerations', 100, 'PopulationSize', 100);

% === Optimizare ===
[x_opt, fval] = ga(fun, 3, [], [], [], [], lb, ub, [], options);

% === Rezultate finale ===
[E_final, E_PV, E_WT, E_PHES] = functie_energie(x_opt);
C_final = functie_cost_total(x_opt);

fprintf('\n=== Rezultat Final GA (w = %.2f) ===\n', w);
fprintf('Panouri PV     : %.0f\n', x_opt(1));
fprintf('Turbine WIND   : %.0f\n', x_opt(2));
fprintf('Înălțime PHES  : %.2f m\n', x_opt(3));
fprintf('Energie totală : %.2f GWh\n', E_final / 1e6);
fprintf(' - PV          : %.2f GWh\n', E_PV / 1e6);
fprintf(' - Eolian      : %.2f GWh\n', E_WT / 1e6);
fprintf(' - PHES        : %.2f GWh\n', E_PHES / 1e6);
fprintf('Cost total     : %.2f Mil USD\n', C_final / 1e6);
fprintf('Diferență față de cerere: %.2f kWh\n', E_final - E_cerut);
