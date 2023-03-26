classdef ResiduePlotter

    properties
        X
        Y
        Residue
        Log

        MarkerSize
    end

    methods (Access = public)
        function obj = ResiduePlotter(X, Y, Residue, Log, varargin)
            numvarargs = length(varargin);
            if numvarargs > 1
                error('ResiduePlotter:constructor:TooManyOptionalParameters: requires at most 1 optional parameter');
            end

            optargs = {5};
            optargs(1:numvarargs) = varargin;
            [obj.MarkerSize] = optargs{:};
          
            obj.X = X;
            obj.Y = Y;
            obj.Residue = Residue;
            obj.Log = (Log ~= 0);
        end

        function plot_stem(obj, ax, Y, YLabel)
            stem(ax, obj.X, Y, '.', 'markersize', obj.MarkerSize, "Color",[0, 0, 0]);
            xlabel(ax, 'H (A/m)');
            ylabel(ax, YLabel);
            if obj.Log
                set(gca,'xscal','log');
            end
            
        end

        function plot_dots(obj, ax, Y, Ylabel)
            plot(ax, obj.X, Y, '.', 'markersize', obj.MarkerSize, "Color",[0, 0, 0]);
            xlabel(ax, 'H (A/m)');
            ylabel(ax, Ylabel);
            if obj.Log
                set(gca,'xscal','log');
            end
        end

        function plot(obj)
            figure();
            tiledlayout(4,1)

            % Top plot
            ax1 = nexttile([3 1]);
            obj.plot_dots(ax1, obj.Y, 'M (A/m)');

            % Bottom plot
            ax2 = nexttile;
            obj.plot_stem(ax2, obj.Residue, 'Residue M (A/m)');
        end
    end
end