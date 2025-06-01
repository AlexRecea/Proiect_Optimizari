clc;
clear;
close all;

% === Cerință ===
E_cerut = 900000;       % [kWh/an]
toleranta = 5;       % admitem o eroare de max. 5 MWh

% === Gama de test pentru PV și WIND ===
NPV_values = 100:100:2000;
NWT_values = 1:1:20;

% === Căutare combinații valide PV + WIND ===
rezultate = [];

for npv = NPV_values
    for nwt = NWT_values
        x_test = [npv, nwt, 0];  % HUR = 0 temporar
        E_pv_wind = functie_energie(x_test);  % doar partea de producție
        
        if E_pv_wind >= E_cerut
            rezultate = [rezultate; npv, nwt, E_pv_wind];
        end
    end
end

% === Alegem cea mai apropiată combinație peste E_cerut ===
[min_diff, idx] = min(rezultate(:,3) - E_cerut);
npv_final = rezultate(idx, 1);
nwt_final = rezultate(idx, 2);

% === Optimizare HUR pentru ajustare finală ===
best_diff = inf;
best_hur = 0;
best_energy = 0;

for hur = 0:1:100
    x = [npv_final, nwt_final, hur];
    E_total = functie_energie(x);
    diff = abs(E_total - E_cerut);

    if diff < best_diff
        best_diff = diff;
        best_hur = hur;
        best_energy = E_total;
    end
end

% === Afișare rezultat final ===
fprintf("\n--- CONFIGURAȚIE OPTIMĂ ---\n");
fprintf("Număr panouri PV: %d\n", npv_final);
fprintf("Număr turbine WIND: %d\n", nwt_final);
fprintf("Înălțime rezervor PHES (HUR): %d m\n", best_hur);
fprintf("Energie totală produsă: %.2f kWh\n", best_energy);
fprintf("Diferență față de cerere: %.2f kWh\n", best_energy - E_cerut);