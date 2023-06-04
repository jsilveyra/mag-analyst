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

            hold( ax, 'on' )
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
            ylabel(ax, '∂M/∂(logH) [A/m]', "Color",[0, 0, 0]);
            box(ax,'on');
            hold( ax, 'off' );
        end

        function plot_HdMdH(obj, ax, plot_components, plot_grid)
            hold( ax, 'on' );
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
            ylabel(ax, '∂M/∂(logH) [A/m]', "Color",[0, 0, 0]);
            box(ax,'on');
            hold( ax, 'off' );
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