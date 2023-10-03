clear

N = 100;

utils = Utils();


[H, M] = Parser('data/MvsH - (nano, AIP advances).csv').get_data_csv;

dMdH = transpose(gradient(M(:)) ./ gradient(H(:)));

HdMdH = H.*dMdH;

[HTip, MTip] = utils.find_tip(H, M);

fprintf('HTip = %f\n', HTip);
fprintf('MTip = %f\n', MTip);


[maxHdMdH, i] = max(HdMdH);
Hcr = [180.138];
mcr = [0.78];

magnetic_parameters = MagneticParameters(H, M, Hcr, mcr);
a = magnetic_parameters.get_a();
alphaMs = magnetic_parameters.get_alphaMs(a);
Ms = magnetic_parameters.get_Ms(a, alphaMs);
fprintf('a = %f\n', a);
fprintf('alphaMs = %f\n', alphaMs);
fprintf('Ms = %f\n', Ms);

alpha = magnetic_parameters.get_alpha(alphaMs, Ms);
fprintf('alpha = %f\n', alpha);

dimensionless_alphaMs = get_dimensionless_alphaMs(alphaMs, a);
fprintf('dimensionless_alphaMs = %f\n', dimensionless_alphaMs);

Hk = get_Hk(alphaMs, a);
fprintf('Hk = %f\n', Hk);

Hhat = logspace(log10(H(2)),log10(HTip),N);

Mhat = get_Mhat(Hhat, a, alphaMs, Ms);

dMdHhat = get_dMdHhat(Hhat, alpha, Ms, a, alphaMs);

HdMdHhat = get_HdMdHhat(Hhat, dMdHhat);

Plotter(H, M, dMdH, HdMdH, Hhat, Mhat, dMdHhat, HdMdHhat, Hcr).plot;

fprintf('\nErrors:\n');
fprintf('Vertical:\n');

[v_error_M, residue_M] = vertical_error(log(H), M, Hhat, Mhat);
fprintf('M = %f\n', v_error_M);

[v_error_dMdH, residue_dMdH] = vertical_error(log(H), dMdH, Hhat, dMdHhat);
fprintf('dMdH = %f\n', v_error_dMdH);

[v_error_HdMdH, residue_HdMdH] = vertical_error(log(H), HdMdH, Hhat, HdMdHhat);
fprintf('HdMdH = %f\n', v_error_HdMdH);

fprintf('\nHorizontal:\n');

h_error_M = horizontal_error(log(H), M, Hhat, Mhat);
fprintf('M = %f\n', h_error_M);

h_error_MlnH = horizontal_error(log(H), M, log(Hhat), Mhat);
fprintf('M vs ln(H) = %f\n', h_error_MlnH);

fprintf('\nDiagonal:\n');
d_error_M = diagonal_error(H, M, Hhat, Mhat);
fprintf('M = %f\n', d_error_M);

ResiduePlotter(H(2:end-1), residue_M, residue_dMdH, residue_HdMdH).plot;


fprintf('\n\nMultiple params extension:\n');

[H, M] = Parser('data/MvsH - (JNEX-900, AIP advances).csv').get_data_csv;

dMdH = transpose(gradient(M(:)) ./ gradient(H(:)));
HdMdH = H.*dMdH;

[HTip, MTip] = Utils().find_tip(H, M);
Hcr = [8.749 6881.3];
mcr = [0.457 0.49];

magnetic_parameters = MagneticParameters(H, M, Hcr, mcr);
a = magnetic_parameters.get_a();
alphaMs = magnetic_parameters.get_alphaMs(a);
Ms = magnetic_parameters.get_Ms(a, alphaMs);
fprintf('a = %f\n', a);
fprintf('alphaMs = %f\n', alphaMs);
fprintf('Ms = %f\n', Ms);

alpha = magnetic_parameters.get_alpha(alphaMs, Ms);
fprintf('alpha = %f\n', alpha);

dimensionless_alphaMs = get_dimensionless_alphaMs(alphaMs, a);
fprintf('dimensionless_alphaMs = %f\n', dimensionless_alphaMs);

Hk = get_Hk(alphaMs, a);
fprintf('Hk = %f\n', Hk);

Hhat = logspace(log10(H(2)),log10(HTip),N);

Mhat = get_Mhat(Hhat, a, alphaMs, Ms);

dMdHhat = get_dMdHhat(Hhat, alpha, Ms, a, alphaMs);

HdMdHhat = get_HdMdHhat(Hhat, dMdHhat);

Plotter(H, M, dMdH, HdMdH, Hhat, Mhat, dMdHhat, HdMdHhat, Hcr).plot;

[H, M] = Parser('data/MvsH - (JNEX-900, AIP advances).csv').get_data_csv;

[HTip, MTip] = Utils().find_tip(H, M);

[Hcr, mcr] = fit(H, M, [10, 8000, 0.5, 0.5]);
disp([Hcr, mcr]);

magnetic_parameters = MagneticParameters(H, M, Hcr, mcr);
a = magnetic_parameters.get_a();
alphaMs = magnetic_parameters.get_alphaMs(a);
Ms = magnetic_parameters.get_Ms(a, alphaMs);
mTip = Utils().get_m(HTip, a, alphaMs);

Hhat = logspace(log10(H(2)),log10(HTip),N);

Mhat = get_Mhat(Hhat, a, alphaMs, Ms);

dMdHhat = get_dMdHhat(Hhat, alpha, Ms, a, alphaMs);

HdMdHhat = get_HdMdHhat(Hhat, dMdHhat);

Plotter(H, M, dMdH, HdMdH, Hhat, Mhat, dMdHhat, HdMdHhat, Hcr).plot;

fprintf('\nDiagonal:\n');
d_error_M = diagonal_error(H, M, Hhat, Mhat);
fprintf('M = %f\n', d_error_M);


function [v_error, residue] = vertical_error(X, Y, Xhat, Yhat)

    Yint = interp1(Xhat, Yhat, X);
    Yint = Yint(3:end);
    Ydat = Y(3:end);
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
    Xint = Xint(2:end);
    Xdat = X(2:end);
    residue = zeros(1, length(Xdat));
    h_error = 0;
    for i = 1:length(Xint)
        residue(i) = Xdat(i) - Xint(i);
        h_error = h_error + (residue(i)^2);
    end
    h_error = sqrt(h_error)/max(X)/length(Xdat);
end
