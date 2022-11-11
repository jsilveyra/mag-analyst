classdef Plotter

    properties
        H
        M
        HdMdH
        dMdH
        MAnalytic
        MarkerSize
    end

    methods (Access = public)
        function obj = Plotter(H, M, dMdH , HdMdH, MAnalytic, varargin)
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
            
        end

        function plot(obj)
            tiledlayout(2,2);
            nexttile;
            plot(obj.H, obj.M, '.', 'markersize', obj.MarkerSize);
            plot(obj.H, obj.MAnalytic);
            xlabel('H (A/m)');
            ylabel('M (A/m)');
            nexttile;
            semilogx(obj.H,obj.M, '.', 'markersize', obj.MarkerSize);
            xlabel('H (A/m)'); 
            ylabel('M (A/m)'); 
            nexttile;
            plot(obj.H,obj.dMdH, '.', 'markersize', obj.MarkerSize);
            xlabel('H (A/m)');
            ylabel('∂M/∂H');
            nexttile;
            semilogx(obj.H,obj.dMdH, '.', 'markersize', obj.MarkerSize);
            xlabel('H (A/m)');
            ylabel('∂M/∂H');
            hold on;
            yyaxis right;
            semilogx(obj.H,obj.HdMdH, '.', 'markersize', obj.MarkerSize);
            ylabel('H ∂M/∂H (A/m)');
            hold off;
        end
    end
end