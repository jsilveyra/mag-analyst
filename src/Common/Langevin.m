function ret = Langevin(h, order)
%LANGEVIN  Langevin function L(h), its inverse, and its derivatives.
%   ret = Langevin(h, order) evaluates, for the reduced field h:
%     order = -1  ->  L^-1(m), the inverse Langevin function (Kroeger's
%                     approximant; the argument is then a reduced
%                     magnetization m rather than a reduced field)
%     order =  0  ->  L(h)   = coth(h) - 1/h
%     order =  1  ->  L'(h)  = 1/h^2 - csch^2(h)
%     order =  2  ->  L''(h) = 2*coth(h)*csch^2(h) - 2/h^3
%
%   L, L' and L'' switch to their Taylor expansion about the origin for
%   |h| <= 0.001, where the coth(h) - 1/h form loses accuracy to
%   catastrophic cancellation.
%
%   See also LangevinPrivate.
    % LangevinPrivate is stateless, so build it once: this function is the
    % innermost call of the JA ODE right-hand side (twice per ja_ode call,
    % ~1e4 calls per simulated branch) and constructing the object on every
    % call was ~half of the right-hand side's cost (2026-09-19 profile:
    % 75 us -> 30 us per ja_ode call).
    persistent L
    if isempty(L)
        L = LangevinPrivate();
    end
    switch order
        case -1
            ret = L.inverse(h);
        case 0
            ret = L.L(h);
        case 1
            ret = L.first_derivative(h);
        case 2
            ret = L.second_derivative(h);
        otherwise
            error('Langevin:InvalidOrder', ...
                'order must be -1, 0, 1 or 2 (got %g).', order);
    end
end
