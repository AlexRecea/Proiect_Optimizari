function cost_total = functie_cost_total(x)
    P_PV = 0.25; P_WT = 1650;
    cost_kW_PV = 3518.60; cost_kW_WT = 4197.42; cost_kW_PHES = 4694.48;

    cost_PV = round(x(1)) * P_PV * cost_kW_PV;
    cost_WT = round(x(2)) * P_WT * cost_kW_WT;
    cost_PHES = x(3) * cost_kW_PHES;

    cost_total = cost_PV + cost_WT + cost_PHES;
end
