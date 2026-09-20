function dFdM = ja_ode_jacobian(H, M, p, delta)
%JA_ODE_JACOBIAN  d(dM/dH)/dM of the Jiles-Atherton ODE right-hand side.
%   dFdM = ja_ode_jacobian(H, M, p, delta) is the derivative with respect to
%   M of ja_ode(H, M, p, delta), handed to ode23tb through odeset's
%   'Jacobian' option by solve_ja_monotonic so the implicit solver does not
%   have to estimate it by finite differences at every step (extra
%   right-hand-side evaluations and a noisier Newton iteration).
%
%   With num = k*delta*c*Manh' + (Manh - M)*deltaM, den = k*delta - alpha*num
%   and F = num/den (see ja_ode.m), and deltaM piecewise constant,
%       dnum/dM = k*delta*c*Manh'' * (alpha/a) + (Manh' * alpha - 1)*deltaM
%       dden/dM = -alpha * dnum/dM
%       dF/dM   = (dnum*den - num*dden)/den^2 = k*delta * dnum/dM / den^2,
%   where Manh' = (Ms/a) L'(h), Manh'' = (Ms/a^2) L''(h), h = (H + alpha*M)/a.
%   L' and L'' use the same three-term Taylor switch at |h| <= 1e-3 as
%   LangevinPrivate (keep in sync).

    h = (H + p.alpha .* M) ./ p.a;
    if abs(h) <= 0.001
        Lh   = h/3 - (h^3)/45 + (2/945)*(h^5);
        dLdh = 1/3 - (h^2)/15 + (2/189)*h^4;
        d2L  = (-2/15)*h + (8/189)*h^3 - (2/225)*h^5;
    else
        ch = coth(h); cs2 = csch(h)^2;
        Lh   = ch - 1/h;
        dLdh = 1/(h^2) - cs2;
        d2L  = 2*ch*cs2 - 2/(h^3);
    end
    Manh = p.Ms .* Lh;
    dManh_dHeff = (p.Ms ./ p.a) .* dLdh;          % Manh'
    d2Manh = (p.Ms ./ p.a.^2) .* d2L;             % Manh''

    deltaM = 0.5 .* (1 + sign(Manh - M) .* delta);
    num = p.k .* delta .* p.c .* dManh_dHeff + (Manh - M) .* deltaM;
    den = p.k .* delta - p.alpha .* num;

    dnum = p.k .* delta .* p.c .* d2Manh .* p.alpha + (dManh_dHeff .* p.alpha - 1) .* deltaM;
    dFdM = p.k .* delta .* dnum ./ den.^2;
end
