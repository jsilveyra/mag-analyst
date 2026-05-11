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

    if ~isstruct(p) || ~isfield(p, 'Ms') || ~isfield(p, 'a')
        error('anhysteretic:InvalidParams', ...
            'Input p must be a struct with fields Ms and a.');
    end

    h = Heff ./ p.a;
    Lh = Langevin(h, 0);
    dLdh = Langevin(h, 1);

    Manh = p.Ms .* Lh;
    dManh_dHeff = (p.Ms ./ p.a) .* dLdh;
end

