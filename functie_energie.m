function cost_total = functie_energie(x)
    % Variabile de decizie
    NPV = x(1);   % numar panouri
    NWT = x(2);   % numar turbine
    % DWTB = x(3);  % diametru palelor (m) - se specifica ce pale se folosesc
    HUR = x(3);   % inaltime rezervor (m)

% ----------------------
% === SOLAR SECTION ===
% ----------------------

    Prated_PV = 0.25;      % kWh - putere fiecare panou
    Y_PV = 0.85;           % factor derating
    eta_INV = 0.95;        % eficienta invertor
    eta_PV = 0.191;        % eficienta panou
    % iradiatia zilnica
    G_day = (4.998+4.907+5.023+4.813+4.460+4.236+3.483+3.868+4.274+4.561+4.952+4.899)/12;
    cost_per_kW_PV = 150;  % $

    % Calcul energie PV - folosim formula 4b (dar nu facem pe ore ci doar o medie)
    E_PV_total = NPV * Prated_PV * Y_PV * eta_INV * eta_PV * G_day * 365;

% ----------------------
% === WIND SECTION ===
% ----------------------

    % Prated_WT = 1650;      % kW per turbină (1.65 MW)
    rho = 1.225;           % kg/m3 - standard la 0m altitudine
    Cp = 0.35;             % coeficient de performanta 
    v_mean = (4.425+4.770+4.395+3.870+3.570+4.425+5.100+5.280+4.710+3.855+3.615+3.960)/12;            % viteza medie vant (m/s)
    DWTB = 82;                % diametru palelor turbinei (m)
    A = (pi / 4) * DWTB^2;    % aria rotorului (m²)
    % cost_per_kW_WT = 1200; % $

    P_D = 0.5 * rho * v_mean^3;              % [kW/m²] – Eq. 6a - densitate de putere
    P_WT = P_D * A * Cp;                % [kW] – Eq. 7a - putere turbina
    hours_per_year = 8760;
    E_WT_total = P_WT * hours_per_year * NWT;  % [kWh/an]


% ----------------------
% === PHES SECTION ===
% ----------------------

    % Parametri fizici PHES (conform lucrare)
    rho_water = 1000;             % kg/m³
    g = 9.81;                     % m/s²
    Q = 0.2;                      % debit mediu zilnic [m³/s] (Q_g)
    t_sec = 86400;                % secunde într-o zi
    eta_PHES = 0.608;             % eficiență totală PHES (60.8%)

    % Volum total într-o zi
    V = Q * t_sec;                % [m³]
    E_PHES_day = eta_PHES * rho_water * V * g * HUR / 3.6e6;   % [kWh/zi]
    E_PHES_total = E_PHES_day * 365;                          % [kWh/an]

    % Cost PHES (estimare economică simplificată)
    % cost_per_kWh_PHES = 50;       % USD/kWh (din literatură)
    % cost_PHES = E_PHES_total * cost_per_kWh_PHES;


% ----------------------
% === COST TOTAL ===
% ----------------------

    cost_total = E_PV_total + E_WT_total + E_PHES_total;

end