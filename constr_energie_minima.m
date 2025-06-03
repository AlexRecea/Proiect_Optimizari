function [c, ceq] = constr_energie_minima(x)
    E = functie_energie(x);
    E_referinta = 9e6;
    c = E_referinta - E;  % vrem E >= E_ref => c <= 0
    ceq = [];
end
