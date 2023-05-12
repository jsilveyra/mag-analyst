function residue2 = residue2(X, Y, Xhat, Yhat)
%ESTA ES UNA COPY-PASTE FUNCTION DE LA QUE ESTÁ EN ERRORCALCULATOR, SOLO QUE NO SABÍA CÓMO USARLA.

    Yint = interp1(Xhat, Yhat, X, 'linear', 'extrap');
    Yint = Yint(2:end);
    Ydat = Y(2:end);
    residue2 = zeros(1, length(Ydat));
    for i = 1:length(Yint)
        residue2(i) = Ydat(i) - Yint(i);
    end
end