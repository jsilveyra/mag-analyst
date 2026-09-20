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

    % No argument validation here on purpose: this is the ODE right-hand
    % side, called ~1e4 times per simulated branch, and the isstruct/
    % isfield/delta checks that used to sit here cost about as much as the
    % arithmetic (2026-09-19 profile). A malformed p fails on the first
    % field access below with an equally clear error.
    Heff = H + p.alpha .* M;
    [Manh, dManh_dHeff] = anhysteretic(Heff, p);

    deltaM = 0.5 .* (1 + sign(Manh - M) .* delta);

    num = p.k .* delta .* p.c .* dManh_dHeff ...
        + (Manh - M) .* deltaM;
    den = p.k .* delta - p.alpha .* num;

    dMdH = num ./ den;
end

