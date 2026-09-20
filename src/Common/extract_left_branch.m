function [H_left, M_left] = extract_left_branch(H_in, M_in)
%EXTRACT_LEFT_BRANCH  Measured descending (upper/left) branch of a loop, as measured.
%   [H_left, M_left] = extract_left_branch(H_in, M_in) takes a measured
%   hysteresis loop (H_in, M_in), locates its positive tip corner (the point
%   maximizing a normalized H^2 + M^2 score) and returns the measured points
%   running from that tip down to the opposite (minimum-H) corner, in
%   measurement order, WITHOUT resampling -- every measured point of the
%   branch, exactly once, as row vectors. Non-finite pairs are dropped.
%
%   This is the branch the Hysteretic-fitting tab fits since 2026-09-19
%   (before, the branch was resampled to the Input tab's N points uniformly
%   in arc length, see extract_left_branch_uniform_arc, which now delegates
%   the corner detection to this function and only adds the resampling).
%
%   See also extract_right_branch, extract_left_branch_uniform_arc.

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

    % Rotate the closed loop so it starts at its minimum-H point; the
    % descending branch then runs from the tip corner to the end.
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

    H_left = H_sorted(max_index:end);
    M_left = M_sorted(max_index:end);
end
