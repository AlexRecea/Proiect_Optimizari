clc;
clear;
close all;

% === Parametri de optimizare ===
E_cerut = 900;     % cererea anuală [kWh]
E_cerut_MW = E_cerut * 1000;
lambda = 0.01;       % parametru LM (adaptiv)
tol = 1e-3;          % toleranță pentru oprire
h = 1e-5;            % pas pentru derivare numerică
max_iter = 100;      % număr maxim de iterații

% === Punct inițial logic ===
x = [1; 1; 1];    % [NPV, NWT, HUR]

% === Funcția f(x) = energie_produsă - energie_cerută ===
f = @(x) functie_energie(x) - E_cerut_MW;

% === Algoritm Levenberg-Marquardt ===
for iter = 1:max_iter
    fx = f(x);
    
    % Gradient numeric
    grad = zeros(3,1);
    for j = 1:3
        xj = x;
        xj(j) = xj(j) + h;
        grad(j) = (f(xj) - fx) / h;
    end

    % Hessiana aproximativă
    H = grad * grad';  % produs vectorial
    
    % Matrice LM
    H_lm = H + lambda * eye(3);
    
    % Calcul pas LM
    delta = -inv(H_lm) * grad * fx;
    x_new = x + delta;
    
% === Rotunjire și limitare ===
    x_new(1) = min(max(0, round(x_new(1))), 3000);   % NPV – rotunjit la întreg
    x_new(2) = min(max(0, round(x_new(2))), 30);     % NWT – rotunjit la întreg
    x_new(3) = min(max(0, x_new(3)), 100);           % HUR – continuă

    fx_new = f(x_new);

    % Afișare progres
    fprintf("Iterația %d: x = [%.0f, %.0f, %.2f] --> E = %.2f kWh\n", ...
        iter, x_new(1), x_new(2), x_new(3), fx_new + E_cerut_MW);

    % Verificare oprire
    if abs(fx_new) < tol
        x = x_new;
        break;
    end

    % Adaptare lambda
    if abs(fx_new) < abs(fx)
        lambda = lambda / 10;
        x = x_new;
    else
        lambda = lambda * 10;
    end
end

% === Rezultate finale ===
E_final = functie_energie(x);
fprintf("\n--- REZULTAT FINAL ---\n");
fprintf("Număr panouri PV: %.2f\n", x(1));
fprintf("Număr turbine WIND: %.2f\n", x(2));
fprintf("Înălțime PHES: %.2f m\n", x(3));
fprintf("Energie totală produsă: %.2f kWh\n", E_final);
fprintf("Diferență față de cerere: %.2f kWh\n", E_final - E_cerut_MW);