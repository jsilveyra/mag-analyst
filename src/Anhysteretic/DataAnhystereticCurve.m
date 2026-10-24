classdef DataAnhystereticCurve
%DATAANHYSTERETICCURVE  Measured anhysteretic M(H) curve plus its derivatives.
%   DataAnhystereticCurve(H, M) stores the measured H, M and derives dMdH
%   (negative slopes clamped to 0) and HdMdH = H.*dMdH (the semilog
%   derivative dM/d(lnH), also clamped to 0). Used as the reference curve
%   compared against ModeledAnhystereticCurve during fitting.
%
%   The derivatives at the last point are NaN: gradient() can only take a
%   one-sided difference there, which on the sparse high-field end of the
%   curve overshoots (up to +20 % in H*dM/dH where the approach to
%   saturation still bends the curve). NaN keeps the point out of the
%   plots, the residues and the export; H and M at that point are kept.

    properties
        H
        M
        dMdH
        HdMdH
    end

    methods (Access = public)
        function obj = DataAnhystereticCurve(H, M)
            obj.H = H;
            obj.M = M;
            obj.dMdH = obj.get_dMdH(H, M);
            obj.HdMdH = obj.get_HdMdH(H, obj.dMdH);
        end
    end

    methods (Access = private)
        function dMdH = get_dMdH(~, H, M)
            dMdH = transpose(gradient(M(:)) ./ gradient(H(:)));
            dMdH(dMdH<0) = 0;
            dMdH(end) = NaN;   % one-sided difference: dropped
        end

        function HdMdH = get_HdMdH(~, H, dMdH)
            HdMdH = H.*dMdH;
            HdMdH(HdMdH<0) = 0;
        end
    end
end
