function d_error2 = diagonal_error2(X, Y, Xhat, Yhat)
%ESTA ES UNA COPY-PASTE FUNCTION DE LA QUE ESTÁ EN ERRORCALCULATOR, SOLO QUE NO SABÍA CÓMO USARLA.
    X = X(2:end);
    Y = Y(2:end);
    Ydat = Y(2:end-1);
    Xdat = X(2:end-1);
    d_error = 0;
    for i = 1:length(Ydat)
        delta_x = abs(interp1(Yhat, Xhat, Ydat(i), 'linear', 'extrap') - Xdat(i))/max(X);
        delta_y = abs(interp1(X, Y, interp1(Yhat, Xhat, Ydat(i), 'linear', 'extrap'), 'linear', 'extrap') - Ydat(i))/max(Y);
        delta_o = delta_y*cos(atan(delta_y/delta_x));
        d_error = d_error + (delta_o^2);
    end
    d_error2 = sqrt(d_error)/length(Y);
end