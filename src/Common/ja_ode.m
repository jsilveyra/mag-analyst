function dMdH = ja_ode(H, M, p, delta)
%JA_ODE Right-hand side of the Jiles-Atherton differential equation
%
%   dM/dH = num / den
%
%   num = k*delta*c*dManh_dHeff + (Manh - M)*deltaM
%   den = k*delta - alpha*num
%
%   Inputs:
%     H     : applied magnetic field [A/m]
%     M     : magnetization [A/m]
%     p     : struct with fields Ms, a, alpha, k, c
%     delta : sign(dH), expected +1 or -1
%
%   Output:
%     dMdH  : differential susceptibility dM/dH

    required_fields = {'Ms', 'a', 'alpha', 'k', 'c'};
    if ~isstruct(p) || ~all(isfield(p, required_fields))
        error('ja_ode:InvalidParams', ...
            'Input p must be a struct with fields Ms, a, alpha, k, c.');
    end

    if ~(isscalar(delta) && (delta == 1 || delta == -1))
        error('ja_ode:InvalidDelta', 'delta must be +1 or -1.');
    end

    Heff = H + p.alpha .* M;
    [Manh, dManh_dHeff] = anhysteretic(Heff, p);

    deltaM = 0.5 .* (1 + sign(Manh - M) .* delta);

    num = p.k .* delta .* p.c .* dManh_dHeff ...
        + (Manh - M) .* deltaM;
    den = p.k .* delta - p.alpha .* num;

    dMdH = num ./ den;
end

