function [c, ceq] = constr_energie_minima(x)
    E = functie_energie(x);  % energie produsă totală
    E_referinta = 9000000;    % prag minim dorit în kWh

    c = -(E - E_referinta);  % c <= 0 ⇨ E ≥ E_ref
    ceq = [];                % fără constrângeri de egalitate
end