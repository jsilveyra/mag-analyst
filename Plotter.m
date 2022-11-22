classdef Plotter

    properties
        H
        M
        HdMdH
        dMdH
        MAnalytic
        dMdHAnalytical
        HdMdHAnalytical
        MarkerSize
    end

    methods (Access = public)
        function obj = Plotter(H, M, dMdH , HdMdH, MAnalytic, dMdHAnalytical, HdMdHAnalytical, varargin)
            numvarargs = length(varargin);
            if numvarargs > 1
                error('Plotter:constructor:TooManyOptionalParameters: requires at most 1 optional parameter');
            end

            optargs = {3};
            optargs(1:numvarargs) = varargin;
            [obj.MarkerSize] = optargs{:};
          
            obj.H = H;
            obj.M = M;
            obj.dMdH = dMdH;
            obj.HdMdH = HdMdH;
            obj.MAnalytic = MAnalytic;
            obj.dMdHAnalytical = dMdHAnalytical;
            obj.HdMdHAnalytical = HdMdHAnalytical;
        end

        function plot(obj)
            tiledlayout(2,2);
            nexttile;
            hold on;
            plot(obj.H, obj.M, '.', 'markersize', obj.MarkerSize);
            plot(obj.H, obj.MAnalytic, "Color",[0 0 0]);
            xlabel('H (A/m)');
            ylabel('M (A/m)');
            hold off;


            nexttile;
            semilogx(obj.H,obj.M, '.', 'markersize', obj.MarkerSize);
            hold on;
            semilogx(obj.H,obj.MAnalytic, "Color",[0 0 0]);
            hold off;
            xlabel('H (A/m)');
            ylabel('M (A/m)');

            nexttile;
            hold on;
            plot(obj.H,obj.dMdH, '.', 'markersize', obj.MarkerSize);
            plot(obj.H, obj.dMdHAnalytical, "Color",[0 0 0]);
            xlabel('H (A/m)');
            ylabel('∂M/∂H');
            hold off;


            nexttile;
            semilogx(obj.H,obj.dMdH, '.', 'markersize', obj.MarkerSize);
            %semilogx(obj.H,obj.dMdHAnalytical, "Color",[0 0 0]);
            xlabel('H (A/m)');
            ylabel('∂M/∂H');
            
            yyaxis right;

            hold on;
            semilogx(obj.H, obj.HdMdHAnalytical, "Color",[0.8500, 0.3250, 0.0980]);
            semilogx(obj.H,obj.HdMdH, '.', 'markersize', obj.MarkerSize, "Color",[0.8500, 0.3250, 0.0980]);
            ylabel('∂M/(∂ln(H))=H ∂M/∂H (A/m)');
            hold off;
        end
    end
end