function [H_left, M_left] = extract_left_branch_uniform_arc(H_in, M_in, number_points)
%EXTRACT_LEFT_BRANCH_UNIFORM_ARC  Descending (upper/left) branch of a loop.
%   [H_left, M_left] = extract_left_branch_uniform_arc(H_in, M_in, number_points)
%   takes a measured hysteresis loop (H_in, M_in), locates its tip corner
%   (the point maximizing a normalized H^2 + M^2 score), and returns the
%   branch running from that tip down to the opposite corner, resampled to
%   `number_points` samples uniformly spaced in arc length, computed in
%   H/M axes each normalized by their own tip value (max(|H|), max(|M|)
%   over the branch) so the two axes contribute comparably regardless of
%   their physical scale (e.g. H in A/m next to M converted from a B-type
%   unit, which can differ by orders of magnitude). Pass an empty or <2
%   number_points to keep the branch's native sampling.
%
%   Shared by the Hysteretic-fitting tab (build_ja_data_cycle,
%   get_hysteretic_left_branch_data, retrieve_ja_seeds, fit_ja_parameters)
%   and the Playground (data-remanence extraction). MagAnalyst also relies on
%   robust left-branch extraction implicitly, since the anhysteretic curve is
%   built by averaging the left and right hysteresis branches.

    % Corner detection is shared with the raw-branch extractor; this
    % function only adds the arc-length resampling.
    [H_left_raw, M_left_raw] = extract_left_branch(H_in, M_in);
    if numel(H_left_raw) < 2
        H_left = H_left_raw;
        M_left = M_left_raw;
        return;
    end
    denom_H = max(H_left_raw.^2);
    denom_M = max(M_left_raw.^2);
    if denom_H == 0
        denom_H = 1;
    end
    if denom_M == 0
        denom_M = 1;
    end
    if nargin < 3 || isempty(number_points) || number_points < 2
        number_points = numel(H_left_raw);
    end

    H_tip_scale = sqrt(denom_H);
    M_tip_scale = sqrt(denom_M);
    ds = hypot(diff(H_left_raw) / H_tip_scale, diff(M_left_raw) / M_tip_scale);
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
