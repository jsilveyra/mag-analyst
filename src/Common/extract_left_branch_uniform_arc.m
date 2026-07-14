function [H_left, M_left] = extract_left_branch_uniform_arc(H_in, M_in, number_points)
%EXTRACT_LEFT_BRANCH_UNIFORM_ARC  Descending (upper/left) branch of a loop.
%   [H_left, M_left] = extract_left_branch_uniform_arc(H_in, M_in, number_points)
%   takes a measured hysteresis loop (H_in, M_in), locates its tip corner
%   (the point maximizing a normalized H^2 + M^2 score), and returns the
%   branch running from that tip down to the opposite corner, resampled to
%   `number_points` samples uniformly spaced in arc length. Pass an empty or
%   <2 number_points to keep the branch's native sampling.
%
%   Shared by the Hysteretic-fitting tab (build_ja_data_cycle,
%   get_hysteretic_left_branch_data, retrieve_ja_seeds, fit_ja_parameters)
%   and the Playground (data-remanence extraction). MagAnalyst also relies on
%   robust left-branch extraction implicitly, since the anhysteretic curve is
%   built by averaging the left and right hysteresis branches.

    H = H_in(:)';
    M = M_in(:)';
    valid = isfinite(H) & isfinite(M);
    H = H(valid);
    M = M(valid);

    if numel(H) < 2
        H_left = H;
        M_left = M;
        return;
    end

    [~, H_min_index] = min(H);
    H_sorted = [H(H_min_index:end) H(1:H_min_index)];
    M_sorted = [M(H_min_index:end) M(1:H_min_index)];

    denom_H = max(H_sorted.^2);
    denom_M = max(M_sorted.^2);
    if denom_H == 0
        denom_H = 1;
    end
    if denom_M == 0
        denom_M = 1;
    end

    H2M2 = sign(H_sorted).*(H_sorted).^2./denom_H + sign(M_sorted).*(M_sorted).^2./denom_M;
    [~, max_index] = max(H2M2);
    H_left_raw = H_sorted(max_index:end);
    M_left_raw = M_sorted(max_index:end);

    if nargin < 3 || isempty(number_points) || number_points < 2
        number_points = numel(H_left_raw);
    end

    ds = hypot(diff(H_left_raw), diff(M_left_raw));
    s = [0 cumsum(ds)];
    [s_unique, idx_unique] = unique(s, 'stable');

    if numel(s_unique) < 2
        H_left = H_left_raw;
        M_left = M_left_raw;
        return;
    end

    H_unique = H_left_raw(idx_unique);
    M_unique = M_left_raw(idx_unique);
    s_query = linspace(s_unique(1), s_unique(end), round(number_points));
    H_left = interp1(s_unique, H_unique, s_query, 'linear');
    M_left = interp1(s_unique, M_unique, s_query, 'linear');
end
