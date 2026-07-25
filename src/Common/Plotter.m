classdef Plotter
%PLOTTER  Draws measured vs. modeled anhysteretic curves on a given axes.
%   Plotter(data_curve, modeled_curve, Hcr, colors, marker_size) plots M,
%   dM/dH, and the semilog derivative H*dM/dH (linear or log-H variants via
%   plot_M/plot_M_log/plot_dMdH/plot_dMdH_log/plot_HdMdH/plot_HdMdH_log),
%   optionally overlaying per-component curves and Hcr marker lines
%   (plot_Hcr). Also provides plot_raw/plot_raw_log for generic scatter plots.

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
            if strcmp(ax.XScale, 'log')
                valid_idx = find(isfinite(obj.Hcr) & obj.Hcr > 0);
            else
                valid_idx = find(isfinite(obj.Hcr));
            end
            for i = valid_idx
                % obj.Colors row 1 is the total curve; row i+1 is component i
                % (same convention as the component-curve plots below).
                color = [0, 0.4470, 0.7410];
                if size(obj.Colors, 1) >= i + 1
                    color = obj.Colors(i + 1, :);
                end
                xline(ax, obj.Hcr(i), '--', "Color", color, "Label", "Hcr");
            end
        end

        function plot_M(obj, ax, plot_components, plot_grid, M_label)
            if nargin < 5 || isempty(M_label)
                M_label = 'M [A/m]';
            end
            hold( ax, 'on' );
            yline(ax, 0);
            tip_data = max(obj.data_curve.M);
            tip_model = max(obj.modeled_curve.M);
            tip = max([tip_model, tip_data]);
            ax.YAxis.Exponent = obj.get_scientific_notation_exponent(tip);
            plot(ax, obj.data_curve.H, obj.data_curve.M, '.', 'markersize', obj.MarkerSize, "Color", [0 0 0]);

            if(plot_components)
                for i=1:size(obj.modeled_curve.Mi,1)
                    plot(ax, obj.modeled_curve.H, obj.modeled_curve.Mi(i,:), "Color", obj.Colors(i + 1,:));
                end
            end

            % total modeled curve drawn last so it stays on top of the
            % component curves (they coincide when there is a single component,
            % and the orange total must remain visible).
            plot(ax, obj.modeled_curve.H, obj.modeled_curve.M, "Color", obj.Colors(1,:), 'LineWidth', 1.6);

            obj.apply_detailed_grid(ax, plot_grid);

            obj.plot_Hcr(ax)
            xlabel(ax, 'H [A/m]');
            ylabel(ax, M_label);
            box(ax,'on');
            hold( ax, 'off' )
        end

        function plot_M_log(obj, ax, plot_components, plot_grid, M_label)
            if nargin < 5 || isempty(M_label)
                M_label = 'M [A/m]';
            end
            [H_data, M_data] = obj.positive_x(obj.data_curve.H, obj.data_curve.M);
            semilogx(ax, H_data, M_data, '.', 'markersize', obj.MarkerSize, "Color", [0 0 0]);
            hold( ax, 'on' )
            yline(ax, 0);
            tip_data = max(obj.data_curve.M);
            tip_model = max(obj.modeled_curve.M);
            tip = max([tip_model, tip_data]);
            ax.YAxis.Exponent = obj.get_scientific_notation_exponent(tip);

            if(plot_components)
                for i=1:size(obj.modeled_curve.Mi,1)
                    semilogx(ax, obj.modeled_curve.H, obj.modeled_curve.Mi(i,:), "Color", obj.Colors(i + 1,:));
                end
            end

            % total modeled curve drawn last so it stays on top of the
            % component curves (they coincide when there is a single component).
            semilogx(ax, obj.modeled_curve.H, obj.modeled_curve.M, "Color", obj.Colors(1,:), 'LineWidth', 1.6);

            obj.apply_detailed_grid(ax, plot_grid);

            xlabel(ax, 'H [A/m]');
            ylabel(ax, M_label);
            obj.plot_Hcr(ax);
            box(ax,'on');
            hold( ax, 'off' )
        end

        function plot_dMdH(obj, ax, plot_components, plot_grid, dMdH_label)
            if nargin < 5 || isempty(dMdH_label)
                dMdH_label = '∂M/∂H';
            end
            hold( ax, 'on' );
            yline(ax, 0);
            tip_data = max(obj.data_curve.dMdH);
            tip_model = max(obj.modeled_curve.dMdH);
            tip = max([tip_model, tip_data]);
            ax.YAxis.Exponent = obj.get_scientific_notation_exponent(tip);
            plot(ax, obj.data_curve.H, obj.data_curve.dMdH, '.', 'markersize', obj.MarkerSize, "Color", [0 0 0]);
            obj.plot_Hcr(ax);

            if(plot_components)
                for i=1:size(obj.modeled_curve.dMidH,1)
                    plot(ax, obj.modeled_curve.H, obj.modeled_curve.dMidH(i,:), "Color", obj.Colors(i + 1,:));
                end
            end

            % total modeled curve drawn last so it stays on top of the
            % component curves (they coincide when there is a single component).
            plot(ax, obj.modeled_curve.H, obj.modeled_curve.dMdH, "Color", obj.Colors(1,:), 'LineWidth', 1.6);

            obj.apply_detailed_grid(ax, plot_grid);

            xlabel(ax, 'H [A/m]');
            ylabel(ax, dMdH_label);
            ax.YLim = [min(obj.data_curve.dMdH) max(obj.data_curve.dMdH)*1.1];
            box(ax,'on');
            hold( ax, 'off' )
        end

        function plot_dMdH_log(obj, ax, plot_components, plot_grid, dMdH_label)
            if nargin < 5 || isempty(dMdH_label)
                dMdH_label = '∂M/∂H';
            end
            [H_data, dMdH_data] = obj.positive_x(obj.data_curve.H, obj.data_curve.dMdH);
            semilogx(ax, H_data, dMdH_data, '.', 'markersize', obj.MarkerSize, "Color", [0 0 0]);
            hold( ax, 'on' );
            yline(ax, 0);
            tip_data = max(obj.data_curve.dMdH);
            tip_model = max(obj.modeled_curve.dMdH);
            tip = max([tip_model, tip_data]);
            ax.YAxis.Exponent = obj.get_scientific_notation_exponent(tip);
            obj.plot_Hcr(ax);

            if(plot_components)
                for i=1:size(obj.modeled_curve.dMidH,1)
                    semilogx(ax, obj.modeled_curve.H, obj.modeled_curve.dMidH(i,:), "Color", obj.Colors(i + 1,:));
                end
            end

            % total modeled curve drawn last so it stays on top of the
            % component curves (they coincide when there is a single component).
            semilogx(ax, obj.modeled_curve.H, obj.modeled_curve.dMdH, "Color", obj.Colors(1,:), 'LineWidth', 1.6);

            obj.apply_detailed_grid(ax, plot_grid);

            xlabel(ax, 'H [A/m]');
            ylabel(ax, dMdH_label);
            box(ax,'on');
            hold( ax, 'off' )
        end

        function plot_HdMdH_log(obj, ax, plot_components, plot_grid, HdMdH_label)
            if nargin < 5 || isempty(HdMdH_label)
                HdMdH_label = '∂M/∂(lnH) [A/m]';
            end
            hold( ax, 'on' );
            yline(ax, 0);
            tip_data = max(obj.data_curve.HdMdH);
            tip_model = max(obj.modeled_curve.HdMdH);
            tip = max([tip_model, tip_data]);
            ax.YAxis.Exponent = obj.get_scientific_notation_exponent(tip);
            [H_data, HdMdH_data] = obj.positive_x(obj.data_curve.H, obj.data_curve.HdMdH);
            semilogx(ax, H_data, HdMdH_data, '.', 'markersize', obj.MarkerSize, "Color", [0 0 0]);
            obj.plot_Hcr(ax);

            if(plot_components)
                for i=1:size(obj.modeled_curve.HdMidH,1)
                    semilogx(ax, obj.modeled_curve.H, obj.modeled_curve.HdMidH(i,:), "Color", obj.Colors(i + 1,:));
                end
            end

            % total modeled curve drawn last so it stays on top of the
            % component curves (they coincide when there is a single component).
            semilogx(ax, obj.modeled_curve.H, obj.modeled_curve.HdMdH, "Color", obj.Colors(1,:), 'LineWidth', 1.6);

            obj.apply_detailed_grid(ax, plot_grid);

            xlabel(ax, 'H [A/m]');
            ylabel(ax, HdMdH_label, "Color",[0, 0, 0]);
            box(ax,'on');
            hold( ax, 'off' );
        end

        function plot_HdMdH(obj, ax, plot_components, plot_grid, HdMdH_label)
            if nargin < 5 || isempty(HdMdH_label)
                HdMdH_label = '∂M/∂(lnH) [A/m]';
            end
            hold( ax, 'on' );
            yline(ax, 0);
            tip_data = max(obj.data_curve.HdMdH);
            tip_model = max(obj.modeled_curve.HdMdH);
            tip = max([tip_model, tip_data]);
            ax.YAxis.Exponent = obj.get_scientific_notation_exponent(tip);
            plot(ax, obj.data_curve.H, obj.data_curve.HdMdH, '.', 'markersize', obj.MarkerSize, "Color", [0 0 0]);
            obj.plot_Hcr(ax);

            if(plot_components)
                for i=1:size(obj.modeled_curve.HdMidH, 1)
                    plot(ax, obj.modeled_curve.H, obj.modeled_curve.HdMidH(i,:), "Color", obj.Colors(i + 1,:));
                end
            end

            % total modeled curve drawn last so it stays on top of the
            % component curves (they coincide when there is a single component).
            plot(ax, obj.modeled_curve.H, obj.modeled_curve.HdMdH, "Color", obj.Colors(1,:), 'LineWidth', 1.6);

            obj.apply_detailed_grid(ax, plot_grid);

            xlabel(ax, 'H [A/m]');
            ylabel(ax, HdMdH_label, "Color",[0, 0, 0]);
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
            obj.apply_detailed_grid(ax);
            yline(ax, 0);
            xlabel(ax, X_label);
            ylabel(ax, Y_label);
            title(ax, plot_title);
            box(ax,'on');
            hold( ax, 'off' )
        end

        function plot_raw_log(obj, ax, X, Y, X_label, Y_label, plot_title)
            [X_positive, Y_positive] = obj.positive_x(X, Y);
            semilogx(ax, X_positive, Y_positive, '.', 'markersize', obj.MarkerSize, "Color", [0 0 0]);
            hold( ax, 'on' );
            tip = max(Y);
            ax.YAxis.Exponent = obj.get_scientific_notation_exponent(tip);
            obj.apply_detailed_grid(ax);
            xlabel(ax, X_label);
            ylabel(ax, Y_label);
            title(ax, plot_title);
            box(ax,'on');
            hold( ax, 'off' )
        end

        function [X_positive, Y_positive] = positive_x(~, X, Y)
            % Drop non-positive-H points before a log-x plot call: MATLAB
            % prints "Warning: Negative data ignored" to the command window
            % for any H<=0 point (e.g. the H=0 demagnetized-state sample
            % that anhysteretic curves commonly start at), so it must be
            % filtered ahead of the call rather than left for MATLAB to warn.
            valid = X > 0;
            X_positive = X(valid);
            Y_positive = Y(valid);
        end

        function apply_detailed_grid(~, ax, show_grid)
            if nargin < 3
                show_grid = true;
            end
            grid(ax, 'off');
            ax.XMinorGrid = 'off';
            ax.YMinorGrid = 'off';
            if isprop(ax, 'XMinorTick')
                ax.XMinorTick = 'on';
            end
            if isprop(ax, 'YMinorTick')
                ax.YMinorTick = 'on';
            end
            if show_grid
                grid(ax, 'on');
                ax.XMinorGrid = 'on';
                ax.YMinorGrid = 'on';
            end
        end
    end
end
