% Backward-compatibility shims for older MATLAB releases.
%
% MagAnalyst is developed on R2024a, but several App Designer component
% properties used by the UI only exist in R2023a or later. Setting one of
% them on an older release is a hard error inside createComponents, so the
% app fails to construct at all (this is what "AllowEmpty is not a
% recognized property" looks like on R2022a/b).
%
% The rule used throughout the project is therefore:
%
%   * NEVER set a release-gated property in Design View -- createComponents
%     is generated code and runs before startupFcn, so there is nowhere to
%     guard it.
%   * Set it here instead, through set_prop(), which silently skips the
%     property when the running release does not have it.
%
% apply(app) is called once from startupFcn (right after the src folder is
% put on the path) and re-applies every such property, so on a current
% release the UI is identical to what Design View used to produce; on an
% older release the app just loses that piece of polish instead of
% refusing to start.
%
% Deliberately release-agnostic: everything is decided with isprop(), never
% by comparing version() against a hardcoded release. That keeps the shim
% correct without anyone having to remember which release introduced what.
%
% See also ThemeUtils (same static-class + one-line-delegator pattern).

classdef CompatUtils

    methods (Static)

        % ---------------------------------------------------------------
        % Generic guarded setters
        % ---------------------------------------------------------------

        function tf = supports(comp, prop)
            % True if COMP is a live handle that actually has property PROP.
            tf = false;
            try
                tf = ~isempty(comp) && all(isvalid(comp)) && isprop(comp(1), prop);
            catch
            end
        end

        function set_prop(comp, prop, value)
            % Set COMP.(PROP) = VALUE, but only if this release has PROP.
            % COMP may be a handle, a handle array, or empty (no-op).
            if ~CompatUtils.supports(comp, prop)
                return;
            end
            try
                set(comp, prop, value);
            catch
                % A property that exists but rejects the value on this
                % release is still better skipped than fatal.
            end
        end

        function h = comp(app, name)
            % Component handle by name, or [] if the app has no such
            % component (guards against a Design View rename/deletion
            % turning this file into a crash on launch).
            h = [];
            try
                if isprop(app, name) && ~isempty(app.(name)) && isvalid(app.(name))
                    h = app.(name);
                end
            catch
            end
        end

        % ---------------------------------------------------------------
        % Numeric edit fields that are meant to be blank
        % ---------------------------------------------------------------

        function clear_value(field)
            % Blank a numeric edit field.
            %
            % Blank ([]) is only assignable when the field has AllowEmpty
            % turned on, which needs R2023a or later. On older releases the
            % closest honest stand-in is NaN: it reads as "no value", and
            % every consumer in this project already rejects it through the
            % isfinite() guards it uses alongside the empty case (see
            % PlaygroundUtils.get_playground_params and
            % HystereticUtils.get_ja_params_from_tab). Use is_blank() rather
            % than isempty() when testing such a field.
            if isempty(field) || ~isvalid(field)
                return;
            end
            if CompatUtils.supports(field, 'AllowEmpty') && ...
                    strcmp(char(string(field.AllowEmpty)), 'on')
                field.Value = [];
                return;
            end
            try
                field.Value = NaN;
            catch
                try
                    field.Value = 0;   % for Limits that exclude NaN
                catch
                end
            end
        end

        function set_value(field, value)
            % Write VALUE to a numeric edit field, routing an empty value
            % through clear_value so it works on every release.
            if isempty(field) || ~isvalid(field)
                return;
            end
            if isempty(value)
                CompatUtils.clear_value(field);
            else
                field.Value = value;
            end
        end

        function tf = is_blank(v)
            % True for the two things clear_value can leave in a field.
            % Accepts either a raw value or the field handle itself.
            try
                if isa(v, 'matlab.ui.control.NumericEditField')
                    v = v.Value;
                end
            catch
            end
            tf = isempty(v) || (isnumeric(v) && isscalar(v) && isnan(v));
        end

        % ---------------------------------------------------------------
        % Main-window pass -- called once from startupFcn
        % ---------------------------------------------------------------

        function apply(app)
            CompatUtils.apply_allow_empty(app);
            CompatUtils.apply_latex_labels(app);
            CompatUtils.apply_button_word_wrap(app);
            CompatUtils.apply_table_selection(app);
            CompatUtils.apply_window_icon(app);
        end

        function names = allow_empty_fields()
            % Numeric edit fields that show blank when they hold no value.
            % Design View must leave AllowEmpty unchecked on all of them.
            names = { ...
                'HTipField', 'MTipField', ...
                'ErrorDisplay', 'chiinField', 'JsField', ...
                'Ms_JA', 'a_JA', 'alpha_JA', 'c_JA', 'k_JA', ...
                'ErrorDisplay_2', 'Htip', 'Mtip', ...
                'Ms_JA_Playground', 'a_JA_Playground', 'alpha_JA_Playground', ...
                'c_JA_Playground', 'k_JA_Playground'};
        end

        function names = allow_empty_bound_fields()
            % JA fitting-bound fields: also need AllowEmpty (a user can
            % clear one at runtime to mean "auto"), but unlike
            % allow_empty_fields() above, each starts with a real default
            % bound (Inf/-Inf/1/0) set by createComponents -- NOT blank.
            % Kept separate so apply_allow_empty() below never blanks these;
            % doing so once left every one of them empty (or, on a release
            % without AllowEmpty, coerced to 0 instead of NaN) at every
            % startup, which is worse than no fix at all since a seed can
            % never lie strictly between a lower and upper bound of 0.
            % aLower_JA is deliberately absent: its default of 0 is already
            % correct and it was never given AllowEmpty in the first place.
            names = { ...
                'MsLower_JA', 'MsUpper_JA', 'aUpper_JA', ...
                'alphaLower_JA', 'alphaUpper_JA', ...
                'cLower_JA', 'cUpper_JA', 'kLower_JA', 'kUpper_JA'};
        end

        function apply_allow_empty(app)
            % AllowEmpty needs R2023a. Turn it on where available, then
            % blank the fields so the app starts up looking the way Design
            % View used to leave it.
            names = CompatUtils.allow_empty_fields();
            for i = 1:numel(names)
                f = CompatUtils.comp(app, names{i});
                if isempty(f)
                    continue;
                end
                CompatUtils.set_prop(f, 'AllowEmpty', 'on');
                CompatUtils.clear_value(f);
            end

            % Bound fields: enable AllowEmpty but leave whatever value
            % createComponents already gave them untouched.
            bound_names = CompatUtils.allow_empty_bound_fields();
            for i = 1:numel(bound_names)
                f = CompatUtils.comp(app, bound_names{i});
                if isempty(f)
                    continue;
                end
                CompatUtils.set_prop(f, 'AllowEmpty', 'on');
            end
        end

        function specs = latex_label_specs()
            % {component, LaTeX text} for the model-equation labels.
            % The plain-text fallback stays in Design View as the label's
            % own Text, so an old release shows readable Unicode instead of
            % raw "$...$" source.
            specs = { ...
                'LWModel_eq', ...
                    ['$M(H) = \sum_{i}^{n} M_i(H) = \sum_{i}^{n} ' ...
                     'M_{S,i} \mathcal{L}\left[(H + \alpha_i M_i) / a_i\right]$']; ...
                'JAmodel_eq1',   '$\quad M_{anh} = M_S \mathcal{L}\left[(H + \alpha M) / a\right]$'; ...
                'JAmodel_eq2',   '$\quad M = c M_{anh} + (1 - c) M_{irr}$'; ...
                'JAmodel_eq3',   '$\quad M_{irr} = M_{anh} - \delta k \, d M_{irr} / d H_{eff}$'; ...
                'JAmodel_eq1_2', '$\quad M_{anh} = M_S \mathcal{L}\left[(H + \alpha M) / a\right]$'; ...
                'JAmodel_eq2_2', '$\quad M = c M_{anh} + (1 - c) M_{irr}$'; ...
                'JAmodel_eq3_2', '$\quad M_{irr} = M_{anh} - \delta k \, d M_{irr} / d H_{eff}$'; ...
                'quadHtsum_kA_ksinkomegatphi_kLabel', ...
                    '$\quad H(t) = \sum_{k} A_k \sin(k\omega t + \phi_k)$'};
        end

        function apply_latex_labels(app)
            % uilabel's Interpreter property needs R2023a.
            specs = CompatUtils.latex_label_specs();
            for i = 1:size(specs, 1)
                lbl = CompatUtils.comp(app, specs{i, 1});
                if isempty(lbl) || ~CompatUtils.supports(lbl, 'Interpreter')
                    continue;   % keep the plain-text Text set in Design View
                end
                CompatUtils.set_prop(lbl, 'Interpreter', 'latex');
                CompatUtils.set_prop(lbl, 'Text', specs{i, 2});
            end
        end

        function apply_button_word_wrap(app)
            % WordWrap on a Button needs R2023a (on a Label it is older).
            names = {'CalculatePlotButton', 'CalculatePlotButton_2', 'CalculatePlotButton_3'};
            for i = 1:numel(names)
                CompatUtils.set_prop(CompatUtils.comp(app, names{i}), 'WordWrap', 'on');
            end
        end

        function apply_table_selection(app)
            % uitable's Selection API (SelectionType/Multiselect/Selection/
            % SelectionChangedFcn) needs R2023a. ColumnRearrangeable and
            % ColumnSortable are applied here too, defensively, so that
            % removing all four from Design View together (they sit in the
            % same Inspector group) is always safe regardless of exactly
            % which release introduced which one.
            specs = { ...
                'UITable',   'row',    'off', 'on', true; ...
                'UITable_3', 'row',    'off', 'on', true; ...
                'UITable2',  'column', 'off', '',  [true false false]};
            for i = 1:size(specs, 1)
                t = CompatUtils.comp(app, specs{i, 1});
                if isempty(t)
                    continue;
                end
                CompatUtils.set_prop(t, 'SelectionType', specs{i, 2});
                CompatUtils.set_prop(t, 'Multiselect',   specs{i, 3});
                if ~isempty(specs{i, 4})
                    CompatUtils.set_prop(t, 'ColumnRearrangeable', specs{i, 4});
                end
                CompatUtils.set_prop(t, 'ColumnSortable', specs{i, 5});
            end
        end

        function apply_window_icon(app)
            % uifigure's Icon property needs R2023b.
            fig = CompatUtils.comp(app, 'MagAnalystUIFigure');
            if isempty(fig) || ~CompatUtils.supports(fig, 'Icon')
                return;
            end
            root = '';
            try
                root = char(app.AppRoot);
            catch
            end
            if isempty(root)
                root = fileparts(which('MagAnalyst'));
            end
            icon_file = fullfile(root, 'assets', 'logo.png');
            if isfile(icon_file)
                CompatUtils.set_prop(fig, 'Icon', icon_file);
            end
        end

        function apply_dialog_icon(fig, icon_file)
            % Same guard for the code-built dialogs (export dialog, fit
            % progress popup, splash screen).
            if isempty(fig) || ~isvalid(fig) || ~CompatUtils.supports(fig, 'Icon')
                return;
            end
            if ~isempty(icon_file) && isfile(icon_file)
                CompatUtils.set_prop(fig, 'Icon', icon_file);
            end
        end

    end
end
