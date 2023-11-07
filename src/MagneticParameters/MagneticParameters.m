classdef MagneticParameters

    properties
        a
        alphaMs
        Ms
        alpha
        dimensionless_alphaMs
        Hk
        Js
        density_product
        initial_relative_magnetic_permeability
        murin
        VACUUM_PERMEABILITY
    end

    methods (Access = public)
        function obj = MagneticParameters(data_curve, Hcr, mcr, Hx, select_a)
            obj.VACUUM_PERMEABILITY = 4 * pi * (10^-7);
            obj.a = obj.get_a(Hcr, mcr, select_a);
            obj.alphaMs = obj.get_alphaMs(Hcr, mcr);
            obj.Ms = obj.get_Ms(data_curve, Hcr, mcr, Hx);
            obj.alpha = obj.get_alpha();
            obj.dimensionless_alphaMs = obj.get_dimensionless_alphaMs();
            obj.Hk = obj.get_Hk();
            obj.Js = obj.get_Js();
            obj.density_product = obj.get_density_product();
            obj.initial_relative_magnetic_permeability = obj.get_initial_relative_magnetic_permeability();
            obj.murin = obj.get_murin();
        end
    end

    methods (Access = private)
        function a = get_a(obj, Hcr, mcr, select_a)
            factors = ones(length(select_a));
            select_a = select_a == 'low';
            for i = 1:length(select_a)
                if select_a(i)
                    factors(i) = -1;
                end
            end

            a = zeros(1, length(Hcr));
            for i = 1:length(Hcr)
                a(i) = Hcr(i) * obj.P(mcr(i)) * ( obj.Q(mcr(i)) + factors(i)*sqrt( (obj.Q(mcr(i))^2) - 1 ));
            end
        end

        function alphaMs = get_alphaMs(obj, Hcr, mcr)
            alphaMs = zeros(1, length(Hcr));
            for i = 1:length(Hcr)
                alphaMs(i) = (Langevin(mcr(i),-1) * obj.a(i) - Hcr(i))/mcr(i);
            end
        end

        function Ms = get_Ms(obj, data_curve, Hcr, mcr, Hx)
            % Check if all components are the same
            some_Hcr = Hcr(1);
            some_mcr = mcr(1);
            all_same_components = true;
            for i = 1:length(Hcr)
                if ((Hcr(i) ~= some_Hcr) || (mcr(i) ~= some_mcr))
                    all_same_components = false;
                end
            end

            [HTip, MTip] = Utils().find_tip(data_curve.H, data_curve.M);

            if all_same_components
                n = length(Hcr);
                Ms = zeros(1, n);
                for i = 1:n
                    Ms(i) = MTip / (n * Utils().get_m(HTip, obj.a(i), obj.alphaMs(i)));
                end
                return;
            end


            H_solve = zeros(1, length(Hcr));
            M_solve = zeros(1, length(Hcr));
            H_solve(1) = HTip;
            M_solve(1) = MTip;
            for i = 2:length(Hcr)
                H_solve(i) = Hx(i-1);
                M_solve(i) = interp1(data_curve.H, data_curve.M, H_solve(i));
            end
            A = zeros(length(Hcr), length(Hcr));
            

            for i = 1:length(Hcr)
                for j = 1:length(Hcr)
                    A(i,j) = Utils().get_m(H_solve(i), obj.a(j), obj.alphaMs(j));
                end
            end
            Ms = linsolve(A, M_solve');
        end

        function alpha = get_alpha(obj)
            alpha = zeros(1, length(obj.alphaMs));
            for i = 1:length(alpha)
                alpha(i) = obj.alphaMs(i)/obj.Ms(i);
            end
        end

        function dimensionless_alphaMs = get_dimensionless_alphaMs(obj)
            dimensionless_alphaMs = zeros(1, length(obj.alpha));
            for i = 1:length(obj.alpha)
                dimensionless_alphaMs(i) = obj.alpha(i)*abs(obj.Ms(i))/(3*obj.a(i));
            end
        end

        function Hk = get_Hk(obj)
            Hk = zeros(1, length(obj.alphaMs));
            for i = 1:length(obj.alphaMs)
                Hk(i) = 3*obj.a(i)-obj.alphaMs(i);
            end
        end

        function Js = get_Js(obj)
            Js = 0;
            for i = 1:length(obj.Ms)
                Js = Js + obj.VACUUM_PERMEABILITY*obj.Ms(i);
            end
        end

        function density_product = get_density_product(obj)
            density_product = zeros(1, length(obj.Ms));
            for i = 1:length(obj.Ms)
                density_product(i) = obj.VACUUM_PERMEABILITY*abs(obj.Ms(i))*obj.a(i);
            end
        end

        function initial_relative_magnetic_permeability = get_initial_relative_magnetic_permeability(obj)
            initial_relative_magnetic_permeability = zeros(1, length(obj.Ms));
            for i = 1:length(obj.Ms)
                initial_relative_magnetic_permeability(i) = 1 + obj.Ms(i)/obj.Hk(i);
            end
        end
        
        function murin = get_murin(obj)
            murin = 0;
            for i = 1:length(obj.initial_relative_magnetic_permeability)
                murin = murin + obj.initial_relative_magnetic_permeability(i);
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
            some_a = m / Langevin(Langevin(m,-1),1);
            b = -Langevin(Langevin(m,-1),2);
            c = 2 * ( m - Langevin(m,-1) * Langevin(Langevin(m,-1),1) );
            q = ((some_a^2) * b / c) - 1;
        end
    end
end