clear

N = 100;

[H, M] = Parser('data/MvsH - (nano, AIP advances).csv').get_data_csv;

dMdH = transpose(gradient(M(:)) ./ gradient(H(:)));

HdMdH = H.*dMdH;

[HTip, MTip] = find_tip(H, M);

fprintf('HTip = %f\n', HTip);
fprintf('MTip = %f\n', MTip);


[maxHdMdH, i] = max(HdMdH);
Hcr = 180.138;
mcr = 0.78;

a = get_a(Hcr, mcr);
fprintf('a = %f\n', a);

alphaMs = get_alphaMs(Hcr, mcr, a);
fprintf('alphaMs = %f\n', alphaMs);

mTip = get_mTip(HTip, a, alphaMs);
fprintf('mTip = %f\n', mTip);

Ms = get_Ms(MTip, mTip);
fprintf('Ms = %f\n', Ms);

alpha = get_alpha(alphaMs, Ms);
fprintf('alpha = %f\n', alpha);

HAnalytical = logspace(log10(H(2)),log10(HTip),N);

MAnalytical = get_MAnalytical(HAnalytical, a, alphaMs, Ms);

dMdHAnalytical = get_dMdHAnalytical(HAnalytical, alpha, MAnalytical, Ms, a);

HdMdHAnalytical = get_HdMdHAnalytical(HAnalytical, dMdHAnalytical);

Plotter(H, M, dMdH, HdMdH, HAnalytical, MAnalytical, dMdHAnalytical, HdMdHAnalytical, Hcr).plot

function [HTip, MTip] = find_tip(H, M)
    [MTip, i] = max(M);
    HTip = H(i);
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
    a = Hcr * P(mcr) * ( Q(mcr) - sqrt( (Q(mcr)^2) - 1 ));
end

function alphaMs = get_alphaMs(Hcr, mcr, a)
    alphaMs = (Langevin(mcr,-1) * a - Hcr)/mcr;
end

function mTip = get_mTip(H, a, alphaMs)
    function ret = f_mTip(m)
        ret = Langevin((H + alphaMs*m)/a,0) - m;
    end
    mTip = fzero(@f_mTip, 0.75);
end

function Ms = get_Ms(MTip, mTip)
    Ms = MTip/mTip;
end

function alpha = get_alpha(alphaMs, Ms)
    alpha = alphaMs/Ms;
end

function MAnalytical = get_MAnalytical(H, a, alphaMs, Ms)
    MAnalytical = zeros(1, length(H));

    for i = 1:length(H)
        mTip = get_mTip(H(i), a, alphaMs);
        MAnalytical(i) = Ms*mTip;
    end

end

function dMdHAnalytical = get_dMdHAnalytical(H, alpha, MAnalytical, Ms, a)
    dMdHAnalytical = zeros(1, length(H));
    for i = 1:length(H)
        h = (H(i)+alpha*MAnalytical(i))/a;
        numerator = Ms*Langevin(h,1)/a;
        dMdHAnalytical(i) = numerator/(1-alpha*numerator);
    end
end

function HdMdHAnalytical = get_HdMdHAnalytical(H, dMdHAnalytical)
    HdMdHAnalytical = zeros(1, length(H));
    for i = 1:length(H)
        HdMdHAnalytical(i) = H(i)*dMdHAnalytical(i);
    end
end
