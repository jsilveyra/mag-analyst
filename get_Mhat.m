function [Mhat, Mihat] = get_Mhat(H, a, alphaMs, Ms)
    Mhat = zeros(1, length(H));
    Mihat = zeros(length(a), length(H));

    for i = 1:length(H)
        for j = 1:length(a)
            m = Utils().get_m(H(i), a(j), alphaMs(j));
            Mihat(j, i) = Ms(j)*m;
            Mhat(i) = Mhat(i) + Mihat(j, i);
        end 
    end
end