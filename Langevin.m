classdef Langevin

    methods(Access = public)
        function obj = Langevin()
        end

        function ret = L(~, h)
            if(abs(h) <= 0.001)
                ret = h/3 - (h^3)/45 + (2/945)*h^5;
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