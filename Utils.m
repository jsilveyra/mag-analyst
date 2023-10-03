classdef Utils
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