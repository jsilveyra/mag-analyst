clear

[H, M] = Parser('data/MvsH - (nano, AIP advances).txt').get_data;
disp(H);
disp(M);

dMdH = transpose(gradient(M(:)) ./ gradient(H(:)));

HdMdH = H.*dMdH;

[HTip, MTip] = find_tip(H, M);

fprintf('HTip = %f\n', HTip);
fprintf('MTip = %f\n', MTip);

Hcr = 180138;
mcr = 0.78;

a = get_a(Hcr, mcr);
fprintf('a = %f\n', a);

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





