function val = functie_multiobiectiv(x, w)
    E = functie_energie(x);     % energie produsă în kWh
    C = functie_cost(x);        % cost total în USD

    val = w * (-E) + (1 - w) * C;
end