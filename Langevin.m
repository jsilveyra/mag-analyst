%hola jose
function ret = Langevin(h,order)
    L = LangevinPrivate();
    switch order
        case -1
            ret = L.inverse(h);
        case 0
            ret = L.L(h);
        case 1
            ret = L.first_derivative(h);
        case 2
            ret = L.second_derivative(h);
    end
end