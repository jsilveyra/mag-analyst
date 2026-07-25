classdef ThemeUtils
%THEMEUTILS App-wide runtime visual theme (colors/fonts/line widths).
%   Shared by every tab, so it lives here rather than in a per-tab Utils
%   file. app_exported.m only needs a single delegator call,
%   ThemeUtils.apply_theme(app), at the end of startupFcn. ColorDialog.m
%   (a separate small .mlapp) needs ThemeUtils.apply_theme_to_dialog(app)
%   at the end of its own startupFcn.

    methods (Static)
        function t = theme_palette()
            % -------------------------------------------------------------
            % THEME KNOBS - this method is the single place to retune the
            % app's look. Every color and font that apply_theme uses is
            % read from the struct below; no other method needs editing.
            % Colors are RGB triplets in [0 1].
            % -------------------------------------------------------------
            t.font          = 'Segoe UI';          % UI font family
            t.monoFont      = 'Consolas';          % Messages console font
            t.accent        = [0.945 0.353 0.161]; % #F15A29 brand orange: primary buttons (and modeled curves)
            t.ink           = [0.149 0.153 0.173]; % near-black for labels and panel titles
            t.mutedInk      = [0.502 0.502 0.502]; % gray for de-emphasized hint text (e.g. "(optional)")
            t.titleColor    = [0.149 0.153 0.173]; % section-title color (dark gray; set = t.accent to tint them orange)
            t.canvas        = [0.957 0.949 0.937]; % warm off-white window/tab background
            t.card          = [1.0 1.0 1.0];       % white background of panels ("cards")
            t.cardBorder    = [0.855 0.839 0.816]; % hairline border around panels
            t.axisInk       = [0.35 0.35 0.38];    % axes tick/label color
            t.gridColor     = [0.55 0.55 0.58];    % plot grid color
            t.gridAlpha     = 0.15;                % plot grid opacity (0..1)
            t.plotLineWidth = 1.4;                 % width of curves drawn in plots
            t.titleSize     = 13;                  % font size of section titles
            % NOTE: the modeled/simulated curve color and the anhysteretic
            % component-curve palette are the rows of app.Colors, set in
            % startupFcn (row 1 = modeled total, rows 2+ = components). Edit
            % them there. The default row 1 already matches t.accent.
        end

        function apply_theme(app)
            % Runtime visual theme for the main window, called once at the
            % end of startupFcn. All knobs live in theme_palette. Applied at
            % runtime, so no component definitions in createComponents
            % change and functionality is untouched.
            t = ThemeUtils.theme_palette();
            fig = app.MagAnalystUIFigure;
            if isempty(fig) || ~isvalid(fig)
                return;
            end

            ThemeUtils.apply_theme_to_figure(fig, t);

            % Canvas vs. card for structural grid layouts: outside any panel
            % gets the warm off-white, inside a panel stays card white so
            % each panel reads as a card sitting on the canvas. Kept out of
            % apply_theme_to_figure (and so NOT applied to ColorDialog) -
            % ColorDialog uses a uigridlayout's BackgroundColor to display a
            % live user-picked color, not as structural decoration, and
            % recoloring it here would overwrite that data.
            grids = findall(fig, 'Type', 'uigridlayout');
            for i = 1:numel(grids)
                try
                    if isempty(ancestor(grids(i), 'uipanel'))
                        grids(i).BackgroundColor = t.canvas;
                    else
                        grids(i).BackgroundColor = t.card;
                    end
                catch
                end
            end

            % Section titles: same dark gray as body text but bold and a
            % touch larger, so the hierarchy reads through weight/size
            % rather than color.
            sectionTitles = {
                'InputDatasetpathLabel', ...
                'MulticomponentLangevinWeissmodelLabel', ...
                'JilesAthertonrateindependentmodelLabel_2', ...
                'JilesAthertonrateindependentmodelLabel', ...
            };
            for i = 1:numel(sectionTitles)
                ThemeUtils.style_section_title(app, sectionTitles{i}, t.titleColor, t.titleSize);
            end

            % De-emphasized hint labels (e.g. "(optional)" next to Notes):
            % restored to gray after the blanket ink pass above, matching
            % their original mlapp styling rather than the general body
            % text color.
            mutedLabels = { 'optionalLabel' };
            for i = 1:numel(mutedLabels)
                ThemeUtils.style_muted_label(app, mutedLabels{i}, t.mutedInk);
            end

            % Primary "do it" buttons: white bold text on accent orange.
            % Everything else stays flat white (set generically by
            % apply_theme_to_figure).
            primaryButtons = { 'FitButton', ...
                'FitButton_2', ...
                'CalculatePlotButton', ...
                'CalculatePlotButton_2', ...
                'CalculatePlotButton_3' };
            for i = 1:numel(primaryButtons)
                ThemeUtils.style_accent_button(app, primaryButtons{i}, t.accent);
            end

            % The Messages log gets a monospaced font on the canvas tint so
            % it reads as a console, not a form field.
            try
                app.MessagesTextArea.FontName = t.monoFont;
                app.MessagesTextArea.FontColor = t.ink;
                app.MessagesTextArea.BackgroundColor = t.canvas;
            catch
            end
        end

        function apply_theme_to_dialog(app)
            % Runtime visual theme for small standalone-.mlapp dialogs
            % (currently: ColorDialog), called once at the end of their own
            % startupFcn. Same palette as the main window, generic passes
            % only - deliberately skips apply_theme's structural-grid
            % recolor pass (see the comment there): ColorDialog shows each
            % curve's live picked color via a uigridlayout's
            % BackgroundColor, and blindly recoloring every uigridlayout
            % would erase that.
            t = ThemeUtils.theme_palette();
            fig = app.UIFigure;
            if isempty(fig) || ~isvalid(fig)
                return;
            end

            ThemeUtils.apply_theme_to_figure(fig, t);
            ThemeUtils.style_section_title(app, 'SetColorsLabel', t.titleColor, t.titleSize);

            % The row of color-pick buttons reads as one card grouped on
            % the canvas, matching the main window's panel-as-card look
            % (ColorDialog has no uipanel, just this one uigridlayout).
            try
                if isprop(app, 'GridLayoutButtons') && isvalid(app.GridLayoutButtons)
                    app.GridLayoutButtons.BackgroundColor = t.card;
                end
            catch
            end
        end

        function apply_theme_to_figure(fig, t)
            % Generic passes safe for ANY uifigure (main window or a small
            % dialog): consistent font, window background, tab backgrounds,
            % panels as white cards, label/button colors, axes/grid
            % styling. Deliberately excludes recoloring uigridlayout
            % backgrounds wholesale - see the callers for why.
            try
                set(findall(fig, '-property', 'FontName'), 'FontName', t.font);
            catch
            end

            try
                fig.Color = t.canvas;
            catch
            end
            try
                set(findall(fig, 'Type', 'uitab'), 'BackgroundColor', t.canvas);
            catch
            end

            panels = findall(fig, 'Type', 'uipanel');
            for i = 1:numel(panels)
                try
                    panels(i).BackgroundColor = t.card;
                    panels(i).ForegroundColor = t.ink;
                    panels(i).FontWeight = 'bold';
                    if isprop(panels(i), 'BorderColor')
                        panels(i).BorderColor = t.cardBorder;
                    end
                catch
                end
            end

            try
                set(findall(fig, 'Type', 'uilabel'), 'FontColor', t.ink);
            catch
            end

            try
                set(findall(fig, 'Type', 'uibutton'), 'BackgroundColor', t.card);
            catch
            end

            % Softer tick/grid colors and slightly heavier curves. Set on
            % existing axes AND as figure-level defaults, because
            % cla(ax,'reset') / semilogx rebuild axes properties from those
            % defaults - per-axes styling alone would be wiped by the first
            % replot.
            axs = findall(fig, 'Type', 'axes');
            for i = 1:numel(axs)
                try
                    set(axs(i), 'XColor', t.axisInk, 'YColor', t.axisInk, ...
                        'GridColor', t.gridColor, 'GridAlpha', t.gridAlpha);
                catch
                end
            end
            try
                set(fig, 'DefaultAxesFontName', t.font, ...
                    'DefaultAxesXColor', t.axisInk, ...
                    'DefaultAxesYColor', t.axisInk, ...
                    'DefaultAxesGridColor', t.gridColor, ...
                    'DefaultAxesGridAlpha', t.gridAlpha, ...
                    'DefaultLineLineWidth', t.plotLineWidth);
            catch
            end
        end

        function style_accent_button(app, name, accent)
            if isprop(app, name) && ~isempty(app.(name)) && isvalid(app.(name))
                b = app.(name);
                b.BackgroundColor = accent;
                b.FontColor = [1 1 1];
                b.FontWeight = 'bold';
            end
        end

        function style_section_title(app, name, titleColor, sz)
            if isprop(app, name) && ~isempty(app.(name)) && isvalid(app.(name))
                lbl = app.(name);
                lbl.FontColor = titleColor;
                lbl.FontWeight = 'bold';
                lbl.FontSize = sz;
            end
        end

        function style_muted_label(app, name, mutedColor)
            if isprop(app, name) && ~isempty(app.(name)) && isvalid(app.(name))
                app.(name).FontColor = mutedColor;
            end
        end
    end
end
