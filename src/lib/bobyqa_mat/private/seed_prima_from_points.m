function [bmat, zmat, idz, gq, hq, pq, xbase, xpt, kopt] = seed_prima_from_points(Y, fvals)
%SEED_PRIMA_FROM_POINTS  Construct PRIMA/NEWUOA's incremental-update state
%   (BMAT, ZMAT, IDZ, and the quadratic model GQ/HQ/PQ) generically from an
%   arbitrary poised interpolation set Y (n-by-npt, columns are points) and its
%   values FVALS. This decouples initialisation from NEWUOA's special +/-rhobeg
%   geometry, so bound-feasible initial points can seed PRIMA's machinery.
%
%   Convention (Powell 2006 / the NEWUOA paper): let W be the KKT matrix
%       W = [ A   P ;  P'  0 ],  A_ij = 0.5*(v_i·v_j)^2,  P = [1, v_i'],
%   with v_i = Y(:,i) - xbase (xbase = Y(:,1)). H = W^{-1} has blocks
%       H = [ Omega  Xi ;  Xi'  Ups ].
%   Then BMAT = [ Xi(:,2:n+1)' , Ups(2:n+1,2:n+1) ] (n-by-(npt+n)) and
%   Omega = ZMAT*diag(s)*ZMAT' with s in {-1,+1}, IDZ marking the sign split.
%   The model is Q(xbase+u) with gradient GQ = g at xbase, HQ = 0, and implicit
%   PQ = lambda (Omega/KKT coefficients), so Hessian = sum_k PQ_k v_k v_k'.
    n = size(Y, 1);
    npt = size(Y, 2);
    xbase = Y(:, 1);
    xpt = Y - xbase;                     % displacements; xpt(:,1) = 0
    V = xpt;

    A = 0.5 * (V' * V).^2;
    P = [ones(npt, 1), V'];
    W = [A, P; P', zeros(n + 1, n + 1)];

    % --- Model (RHS = function values) ---
    sol = W \ [fvals(:); zeros(n + 1, 1)];
    lambda = sol(1:npt);
    mu = sol(npt + 1:end);               % [c; g]
    gq = mu(2:end);
    hq = zeros(n, n);
    pq = lambda;

    % --- H = W^{-1} blocks ---
    Hinv = inv(W); %#ok<MINV>  (small dense system; explicit inverse is fine)
    Omega = Hinv(1:npt, 1:npt);
    Xi    = Hinv(1:npt, npt + 1:npt + n + 1);      % npt-by-(n+1)
    Ups   = Hinv(npt + 1:end, npt + 1:end);        % (n+1)-by-(n+1)

    bmat = [Xi(:, 2:end)', Ups(2:end, 2:end)];     % n-by-(npt+n)

    % --- Factor Omega = ZMAT*diag(s)*ZMAT' (rank npt-n-1), negatives first ---
    Omega = (Omega + Omega') / 2;
    [Vv, Dd] = eig(Omega);
    ev = diag(Dd);
    [~, order] = sort(abs(ev), 'descend');
    keep = order(1:npt - n - 1);         % drop the n+1 (near-)zero eigenvalues
    evk = ev(keep);
    Vk = Vv(:, keep);

    neg = evk < 0;
    idz = sum(neg) + 1;                  % columns 1:idz-1 carry sign -1
    col_order = [find(neg); find(~neg)];
    zmat = zeros(npt, npt - n - 1);
    for t = 1:numel(col_order)
        i = col_order(t);
        zmat(:, t) = sqrt(abs(evk(i))) * Vk(:, i);
    end

    [~, kopt] = min(fvals);
end
