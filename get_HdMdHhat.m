function HdMdHhat = get_HdMdHhat(H, dMdHhat)
    HdMdHhat = zeros(1, length(H));
    for i = 1:length(H)
        HdMdHhat(i) = H(i)*dMdHhat(i);
    end
end