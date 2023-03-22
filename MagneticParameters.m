classdef MagneticParameters

    properties
        H
        M
        Hcr
        mcr
        VACUUM_PERMEABILITY
    end

    methods (Access = public)
        function obj = MagneticParameters(H, M, Hcr, mcr)
            obj.H = H;
            obj.M = M;
            obj.Hcr = Hcr;
            obj.mcr = mcr;
            obj.VACUUM_PERMEABILITY = 4 * pi * (10^-7);
        end

        function a = get_a(obj)
            a = zeros(1, length(obj.Hcr));
            for i = 1:length(obj.Hcr)
                a(i) = obj.Hcr(i) * obj.P(obj.mcr(i)) * ( obj.Q(obj.mcr(i)) - sqrt( (obj.Q(obj.mcr(i))^2) - 1 ));
            end
        end

        function alphaMs = get_alphaMs(obj, a)
            alphaMs = zeros(1, length(obj.Hcr));
            for i = 1:length(obj.Hcr)
                alphaMs(i) = (Langevin(obj.mcr(i),-1) * a(i) - obj.Hcr(i))/obj.mcr(i);
            end
        end

        function Ms = get_Ms(obj, a, alphaMs)

            [HTip, MTip] = Utils().find_tip(obj.H, obj.M);
            H_solve = zeros(1, length(obj.Hcr));
            M_solve = zeros(1, length(obj.Hcr));
            H_solve(1) = HTip;
            M_solve(1) = MTip;
            for i = 2:length(obj.Hcr)
                H_solve(i) = (obj.Hcr(i-1)+obj.Hcr(i))/2;
                M_solve(i) = interp1(obj.H,obj.M, H_solve(i));
            end
            A = zeros(length(obj.Hcr), length(obj.Hcr));

            for i = 1:length(obj.Hcr)
                for j = 1:length(obj.Hcr)
                    A(i,j) = Utils().get_m(H_solve(i), a(j), alphaMs(j));
                end
            end
            Ms = linsolve(A, M_solve');
        end

        function alpha = get_alpha(~, alphaMs, Ms)
            alpha = zeros(1, length(alphaMs));
            for i = 1:length(alpha)
                alpha(i) = alphaMs(i)/Ms(i);
            end
        end


        function dimensionless_alphaMs = get_dimensionless_alphaMs(~, alpha, Ms, a)
            dimensionless_alphaMs = zeros(1, length(alpha));
            for i = 1:length(alpha)
                dimensionless_alphaMs(i) = alpha(i)*abs(Ms(i))/(3*a(i));
            end
        end

        function Hk = get_Hk(~, alphaMs, a)
            Hk = zeros(1, length(alphaMs));
            for i = 1:length(alphaMs)
                Hk(i) = 3*a(i)-alphaMs(i);
            end
        end

        function Js = get_Js(obj, Ms)
            Js = 0;
            for i = 1:length(Ms)
                Js = Js + obj.VACUUM_PERMEABILITY*Ms(i);
            end
        end

        function density_product = get_density_product(obj, Ms, a)
            density_product = zeros(1, length(Ms));
            for i = 1:length(Ms)
                density_product(i) = obj.VACUUM_PERMEABILITY*abs(Ms(i))*a(i);
            end
        end
    end

    methods (Access = private)

        function p = P(~, m)
            numerator = Langevin(Langevin(m,-1),1);
            denominator = m - Langevin(m,-1) * Langevin(Langevin(m,-1),1);
            p = numerator/denominator;
        end

        function q = Q(~, m)
            a = m / Langevin(Langevin(m,-1),1);
            b = -Langevin(Langevin(m,-1),2);
            c = 2 * ( m - Langevin(m,-1) * Langevin(Langevin(m,-1),1) );
            q = ((a^2) * b / c) - 1;
        end
    end
end