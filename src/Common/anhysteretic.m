function [Manh, dManh_dHeff] = anhysteretic(Heff, p)
%ANHYSTERETIC Anhysteretic magnetization and derivative for JA model
%
%   [Manh, dManh_dHeff] = anhysteretic(Heff, p)
%
%   Manh = Ms * L(h)
%   dManh/dHeff = (Ms/a) * L'(h)
%   h = Heff / a
%
%   Inputs:
%     Heff : effective field [A/m]
%     p    : struct with fields p.Ms and p.a
%
%   Outputs:
%     Manh         : anhysteretic magnetization [A/m]
%     dManh_dHeff  : derivative dManh/dHeff

    % No argument validation: called from the ODE right-hand side (see
    % ja_ode.m); a malformed p fails on the field access below.
    h = Heff ./ p.a;
    % L(h) and L'(h) inlined from LangevinPrivate (same formulas, same
    % three-term Taylor switch at |h| <= 1e-3): the two Langevin() calls
    % were half of the ODE right-hand side's cost (2026-09-19 profile).
    % Keep in sync with LangevinPrivate.L / .first_derivative.
    if abs(h) <= 0.001
        Lh = h/3 - (h^3)/45 + (2/945)*(h^5);
        dLdh = 1/3 - (h^2)/15 + (2/189)*h^4;
    else
        Lh = coth(h) - 1/h;
        dLdh = 1/(h^2) - csch(h)^2;
    end

    Manh = p.Ms .* Lh;
    dManh_dHeff = (p.Ms ./ p.a) .* dLdh;
end

