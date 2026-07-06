classdef LangevinPrivate
%LANGEVINPRIVATE  Langevin function L(h), its inverse and derivatives.
%   Backing implementation for the Langevin(h, order) free function
%   (order -1/0/1/2 selects inverse/L/first_derivative/second_derivative).
%   Each method uses a small-h series expansion below |h|<=0.001 to avoid
%   the coth(h)-1/h cancellation/singularity at h=0.

    methods(Access = public)
        function obj = LangevinPrivate()
        end

        function ret = L(~, h)
            if(abs(h) <= 0.001)
                ret = h/3 - (h^3)/45 + (2/945)*(h^5);
            else
                ret = coth(h) - 1/h;
            end
        end

        function ret = inverse(~, m)
            if m == 1
                error('Langevin:inverse m cannot be equal to one');
            end

            numerator = 3*m - m*(6*m^2 + m^4 - 2*m^6) / 5;
            denominator = 1 - m^2;

            ret = numerator/denominator;
        end

        function ret = first_derivative(~, h)
            if(abs(h) <= 0.001)
                ret = 1/3 - (h^2)/15 + (2/189)*h^4;
            else
                ret = -(csch(h)^2) + 1/(h^2);
            end
        end

        function ret = second_derivative(~, h)
            if(abs(h) <= 0.001)
                ret = (-2/15)*h + (8/189)*h^3 - (2/225)*h^5;
            else
                ret = 2*coth(h)*(csch(h)^2) - 2/(h^3);
            end
        end

   end
end