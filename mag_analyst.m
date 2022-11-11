clear

[H, M] = Parser('data/MvsH - (nano, AIP advances).csv').get_data_csv;

%[H, M] = Parser('data/MvsH - (nano, AIP advances).txt').get_data;

dMdH = transpose(gradient(M(:)) ./ gradient(H(:)));

HdMdH = H.*dMdH;

[HTip, MTip] = find_tip(H, M);

fprintf('HTip = %f\n', HTip);
fprintf('MTip = %f\n', MTip);

Hcr = 180138;
mcr = 0.78;

a = get_a(Hcr, mcr);
fprintf('a = %f\n', a);

alphaMs = get_alphaMs(Hcr, mcr, a);
fprintf('alphaMs = %f\n', alphaMs);

mTip = get_mTip(Hcr, a, alphaMs);
fprintf('mTip = %f\n', mTip);

Ms = get_Ms(MTip, mTip);
fprintf('Ms = %f\n', Ms);

alpha = get_alpha(alphaMs, Ms);
fprintf('alpha = %f\n', alpha);

Plotter(H, M, dMdH, HdMdH).plot

function [HTip, MTip] = find_tip(H, M)
    [MTip, i] = max(M);
    HTip = H(i);
end

function p = P(m)
    L = Langevin();
    numerator = L.first_derivative(L.inverse(m));
    denominator = m - L.inverse(m) * L.first_derivative(L.inverse(m));
    p = numerator/denominator;
end

function q = Q(m)
    L = Langevin();
    a = m / L.first_derivative(L.inverse(m));
    b = -L.second_derivative(L.inverse(m));
    c = 2 * ( m - L.inverse(m) * L.first_derivative(L.inverse(m)) );
    q = ((a^2) * b / c) - 1;
end

function a = get_a(Hcr, mcr)
    a = Hcr * P(mcr) * ( Q(mcr) - sqrt( (Q(mcr)^2) - 1 ));
end

function alphaMs = get_alphaMs(Hcr, mcr, a)
    L = Langevin();
    alphaMs = (L.inverse(mcr) * a - Hcr)/mcr;
end

function mTip = get_mTip(H, a, alphaMs)

    function ret = f_mTip(m)
        L = Langevin();
        ret = L.L((H + alphaMs*m)/a) - m;
    end

    mTip = fzero(@f_mTip, 0.75);
end

function Ms = get_Ms(MTip, mTip)
    Ms = MTip/mTip;
end

function alpha = get_alpha(alphaMs, Ms)
    alpha = alphaMs/Ms;
end
