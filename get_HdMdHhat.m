function [HdMdHhat, HdMidHhat] = get_HdMdHhat(H, dMidHhat)
    HdMdHhat = zeros(1, length(H));
    HdMidHhat = zeros(size(dMidHhat,1), length(H));

    for i = 1:length(H)
        for j = 1:size(dMidHhat,1)
            HdMidHhat(j, i) = H(i)*dMidHhat(j, i);
            HdMdHhat(i) = HdMdHhat(i) + HdMidHhat(j, i);
        end
    end
end