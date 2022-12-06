clear

N = 100;

[H, M] = Parser('data/MvsH - (nano, AIP advances).csv').get_data_csv;

dMdH = transpose(gradient(M(:)) ./ gradient(H(:)));

HdMdH = H.*dMdH;

[HTip, MTip] = find_tip(H, M);

fprintf('HTip = %f\n', HTip);
fprintf('MTip = %f\n', MTip);


[maxHdMdH, i] = max(HdMdH);
Hcr = [180.138];
mcr = [0.78];

a = get_a(Hcr, mcr);
fprintf('a = %f\n', a);

alphaMs = get_alphaMs(Hcr, mcr, a);
fprintf('alphaMs = %f\n', alphaMs);

mTip = get_m(HTip, a, alphaMs);
fprintf('mTip = %f\n', mTip);

Ms = get_Ms(H, M, Hcr, alphaMs, a);
fprintf('Ms = %f\n', Ms);

alpha = get_alpha(alphaMs, Ms);
fprintf('alpha = %f\n', alpha);

Hhat = logspace(log10(H(2)),log10(HTip),N);

Mhat = get_Mhat(Hhat, a, alphaMs, Ms);

dMdHhat = get_dMdHhat(Hhat, alpha, Mhat, Ms, a);

HdMdHhat = get_HdMdHhat(Hhat, dMdHhat);

%Plotter(H, M, dMdH, HdMdH, Hhat, Mhat, dMdHhat, HdMdHhat, Hcr(1)).plot;

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

h_error_MlnH = horizontal_error(log(H), M, log(Hhat), Mhat);
fprintf('M vs ln(H) = %f\n', h_error_MlnH);

fprintf('\nDiagonal:\n');
d_error_M = diagonal_error(H, M, Hhat, Mhat);
fprintf('M = %f\n', d_error_M);

%ResiduePlotter(H(2:end-1), residue_M, residue_dMdH, residue_HdMdH).plot;


fprintf('\n\nMultiple params extension:\n');

[H, M] = Parser('data/MvsH - (JNEX-900, AIP advances).csv').get_data_csv;

dMdH = transpose(gradient(M(:)) ./ gradient(H(:)));
HdMdH = H.*dMdH;

[HTip, MTip] = find_tip(H, M);
Hcr = [8.749 6881.3];
mcr = [0.457 0.49];

a = get_a(Hcr, mcr);
fprintf('a = %f\n', a);

alphaMs = get_alphaMs(Hcr, mcr, a);
fprintf('alphaMs = %f\n', alphaMs);

Ms = get_Ms(H, M, Hcr, alphaMs, a);
fprintf('Ms = %f\n', Ms);

alpha = get_alpha(alphaMs, Ms);
fprintf('alpha = %f\n', alpha);

Hhat = logspace(log10(H(2)),log10(HTip),N);

Mhat = get_Mhat(Hhat, a, alphaMs, Ms);

%dMdHhat = get_dMdHhat(Hhat, alpha, Mhat, Ms, a);

%HdMdHhat = get_HdMdHhat(Hhat, dMdHhat);

Plotter(H, M, dMdH, HdMdH, Hhat, Mhat, dMdHhat, HdMdHhat, Hcr(1)).plot;


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

function m = get_m(H, a, alphaMs)
    function ret = f_m(m)
        ret = Langevin((H + alphaMs*m)/a,0) - m;
    end
    m = fzero(@f_m, 0.75);
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

function alpha = get_alpha(alphaMs, Ms)
    alpha = zeros(1, length(alphaMs));
    for i = 1:length(alpha)
        alpha(i) = alphaMs(i)/Ms(i);
    end
end

function Mhat = get_Mhat(H, a, alphaMs, Ms)
    Mhat = zeros(1, length(H));

    for i = 1:length(H)
        for j = 1:length(a)
            m = get_m(H(i), a(j), alphaMs(j));
            Mhat(i) = Mhat(i) + Ms(j)*m;
        end 
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
    h_error = sqrt(h_error)/max(X)/length(Xdat);
end

function d_error = diagonal_error(X, Y, Xhat, Yhat)
    Ydat = Y(2:end-1);
    Xdat = X(2:end-1);
    d_error = 0;
    for i = 1:length(Ydat)
        delta_x = abs(interp1(Yhat, Xhat, Ydat(i)) - Xdat(i))/max(X);
        delta_y = abs(interp1(Xdat, Ydat, interp1(Yhat, Xhat, Ydat(i))) - Ydat(i))/max(Y);
        delta_o = delta_y*cos(atan(delta_y/delta_x));
        d_error = d_error + (delta_o^2);
    end
    d_error = sqrt(d_error)/length(Y);
end
