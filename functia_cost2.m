function cost_total = functia_cost2(x)
    % x(1) = NPV – număr de panouri fotovoltaice
    % x(2) = NWT – număr de turbine eoliene
    % x(3) = HUR – înălțimea rezervorului superior (m)

%% ----------------------
%     PV SECTION
% -----------------------
NPV = x(1);
Prated_PV = 0.25;        % kW per panou (din tabel)
Y_PV = 0.85;             % derating factor
eta_PV = 0.191;          % eficiență panou
eta_INV = 0.95;          % eficiență invertor
G_day = 5.0;             % iradianță zilnică [kWh/m²/zi]
cost_per_kW_PV = 150;    % $/kW instalat

E_PV = NPV * Prated_PV * Y_PV * eta_PV * eta_INV * G_day * 365; % [kWh/an]
cost_PV = NPV * Prated_PV * cost_per_kW_PV;

%% ----------------------
%     WIND SECTION
% -----------------------
NWT = x(2);
v = 4.3313;              % viteza medie anuală [m/s]
rho_air = 1.225;         % densitate aer [kg/m³]
Cp = 0.35;               % coeficient performanță
DWTB = 82;               % diametru palete [m]
A = (pi / 4) * DWTB^2;   % aria rotorului [m²]
hours_per_year = 8760;

P_D = 0.5 * rho_air * v^3;     % densitate de putere [kW/m²]
P_WT = P_D * A * Cp;           % putere o turbină [kW]
E_WT_total = P_WT * hours_per_year * NWT;  % energie totală anuală [kWh]
Prated_WT = 1650;              % kW – turbină Vestas V82
cost_per_kW_WT = 1200;         % $/kW instalat
cost_WT = NWT * Prated_WT * cost_per_kW_WT;

%% ----------------------
%     PHES SECTION
% -----------------------
HUR = x(3);
rho_water = 1000;         % kg/m³
g = 9.81;                 % m/s²
Q = 0.2;                  % debit [m³/s]
t_day = 86400;            % secunde într-o zi
eta_PHES = 0.608;         % eficiență totală PHES
cost_per_kWh_PHES = 50;   % $/kWh stocat

V = Q * t_day;    % volum zilnic [m³]
E_PHES_day = eta_PHES * rho_water * V * g * HUR / 3.6e6;   % [kWh/zi]
E_PHES_total = E_PHES_day * 365;                          % [kWh/an]
cost_PHES = E_PHES_total * cost_per_kWh_PHES;

%% ----------------------
%     COST TOTAL
% -----------------------
cost_total = cost_PV + cost_WT + cost_PHES;

end