function Mhat = get_Mhat(H, a, alphaMs, Ms)
    Mhat = zeros(1, length(H));

    for i = 1:length(H)
        for j = 1:length(a)
            m = get_m(H(i), a(j), alphaMs(j));
            Mhat(i) = Mhat(i) + Ms(j)*m;
        end 
    end
end