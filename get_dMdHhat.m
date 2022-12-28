function dMdHhat = get_dMdHhat(H, alpha, Ms, a, alphaMs)
    dMdHhat = zeros(1, length(H));
    for i = 1:length(H)
        for j = 1:length(a)
            m = Utils().get_m(H(i), a(j), alphaMs(j));
            h = (H(i)+m*alphaMs(j))/a(j);
            numerator = Ms(j)*Langevin(h,1)/a(j);
            dMdHhat(i) = dMdHhat(i) + numerator/(1-alpha(j)*numerator);
        end  
    end
end