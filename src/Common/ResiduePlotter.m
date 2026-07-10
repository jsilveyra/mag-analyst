classdef ResiduePlotter
%RESIDUEPLOTTER  Data/model overlay plus residual stem plot for one residue.
%   ResiduePlotter(X, Y, Xhat, Yhat, Residue, Log, Label, ...).plot() opens a
%   figure with a data-vs-model curve on top (plot_dots) and the
%   corresponding residual stem plot below (plot_stem); Log selects a
%   log-x axis and Label sets the Y-axis/figure title.

    properties
        X
        Y
        Xhat
        Yhat
        Residue
        Log
        Label

        MarkerSize
        DataColor
        ModelColor
        ResidueColor
        ShowZeroLines
    end

    methods (Access = public)
        function obj = ResiduePlotter(X, Y, Xhat, Yhat, Residue, Log, Label, varargin)
            numvarargs = length(varargin);
            if numvarargs > 5
                error('ResiduePlotter:constructor:TooManyOptionalParameters: requires at most 5 optional parameters');
            end

            optargs = {5, [0 0 0], [0 0 0], [0 0 0], false};
            optargs(1:numvarargs) = varargin;
            [obj.MarkerSize, obj.DataColor, obj.ModelColor, obj.ResidueColor, obj.ShowZeroLines] = optargs{:};
          
            obj.X = X;
            obj.Y = Y;
            obj.Xhat = Xhat;
            obj.Yhat = Yhat;
            obj.Residue = Residue;
            obj.Log = (Log ~= 0);
            obj.Label = Label;
        end

        function plot_stem(obj, ax)
            hold( ax, 'on' );
            if obj.ShowZeroLines
                xline(ax, 0, 'k-', 'LineWidth', 1.2, 'HandleVisibility', 'off');
                yline(ax, 0, 'k-', 'LineWidth', 1.2, 'HandleVisibility', 'off');
                obj.apply_detailed_grid(ax);
            end
            stem(ax, obj.X, obj.Residue, '.', 'markersize', obj.MarkerSize, "Color", obj.ResidueColor);
            xlabel(ax, 'H (A/m)');
            ylabel(ax, 'Residual');
            if obj.Log
                set(gca,'xscal','log');
            end
            set(ax,'yticklabels',[]);
            hold( ax, 'off' );
        end

        function plot_dots(obj, ax)
            hold( ax, 'on' );
            plot(ax, obj.X, obj.Y, '.', 'markersize', obj.MarkerSize, "Color", obj.DataColor);
            plot(ax, obj.Xhat, obj.Yhat, "Color", obj.ModelColor);
            if obj.ShowZeroLines
                xline(ax, 0, 'k-', 'LineWidth', 1.2, 'HandleVisibility', 'off');
                yline(ax, 0, 'k-', 'LineWidth', 1.2, 'HandleVisibility', 'off');
                obj.apply_detailed_grid(ax);
            end
            xlabel(ax, 'H (A/m)');
            ylabel(ax, obj.Label);
            hold( ax, 'off' );
            if obj.Log
                set(gca,'xscal','log');
            end
        end

        function apply_detailed_grid(~, ax)
            grid(ax, 'on');
            ax.XMinorGrid = 'on';
            ax.YMinorGrid = 'on';
            if isprop(ax, 'XMinorTick')
                ax.XMinorTick = 'on';
            end
            if isprop(ax, 'YMinorTick')
                ax.YMinorTick = 'on';
            end
        end

        function plot(obj)
            figure('Name',"Residual plot: " + obj.Label,'NumberTitle','off');
            tiledlayout(4,1)

            % Top plot
            ax1 = nexttile([3 1]);
            box(ax1,'on');
            obj.plot_dots(ax1);

            % Bottom plot
            ax2 = nexttile;
            obj.plot_stem(ax2);
        end
    end
end
