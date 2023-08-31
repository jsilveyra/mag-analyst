classdef MagneticParameters

    properties
        H
        M
        Hcr
        mcr
        Hx
        VACUUM_PERMEABILITY
    end

    methods (Access = public)
        function obj = MagneticParameters(H, M, Hcr, mcr, Hx)
            obj.H = H;
            obj.M = M;
            obj.Hcr = Hcr;
            obj.mcr = mcr;
            obj.Hx = Hx;
            obj.VACUUM_PERMEABILITY = 4 * pi * (10^-7);
        end

        function a = get_a(obj, select_a)
            factors = ones(length(select_a));
            select_a = select_a == 'low';
            for i = 1:length(select_a)
                if select_a(i)
                    factors(i) = -1;
                end
            end
            
            a = zeros(1, length(obj.Hcr));
            for i = 1:length(obj.Hcr)
                a(i) = obj.Hcr(i) * obj.P(obj.mcr(i)) * ( obj.Q(obj.mcr(i)) + factors(i)*sqrt( (obj.Q(obj.mcr(i))^2) - 1 ));
            end
        end

        function alphaMs = get_alphaMs(obj, a)
            alphaMs = zeros(1, length(obj.Hcr));
            for i = 1:length(obj.Hcr)
                alphaMs(i) = (Langevin(obj.mcr(i),-1) * a(i) - obj.Hcr(i))/obj.mcr(i);
            end
        end

        function Ms = get_Ms(obj, a, alphaMs)
            % Check if all components are the same
            some_Hcr = obj.Hcr(1);
            some_mcr = obj.mcr(1);
            all_same_components = true;
            for i = 1:length(obj.Hcr)
                if ((obj.Hcr(i) ~= some_Hcr) || (obj.mcr(i) ~= some_mcr))
                    all_same_components = false;
                end
            end

            [HTip, MTip] = Utils().find_tip(obj.H, obj.M);

            if all_same_components
                n = length(obj.Hcr);
                Ms = zeros(1, n);
                for i = 1:n
                    Ms(i) = MTip / (n * Utils().get_m(HTip, a(i), alphaMs(i)));
                end

                return;
            end

            H_solve = zeros(1, length(obj.Hcr));
            M_solve = zeros(1, length(obj.Hcr));
            H_solve(1) = HTip;
            M_solve(1) = MTip;
            for i = 2:length(obj.Hcr)
                H_solve(i) = obj.Hx(i-1);
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

        function initial_relative_magnetic_permeability = get_initial_relative_magnetic_permeability(obj, Ms, Hk)
            initial_relative_magnetic_permeability = zeros(1, length(Ms));
            for i = 1:length(Ms)
                initial_relative_magnetic_permeability(i) = 1 + Ms(i)/Hk(i);
            end
        end
        
        function murin = get_murin(~, initial_relative_magnetic_permeability)
            murin = 0;
            for i = 1:length(initial_relative_magnetic_permeability)
                murin = murin + initial_relative_magnetic_permeability(i);
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