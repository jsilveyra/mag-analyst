classdef ResiduePlotter

    properties
        X
        Y
        Xhat
        Yhat
        Residue
        Log
        Label

        MarkerSize
    end

    methods (Access = public)
        function obj = ResiduePlotter(X, Y, Xhat, Yhat, Residue, Log, Label, varargin)
            numvarargs = length(varargin);
            if numvarargs > 1
                error('ResiduePlotter:constructor:TooManyOptionalParameters: requires at most 1 optional parameter');
            end

            optargs = {5};
            optargs(1:numvarargs) = varargin;
            [obj.MarkerSize] = optargs{:};
          
            obj.X = X;
            obj.Y = Y;
            obj.Xhat = Xhat;
            obj.Yhat = Yhat;
            obj.Residue = Residue;
            obj.Log = (Log ~= 0);
            obj.Label = Label;
        end

        function plot_stem(obj, ax)
            stem(ax, obj.X, obj.Residue, '.', 'markersize', obj.MarkerSize, "Color",[0, 0, 0]);
            xlabel(ax, 'H (A/m)');
            ylabel(ax, "Residue " + obj.Label);
            if obj.Log
                set(gca,'xscal','log');
            end
            
        end

        function plot_dots(obj, ax)
            hold( ax, 'on' );
            plot(ax, obj.X, obj.Y, '.', 'markersize', obj.MarkerSize, "Color",[0, 0, 0]);
            plot(ax, obj.Xhat, obj.Yhat, "Color",[0,0,0]);
            xlabel(ax, 'H (A/m)');
            ylabel(ax, obj.Label);
            hold( ax, 'off' );
            if obj.Log
                set(gca,'xscal','log');
            end
        end

        function plot(obj)
            figure('Name',"Residue plot: " + obj.Label,'NumberTitle','off');
            tiledlayout(4,1)

            % Top plot
            ax1 = nexttile([3 1]);
            obj.plot_dots(ax1);

            % Bottom plot
            ax2 = nexttile;
            obj.plot_stem(ax2);
        end
    end
end