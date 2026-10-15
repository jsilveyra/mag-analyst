function s = signed_point_to_polyline_distance(points, polyline, chunk)
%SIGNED_POINT_TO_POLYLINE_DISTANCE  Point-to-polyline distance with a side sign.
%   s = signed_point_to_polyline_distance(points, polyline) is
%   point_to_polyline_distance(points, polyline) with the sign of the cross
%   product of the nearest segment's direction and the vector from its
%   nearest point to the data point: positive on the left of the polyline's
%   direction of travel, negative on the right. For a closed loop traversed
%   in one direction the sign separates the inside from the outside, so
%   abs(s) is the usual distance and s changes sign, smoothly, when the model
%   crosses a data point.
%
%   Used for the residual vector of the DFO-LS solver (dfols_mat, via
%   DiagonalErrorCalculator.get_residuals); the fit objective itself is
%   unchanged, since sum(s.^2) = sum(d.^2). Why signed (2026-09-25 trials on
%   the LMAG 2026 benchmark loops): DFO-LS models each residual linearly,
%   and an unsigned distance has a kink at zero, where the model curve
%   crosses a data point; with the sign the residual is smooth there. Same
%   polished fits either way, but fewer evaluations with the sign (e.g.
%   1188 -> 635 on one loop) and a cleaner convergence on the synthetic loop.

    if nargin < 3 || isempty(chunk)
        chunk = 256;
    end
    P = points;
    A = polyline(1:end-1, :);
    D = polyline(2:end, :) - A;
    L2 = sum(D.^2, 2);
    L2(L2 == 0) = 1;
    Ax = A(:, 1)'; Ay = A(:, 2)';
    Dx = D(:, 1)'; Dy = D(:, 2)';
    L2 = L2';

    N = size(P, 1);
    s = nan(N, 1);
    for i0 = 1:chunk:N
        i1 = min(N, i0 + chunk - 1);
        px = P(i0:i1, 1); py = P(i0:i1, 2);
        PAx = px - Ax;
        PAy = py - Ay;
        t = (PAx .* Dx + PAy .* Dy) ./ L2;
        t = min(max(t, 0), 1);
        ex = PAx - t .* Dx;
        ey = PAy - t .* Dy;
        [d2, j] = min(ex.^2 + ey.^2, [], 2);
        idx = sub2ind(size(ex), (1:numel(j))', j);
        crs = Dx(j)' .* ey(idx) - Dy(j)' .* ex(idx);
        sg = sign(crs);
        sg(sg == 0) = 1;
        s(i0:i1) = sg .* sqrt(d2);
    end
end
