function val = functie_multiobiectiv_LM(x, E_cerut, w)
    E = functie_energie(x);
    C = functie_cost_total(x);

    if E < E_cerut
        val = 1e4 + 10 * (E_cerut - E);  % penalizare severă la deficit
        return;
    end

    if E > E_cerut + 1000
        penalizare = 1e3 + (E - E_cerut - 1000);  % penalizare ușoară la exces
    else
        penalizare = 0;
    end

    C_norm = C / 1e7;
    E_diff_norm = (E - E_cerut) / E_cerut;

    val = penalizare + w * E_diff_norm + (1 - w) * C_norm;
end
