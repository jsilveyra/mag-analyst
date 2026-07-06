classdef Utils
%UTILS  Misc anhysteretic-model helpers.
%   get_m(H, a, alphaMs) solves m = L((H+alphaMs*m)/a) for a single
%   component's normalized magnetization via fzero. find_tip(H, M) returns
%   the (H, M) pair at the curve's maximum M (the loop "tip").
    methods
        function m = get_m(~, H, a, alphaMs)
            function ret = f_m(m)
                ret = Langevin((H + alphaMs*m)/a,0) - m;
            end
            m = fzero(@f_m, 0.5);
        end

        function [HTip, MTip] = find_tip(~, H, M)
            [MTip, i] = max(M);
            HTip = H(i);
        end
    end
end