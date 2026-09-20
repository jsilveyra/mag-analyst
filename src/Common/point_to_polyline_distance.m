function d = point_to_polyline_distance(points, polyline, chunk)
%POINT_TO_POLYLINE_DISTANCE  Exact Euclidean distance from points to a polyline.
%   d = point_to_polyline_distance(points, polyline) returns, for each row of
%   points (N x 2), the shortest distance to the open polyline whose vertices
%   are the rows of polyline (M x 2), i.e. the minimum over its M-1 segments
%   of the distance to the segment (end points included). Same result as
%   distance2curve(polyline, points, 'linear') (src/lib/distance2curve), to
%   rounding, but computed in chunks of `chunk` points (default 256) so the
%   N x (M-1) intermediate arrays stay cache-sized: for the ~1600-point
%   measured cycles the Hysteretic fit compares since 2026-09-19 this is
%   several times faster than distance2curve, which allocates the full
%   N x M temporaries (2026-09-19 profile: 218 ms -> see get_continuous_error).
%
%   Non-finite points give NaN. Degenerate (zero-length) segments are
%   treated as their end point.

    if nargin < 3 || isempty(chunk)
        chunk = 256;
    end
    P = points;
    A = polyline(1:end-1, :);
    D = polyline(2:end, :) - A;             % segment vectors
    L2 = sum(D.^2, 2);                      % squared segment lengths (M-1 x 1)
    L2(L2 == 0) = 1;                        % zero-length: t = 0 below, distance to A
    Ax = A(:, 1)'; Ay = A(:, 2)';           % row vectors, 1 x (M-1)
    Dx = D(:, 1)'; Dy = D(:, 2)';
    L2 = L2';

    N = size(P, 1);
    d = nan(N, 1);
    for i0 = 1:chunk:N
        i1 = min(N, i0 + chunk - 1);
        px = P(i0:i1, 1); py = P(i0:i1, 2);           % n x 1
        PAx = px - Ax;                                 % n x (M-1)
        PAy = py - Ay;
        t = (PAx .* Dx + PAy .* Dy) ./ L2;             % projection parameter
        t = min(max(t, 0), 1);                         % clamp to the segment
        ex = PAx - t .* Dx;
        ey = PAy - t .* Dy;
        d(i0:i1) = sqrt(min(ex.^2 + ey.^2, [], 2));
    end
end
