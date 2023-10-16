classdef Plotter

    properties
        data_curve
        modeled_curve
        Hcr
        Colors
        MarkerSize
    end

    methods (Access = public)
        function obj = Plotter(data_curve, modeled_curve, Hcr, colors, varargin)
            numvarargs = length(varargin);
            if numvarargs > 1
                error('Plotter:constructor:TooManyOptionalParameters: requires at most 1 optional parameter');
            end

            optargs = {3};
            optargs(1:numvarargs) = varargin;
            [obj.MarkerSize] = optargs{:};
          
            obj.data_curve = data_curve;
            obj.modeled_curve = modeled_curve;
            obj.Hcr = Hcr;
            obj.Colors = colors;
        end

        function plot_Hcr(obj, ax)
            for i = 1:length(obj.Hcr)
                xline(ax, obj.Hcr(i), '--', "Color",[0, 0.4470, 0.7410], "Label", "Hcr");
            end
        end

        function plot_M(obj, ax, plot_components, plot_grid)
            hold( ax, 'on' );
            tip_data = max(obj.data_curve.M);
            tip_model = max(obj.modeled_curve.M);
            tip = max([tip_model, tip_data]);
            ax.YAxis.Exponent = obj.get_scientific_notation_exponent(tip);
            plot(ax, obj.data_curve.H, obj.data_curve.M, '.', 'markersize', obj.MarkerSize, "Color", [0 0 0]);
            plot(ax, obj.modeled_curve.H, obj.modeled_curve.M, "Color", obj.Colors(1,:));

            if(plot_components)
                for i=1:size(obj.modeled_curve.Mi,1)
                    plot(ax, obj.modeled_curve.H, obj.modeled_curve.Mi(i,:), "Color", obj.Colors(i + 1,:));
                end
            end

            if(plot_grid)
                grid(ax,"on");
            end

            yline(ax, 0);

            obj.plot_Hcr(ax)
            xlabel(ax, 'H [A/m]');
            ylabel(ax, 'M [A/m]');
            box(ax,'on');
            hold( ax, 'off' )     
        end

        function plot_M_log(obj, ax, plot_components, plot_grid)
            semilogx(ax, obj.data_curve.H, obj.data_curve.M, '.', 'markersize', obj.MarkerSize, "Color", [0 0 0]);
            hold( ax, 'on' )
            tip_data = max(obj.data_curve.M);
            tip_model = max(obj.modeled_curve.M);
            tip = max([tip_model, tip_data]);
            ax.YAxis.Exponent = obj.get_scientific_notation_exponent(tip);
            semilogx(ax, obj.modeled_curve.H, obj.modeled_curve.M, "Color", obj.Colors(1,:));

            if(plot_components)
                for i=1:size(obj.modeled_curve.Mi,1)
                    semilogx(ax, obj.modeled_curve.H, obj.modeled_curve.Mi(i,:), "Color", obj.Colors(i + 1,:));
                end
            end

            if(plot_grid)
                grid(ax,"on");
            end

            yline(ax, 0);

            xlabel(ax, 'H [A/m]');
            ylabel(ax, 'M [A/m]');
            obj.plot_Hcr(ax);
            box(ax,'on');
            hold( ax, 'off' )
        end

        function plot_dMdH(obj, ax, plot_components, plot_grid)
            hold( ax, 'on' );
            tip_data = max(obj.data_curve.dMdH);
            tip_model = max(obj.modeled_curve.dMdH);
            tip = max([tip_model, tip_data]);
            ax.YAxis.Exponent = obj.get_scientific_notation_exponent(tip);
            plot(ax, obj.data_curve.H, obj.data_curve.dMdH, '.', 'markersize', obj.MarkerSize, "Color", [0 0 0]);
            plot(ax, obj.modeled_curve.H, obj.modeled_curve.dMdH, "Color", obj.Colors(1,:));
            obj.plot_Hcr(ax);

            if(plot_components)
                for i=1:size(obj.modeled_curve.dMidH,1)
                    plot(ax, obj.modeled_curve.H, obj.modeled_curve.dMidH(i,:), "Color", obj.Colors(i + 1,:));
                end
            end

            if(plot_grid)
                grid(ax,"on");
            end

            yline(ax, 0);

            xlabel(ax, 'H [A/m]');
            ylabel(ax, '∂M/∂H');
            ax.YLim = [min(obj.data_curve.dMdH) max(obj.data_curve.dMdH)*1.1];
            box(ax,'on');
            hold( ax, 'off' )
        end

        function plot_dMdH_log(obj, ax, plot_components, plot_grid)
            semilogx(ax, obj.data_curve.H, obj.data_curve.dMdH, '.', 'markersize', obj.MarkerSize, "Color", [0 0 0]);
            hold( ax, 'on' );
            tip_data = max(obj.data_curve.dMdH);
            tip_model = max(obj.modeled_curve.dMdH);
            tip = max([tip_model, tip_data]);
            ax.YAxis.Exponent = obj.get_scientific_notation_exponent(tip);
            semilogx(ax, obj.modeled_curve.H, obj.modeled_curve.dMdH, "Color", obj.Colors(1,:));
            obj.plot_Hcr(ax);
            
            if(plot_components)
                for i=1:size(obj.modeled_curve.dMidH,1)
                    semilogx(ax, obj.modeled_curve.H, obj.modeled_curve.dMidH(i,:), "Color", obj.Colors(i + 1,:));
                end
            end

            if(plot_grid)
                grid(ax,"on");
            end

            yline(ax, 0);

            xlabel(ax, 'H [A/m]');
            ylabel(ax, '∂M/∂H');
            box(ax,'on');
            hold( ax, 'off' )
        end

        function plot_HdMdH_log(obj, ax, plot_components, plot_grid)
            semilogx(ax, obj.modeled_curve.H, obj.modeled_curve.HdMdH, "Color", obj.Colors(1,:));
            hold( ax, 'on' );
            tip_data = max(obj.data_curve.HdMdH);
            tip_model = max(obj.modeled_curve.HdMdH);
            tip = max([tip_model, tip_data]);
            ax.YAxis.Exponent = obj.get_scientific_notation_exponent(tip);
            semilogx(ax, obj.data_curve.H, obj.data_curve.HdMdH, '.', 'markersize', obj.MarkerSize, "Color", [0 0 0]);
            obj.plot_Hcr(ax);

            if(plot_components)
                for i=1:size(obj.modeled_curve.HdMidH,1)
                    semilogx(ax, obj.modeled_curve.H, obj.modeled_curve.HdMidH(i,:), "Color", obj.Colors(i + 1,:));
                end
            end

            if(plot_grid)
                grid(ax,"on");
            end

            yline(ax, 0);

            xlabel(ax, 'H [A/m]');
            ylabel(ax, '∂M/∂(lnH) [A/m]', "Color",[0, 0, 0]);
            box(ax,'on');
            hold( ax, 'off' );
        end

        function plot_HdMdH(obj, ax, plot_components, plot_grid)
            hold( ax, 'on' );
            tip_data = max(obj.data_curve.HdMdH);
            tip_model = max(obj.modeled_curve.HdMdH);
            tip = max([tip_model, tip_data]);
            ax.YAxis.Exponent = obj.get_scientific_notation_exponent(tip);
            plot(ax, obj.modeled_curve.H, obj.modeled_curve.HdMdH, "Color", obj.Colors(1,:));
            plot(ax, obj.data_curve.H, obj.data_curve.HdMdH, '.', 'markersize', obj.MarkerSize, "Color", [0 0 0]);
            obj.plot_Hcr(ax);

            if(plot_components)
                for i=1:size(obj.modeled_curve.HdMidH, 1)
                    plot(ax, obj.modeled_curve.H, obj.modeled_curve.HdMidH(i,:), "Color", obj.Colors(i + 1,:));
                end
            end

            if(plot_grid)
                grid(ax,"on");
            end

            yline(ax, 0);

            xlabel(ax, 'H [A/m]');
            ylabel(ax, '∂M/∂(lnH) [A/m]', "Color",[0, 0, 0]);
            box(ax,'on');
            hold( ax, 'off' );
        end

        function exponent = get_scientific_notation_exponent(~, tip)
            exponent = 0;

            while (tip >= 10)
                tip = tip / 10;
                exponent = exponent + 1;
            end
        end

        function plot_raw(obj, ax, X, Y, X_label, Y_label, plot_title)
            hold( ax, 'on' );
            xline(ax, 0);
            tip = max(Y);
            ax.YAxis.Exponent = obj.get_scientific_notation_exponent(tip);
            plot(ax, X, Y, '.', 'markersize', obj.MarkerSize, "Color", [0 0 0]);
            grid(ax,"on");
            yline(ax, 0);
            xlabel(ax, X_label);
            ylabel(ax, Y_label);
            title(ax, plot_title);
            box(ax,'on');
            hold( ax, 'off' )     
        end

        function plot_raw_log(obj, ax, X, Y, X_label, Y_label, plot_title)
            semilogx(ax, X, Y, '.', 'markersize', obj.MarkerSize, "Color", [0 0 0]);
            hold( ax, 'on' );
            tip = max(Y);
            ax.YAxis.Exponent = obj.get_scientific_notation_exponent(tip);
            grid(ax,"on");
            yline(ax, 0);
            xlabel(ax, X_label);
            ylabel(ax, Y_label);
            title(ax, plot_title);
            box(ax,'on');
            hold( ax, 'off' )     
        end
    end
end