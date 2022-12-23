classdef MagneticParameters

    properties
        H
        M
        Hcr
        mcr
    end

    methods (Access = public)
        function obj = MagneticParameters(H, M, Hcr, mcr)
            obj.H = H;
            obj.M = M;
            obj.Hcr = Hcr;
            obj.mcr = mcr;
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