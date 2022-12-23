function [a, alphaMs, Ms] = magnetic_parameters(H, M, Hcr, mcr)
    a = get_a(Hcr, mcr);
    alphaMs = get_alphaMs(Hcr, mcr, a);
    Ms = get_Ms(H, M, Hcr, alphaMs, a);
end

function p = P(m)
    numerator = Langevin(Langevin(m,-1),1);
    denominator = m - Langevin(m,-1) * Langevin(Langevin(m,-1),1);
    p = numerator/denominator;
end

function q = Q(m)
    a = m / Langevin(Langevin(m,-1),1);
    b = -Langevin(Langevin(m,-1),2);
    c = 2 * ( m - Langevin(m,-1) * Langevin(Langevin(m,-1),1) );
    q = ((a^2) * b / c) - 1;
end

function a = get_a(Hcr, mcr)
    a = zeros(1, length(Hcr));
    for i = 1:length(Hcr)
        a(i) = Hcr(i) * P(mcr(i)) * ( Q(mcr(i)) - sqrt( (Q(mcr(i))^2) - 1 ));
    end
end

function alphaMs = get_alphaMs(Hcr, mcr, a)
    alphaMs = zeros(1, length(Hcr));
    for i = 1:length(Hcr)
        alphaMs(i) = (Langevin(mcr(i),-1) * a(i) - Hcr(i))/mcr(i);
    end
end

function Ms = get_Ms(H, M, Hcr, alphaMs, a)
    [HTip, MTip] = find_tip(H, M);
    H_solve = zeros(1, length(Hcr));
    M_solve = zeros(1, length(Hcr));
    H_solve(1) = HTip;
    M_solve(1) = MTip;
    for i = 2:length(Hcr)
        H_solve(i) = (Hcr(i-1)+Hcr(i))/2;
        M_solve(i) = interp1(H,M, H_solve(i));
    end
    A = zeros(length(Hcr), length(Hcr));

    for i = 1:length(Hcr)
        for j = 1:length(Hcr)
            A(i,j) = get_m(H_solve(i), a(j), alphaMs(j));
        end
    end
    Ms = linsolve(A, M_solve');
end