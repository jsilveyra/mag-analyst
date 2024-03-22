classdef DataAnhystereticCurve

    properties
        H
        M
        dMdH
        HdMdH
    end

    methods (Access = public)
        function obj = DataAnhystereticCurve(H, M)
            if (H(1) ~= 0)
                H = [0, H];
                M = [0, M];
            end
            obj.H = H;
            obj.M = M;
            obj.dMdH = obj.get_dMdH(H, M);
            obj.HdMdH = obj.get_HdMdH(H, obj.dMdH);
        end
    end

    methods (Access = private)
        function dMdH = get_dMdH(~, H, M)
            dMdH = transpose(gradient(M(:)) ./ gradient(H(:)));
        end

        function HdMdH = get_HdMdH(~, H, dHdH)
            HdMdH = H.*dHdH;
        end
    end
end