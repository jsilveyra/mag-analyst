classdef ResiduePlotter

    properties
        H
        MRes
        dMdHRes
        HdMdHRes

        MarkerSize
    end

    methods (Access = public)
        function obj = ResiduePlotter(H, MRes, dMdHRes, HdMdHRes, varargin)
            numvarargs = length(varargin);
            if numvarargs > 1
                error('ResiduePlotter:constructor:TooManyOptionalParameters: requires at most 1 optional parameter');
            end

            optargs = {5};
            optargs(1:numvarargs) = varargin;
            [obj.MarkerSize] = optargs{:};
          
            obj.H = H;
            obj.MRes = MRes;
            obj.dMdHRes = dMdHRes;
            obj.HdMdHRes = HdMdHRes;
        end

        function plot_stem(obj, Y, YLabel)
            stem(obj.H, Y, '.', 'markersize', obj.MarkerSize, "Color",[0, 0, 0]);
            xlabel('H (A/m)');
            ylabel(YLabel);
        end

        function plot(obj)
            obj.plot_stem(obj.MRes, 'Residue M (A/m)');
            figure();

            obj.plot_stem(obj.dMdHRes, 'Residue dMdH (A/m)');
            figure();

            obj.plot_stem(obj.HdMdHRes, 'Residue HdMdH (A/m)');


        end
    end
end