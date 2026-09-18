function [H_right, M_right] = extract_right_branch_uniform_arc(H_in, M_in, number_points)
%EXTRACT_RIGHT_BRANCH_UNIFORM_ARC  Ascending (lower/right) branch of a loop.
%   [H_right, M_right] = extract_right_branch_uniform_arc(H_in, M_in, number_points)
%   is the mirror image of extract_left_branch_uniform_arc: it returns the
%   MEASURED branch running from the loop's negative corner (-Htip, -Mtip)
%   up to the positive corner, resampled to `number_points` samples
%   uniformly spaced in normalized arc length. It is implemented by
%   point-reflecting the loop through the origin, extracting that loop's
%   descending branch with extract_left_branch_uniform_arc, and reflecting
%   the result back -- so the corner detection, the arc-length
%   normalization (max(|H|), max(|M|) over the loop, which are invariant
%   under the reflection) and the resampling are exactly those of the left
%   branch, and the two branches of a cycle are sampled the same way.
%
%   Used by HystereticUtils.build_ja_data_cycle_core, which since
%   2026-09-18 assembles the "Entire loop" data cycle from the two measured
%   branches (before that the right branch was the reflection of the left
%   one, so the data cycle was point-symmetric by construction and the fit
%   could not see any asymmetry of the measured loop).

    [H_neg, M_neg] = extract_left_branch_uniform_arc(-H_in, -M_in, number_points);
    H_right = -H_neg;
    M_right = -M_neg;
end
