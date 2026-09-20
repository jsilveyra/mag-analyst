function [H_right, M_right] = extract_right_branch(H_in, M_in)
%EXTRACT_RIGHT_BRANCH  Measured ascending (lower/right) branch of a loop, as measured.
%   [H_right, M_right] = extract_right_branch(H_in, M_in) is the mirror image
%   of extract_left_branch: the measured points running from the loop's
%   negative corner up to the positive one, in measurement order, without
%   resampling. Implemented by point-reflecting the loop through the origin,
%   taking that loop's descending branch and reflecting it back, so the
%   corner detection is exactly that of the left branch.
%
%   See also extract_left_branch, extract_right_branch_uniform_arc.

    [H_neg, M_neg] = extract_left_branch(-H_in, -M_in);
    H_right = -H_neg;
    M_right = -M_neg;
end
