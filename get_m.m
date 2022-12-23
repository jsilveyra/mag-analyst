function m = get_m(H, a, alphaMs)
    function ret = f_m(m)
        ret = Langevin((H + alphaMs*m)/a,0) - m;
    end
    m = fzero(@f_m, 0.5);
end