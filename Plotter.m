classdef Plotter

    properties
        H
        M
        HdMdH
        dMdH
        Hhat
        Mhat
        Mihat
        dMdHhat
        dMidHhat
        HdMdHhat
        HdMidHhat
        Hcr
        Colors
        MarkerSize
    end

    methods (Access = public)
        function obj = Plotter(H, M, dMdH , HdMdH, Hhat, Mhat, Mihat, dMdHhat, dMidHhat, HdMdHhat, HdMidHhat, Hcr, colors, varargin)
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
            obj.Mihat = Mihat;
            obj.dMdHhat = dMdHhat;
            obj.dMidHhat = dMidHhat;
            obj.HdMdHhat = HdMdHhat;
            obj.HdMidHhat = HdMidHhat;
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
            tip_data = max(obj.M);
            tip_model = max(obj.Mhat);
            tip = max([tip_model, tip_data]);
            ax.YAxis.Exponent = obj.get_scientific_notation_exponent(tip);
            plot(ax, obj.H, obj.M, '.', 'markersize', obj.MarkerSize, "Color", [0 0 0]);
            plot(ax, obj.Hhat, obj.Mhat, "Color", obj.Colors(1,:));

            if(plot_components)
                for i=1:size(obj.Mihat,1)
                    plot(ax, obj.Hhat,obj.Mihat(i,:), "Color", obj.Colors(i + 1,:));
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
            semilogx(ax, obj.H,obj.M, '.', 'markersize', obj.MarkerSize, "Color", [0 0 0]);
            hold( ax, 'on' )
            tip_data = max(obj.M);
            tip_model = max(obj.Mhat);
            tip = max([tip_model, tip_data]);
            ax.YAxis.Exponent = obj.get_scientific_notation_exponent(tip);
            semilogx(ax, obj.Hhat,obj.Mhat, "Color", obj.Colors(1,:));

            if(plot_components)
                for i=1:size(obj.Mihat,1)
                    semilogx(ax, obj.Hhat,obj.Mihat(i,:), "Color", obj.Colors(i + 1,:));
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
            tip_data = max(obj.dMdH);
            tip_model = max(obj.dMdHhat);
            tip = max([tip_model, tip_data]);
            ax.YAxis.Exponent = obj.get_scientific_notation_exponent(tip);
            plot(ax, obj.H,obj.dMdH, '.', 'markersize', obj.MarkerSize, "Color", [0 0 0]);
            plot(ax, obj.Hhat, obj.dMdHhat, "Color", obj.Colors(1,:));
            obj.plot_Hcr(ax);

            if(plot_components)
                for i=1:size(obj.dMidHhat,1)
                    plot(ax, obj.Hhat,obj.dMidHhat(i,:), "Color", obj.Colors(i + 1,:));
                end
            end

            if(plot_grid)
                grid(ax,"on");
            end

            yline(ax, 0);

            xlabel(ax, 'H [A/m]');
            ylabel(ax, '∂M/∂H');
            ax.YLim = [min(obj.dMdH) max(obj.dMdH)*1.1];
            box(ax,'on');
            hold( ax, 'off' )
        end

        function plot_dMdH_log(obj, ax, plot_components, plot_grid)
            semilogx(ax, obj.H,obj.dMdH, '.', 'markersize', obj.MarkerSize, "Color", [0 0 0]);
            hold( ax, 'on' );
            tip_data = max(obj.dMdH);
            tip_model = max(obj.dMdHhat);
            tip = max([tip_model, tip_data]);
            ax.YAxis.Exponent = obj.get_scientific_notation_exponent(tip);
            semilogx(ax, obj.Hhat, obj.dMdHhat, "Color", obj.Colors(1,:));
            obj.plot_Hcr(ax);
            
            if(plot_components)
                for i=1:size(obj.dMidHhat,1)
                    semilogx(ax, obj.Hhat,obj.dMidHhat(i,:), "Color", obj.Colors(i + 1,:));
                end
            end

            if(plot_grid)
                grid(ax,"on");
            end

            yline(ax, 0);

            xlabel(ax, 'H [A/m]');
            ylabel(ax, '∂M/∂H');
            %ax.YLim = [min(obj.dMdH) max(obj.dMdH)*1.1];
            box(ax,'on');
            hold( ax, 'off' )
        end

        function plot_HdMdH_log(obj, ax, plot_components, plot_grid)
            semilogx(ax, obj.Hhat, obj.HdMdHhat, "Color", obj.Colors(1,:));
            hold( ax, 'on' );
            tip_data = max(obj.HdMdH);
            tip_model = max(obj.HdMdHhat);
            tip = max([tip_model, tip_data]);
            ax.YAxis.Exponent = obj.get_scientific_notation_exponent(tip);
            semilogx(ax, obj.H,obj.HdMdH, '.', 'markersize', obj.MarkerSize, "Color", [0 0 0]);
            obj.plot_Hcr(ax);

            if(plot_components)
                for i=1:size(obj.HdMidHhat,1)
                    semilogx(ax, obj.Hhat,obj.HdMidHhat(i,:), "Color", obj.Colors(i + 1,:));
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
            tip_data = max(obj.HdMdH);
            tip_model = max(obj.HdMdHhat);
            tip = max([tip_model, tip_data]);
            ax.YAxis.Exponent = obj.get_scientific_notation_exponent(tip);
            plot(ax, obj.Hhat, obj.HdMdHhat, "Color", obj.Colors(1,:));
            plot(ax, obj.H,obj.HdMdH, '.', 'markersize', obj.MarkerSize, "Color", [0 0 0]);
            obj.plot_Hcr(ax);

            if(plot_components)
                for i=1:size(obj.HdMidHhat,1)
                    plot(ax, obj.Hhat,obj.HdMidHhat(i,:), "Color", obj.Colors(i + 1,:));
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