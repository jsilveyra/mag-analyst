classdef Plotter

    properties
        H
        M
        HdMdH
        dMdH
        Hhat
        Mhat
        dMdHhat
        HdMdHhat
        Hcr
        MarkerSize
    end

    methods (Access = public)
        function obj = Plotter(H, M, dMdH , HdMdH, Hhat, Mhat, dMdHhat, HdMdHhat, Hcr, varargin)
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
            obj.Hhat = Hhat;
            obj.Mhat = Mhat;
            obj.dMdHhat = dMdHhat;
            obj.HdMdHhat = HdMdHhat;
            obj.Hcr = Hcr;
        end

        function plot_Hcr(obj)
            xline(obj.Hcr, '--', "Color",[0, 0.4470, 0.7410], "Label", "Hcr");
        end

        function plot_M(obj, ~)
            hold on;
            plot(obj.H, obj.M, '.', 'markersize', obj.MarkerSize, "Color",[0, 0, 0]);
            plot(obj.Hhat, obj.Mhat, "Color",[0,0,0]);
            obj.plot_Hcr;
            xlabel('H (A/m)');
            ylabel('M (A/m)');
            hold off;
        end

        function plot_M_log(obj, ~)
            semilogx(obj.H,obj.M, '.', 'markersize', obj.MarkerSize, "Color",[0, 0, 0]);
            hold on;
            semilogx(obj.Hhat,obj.Mhat, "Color",[0 0 0]);
            obj.plot_Hcr;
            hold off;
            xlabel('H (A/m)');
            ylabel('M (A/m)');
        end

        function plot_dMdH(obj, ax)
            hold on;
            plot(obj.H,obj.dMdH, '.', 'markersize', obj.MarkerSize, "Color",[0, 0, 0]);
            plot(obj.Hhat, obj.dMdHhat, "Color",[0 0 0]);
            obj.plot_Hcr;
            xlabel('H (A/m)');
            ylabel('∂M/∂H');
            ax.YLim = [min(obj.dMdH) max(obj.dMdH)*1.1];
            hold off;
        end

        function plot_HdMdH(obj, ax)
            semilogx(obj.H,obj.dMdH, '.', 'markersize', obj.MarkerSize, "Color",[0, 0, 0]);
            hold on;
            obj.plot_Hcr;
            semilogx(obj.Hhat,obj.dMdHhat, "Color",[0 0 0]);
            hold off;
            
            xlabel('H (A/m)');
            ylabel('∂M/∂H');
            
            yyaxis right;
            hold on;
            semilogx(obj.Hhat, obj.HdMdHhat, "Color",[0.8500, 0.3250, 0.0980]);
            semilogx(obj.H,obj.HdMdH, '.', 'markersize', obj.MarkerSize, "Color",[0.8500, 0.3250, 0.0980]);
            ylabel('∂M/∂ln(H) = H ∂M/∂H (A/m)', "Color",[0.8500, 0.3250, 0.0980]);
            hold off;

            yyaxis left;  ax.YLim = [0 max(obj.dMdH)*1.1];
            yyaxis right; ax.YLim = [0 max(obj.HdMdHhat)*1.1];
        end

        function plot(obj)
            figure();
            tiledlayout(2,2);
            colororder([0.8500, 0.3250, 0.0980])

            ax = nexttile;
            obj.plot_M(ax);

            ax = nexttile;
            obj.plot_M_log(ax);

            ax = nexttile;
            obj.plot_dMdH(ax);

            ax = nexttile;
            obj.plot_HdMdH(ax);
        end
    end
end