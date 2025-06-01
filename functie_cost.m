function cost_total = functie_cost(x)
    % x = [NPV, NWT, HUR]
    P_PV = 0.25;        % kW/panou
    P_WT = 1650;        % kW/turbina

    % Costuri conform Tabelul 4
    cost_per_kW_PV = 3518.60;    % USD/kW
    cost_per_kW_WT = 4197.42;    % USD/kW
    cost_per_kW_PHES = 4694.48;  % USD/kW 

    % Costuri individuale
    cost_PV = round(x(1)) * P_PV * cost_per_kW_PV;
    cost_WT = round(x(2)) * P_WT * cost_per_kW_WT;
    cost_PHES = x(3) * cost_per_kW_PHES;  % presupunem 1 kW stocabil/m HUR

    % Cost total
    cost_total = cost_PV + cost_WT + cost_PHES;
end 