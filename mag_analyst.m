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

Hhat = logspace(log10(H(2)),log10(HTip),N);

Mhat = get_Mhat(Hhat, a, alphaMs, Ms);

dMdHhat = get_dMdHhat(Hhat, alpha, Mhat, Ms, a);

HdMdHhat = get_HdMdHhat(Hhat, dMdHhat);

Plotter(H, M, dMdH, HdMdH, Hhat, Mhat, dMdHhat, HdMdHhat, Hcr).plot;

fprintf('\nErrors:\n');
fprintf('Vertical:\n');

[v_error_M, residue_M] = vertical_error(H, M, Hhat, Mhat);
fprintf('M = %f\n', v_error_M);

[v_error_dMdH, residue_dMdH] = vertical_error(H, dMdH, Hhat, dMdHhat);
fprintf('dMdH = %f\n', v_error_dMdH);

[v_error_HdMdH, residue_HdMdH] = vertical_error(H, HdMdH, Hhat, HdMdHhat);
fprintf('HdMdH = %f\n', v_error_HdMdH);

fprintf('\nHorizontal:\n');

h_error_M = horizontal_error(H, M, Hhat, Mhat);
fprintf('M = %f\n', h_error_M);

ResiduePlotter(H(2:end-1), residue_M, residue_dMdH, residue_HdMdH).plot;

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

function Mhat = get_Mhat(H, a, alphaMs, Ms)
    Mhat = zeros(1, length(H));

    for i = 1:length(H)
        mTip = get_mTip(H(i), a, alphaMs);
        Mhat(i) = Ms*mTip;
    end

end

function dMdHhat = get_dMdHhat(H, alpha, Mhat, Ms, a)
    dMdHhat = zeros(1, length(H));
    for i = 1:length(H)
        h = (H(i)+alpha*Mhat(i))/a;
        numerator = Ms*Langevin(h,1)/a;
        dMdHhat(i) = numerator/(1-alpha*numerator);
    end
end

function HdMdHhat = get_HdMdHhat(H, dMdHhat)
    HdMdHhat = zeros(1, length(H));
    for i = 1:length(H)
        HdMdHhat(i) = H(i)*dMdHhat(i);
    end
end

function [v_error, residue] = vertical_error(X, Y, Xhat, Yhat)
    Yint = interp1(Xhat, Yhat, X);
    Yint = Yint(2:end-1);
    Ydat = Y(2:end-1);
    residue = zeros(1, length(Ydat));
    v_error = 0;
    for i = 1:length(Yint)
        residue(i) = Ydat(i) - Yint(i);
        v_error = v_error + (residue(i)^2);
    end
    v_error = (sqrt(v_error)/max(Y))/length(Y);
end

function [h_error, residue] = horizontal_error(X, Y, Xhat, Yhat)
    Xint = interp1(Yhat, Xhat, Y);
    Xint = Xint(2:end-1);
    Xdat = X(2:end-1);
    residue = zeros(1, length(Xdat));
    h_error = 0;
    for i = 1:length(Xint)
        residue(i) = Xdat(i) - Xint(i);
        h_error = h_error + (residue(i)^2);
    end
    h_error = sqrt(h_error)/max(X);
end
