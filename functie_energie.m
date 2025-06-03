function [energie_total, E_PV_total, E_WT_total, E_PHES_total] = functie_energie(x)
    NPV = x(1);
    NWT = x(2);
    HUR = x(3);

    % === Solar ===
    Prated_PV = 0.25; Y_PV = 0.85; eta_INV = 0.95; eta_PV = 0.191;
    G_day = mean([4.998,4.907,5.023,4.813,4.460,4.236,3.483,3.868,4.274,4.561,4.952,4.899]);
    E_PV_total = NPV * Prated_PV * Y_PV * eta_INV * eta_PV * G_day * 365;

    % === Eolian ===
    Prated_WT = 1650; CF = 0.20; hours_per_year = 8760;
    E_WT_total = NWT * Prated_WT * CF * hours_per_year;

    % === PHES ===
    rho_water = 1000; g = 9.81; Q = 0.2; t_sec = 86400; eta_PHES = 0.608;
    V = Q * t_sec;
    E_PHES_day = eta_PHES * rho_water * V * g * HUR / 3.6e6;
    E_PHES_total = E_PHES_day * 365;

    energie_total = E_PV_total + E_WT_total + E_PHES_total;
end
