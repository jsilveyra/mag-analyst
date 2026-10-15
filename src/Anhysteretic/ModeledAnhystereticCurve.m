classdef ModeledAnhystereticCurve
%MODELEDANHYSTERETICCURVE  Anhysteretic M(H) curve computed from fitted parameters.
%   ModeledAnhystereticCurve(H, magnetic_parameters) evaluates the modeled
%   total magnetization M (and per-component Mi) plus their derivatives
%   dMdH/dMidH and semilog derivatives HdMdH/HdMidH over the sample field H,
%   using each component's a, alphaMs, Ms, alpha from a MagneticParameters
%   object. The linear term chi0 (component 0) is included in the totals
%   and kept apart in M0/dM0dH/HdM0dH (all zero when chi0 = 0), so Mi and
%   friends still hold only the Langevin components 1..n.

    properties
        H
        M
        Mi
        dMdH
        dMidH
        HdMdH
        HdMidH
        M0
        dM0dH
        HdM0dH
    end

    methods (Access = public)
        function obj = ModeledAnhystereticCurve(H, magnetic_parameters)
            obj.H = H;
            [obj.M, obj.Mi] = obj.get_M(H, magnetic_parameters.a, magnetic_parameters.alphaMs, magnetic_parameters.Ms);
            [obj.dMdH, obj.dMidH] = obj.get_dMdH(H, magnetic_parameters.alpha, magnetic_parameters.Ms, magnetic_parameters.a, magnetic_parameters.alphaMs);
            [obj.HdMdH, obj.HdMidH] = obj.get_HdMdH(H, obj.dMidH);
            chi0 = 0;
            if isprop(magnetic_parameters, 'chi0') && ~isempty(magnetic_parameters.chi0)
                chi0 = magnetic_parameters.chi0;
            end
            obj.M0 = chi0 * H;
            obj.dM0dH = chi0 * ones(size(H));
            obj.HdM0dH = chi0 * H;
            obj.M = obj.M + obj.M0;
            obj.dMdH = obj.dMdH + obj.dM0dH;
            obj.HdMdH = obj.HdMdH + obj.HdM0dH;
        end
    end

    methods (Access = private)
        function [M, Mi] = get_M(~, H, a, alphaMs, Ms)
            M = zeros(1, length(H));
            Mi = zeros(length(a), length(H));
    
            for i = 1:length(H)
                for j = 1:length(a)
                    m = Utils().get_m(H(i), a(j), alphaMs(j));
                    Mi(j, i) = Ms(j)*m;
                    M(i) = M(i) + Mi(j, i);
                end 
            end

        end

        function [dMdH, dMidH] = get_dMdH(~, H, alpha, Ms, a, alphaMs)
            dMdH = zeros(1, length(H));
            dMidH = zeros(length(a), length(H));
        
            for i = 1:length(H)
                for j = 1:length(a)
                    m = Utils().get_m(H(i), a(j), alphaMs(j));
                    h = (H(i)+m*alphaMs(j))/a(j);
                    numerator = Ms(j)*Langevin(h,1)/a(j);
                    dMidH(j, i) = numerator/(1-alpha(j)*numerator);
                    dMdH(i) = dMdH(i) + dMidH(j, i);
                end  
            end
        end

        function [HdMdH, HdMidH] = get_HdMdH(~, H, dMidH)
            HdMdH = zeros(1, length(H));
            HdMidH = zeros(size(dMidH,1), length(H));
        
            for i = 1:length(H)
                for j = 1:size(dMidH,1)
                    HdMidH(j, i) = H(i)*dMidH(j, i);
                    HdMdH(i) = HdMdH(i) + HdMidH(j, i);
                end
            end
        end
    end
end