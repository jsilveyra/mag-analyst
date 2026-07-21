classdef app_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        MagAnalystUIFigure              matlab.ui.Figure
        ProjectMenu                     matlab.ui.container.Menu
        NewMenu                         matlab.ui.container.Menu
        OpenMenu                        matlab.ui.container.Menu
        SaveMenu                        matlab.ui.container.Menu
        SaveasMenu                      matlab.ui.container.Menu
        ExportMenu                      matlab.ui.container.Menu
        AppGridLayout                   matlab.ui.container.GridLayout
        MessagesTabPanel                matlab.ui.container.TabGroup
        ActivitylogTab                  matlab.ui.container.Tab
        MessagesGridLayout              matlab.ui.container.GridLayout
        MessagesTextArea                matlab.ui.control.TextArea
        TabGroup                        matlab.ui.container.TabGroup
        InputdataTab                    matlab.ui.container.Tab
        GridLayout9                     matlab.ui.container.GridLayout
        MtipAmLabel                     matlab.ui.control.Label
        MTipField                       matlab.ui.control.NumericEditField
        HtipAmLabel                     matlab.ui.control.Label
        HTipField                       matlab.ui.control.NumericEditField
        CurvetypeDropDown               matlab.ui.control.DropDown
        CurvetypeDropDownLabel          matlab.ui.control.Label
        VerticalaxisfieldDropDown       matlab.ui.control.DropDown
        VerticalaxisfieldDropDownLabel  matlab.ui.control.Label
        HorizontalaxisfieldDropDown     matlab.ui.control.DropDown
        HorizontalaxisfieldDropDownLabel  matlab.ui.control.Label
        optionalLabel                   matlab.ui.control.Label
        InputNumberofPointsLabel        matlab.ui.control.Label
        InputNumberofPointsEditField    matlab.ui.control.NumericEditField
        AxisscaleLabel                  matlab.ui.control.Label
        InputAxisScaleDropDown          matlab.ui.control.DropDown
        NotesLabel                      matlab.ui.control.Label
        InputDatasetPath                matlab.ui.control.EditField
        InputBrowseButton               matlab.ui.control.Button
        InputDatasetpathLabel           matlab.ui.control.Label
        DescriptionTextArea             matlab.ui.control.TextArea
        AxesRawInputData                matlab.ui.control.UIAxes
        AxesProcessedInputData          matlab.ui.control.UIAxes
        AnhystereticfittingTab          matlab.ui.container.Tab
        GridLayout11                    matlab.ui.container.GridLayout
        NofpointsEditField              matlab.ui.control.NumericEditField
        NofpointsLabel                  matlab.ui.control.Label
        NofcompSpinner                  matlab.ui.control.Spinner
        NofcompLabel                    matlab.ui.control.Label
        JsTLabel                        matlab.ui.control.Label
        JsField                         matlab.ui.control.NumericEditField
        ErrorDropDown                   matlab.ui.control.DropDown
        ErrorDropDownLabel              matlab.ui.control.Label
        ReduceDofCheckBox               matlab.ui.control.CheckBox
        MathematicalparametersLabel     matlab.ui.control.Label
        MulticomponentLangevinWeissmodelLabel  matlab.ui.control.Label
        TableQuantities                 matlab.ui.control.Table
        TableParameters                 matlab.ui.control.Table
        PhysicalparametersLabel         matlab.ui.control.Label
        TableFittedParameters           matlab.ui.control.Table
        SetcolorsButton                 matlab.ui.control.Button
        PointSpaceDropDown              matlab.ui.control.DropDown
        chiinLabel                      matlab.ui.control.Label
        chiinField                      matlab.ui.control.NumericEditField
        CalculatedquantitiesLabel       matlab.ui.control.Label
        StopfitButton                   matlab.ui.control.Button
        ErrorDisplay                    matlab.ui.control.NumericEditField
        CalculatePlotButton             matlab.ui.control.Button
        FitButton                       matlab.ui.control.Button
        ShowhcrCheckBoxHdMdH            matlab.ui.control.CheckBox
        AxisScaleDropDownHdMdH          matlab.ui.control.DropDown
        ShowgridCheckBoxHdMdH           matlab.ui.control.CheckBox
        PlotcomponentsCheckBoxHdMdH     matlab.ui.control.CheckBox
        ResidualplotButtondHdMdH        matlab.ui.control.Button
        ShowhcrCheckBoxdMdH             matlab.ui.control.CheckBox
        AxisScaleDropDowndMdH           matlab.ui.control.DropDown
        ShowgridCheckBoxdMdH            matlab.ui.control.CheckBox
        PlotcomponentsCheckBoxdMdH      matlab.ui.control.CheckBox
        ResidualplotButtondMdH          matlab.ui.control.Button
        ShowhcrCheckBoxM                matlab.ui.control.CheckBox
        AxisScaleDropDownM              matlab.ui.control.DropDown
        ShowgridCheckBoxM               matlab.ui.control.CheckBox
        PlotcomponentsCheckBoxM         matlab.ui.control.CheckBox
        ResidualplotButtonM             matlab.ui.control.Button
        AxesHdMdH                       matlab.ui.control.UIAxes
        AxesdMdH                        matlab.ui.control.UIAxes
        AxesM                           matlab.ui.control.UIAxes
        HystereticfittingTab            matlab.ui.container.Tab
        GridLayout10                    matlab.ui.container.GridLayout
        MaximumrepetitionsEditField     matlab.ui.control.NumericEditField
        MaximumrepetitionsEditFieldLabel  matlab.ui.control.Label
        RelativetoleranceEditField      matlab.ui.control.NumericEditField
        RelativetoleranceEditFieldLabel  matlab.ui.control.Label
        RepetitionsEditField_3          matlab.ui.control.NumericEditField
        RepetitionsEditField_3Label     matlab.ui.control.Label
        StopcriterionDropDown_5         matlab.ui.control.DropDown
        StopcriterionDropDown_5Label    matlab.ui.control.Label
        FittingregionDropDown           matlab.ui.control.DropDown
        FittingregionDropDownLabel      matlab.ui.control.Label
        StartingpointDropDown_4         matlab.ui.control.DropDown
        StartingpointDropDown_4Label    matlab.ui.control.Label
        FittingconditionsLabel          matlab.ui.control.Label
        StopfitButton_2                 matlab.ui.control.Button
        kConstrainedCheckBox_2          matlab.ui.control.CheckBox
        FitkCheckBox                    matlab.ui.control.CheckBox
        CheckBox_4                      matlab.ui.control.CheckBox
        CheckBox_3                      matlab.ui.control.CheckBox
        CheckBox_2                      matlab.ui.control.CheckBox
        CheckBox                        matlab.ui.control.CheckBox
        FitLabel                        matlab.ui.control.Label
        kUpper_JA                       matlab.ui.control.NumericEditField
        UpperboundLabel                 matlab.ui.control.Label
        kLower_JA                       matlab.ui.control.NumericEditField
        LowerboundLabel                 matlab.ui.control.Label
        cUpper_JA                       matlab.ui.control.NumericEditField
        cLower_JA                       matlab.ui.control.NumericEditField
        alphaUpper_JA                   matlab.ui.control.NumericEditField
        alphaLower_JA                   matlab.ui.control.NumericEditField
        aUpper_JA                       matlab.ui.control.NumericEditField
        aLower_JA                       matlab.ui.control.NumericEditField
        Mtip                            matlab.ui.control.NumericEditField
        MsUpper_JA                      matlab.ui.control.NumericEditField
        MsLower_JA                      matlab.ui.control.NumericEditField
        MtipLabel                       matlab.ui.control.Label
        Htip                            matlab.ui.control.NumericEditField
        ResidualplotButtondMdH_2        matlab.ui.control.Button
        ShowgridCheckBoxM_2             matlab.ui.control.CheckBox
        HtipLabel                       matlab.ui.control.Label
        ErrorDisplay_2                  matlab.ui.control.NumericEditField
        TippointdataLabel               matlab.ui.control.Label
        RetrieveseedsButton             matlab.ui.control.Button
        ErrortominimizeDropDown_2       matlab.ui.control.DropDown
        ErrortominimizeDropDownLabel_2  matlab.ui.control.Label
        k_JA                            matlab.ui.control.NumericEditField
        CalculatePlotButton_2           matlab.ui.control.Button
        FitButton_2                     matlab.ui.control.Button
        c_JA                            matlab.ui.control.NumericEditField
        k_JALabel                       matlab.ui.control.Label
        alpha_JA                        matlab.ui.control.NumericEditField
        c_JALabel                       matlab.ui.control.Label
        a_JA                            matlab.ui.control.NumericEditField
        alpha_JALabel                   matlab.ui.control.Label
        Ms_JA                           matlab.ui.control.NumericEditField
        a_JALabel                       matlab.ui.control.Label
        Ms_JALabel                      matlab.ui.control.Label
        ModelparametersLabel            matlab.ui.control.Label
        JilesAthertonrateindependentmodelLabel_2  matlab.ui.control.Label
        AxesM_2                         matlab.ui.control.UIAxes
        PlaygroundTab                   matlab.ui.container.Tab
        GridLayout3                     matlab.ui.container.GridLayout
        VerticalaxisfieldDropDown_2     matlab.ui.control.DropDown
        VerticalaxisfieldDropDown_2Label  matlab.ui.control.Label
        HorizontalaxisfieldDropDown_2   matlab.ui.control.DropDown
        HorizontalaxisfieldDropDown_2Label  matlab.ui.control.Label
        CalculatePlotButton_3           matlab.ui.control.Button
        ShowgridCheckBoxM_5             matlab.ui.control.CheckBox
        HcaseDropDown                   matlab.ui.control.DropDown
        ShowgridCheckBoxM_4             matlab.ui.control.CheckBox
        DrivingfieldLabel_2             matlab.ui.control.Label
        RetrieveparametersButton        matlab.ui.control.Button
        k_JA_Playground                 matlab.ui.control.NumericEditField
        k_JA_PlaygroundLabel            matlab.ui.control.Label
        c_JA_Playground                 matlab.ui.control.NumericEditField
        c_JA_PlaygroundLabel            matlab.ui.control.Label
        alpha_JA_Playground             matlab.ui.control.NumericEditField
        alpha_JA_PlaygroundLabel        matlab.ui.control.Label
        a_JA_Playground                 matlab.ui.control.NumericEditField
        a_JA_PlaygroundLabel            matlab.ui.control.Label
        Ms_JA_Playground                matlab.ui.control.NumericEditField
        Ms_JA_PlaygroundLabel           matlab.ui.control.Label
        ModelparametersLabel_2          matlab.ui.control.Label
        JilesAthertonrateindependentmodelLabel  matlab.ui.control.Label
        MajorloopwithharmonicsPanel     matlab.ui.container.Panel
        GridLayout7                     matlab.ui.container.GridLayout
        DistortedmajorloopwithharmoniccomponentsLabel  matlab.ui.control.Label
        Htsum_kA_ksinkomegatphi_kLabel  matlab.ui.control.Label
        UITable2                        matlab.ui.control.Table
        HstartAmEditField_3             matlab.ui.control.NumericEditField
        HstartAmEditField_3Label        matlab.ui.control.Label
        MstartAmEditField_3             matlab.ui.control.NumericEditField
        MstartAmEditField_3Label        matlab.ui.control.Label
        StartingpointDropDown_5         matlab.ui.control.DropDown
        StartingpointDropDown_5Label    matlab.ui.control.Label
        DegaussingPanel                 matlab.ui.container.Panel
        GridLayout5                     matlab.ui.container.GridLayout
        UITable_3                       matlab.ui.control.Table
        FinalamplitudeAmEditField       matlab.ui.control.NumericEditField
        FinalamplitudeAmEditFieldLabel  matlab.ui.control.Label
        InitialamplitudeAmEditField     matlab.ui.control.NumericEditField
        InitialamplitudeAmEditFieldLabel  matlab.ui.control.Label
        NofstepsEditField               matlab.ui.control.NumericEditField
        NofstepsEditFieldLabel          matlab.ui.control.Label
        HamplitudeDropDown              matlab.ui.control.DropDown
        HamplitudeDropDownLabel         matlab.ui.control.Label
        HstartAmEditField_2             matlab.ui.control.NumericEditField
        HstartAmEditField_2Label        matlab.ui.control.Label
        MstartAmEditField_2             matlab.ui.control.NumericEditField
        MstartAmEditField_2Label        matlab.ui.control.Label
        StartingpointDropDown_3         matlab.ui.control.DropDown
        StartingpointDropDown_3Label    matlab.ui.control.Label
        MinorloopsPanel                 matlab.ui.container.Panel
        GridLayout6                     matlab.ui.container.GridLayout
        MaxrepetitionsEditFieldLabel_2  matlab.ui.control.Label
        MaxrepetitionsEditField_2       matlab.ui.control.NumericEditField
        ReltoleranceEditField_5         matlab.ui.control.NumericEditField
        ReltoleranceEditField_5Label    matlab.ui.control.Label
        StopcriterionDropDown_4         matlab.ui.control.DropDown
        StopcriterionDropDown_4Label    matlab.ui.control.Label
        PlotDropDown_2                  matlab.ui.control.DropDown
        PlotDropDown_2Label             matlab.ui.control.Label
        RepetitionsEditField_2          matlab.ui.control.NumericEditField
        RepetitionsEditFieldLabel_2     matlab.ui.control.Label
        StopcriterionDropDown_2Label_3  matlab.ui.control.Label
        StopcriterionDropDown_2Label_2  matlab.ui.control.Label
        UITable                         matlab.ui.control.Table
        MajorloopPanel                  matlab.ui.container.Panel
        GridLayout4                     matlab.ui.container.GridLayout
        MaxrepetitionsEditField         matlab.ui.control.NumericEditField
        MaxrepetitionsEditFieldLabel    matlab.ui.control.Label
        HamplitudeAmEditField           matlab.ui.control.NumericEditField
        HamplitudeAmEditFieldLabel      matlab.ui.control.Label
        HstartAmEditField               matlab.ui.control.NumericEditField
        HstartAmEditFieldLabel          matlab.ui.control.Label
        MstartAmEditField               matlab.ui.control.NumericEditField
        MstartAmEditFieldLabel          matlab.ui.control.Label
        StartingpointDropDown           matlab.ui.control.DropDown
        StartingpointDropDownLabel      matlab.ui.control.Label
        PlotDropDown                    matlab.ui.control.DropDown
        PlotDropDownLabel               matlab.ui.control.Label
        ReltoleranceEditField_6         matlab.ui.control.NumericEditField
        ReltoleranceEditField_6Label    matlab.ui.control.Label
        RepetitionsEditField            matlab.ui.control.NumericEditField
        RepetitionsEditFieldLabel       matlab.ui.control.Label
        StopcriterionDropDown           matlab.ui.control.DropDown
        StopcriterionDropDownLabel      matlab.ui.control.Label
        AxesM_5                         matlab.ui.control.UIAxes
        ContextMenu                     matlab.ui.container.ContextMenu
        Menu                            matlab.ui.container.Menu
        Menu2                           matlab.ui.container.Menu
    end

    
    properties (Access = public)
        AppRoot string                % root folder of the app
        H_raw
        M_raw
        imported_curve_type string = ""
        data_curvel
        modeled_curve
        Hcr
        mcr
        Hx
        magnetic_parameters
        playground_curve_H
        playground_curve_M
        playground_curve_ready logical = false
        minor_loop_table_user_edited logical = false   % true once the user manually edits the Htip_i table
        degaussing_user_edited logical = false          % true once the user edits any Degaussing amplitude field/table
        harmonics_user_edited logical = false           % true once the user edits any harmonic drive field/table
        hysteretic_ms_lower_bound_user_edited logical = false   % true once the user edits the Ms lower bound; stops auto-filling it from Mtip
        number_components
        lb
        ub
        select_fit
        Colors
        ColorDialogApp
        ProjectPath
        ProjectDirty logical = false   % true when the open project has unsaved changes (see MenuUtils.mark_project_dirty)
        fitted_parameter_values
        component_row_types
        data_curve
        stop_fit_requested logical = false   % set by "Stop fit" buttons to abort a running fit
        physical_fit_active logical = false   % true when the last Anhysteretic fit was a "reduce dof" unchecked physical fit (Ms/alpha/a fit directly); keeps magnetic_parameters from being rebuilt from stale Hcr/mcr/Hx
        last_import_folder string = ""   % remembers the last folder browsed for a dataset this session
        M_is_mass_based logical = false   % true when the vertical-axis unit is sigma [emu/g=Am^2/kg]
        export_dialog struct = struct()   % state of the currently-open unified Export dialog (see ExportDialogUtils)
        export_settings struct = struct()   % persisted Export-dialog settings (folder/prefix/format/checked items)
    end
    
    methods (Access = public)
        %% =====================================================
        %  Safe file & folder helpers (cancel-safe, portable)
        %  =====================================================
        %  Helpers to centralize file dialogs and paths

        function fullpath = safe_getfile(app, filter, startpath, dialog_title)
            fullpath = FileDialogUtils.safe_getfile(app, filter, startpath, dialog_title);
        end

        function fullpath = safe_putfile(app, filter, startpath, dialog_title, default_name)
            fullpath = FileDialogUtils.safe_putfile(app, filter, startpath, dialog_title, default_name);
        end

        function folder = safe_getdir(app, startpath, dialog_title)
            folder = FileDialogUtils.safe_getdir(app, startpath, dialog_title);
        end

        function folder = default_data_folder(app)
            folder = FileDialogUtils.default_data_folder(app);
        end

        function folder = default_import_folder(app)
            folder = FileDialogUtils.default_import_folder(app);
        end

        function ensure_folder(app, folder)
            FileDialogUtils.ensure_folder(app, folder);
        end

        %%
        function adjust_window(app)
        
            scr = get(groot,'ScreenSize');
            pos = app.MagAnalystUIFigure.Position;
        
            max_height = scr(4) * 0.85;
            if pos(4) > max_height
                pos(4) = max_height;
            end
        
            pos(1) = max(40, (scr(3) - pos(3))/2);
            pos(2) = max(40, (scr(4) - pos(4))/2);
        
            app.MagAnalystUIFigure.Position = pos;
            figure(app.MagAnalystUIFigure);  % devolver foco
        end

        function plot(app)
            AnhystereticUtils.plot(app);
        end

        function update_anhysteretic_error_display(app)
            AnhystereticUtils.update_error_display(app);
        end
        
        function calculate_parameters(app)
            AnhystereticUtils.calculate_parameters(app);
        end

        function fit_parameters(app)
            AnhystereticUtils.fit_parameters(app);
        end
        
        function stop = fit_stop_output_fcn(app, x, optimValues, ~)
            FitProgressUtils.append(app, x, optimValues);
            drawnow limitrate;
            stop = app.stop_fit_requested;
        end

        function write_m_lower_bound_messages(app, select_a, fit_lb, fit_select_fit)
            AnhystereticUtils.write_m_lower_bound_messages(app, select_a, fit_lb, fit_select_fit);
        end
        
        function update_components(app)
            AnhystereticUtils.update_components(app);
        end
        
        function init_components(app)
            AnhystereticUtils.init_components(app);
        end

        
        function plot_input(app)
            InputUtils.plot_input(app);
        end

        function plot_playground(app)
            PlaygroundUtils.plot_playground(app);
        end

        function apply_detailed_grid(app, ax, show_grid)
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

        function sync_playground_mode_ui(app)
            PlaygroundUtils.sync_playground_mode_ui(app);
        end

        function apply_axis_scale(~, ax, selection)
            selection = string(selection);
            if FormatUtils.axis_scale_has_x(selection)
                ax.XScale = 'log';
            else
                ax.XScale = 'linear';
            end
            if FormatUtils.axis_scale_has_y(selection)
                ax.YScale = 'log';
            else
                ax.YScale = 'linear';
            end
        end

        function init_parameters_table(app, default_values)
            AnhystereticUtils.init_parameters_table(app, default_values);
        end

        function init_quantities_table(app, default_values)
            AnhystereticUtils.init_quantities_table(app, default_values);
        end

        function ret = format_k_seed_display(app, v)
            ret = HystereticUtils.format_k_seed_display(app, v);
        end

        function refresh_table_value_display(app)
            AnhystereticUtils.refresh_table_value_display(app);
        end

        function sync_fitted_parameter_values_from_components(app)
            AnhystereticUtils.sync_fitted_parameter_values_from_components(app);
        end

        function ret = format_value_for_display(app, row, value)
            ret = AnhystereticUtils.format_value_for_display(app, row, value);
        end

        function ret = format_value_for_edit(app, row)
            ret = AnhystereticUtils.format_value_for_edit(app, row);
        end

        function ret = format_m_display(app, value)
            ret = AnhystereticUtils.format_m_display(app, value);
        end

        function tf = is_m_row(app, row)
            tf = AnhystereticUtils.is_m_row(app, row);
        end

        function plot_M(app)
            AnhystereticUtils.plot_M(app);
        end

        function plot_dMdH(app)
            AnhystereticUtils.plot_dMdH(app);
        end
        
        function plot_HdMdH(app)
            AnhystereticUtils.plot_HdMdH(app);
        end
        
        function write_message(app, message)
            msg = sprintf("[%s] %s", FormatUtils.get_time_string(), message);
            app.MessagesTextArea.Value(end+1) = cellstr(msg);
            scroll(app.MessagesTextArea, 'bottom');
        end

        function import_data(app, path)
            InputUtils.import_data(app, path);
        end
        
        function is_anhysteretic = is_last_import_anhysteretic(app)
            is_anhysteretic = InputUtils.is_last_import_anhysteretic(app);
        end

        function reprocess_dataset(app)
            InputUtils.reprocess_dataset(app);
        end

        function [H_cycle, M_cycle] = build_ja_data_cycle(app)
            [H_cycle, M_cycle] = HystereticUtils.build_ja_data_cycle(app);
        end

        function [H_left, M_left] = get_hysteretic_left_branch_data(app)
            [H_left, M_left] = HystereticUtils.get_hysteretic_left_branch_data(app);
        end

        function [H_model_left, M_model_left, has_model] = get_hysteretic_left_branch_model(app)
            [H_model_left, M_model_left, has_model] = HystereticUtils.get_hysteretic_left_branch_model(app);
        end

        function [H_model, M_model, has_model] = get_hysteretic_modeled_region(app)
            [H_model, M_model, has_model] = HystereticUtils.get_hysteretic_modeled_region(app);
        end

        function repetitions = get_hysteretic_repetition_value(app)
            repetitions = HystereticUtils.get_hysteretic_repetition_value(app);
        end

        function max_repetitions = get_hysteretic_max_repetitions_value(app)
            max_repetitions = HystereticUtils.get_hysteretic_max_repetitions_value(app);
        end

        function sync_hysteretic_fitting_ui(app)
            HystereticUtils.sync_hysteretic_fitting_ui(app);
        end

        function sync_hysteretic_stop_criterion_ui(app)
            HystereticUtils.sync_hysteretic_stop_criterion_ui(app);
        end

        function plot_hysteretic_residuals(app)
            HystereticUtils.plot_hysteretic_residuals(app);
        end

        function update_hysteretic_error_display(app)
            HystereticUtils.update_hysteretic_error_display(app);
        end

        function [H_left, M_left, H_right, M_right, has_branches] = split_hysteretic_model_branches(app, H_model, M_model)
            [H_left, M_left, H_right, M_right, has_branches] = HystereticUtils.split_hysteretic_model_branches(app, H_model, M_model);
        end

        function plot_hysteretic_branch_residuals(app, H_left, M_left, H_right, M_right, H_model_left, M_model_left, H_model_right, M_model_right, residue_left, residue_right)
            HystereticUtils.plot_hysteretic_branch_residuals(app, H_left, M_left, H_right, M_right, H_model_left, M_model_left, H_model_right, M_model_right, residue_left, residue_right);
        end

        function plot_hysteretic_tab_data(app)
            HystereticUtils.plot_hysteretic_tab_data(app);
        end
       
        function [params, ok] = get_ja_params_from_tab(app)
            [params, ok] = HystereticUtils.get_ja_params_from_tab(app);
        end
        
        function [params, ok] = get_playground_hysteretic_params(app)
            [params, ok] = HystereticUtils.get_playground_hysteretic_params(app);
        end

        function [Htip, Mtip, ok] = get_ja_tip_from_tab_or_data(app)
            [Htip, Mtip, ok] = HystereticUtils.get_ja_tip_from_tab_or_data(app);
        end

        function maybe_refresh_ms_lower_bound_default(app)
            HystereticUtils.maybe_refresh_ms_lower_bound_default(app);
        end

        function [ms_seed, a_seed, alpha_seed, has_seeds] = get_first_anhysteretic_seeds(app)
            [ms_seed, a_seed, alpha_seed, has_seeds] = AnhystereticUtils.get_first_anhysteretic_seeds(app);
        end

        function retrieve_ja_seeds(app)
            HystereticUtils.retrieve_ja_seeds(app);
        end

        function [J, ok] = compute_ja_left_branch_error_core(app, error_type, Hleft, Mleft, Hhat, Mhat)
            [J, ok] = HystereticUtils.compute_ja_left_branch_error_core(app, error_type, Hleft, Mleft, Hhat, Mhat);
        end

        function [v, ok] = read_numeric_field(app, field_handle)
            [v, ok] = HystereticUtils.read_numeric_field(app, field_handle);
        end

        function sync_k_fit_mode_ui(app)
            HystereticUtils.sync_k_fit_mode_ui(app);
        end

        function fit_ja_parameters(app)
            HystereticUtils.fit_ja_parameters(app);
        end

        function k_est = estimate_k_from_coercive_point(app, Hleft, Mleft, Ms, a, alpha, c)
            k_est = HystereticUtils.estimate_k_from_coercive_point(app, Hleft, Mleft, Ms, a, alpha, c);
        end

        function ret = subscript_to_number(app, str)
            ret = AnhystereticUtils.subscript_to_number(app, str);
        end

        function save(app)
            MenuUtils.save(app);
        end

        function calculate_plot_and_refresh_hysteretic(app)
            if ~isobject(app.data_curve) || ~isprop(app.data_curve, 'H') || isempty(app.data_curve.H)
                app.write_message("No dataset imported yet. Please import a dataset on the Input data tab first.");
                return;
            end
            update_components(app)
            calculate_parameters(app)
            plot(app)
            % Ensure hysteretic tip fields are populated from data so error can be computed
            try
                [Htip, Mtip, ok_tip] = app.get_ja_tip_from_tab_or_data();
                if ok_tip
                    app.Htip.Value = Htip;
                    app.Mtip.Value = Mtip;
                end
            catch
                % ignore any failure here
            end

            % Update hysteretic error display immediately after plotting
            try
                app.update_hysteretic_error_display();
            catch
                % ignore
            end
        end

        function calculate_plot_and_refresh_hysteretic_live(app)
            AnhystereticUtils.calculate_plot_and_refresh_hysteretic_live(app);
        end
    end
    
    methods (Access = public)
        
        function [H_unit, M_unit] = get_playground_axis_units(app)
            [H_unit, M_unit] = PlaygroundUtils.get_playground_axis_units(app);
        end

        function values = get_minor_loop_default_values(app)
            values = PlaygroundUtils.get_minor_loop_default_values(app);
        end

        function configure_minor_loop_table(app)
            PlaygroundUtils.configure_minor_loop_table(app);
            if isprop(app, 'UITable') && ~isempty(app.UITable) && isvalid(app.UITable)
                app.UITable.CellEditCallback = createCallbackFcn(app, @UITableCellEdit, true);
            end
        end

        function maybe_refresh_minor_loop_defaults(app)
            PlaygroundUtils.maybe_refresh_minor_loop_defaults(app);
        end

        function expand_minor_loop_table_if_needed(app, event)
            PlaygroundUtils.expand_minor_loop_table_if_needed(app, event);
        end

        function refresh_playground_data_curve(app)
            PlaygroundUtils.refresh_playground_data_curve(app);
        end

        function [H_plot, M_plot, has_data] = get_playground_data_curve(app)
            [H_plot, M_plot, has_data] = PlaygroundUtils.get_playground_data_curve(app);
        end

        function [H_out, M_out] = convert_playground_curve_units(app, H_in, M_in, H_source_unit, M_source_unit, H_target_unit, M_target_unit)
            [H_out, M_out] = PlaygroundUtils.convert_playground_curve_units(app, H_in, M_in, H_source_unit, M_source_unit, H_target_unit, M_target_unit);
        end

        function [Htips, ok] = get_minor_loop_inputs(app)
            [Htips, ok] = PlaygroundUtils.get_minor_loop_inputs(app);
        end

        function run_playground_minor_loop(app)
            PlaygroundUtils.run_playground_minor_loop(app);
        end

        function run_playground_major_loop(app)
            PlaygroundUtils.run_playground_major_loop(app);
        end

        function run_playground_live(app)
            PlaygroundUtils.run_playground_live(app);
        end

        % =====================================================
        %  Degaussing (Playground)
        % =====================================================

        function [Mr, ok] = get_data_remanence(app)
            [Mr, ok] = PlaygroundUtils.get_data_remanence(app);
        end

        function [amps, ok] = get_degaussing_amplitudes_auto(app)
            [amps, ok] = PlaygroundUtils.get_degaussing_amplitudes_auto(app);
        end

        function [amps, ok] = get_degaussing_table_inputs(app)
            [amps, ok] = PlaygroundUtils.get_degaussing_table_inputs(app);
        end

        function values = get_degaussing_default_table_values(app)
            values = PlaygroundUtils.get_degaussing_default_table_values(app);
        end

        function configure_degaussing_table(app)
            PlaygroundUtils.configure_degaussing_table(app);
            if isprop(app, 'UITable_3') && ~isempty(app.UITable_3) && isvalid(app.UITable_3)
                app.UITable_3.CellEditCallback = createCallbackFcn(app, @DegaussingTableCellEdit, true);
            end
        end

        function maybe_refresh_degaussing_defaults(app)
            PlaygroundUtils.maybe_refresh_degaussing_defaults(app);
        end

        function sync_degaussing_ui(app)
            PlaygroundUtils.sync_degaussing_ui(app);
        end

        function set_degaussing_start_enable(app, state)
            PlaygroundUtils.set_degaussing_start_enable(app, state);
        end

        function set_degaussing_auto_enable(app, state)
            PlaygroundUtils.set_degaussing_auto_enable(app, state);
        end

        function set_degaussing_table_enable(app, state)
            PlaygroundUtils.set_degaussing_table_enable(app, state);
        end

        function set_enable_safe(app, component, state)
            PlaygroundUtils.set_enable_safe(app, component, state);
        end

        function [Hstart, Mstart, amplitudes, ok, message] = get_degaussing_inputs(app)
            [Hstart, Mstart, amplitudes, ok, message] = PlaygroundUtils.get_degaussing_inputs(app);
        end

        function run_playground_degaussing(app)
            PlaygroundUtils.run_playground_degaussing(app);
        end

        function expand_degaussing_table_if_needed(app, event)
            PlaygroundUtils.expand_degaussing_table_if_needed(app, event);
        end
        
        % =====================================================
        %  Major loop with harmonics (Playground)
        % =====================================================

        function [orders, amplitudes, phases, ok] = get_harmonics_table_inputs(app)
            [orders, amplitudes, phases, ok] = PlaygroundUtils.get_harmonics_table_inputs(app);
        end

        function [Hstart, Mstart, orders, amplitudes, phases, ok, message] = get_harmonics_inputs(app)
            [Hstart, Mstart, orders, amplitudes, phases, ok, message] = PlaygroundUtils.get_harmonics_inputs(app);
        end

        function values = get_harmonics_default_table_values(app)
            values = PlaygroundUtils.get_harmonics_default_table_values(app);
        end

        function configure_harmonics_table(app)
            PlaygroundUtils.configure_harmonics_table(app);
            if isprop(app, 'UITable2') && ~isempty(app.UITable2) && isvalid(app.UITable2)
                app.UITable2.CellEditCallback = createCallbackFcn(app, @HarmonicsTableCellEdit, true);
            end
        end

        function maybe_refresh_harmonics_defaults(app)
            PlaygroundUtils.maybe_refresh_harmonics_defaults(app);
        end

        function sync_harmonics_ui(app)
            PlaygroundUtils.sync_harmonics_ui(app);
        end

        function set_harmonics_start_enable(app, state)
            PlaygroundUtils.set_harmonics_start_enable(app, state);
        end

        function expand_harmonics_table_if_needed(app, event)
            PlaygroundUtils.expand_harmonics_table_if_needed(app, event);
        end

        function run_playground_major_harmonics(app)
            PlaygroundUtils.run_playground_major_harmonics(app);
        end

        function set_colors_and_plot(app, colors)
            AnhystereticUtils.set_colors_and_plot(app, colors);
        end

        function apply_component_color_styles(app)
            AnhystereticUtils.apply_component_color_styles(app);
        end

        function a = calculate_and_plot(app)
            a = AnhystereticUtils.calculate_and_plot(app);
        end
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            % Startup function

            % Determine application root
            app.AppRoot = string(fileparts(mfilename('fullpath')));
        
            % Add src folder (portable)
            src_folder = fullfile(app.AppRoot, "src");
            if isfolder(src_folder)
                addpath(genpath(char(src_folder)));
            end
          
            app.ProjectPath = "";
            MenuUtils.setup_dirty_tracking(app);   % window-title dirty tracking
            MenuUtils.update_window_title(app);    % window-title dirty tracking
            app.number_components = app.NofcompSpinner.Value;
        
            app.init_components();
            app.configure_minor_loop_table();
            app.configure_degaussing_table();
            app.configure_harmonics_table();
            app.TableFittedParameters.ColumnFormat = {[] 'char' 'short' 'short' 'logical'};

            app.init_parameters_table(true);
            for i = 1:5
                addStyle(app.TableParameters, ...
                    uistyle('HorizontalAlignment','right'), "column", i);
            end
        
            app.init_quantities_table(true);
            for i = 1:5
                addStyle(app.TableQuantities, ...
                    uistyle('HorizontalAlignment','right'), "column", i);
            end
        
            update_components(app);
            app.sync_k_fit_mode_ui();
            app.sync_hysteretic_fitting_ui();
            app.apply_detailed_grid(app.AxesM, app.ShowgridCheckBoxM.Value == 1);   % grid checkbox defaults to checked but was never applied until Calculate&Plot
            app.apply_detailed_grid(app.AxesdMdH, app.ShowgridCheckBoxdMdH.Value == 1);   % grid checkbox defaults to checked but was never applied until Calculate&Plot
            app.apply_detailed_grid(app.AxesHdMdH, app.ShowgridCheckBoxHdMdH.Value == 1);   % grid checkbox defaults to checked but was never applied until Calculate&Plot
            app.apply_detailed_grid(app.AxesM_2, app.ShowgridCheckBoxM_2.Value == 1);   % grid checkbox defaults to checked but was never applied until Calculate&Plot
            PlaygroundUtils.clear_simulation(app);
            PlaygroundUtils.sync_major_ui(app);
            PlaygroundUtils.sync_minor_ui(app);   % gray minor-loop stop-criterion fields+labels
            app.sync_playground_mode_ui();
            app.sync_degaussing_ui();
            app.apply_detailed_grid(app.AxesM_5, app.ShowgridCheckBoxM_5.Value == 1);   % grid checkbox defaults to checked but was never applied until Calculate&Plot
            app.sync_harmonics_ui();

            % note the convergence-mode repetition cap in the Rel. tolerance labels
            % (the solver still stops after Max. repetitions loops even in "Until convergence" mode).
            conv_tip = 'In "Until convergence" mode the loop still stops once Max. repetitions is reached.';
            app.ReltoleranceEditField_6.Tooltip = conv_tip;
            app.ReltoleranceEditField_6Label.Tooltip = conv_tip;
            app.ReltoleranceEditField_5.Tooltip = [conv_tip ' Applied per tip.'];
            app.ReltoleranceEditField_5Label.Tooltip = [conv_tip ' Applied per tip.'];
        
            % Default colors
            app.Colors = [
                0.58 0    0.70
                0.70 0    0
                0    0    0.70
                0    0.70 0
                1    0.50 0
            ];

            app.apply_component_color_styles();   % shade fitting/model/quantities table rows to match component colors
            ThemeUtils.apply_theme(app);   % runtime visual theme (see src/Theme/ThemeUtils.m)
        
            app.write_message("MagAnalyst " + AppVersion());
        
            drawnow;
            
            t = timer( ...
                'StartDelay', 0.05, ...
                'ExecutionMode', 'singleShot', ...
                'TimerFcn', @(~,~) adjust_window(app) );
            start(t);

        end

        % Button pushed function: FitButton
        function FitButtonPushed(app, event)
            update_components(app)
            fit_parameters(app)
            calculate_parameters(app)
            plot(app)
        end

        % Button pushed function: CalculatePlotButton
        function CalculatePlotButtonPushed(app, event)
            app.calculate_plot_and_refresh_hysteretic();
        end

        % Value changed function: NofcompSpinner
        function NofcompSpinnerValueChanged(app, event)
            app.number_components = app.NofcompSpinner.Value;
            app.init_components();
            app.configure_minor_loop_table();
            app.calculate_plot_and_refresh_hysteretic_live();
        end

        % Button pushed function: InputBrowseButton
        function InputBrowseButtonPushed(app, event)
            if strlength(app.last_import_folder) > 0 && isfolder(app.last_import_folder)
                start_folder = app.last_import_folder;
            else
                start_folder = app.default_import_folder();
            end
            fullpath = app.safe_getfile('*.csv', start_folder, ...
                "Select dataset file");

            if fullpath == ""
                return;
            end

            app.last_import_folder = string(fileparts(fullpath));

            try
                app.import_data(fullpath);
                app.InputDatasetPath.Value = char(fullpath);
                app.init_components();
                update_components(app)
                calculate_parameters(app)
                app.plot_input();
                app.write_message("Imported " + fullpath);
                MenuUtils.mark_project_dirty(app);   % window-title dirty tracking
            catch e
                app.write_message("Import failed: " + e.message);
            end
        end

        % Value changed function: InputDatasetPath
        function InputDatasetPathValueChanged(app, event)
            dataset_path = app.InputDatasetPath.Value;
            try
                app.import_data(dataset_path);
                app.init_components();
                update_components(app)
                calculate_parameters(app)
                app.plot_input();
                app.write_message("Imported " + dataset_path);
                MenuUtils.mark_project_dirty(app);   % window-title dirty tracking
            catch e
                app.write_message("Import failed: " + e.message);
            end
        end

        % Button pushed function: ResidualplotButtonM
        function ResidualplotButtonMPushed(app, event)
            AnhystereticUtils.residual_plot_M(app);
        end

        % Button pushed function: ResidualplotButtondMdH
        function ResidualplotButtondMdHPushed(app, event)
            AnhystereticUtils.residual_plot_dMdH(app);
        end

        % Button pushed function: ResidualplotButtondHdMdH
        function ResidualplotButtondHdMdHPushed(app, event)
            AnhystereticUtils.residual_plot_HdMdH(app);
        end

        % Value changed function: PlotcomponentsCheckBoxM
        function PlotcomponentsCheckBoxMValueChanged(app, event)
            app.plot_M()
        end

        % Value changed function: PlotcomponentsCheckBoxdMdH
        function PlotcomponentsCheckBoxdMdHValueChanged(app, event)
            app.plot_dMdH()
        end

        % Value changed function: PlotcomponentsCheckBoxHdMdH
        function PlotcomponentsCheckBoxHdMdHValueChanged(app, event)
            app.plot_HdMdH()
        end

        % Value changed function: ShowgridCheckBoxM
        function ShowgridCheckBoxMValueChanged(app, event)
            app.apply_detailed_grid(app.AxesM, app.ShowgridCheckBoxM.Value == 1);
        end

        % Value changed function: ShowgridCheckBoxdMdH
        function ShowgridCheckBoxdMdHValueChanged(app, event)
            app.apply_detailed_grid(app.AxesdMdH, app.ShowgridCheckBoxdMdH.Value == 1);
        end

        % Value changed function: ShowgridCheckBoxHdMdH
        function ShowgridCheckBoxHdMdHValueChanged(app, event)
            app.apply_detailed_grid(app.AxesHdMdH, app.ShowgridCheckBoxHdMdH.Value == 1);
        end

        % Button pushed function: SetcolorsButton
        function SetcolorsButtonPushed(app, event)
            app.SetcolorsButton.Enable = false;
            app.ColorDialogApp = ColorDialog(app, app.Colors, app.number_components);
        end

        % Close request function: MagAnalystUIFigure
        function MagAnalystUIFigureCloseRequest(app, event)
            FitProgressUtils.close(app);
            delete(app.ColorDialogApp)
            delete(app)
        end

        % Menu selected function: SaveasMenu
        function SaveasMenuSelected(app, event)
            MenuUtils.save_project(app);
        end

        % Menu selected function: OpenMenu
        function OpenMenuSelected(app, event)
            MenuUtils.open_project(app);
        end

        % Menu selected function: SaveMenu
        function SaveMenuSelected(app, event)
            MenuUtils.save_or_prompt(app);
        end

        % Value changed function: HorizontalaxisfieldDropDown
        function HorizontalaxisfieldDropDownValueChanged(app, event)
            app.calculate_and_plot();
        end

        % Value changed function: VerticalaxisfieldDropDown
        function VerticalaxisfieldDropDownValueChanged(app, event)
            app.calculate_and_plot();
        end

        % Value changed function: InputAxisScaleDropDown
        function DropDownValueChanged(app, event)
            value = app.InputAxisScaleDropDown.Value;
            app.plot_input();
            app.apply_axis_scale(app.AxesProcessedInputData, value);
            app.apply_axis_scale(app.AxesRawInputData, value);
        end

        % Value changed function: AxisScaleDropDownM
        function AxisScaleDropDownMValueChanged(app, event)
            app.AxisScaleDropDownM.Value;
            axis_scale = string(app.AxisScaleDropDownM.Value);
            app.apply_axis_scale(app.AxesM, axis_scale);
        end

        % Value changed function: AxisScaleDropDowndMdH
        function AxisScaleDropDowndMdHValueChanged(app, event)
            app.AxisScaleDropDowndMdH.Value;
            axis_scale = string(app.AxisScaleDropDowndMdH.Value);
            app.apply_axis_scale(app.AxesdMdH, axis_scale);
        end

        % Value changed function: AxisScaleDropDownHdMdH
        function AxisScaleDropDownHdMdHValueChanged(app, event)
            app.AxisScaleDropDownHdMdH.Value;
            app.plot_HdMdH();
            axis_scale = string(app.AxisScaleDropDownHdMdH.Value);
            app.apply_axis_scale(app.AxesHdMdH, axis_scale);
        end

        % Value changed function: CurvetypeDropDown
        function CurvetypeDropDownValueChanged(app, event)
            app.reprocess_dataset();
        end

        % Value changed function: InputNumberofPointsEditField
        function InputApplyPointsButtonPushed(app, event)
            app.reprocess_dataset();
        end

        % Cell edit callback: TableFittedParameters
        function TableFittedParametersCellEdit(app, event)
            if isempty(event.Indices)
                return
            end
            row = event.Indices(1,1);
            col = event.Indices(1,2);
            if row > size(app.TableFittedParameters.Data, 1)
                return
            end
            new_text = strrep(string(event.NewData), ',', '');
            new_value = str2double(new_text);
            if col == 2
                if row > numel(app.fitted_parameter_values)
                    return
                end
                if isnan(new_value) || ~isfinite(new_value)
                    app.write_message("Invalid fitted parameter value");
                else
                    app.fitted_parameter_values(row) = new_value;
                    update_components(app);
                    app.calculate_plot_and_refresh_hysteretic_live();
                end
            elseif col == 3
                if row > numel(app.lb)
                    return
                end
                if isnan(new_value) || ~isfinite(new_value)
                    app.write_message("Invalid lower bound value");
                else
                    app.lb(row) = new_value;
                end
            elseif col == 4
                if row > numel(app.ub)
                    return
                end
                if isnan(new_value) || ~isfinite(new_value)
                    app.write_message("Invalid upper bound value");
                else
                    app.ub(row) = new_value;
                end
            else
                return
            end
            app.refresh_table_value_display();
        end

        % Cell selection callback: TableFittedParameters
        function TableFittedParametersCellSelection(app, event)
            if isempty(event.Indices)
                return
            end
            row = event.Indices(1,1);
            col = event.Indices(1,2);
            if row > size(app.TableFittedParameters.Data, 1)
                return
            end
            app.refresh_table_value_display();
            if col == 2
                app.TableFittedParameters.Data(row, 2) = {app.format_value_for_edit(row)};
            elseif col == 3 && row <= numel(app.lb)
                app.TableFittedParameters.Data(row, 3) = {char(sprintf('%.16g', app.lb(row)))};
            elseif col == 4 && row <= numel(app.ub)
                app.TableFittedParameters.Data(row, 4) = {char(sprintf('%.16g', app.ub(row)))};
            end
        end

        % Value changed function: ShowhcrCheckBoxM
        function ShowhcrCheckBoxMValueChanged(app, event)
            app.plot_M()
        end

        % Value changed function: ShowhcrCheckBoxdMdH
        function ShowhcrCheckBoxdMdHValueChanged(app, event)
            app.plot_dMdH()
        end

        % Value changed function: ShowhcrCheckBoxHdMdH
        function ShowhcrCheckBoxHdMdHValueChanged(app, event)
            app.plot_HdMdH()
        end

        % Button pushed function: CalculatePlotButton_2
        function CalculatePlotButton_2Pushed(app, event)
            app.plot_hysteretic_tab_data();
            app.update_hysteretic_error_display();
        end

        % Value changed function: ShowgridCheckBoxM_2
        function ShowgridCheckBoxM_2ValueChanged(app, event)
            app.apply_detailed_grid(app.AxesM_2, app.ShowgridCheckBoxM_2.Value == 1);
        end

        % Button pushed function: RetrieveseedsButton
        function RetrieveseedsButtonPushed(app, event)
            app.retrieve_ja_seeds();
            
        end

        % Button pushed function: FitButton_2
        function FitButton_2Pushed(app, event)
            app.write_message("Fitting started");
            drawnow;
            app.fit_ja_parameters();
        end

        % Value changed function: kConstrainedCheckBox_2
        function kConstrainedCheckBox_2ValueChanged(app, event)
            app.sync_k_fit_mode_ui();
        end

        % Button pushed function: ResidualplotButtondMdH_2
        function ResidualplotButtondMdH_2Pushed(app, event)
            app.plot_hysteretic_residuals();
        end

        % Button pushed function: RetrieveparametersButton
        function RetrieveparametersButtonPushed(app, event)
            [~, has_hysteretic_params] = app.get_playground_hysteretic_params();
            if has_hysteretic_params
                app.Ms_JA_Playground.Value = app.Ms_JA.Value;
                app.a_JA_Playground.Value = app.a_JA.Value;
                app.alpha_JA_Playground.Value = app.alpha_JA.Value;
                app.c_JA_Playground.Value = app.c_JA.Value;
                app.k_JA_Playground.Value = app.k_JA.Value;
                app.write_message("Jiles-Atherton parameters retrieved from Hysteretic Fitting tab.");
                MenuUtils.mark_project_dirty(app);   % window-title dirty tracking
                return;
            end

            [ms_seed, a_seed, alpha_seed, has_seeds] = app.get_first_anhysteretic_seeds();
            if has_seeds
                app.Ms_JA_Playground.Value = ms_seed;
                app.a_JA_Playground.Value = a_seed;
                app.alpha_JA_Playground.Value = alpha_seed;
                app.c_JA_Playground.Value = 0;
                app.k_JA_Playground.Value = 0;
                app.write_message("Anhysteretic parameters retrieved from Anhysteretic Fitting tab.");
                MenuUtils.mark_project_dirty(app);   % window-title dirty tracking
                return;
            end

            app.write_message("No parameters available to retrieve.");
        end

        % Value changed function: RepetitionsEditField_3
        function RepetitionsEditField_3ValueChanged(app, event)
            app.plot_hysteretic_tab_data()
            app.update_hysteretic_error_display();
        end

        % Value changed function: RelativetoleranceEditField
        function RelativetoleranceEditFieldValueChanged(app, event)
            app.plot_hysteretic_tab_data()
            app.update_hysteretic_error_display();
        end

        % Value changed function: StartingpointDropDown_4
        function StartingpointDropDown_4ValueChanged(app, event)
            app.plot_hysteretic_tab_data()
            app.update_hysteretic_error_display();
        end

        % Value changed function: FittingregionDropDown
        function FittingregionDropDownValueChanged(app, event)
            app.sync_hysteretic_fitting_ui();
            app.plot_hysteretic_tab_data();
            app.update_hysteretic_error_display();
        end

        % Value changed function: StopcriterionDropDown_5
        function StopcriterionDropDown_5ValueChanged(app, event)
            app.sync_hysteretic_stop_criterion_ui();
            app.plot_hysteretic_tab_data();
            app.update_hysteretic_error_display();
        end

        % Value changed function: MaximumrepetitionsEditField
        function MaximumrepetitionsEditFieldValueChanged(app, event)
            app.plot_hysteretic_tab_data();
            app.update_hysteretic_error_display();
        end

        % Value changed function: ShowgridCheckBoxM_4
        function ShowgridCheckBoxM_4ValueChanged(app, event)
            app.plot_playground();
        end

        % Value changed function: VerticalaxisfieldDropDown_2
        function VerticalaxisfieldDropDown_2ValueChanged(app, event)
            app.refresh_playground_data_curve();
            app.plot_playground();
        end

        % Value changed function: HorizontalaxisfieldDropDown_2
        function HorizontalaxisfieldDropDown_2ValueChanged(app, event)
            app.refresh_playground_data_curve();
            app.plot_playground();
        end

        % Button pushed function: CalculatePlotButton_3
        function CalculatePlotButton_3Pushed(app, event)
            if PlaygroundUtils.is_minor_mode(app)
                app.run_playground_minor_loop();
            elseif PlaygroundUtils.is_degaussing_mode(app)
                app.run_playground_degaussing();
            elseif PlaygroundUtils.is_harmonics_mode(app)
                app.run_playground_major_harmonics();
            else
                app.run_playground_major_loop();
            end
        end

        % Value changed function: ShowgridCheckBoxM_5
        function ShowgridCheckBoxM_5ValueChanged(app, event)
            app.apply_detailed_grid(app.AxesM_5, app.ShowgridCheckBoxM_5.Value == 1);
            app.plot_playground();
        end

        % Value changed function: HamplitudeAmEditField, 
        % ...and 8 other components
        function PlotDropDownValueChanged(app, event)
            PlaygroundUtils.sync_major_ui(app);
            app.run_playground_live();
        end

        % Value changed function: HcaseDropDown
        function HcaseDropDownValueChanged(app, event)
            app.sync_playground_mode_ui();
            if PlaygroundUtils.is_minor_mode(app)
                app.maybe_refresh_minor_loop_defaults();   % fill Htip_i defaults from data tip when switching to Minor Loops
                PlaygroundUtils.sync_minor_ui(app);        % gray minor-loop stop-criterion fields+labels on mode switch
            elseif PlaygroundUtils.is_degaussing_mode(app)
                app.maybe_refresh_degaussing_defaults();
                app.sync_degaussing_ui();
            elseif PlaygroundUtils.is_harmonics_mode(app)
                app.maybe_refresh_harmonics_defaults();
                app.sync_harmonics_ui();
            end
            PlaygroundUtils.sync_major_ui(app);
            app.run_playground_live();
        end

        % Value changed function: FinalamplitudeAmEditField, 
        % ...and 4 other components
        function DegaussingValueChanged(app, event)
            app.degaussing_user_edited = true;   % stop auto-filling defaults once edited
            app.run_playground_live();
        end

        % Value changed function: HamplitudeDropDown, 
        % ...and 1 other component
        function DegaussingModeChanged(app, event)
            app.sync_degaussing_ui();
            app.run_playground_live();
        end

        % Cell edit callback: UITable_3
        function DegaussingTableCellEdit(app, event)
            app.degaussing_user_edited = true;   % stop auto-filling defaults once edited
            app.expand_degaussing_table_if_needed(event);
            app.run_playground_live();
        end

        % Button pushed function: StopfitButton_2
        function StopfitButton_2Pushed(app, event)
            app.stop_fit_requested = true;
            app.write_message("Stop requested: fitting will stop after the current iteration.");
        end

        % Button pushed function: StopfitButton
        function StopFitButtonPushed(app, event)
            app.stop_fit_requested = true;
            app.write_message("Stop requested: fitting will stop after the current iteration.");
        end

        % Value changed function: HstartAmEditField_3, 
        % ...and 2 other components
        function HarmonicsValueChanged(app, event)
            % shared value-changed callback for the harmonic-drive controls
            % (everything except the harmonics table). Re-syncs enable states,
            % invalidates the cached simulation and redraws.
            app.sync_harmonics_ui();
            app.run_playground_live();
        end

        % Cell edit callback: UITable2
        function HarmonicsTableCellEdit(app, event)
            app.harmonics_user_edited = true;   % stop auto-filling defaults once edited
            app.expand_harmonics_table_if_needed(event);
            app.run_playground_live();
        end

        % Value changed function: MaxrepetitionsEditField_2, 
        % ...and 1 other component
        function StopcriterionDropDown_4ValueChanged(app, event)
            % gray the minor-loop Repetitions / Rel. tolerance fields (and
            % labels) to match the chosen stop criterion, then invalidate the
            % cached simulation and redraw.
            PlaygroundUtils.sync_minor_ui(app);
            app.run_playground_live();
        end

        % Value changed function: MsLower_JA
        function MsLower_JAValueChanged(app, event)
            app.hysteretic_ms_lower_bound_user_edited = true;   % stop auto-filling the Ms lower bound from Mtip once edited
        end

        % Cell selection callback: TableParameters
        function TableParametersCellSelection(app, event)
            if isempty(event.Indices)
                return
            end
            row = event.Indices(1,1);
            col = event.Indices(1,2);
            if row > height(app.TableParameters.Data) || isempty(app.magnetic_parameters) || row > numel(app.magnetic_parameters.Ms)
                return
            end
            app.init_parameters_table(false);
            switch col
                case 2
                    app.TableParameters.Data.Ms_col{row} = sprintf('%.16g', app.magnetic_parameters.Ms(row));
                case 3
                    app.TableParameters.Data.alpha_col{row} = sprintf('%.16g', app.magnetic_parameters.alpha(row));
                case 4
                    app.TableParameters.Data.a_col{row} = sprintf('%.16g', app.magnetic_parameters.a(row));
            end
        end

        % Cell selection callback: TableQuantities
        function TableQuantitiesCellSelection(app, event)
            if isempty(event.Indices)
                return
            end
            row = event.Indices(1,1);
            col = event.Indices(1,2);
            if row > height(app.TableQuantities.Data) || isempty(app.magnetic_parameters) || row > numel(app.magnetic_parameters.dimensionless_alphaMs)
                return
            end
            app.init_quantities_table(false);
            switch col
                case 2
                    app.TableQuantities.Data.dimensionless_alphaMs_col{row} = sprintf('%.16g', app.magnetic_parameters.dimensionless_alphaMs(row));
                case 3
                    app.TableQuantities.Data.density_product_col{row} = sprintf('%.16g', app.magnetic_parameters.density_product(row));
                case 4
                    app.TableQuantities.Data.Hk_col{row} = sprintf('%.16g', app.magnetic_parameters.Hk(row));
                case 5
                    app.TableQuantities.Data.chi_in_col{row} = sprintf('%.16g', app.magnetic_parameters.chi_in(row));
            end
        end

        % Value changed function: ErrorDropDown
        function ErrorDropDownValueChanged(app, event)
            app.update_anhysteretic_error_display();
        end

        % Value changed function: ErrortominimizeDropDown_2
        function ErrortominimizeDropDown_2ValueChanged(app, event)
            app.update_hysteretic_error_display();
        end

        % Cell edit callback: TableParameters
        function TableParametersCellEdit(app, event)
            % live-recompute when the "select a" root checkbox is toggled
            app.calculate_plot_and_refresh_hysteretic_live();
        end

        % Value changed function: NofpointsEditField
        function NofpointsEditFieldValueChanged(app, event)
            app.calculate_plot_and_refresh_hysteretic_live();
        end

        % Value changed function: PointSpaceDropDown
        function PointSpaceDropDownValueChanged(app, event)
            app.calculate_plot_and_refresh_hysteretic_live();
        end

        % Value changed function: Ms_JA, a_JA, alpha_JA, c_JA, k_JA
        function JAParamsHystereticValueChanged(app, event)
            app.plot_hysteretic_tab_data();
            app.update_hysteretic_error_display();
        end

        % Value changed function: Ms_JA_Playground, a_JA_Playground, 
        % ...and 3 other components
        function JAParamsPlaygroundValueChanged(app, event)
            app.run_playground_live();
        end

        % Menu selected function: NewMenu
        function NewMenuSelected(app, event)
            MenuUtils.new_project(app);
        end

        % Menu selected function: ExportMenu
        function ExportMenuSelected(app, event)
            ExportDialogUtils.open_dialog(app);
        end

        % Value changed function: ReduceDofCheckBox
        function ReduceDofCheckBoxValueChanged(app, event)
            AnhystereticUtils.on_reduce_dof_changed(app);
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Get the file path for locating images
            pathToMLAPP = fileparts(mfilename('fullpath'));

            % Create MagAnalystUIFigure and hide until all components are created
            app.MagAnalystUIFigure = uifigure('Visible', 'off');
            app.MagAnalystUIFigure.Position = [100 100 1044 768];
            app.MagAnalystUIFigure.Name = 'MagAnalyst';
            app.MagAnalystUIFigure.Icon = fullfile(pathToMLAPP, 'assets', 'logo.png');
            app.MagAnalystUIFigure.CloseRequestFcn = createCallbackFcn(app, @MagAnalystUIFigureCloseRequest, true);

            % Create ProjectMenu
            app.ProjectMenu = uimenu(app.MagAnalystUIFigure);
            app.ProjectMenu.Text = 'Project';

            % Create NewMenu
            app.NewMenu = uimenu(app.ProjectMenu);
            app.NewMenu.MenuSelectedFcn = createCallbackFcn(app, @NewMenuSelected, true);
            app.NewMenu.Text = 'New';

            % Create OpenMenu
            app.OpenMenu = uimenu(app.ProjectMenu);
            app.OpenMenu.MenuSelectedFcn = createCallbackFcn(app, @OpenMenuSelected, true);
            app.OpenMenu.Separator = 'on';
            app.OpenMenu.Accelerator = 'O';
            app.OpenMenu.Text = 'Open...';

            % Create SaveMenu
            app.SaveMenu = uimenu(app.ProjectMenu);
            app.SaveMenu.MenuSelectedFcn = createCallbackFcn(app, @SaveMenuSelected, true);
            app.SaveMenu.Accelerator = 'S';
            app.SaveMenu.Text = 'Save';

            % Create SaveasMenu
            app.SaveasMenu = uimenu(app.ProjectMenu);
            app.SaveasMenu.MenuSelectedFcn = createCallbackFcn(app, @SaveasMenuSelected, true);
            app.SaveasMenu.Separator = 'on';
            app.SaveasMenu.Text = 'Save as...';

            % Create ExportMenu
            app.ExportMenu = uimenu(app.ProjectMenu);
            app.ExportMenu.MenuSelectedFcn = createCallbackFcn(app, @ExportMenuSelected, true);
            app.ExportMenu.Text = 'Export...';

            % Create AppGridLayout
            app.AppGridLayout = uigridlayout(app.MagAnalystUIFigure);
            app.AppGridLayout.ColumnWidth = {'1x'};
            app.AppGridLayout.RowHeight = {'3x', '0.8x'};
            app.AppGridLayout.RowSpacing = 0;
            app.AppGridLayout.Padding = [0 0 0 0];

            % Create TabGroup
            app.TabGroup = uitabgroup(app.AppGridLayout);
            app.TabGroup.AutoResizeChildren = 'off';
            app.TabGroup.Layout.Row = 1;
            app.TabGroup.Layout.Column = 1;

            % Create InputdataTab
            app.InputdataTab = uitab(app.TabGroup);
            app.InputdataTab.AutoResizeChildren = 'off';
            app.InputdataTab.Title = 'Input data';

            % Create GridLayout9
            app.GridLayout9 = uigridlayout(app.InputdataTab);
            app.GridLayout9.ColumnWidth = {40, 65, '1.4x', 56, '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x'};
            app.GridLayout9.RowHeight = {31, 31, 31, 31, 31, '6.77x', '1x', 28};
            app.GridLayout9.ColumnSpacing = 9.91666666666667;
            app.GridLayout9.RowSpacing = 9.9;
            app.GridLayout9.Padding = [9.91666666666667 9.9 9.91666666666667 9.9];

            % Create AxesProcessedInputData
            app.AxesProcessedInputData = uiaxes(app.GridLayout9);
            title(app.AxesProcessedInputData, 'Processed input data')
            app.AxesProcessedInputData.Box = 'on';
            app.AxesProcessedInputData.Layout.Row = [1 6];
            app.AxesProcessedInputData.Layout.Column = [9 12];

            % Create AxesRawInputData
            app.AxesRawInputData = uiaxes(app.GridLayout9);
            title(app.AxesRawInputData, 'Raw input data')
            zlabel(app.AxesRawInputData, 'Z')
            app.AxesRawInputData.Box = 'on';
            app.AxesRawInputData.Layout.Row = [1 6];
            app.AxesRawInputData.Layout.Column = [5 8];

            % Create DescriptionTextArea
            app.DescriptionTextArea = uitextarea(app.GridLayout9);
            app.DescriptionTextArea.Layout.Row = [6 8];
            app.DescriptionTextArea.Layout.Column = [1 4];

            % Create InputDatasetpathLabel
            app.InputDatasetpathLabel = uilabel(app.GridLayout9);
            app.InputDatasetpathLabel.FontWeight = 'bold';
            app.InputDatasetpathLabel.Layout.Row = 1;
            app.InputDatasetpathLabel.Layout.Column = [1 2];
            app.InputDatasetpathLabel.Text = 'Dataset';

            % Create InputBrowseButton
            app.InputBrowseButton = uibutton(app.GridLayout9, 'push');
            app.InputBrowseButton.ButtonPushedFcn = createCallbackFcn(app, @InputBrowseButtonPushed, true);
            app.InputBrowseButton.Tooltip = {'If the dataset was measured in an open magnetic circuit, H, Hk, susceptibilities, and Weiss coefficients here are apparent/effective, not intrinsic.'};
            app.InputBrowseButton.Layout.Row = 1;
            app.InputBrowseButton.Layout.Column = 4;
            app.InputBrowseButton.Text = 'Browse';

            % Create InputDatasetPath
            app.InputDatasetPath = uieditfield(app.GridLayout9, 'text');
            app.InputDatasetPath.ValueChangedFcn = createCallbackFcn(app, @InputDatasetPathValueChanged, true);
            app.InputDatasetPath.Layout.Row = 1;
            app.InputDatasetPath.Layout.Column = [2 3];

            % Create NotesLabel
            app.NotesLabel = uilabel(app.GridLayout9);
            app.NotesLabel.FontWeight = 'bold';
            app.NotesLabel.Layout.Row = 5;
            app.NotesLabel.Layout.Column = 1;
            app.NotesLabel.Text = 'Notes';

            % Create InputAxisScaleDropDown
            app.InputAxisScaleDropDown = uidropdown(app.GridLayout9);
            app.InputAxisScaleDropDown.Items = {'linear', 'semilog-x', 'semilog-y', 'log-log'};
            app.InputAxisScaleDropDown.ValueChangedFcn = createCallbackFcn(app, @DropDownValueChanged, true);
            app.InputAxisScaleDropDown.Tag = 'InputAxisScaleDropDown';
            app.InputAxisScaleDropDown.Layout.Row = 7;
            app.InputAxisScaleDropDown.Layout.Column = [9 10];
            app.InputAxisScaleDropDown.Value = 'linear';

            % Create AxisscaleLabel
            app.AxisscaleLabel = uilabel(app.GridLayout9);
            app.AxisscaleLabel.HorizontalAlignment = 'right';
            app.AxisscaleLabel.FontWeight = 'bold';
            app.AxisscaleLabel.Layout.Row = 7;
            app.AxisscaleLabel.Layout.Column = 8;
            app.AxisscaleLabel.Text = 'Axis scale';

            % Create InputNumberofPointsEditField
            app.InputNumberofPointsEditField = uieditfield(app.GridLayout9, 'numeric');
            app.InputNumberofPointsEditField.Limits = [2 Inf];
            app.InputNumberofPointsEditField.RoundFractionalValues = 'on';
            app.InputNumberofPointsEditField.ValueDisplayFormat = '%.0f';
            app.InputNumberofPointsEditField.ValueChangedFcn = createCallbackFcn(app, @InputApplyPointsButtonPushed, true);
            app.InputNumberofPointsEditField.Tooltip = {'N° of points of processed anhysteretic curve'};
            app.InputNumberofPointsEditField.Layout.Row = 7;
            app.InputNumberofPointsEditField.Layout.Column = 12;
            app.InputNumberofPointsEditField.Value = 50;

            % Create InputNumberofPointsLabel
            app.InputNumberofPointsLabel = uilabel(app.GridLayout9);
            app.InputNumberofPointsLabel.HorizontalAlignment = 'right';
            app.InputNumberofPointsLabel.FontWeight = 'bold';
            app.InputNumberofPointsLabel.Tooltip = {'N° of points of processed anhysteretic curve'};
            app.InputNumberofPointsLabel.Layout.Row = 7;
            app.InputNumberofPointsLabel.Layout.Column = 11;
            app.InputNumberofPointsLabel.Text = 'N° of points';

            % Create optionalLabel
            app.optionalLabel = uilabel(app.GridLayout9);
            app.optionalLabel.FontColor = [0.502 0.502 0.502];
            app.optionalLabel.Layout.Row = 5;
            app.optionalLabel.Layout.Column = 2;
            app.optionalLabel.Text = '(optional)';

            % Create HorizontalaxisfieldDropDownLabel
            app.HorizontalaxisfieldDropDownLabel = uilabel(app.GridLayout9);
            app.HorizontalaxisfieldDropDownLabel.FontWeight = 'bold';
            app.HorizontalaxisfieldDropDownLabel.Layout.Row = 2;
            app.HorizontalaxisfieldDropDownLabel.Layout.Column = [1 2];
            app.HorizontalaxisfieldDropDownLabel.Text = 'Horizontal axis field';

            % Create HorizontalaxisfieldDropDown
            app.HorizontalaxisfieldDropDown = uidropdown(app.GridLayout9);
            app.HorizontalaxisfieldDropDown.Items = {'H [A/m]', 'H [kA/m]', 'H [Oe]', 'H [kOe]', 'Bext [T]', 'Bext [G]', 'Bext [kG]'};
            app.HorizontalaxisfieldDropDown.ValueChangedFcn = createCallbackFcn(app, @HorizontalaxisfieldDropDownValueChanged, true);
            app.HorizontalaxisfieldDropDown.Layout.Row = 2;
            app.HorizontalaxisfieldDropDown.Layout.Column = [3 4];
            app.HorizontalaxisfieldDropDown.Value = 'H [A/m]';

            % Create VerticalaxisfieldDropDownLabel
            app.VerticalaxisfieldDropDownLabel = uilabel(app.GridLayout9);
            app.VerticalaxisfieldDropDownLabel.FontWeight = 'bold';
            app.VerticalaxisfieldDropDownLabel.Layout.Row = 3;
            app.VerticalaxisfieldDropDownLabel.Layout.Column = [1 2];
            app.VerticalaxisfieldDropDownLabel.Text = 'Vertical axis field';

            % Create VerticalaxisfieldDropDown
            app.VerticalaxisfieldDropDown = uidropdown(app.GridLayout9);
            app.VerticalaxisfieldDropDown.Items = {'M [A/m]', 'M [kA/m]', 'M [MA/m]', 'M [emu/cm^3]', 'J [T]', 'B [T]', 'B [G]', 'B [kG]', 'σ [emu/g=Am^2/kg]'};
            app.VerticalaxisfieldDropDown.ValueChangedFcn = createCallbackFcn(app, @VerticalaxisfieldDropDownValueChanged, true);
            app.VerticalaxisfieldDropDown.Layout.Row = 3;
            app.VerticalaxisfieldDropDown.Layout.Column = [3 4];
            app.VerticalaxisfieldDropDown.Value = 'B [T]';

            % Create CurvetypeDropDownLabel
            app.CurvetypeDropDownLabel = uilabel(app.GridLayout9);
            app.CurvetypeDropDownLabel.FontWeight = 'bold';
            app.CurvetypeDropDownLabel.Layout.Row = 4;
            app.CurvetypeDropDownLabel.Layout.Column = [1 2];
            app.CurvetypeDropDownLabel.Text = 'Curve type';

            % Create CurvetypeDropDown
            app.CurvetypeDropDown = uidropdown(app.GridLayout9);
            app.CurvetypeDropDown.Items = {'Anhysteretic curve', 'Hysteresis loop'};
            app.CurvetypeDropDown.ValueChangedFcn = createCallbackFcn(app, @CurvetypeDropDownValueChanged, true);
            app.CurvetypeDropDown.Layout.Row = 4;
            app.CurvetypeDropDown.Layout.Column = [3 4];
            app.CurvetypeDropDown.Value = 'Hysteresis loop';

            % Create HTipField
            app.HTipField = uieditfield(app.GridLayout9, 'numeric');
            app.HTipField.ValueDisplayFormat = '%.6e';
            app.HTipField.AllowEmpty = 'on';
            app.HTipField.Editable = 'off';
            app.HTipField.Layout.Row = 7;
            app.HTipField.Layout.Column = [6 7];
            app.HTipField.Value = [];

            % Create HtipAmLabel
            app.HtipAmLabel = uilabel(app.GridLayout9);
            app.HtipAmLabel.HorizontalAlignment = 'right';
            app.HtipAmLabel.FontWeight = 'bold';
            app.HtipAmLabel.Layout.Row = 7;
            app.HtipAmLabel.Layout.Column = 5;
            app.HtipAmLabel.Text = 'Htip [A/m]';

            % Create MTipField
            app.MTipField = uieditfield(app.GridLayout9, 'numeric');
            app.MTipField.ValueDisplayFormat = '%.6e';
            app.MTipField.AllowEmpty = 'on';
            app.MTipField.Editable = 'off';
            app.MTipField.Layout.Row = 8;
            app.MTipField.Layout.Column = [6 7];
            app.MTipField.Value = [];

            % Create MtipAmLabel
            app.MtipAmLabel = uilabel(app.GridLayout9);
            app.MtipAmLabel.HorizontalAlignment = 'right';
            app.MtipAmLabel.FontWeight = 'bold';
            app.MtipAmLabel.Layout.Row = 8;
            app.MtipAmLabel.Layout.Column = 5;
            app.MtipAmLabel.Text = 'Mtip [A/m]';

            % Create AnhystereticfittingTab
            app.AnhystereticfittingTab = uitab(app.TabGroup);
            app.AnhystereticfittingTab.AutoResizeChildren = 'off';
            app.AnhystereticfittingTab.Title = 'Anhysteretic fitting';

            % Create GridLayout11
            app.GridLayout11 = uigridlayout(app.AnhystereticfittingTab);
            app.GridLayout11.ColumnWidth = {'1.5x', '1x', '1x', '1x', '1x', '2.5x', '0.75x', '1.25x', '1x', '1x', '1x', '1x', '1x', '1x', '0.75x', '1.25x'};
            app.GridLayout11.RowHeight = {'1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x'};
            app.GridLayout11.ColumnSpacing = 4.29411764705882;
            app.GridLayout11.RowSpacing = 4.85714285714286;
            app.GridLayout11.Padding = [4.29411764705882 4.85714285714286 4.29411764705882 4.85714285714286];

            % Create AxesM
            app.AxesM = uiaxes(app.GridLayout11);
            xlabel(app.AxesM, 'H [A/m]')
            ylabel(app.AxesM, 'M [A/m]')
            zlabel(app.AxesM, 'Z')
            app.AxesM.Box = 'on';
            app.AxesM.Layout.Row = [1 5];
            app.AxesM.Layout.Column = [1 6];

            % Create AxesdMdH
            app.AxesdMdH = uiaxes(app.GridLayout11);
            xlabel(app.AxesdMdH, 'H [A/m]')
            ylabel(app.AxesdMdH, '∂M/∂H')
            zlabel(app.AxesdMdH, 'Z')
            app.AxesdMdH.Box = 'on';
            app.AxesdMdH.Layout.Row = [7 11];
            app.AxesdMdH.Layout.Column = [1 6];

            % Create AxesHdMdH
            app.AxesHdMdH = uiaxes(app.GridLayout11);
            xlabel(app.AxesHdMdH, 'H [A/m]')
            ylabel(app.AxesHdMdH, '∂M/∂(lnH) [A/m]')
            zlabel(app.AxesHdMdH, 'Z')
            app.AxesHdMdH.Box = 'on';
            app.AxesHdMdH.Layout.Row = [13 17];
            app.AxesHdMdH.Layout.Column = [1 6];

            % Create ResidualplotButtonM
            app.ResidualplotButtonM = uibutton(app.GridLayout11, 'push');
            app.ResidualplotButtonM.ButtonPushedFcn = createCallbackFcn(app, @ResidualplotButtonMPushed, true);
            app.ResidualplotButtonM.Layout.Row = 6;
            app.ResidualplotButtonM.Layout.Column = 1;
            app.ResidualplotButtonM.Text = 'Residuals';

            % Create PlotcomponentsCheckBoxM
            app.PlotcomponentsCheckBoxM = uicheckbox(app.GridLayout11);
            app.PlotcomponentsCheckBoxM.ValueChangedFcn = createCallbackFcn(app, @PlotcomponentsCheckBoxMValueChanged, true);
            app.PlotcomponentsCheckBoxM.Text = 'Components';
            app.PlotcomponentsCheckBoxM.Layout.Row = 6;
            app.PlotcomponentsCheckBoxM.Layout.Column = [3 4];
            app.PlotcomponentsCheckBoxM.Value = true;

            % Create ShowgridCheckBoxM
            app.ShowgridCheckBoxM = uicheckbox(app.GridLayout11);
            app.ShowgridCheckBoxM.ValueChangedFcn = createCallbackFcn(app, @ShowgridCheckBoxMValueChanged, true);
            app.ShowgridCheckBoxM.Text = 'Grid';
            app.ShowgridCheckBoxM.Layout.Row = 6;
            app.ShowgridCheckBoxM.Layout.Column = 2;
            app.ShowgridCheckBoxM.Value = true;

            % Create AxisScaleDropDownM
            app.AxisScaleDropDownM = uidropdown(app.GridLayout11);
            app.AxisScaleDropDownM.Items = {'linear', 'semilog-x', 'semilog-y', 'log-log'};
            app.AxisScaleDropDownM.ValueChangedFcn = createCallbackFcn(app, @AxisScaleDropDownMValueChanged, true);
            app.AxisScaleDropDownM.Tag = 'InputAxisScaleDropDown';
            app.AxisScaleDropDownM.Layout.Row = 6;
            app.AxisScaleDropDownM.Layout.Column = 6;
            app.AxisScaleDropDownM.Value = 'semilog-x';

            % Create ShowhcrCheckBoxM
            app.ShowhcrCheckBoxM = uicheckbox(app.GridLayout11);
            app.ShowhcrCheckBoxM.ValueChangedFcn = createCallbackFcn(app, @ShowhcrCheckBoxMValueChanged, true);
            app.ShowhcrCheckBoxM.Text = 'Hcr,i';
            app.ShowhcrCheckBoxM.Layout.Row = 6;
            app.ShowhcrCheckBoxM.Layout.Column = 5;
            app.ShowhcrCheckBoxM.Value = true;

            % Create ResidualplotButtondMdH
            app.ResidualplotButtondMdH = uibutton(app.GridLayout11, 'push');
            app.ResidualplotButtondMdH.ButtonPushedFcn = createCallbackFcn(app, @ResidualplotButtondMdHPushed, true);
            app.ResidualplotButtondMdH.Layout.Row = 12;
            app.ResidualplotButtondMdH.Layout.Column = 1;
            app.ResidualplotButtondMdH.Text = 'Residuals';

            % Create PlotcomponentsCheckBoxdMdH
            app.PlotcomponentsCheckBoxdMdH = uicheckbox(app.GridLayout11);
            app.PlotcomponentsCheckBoxdMdH.ValueChangedFcn = createCallbackFcn(app, @PlotcomponentsCheckBoxdMdHValueChanged, true);
            app.PlotcomponentsCheckBoxdMdH.Text = 'Components';
            app.PlotcomponentsCheckBoxdMdH.Layout.Row = 12;
            app.PlotcomponentsCheckBoxdMdH.Layout.Column = [3 4];
            app.PlotcomponentsCheckBoxdMdH.Value = true;

            % Create ShowgridCheckBoxdMdH
            app.ShowgridCheckBoxdMdH = uicheckbox(app.GridLayout11);
            app.ShowgridCheckBoxdMdH.ValueChangedFcn = createCallbackFcn(app, @ShowgridCheckBoxdMdHValueChanged, true);
            app.ShowgridCheckBoxdMdH.Text = 'Grid';
            app.ShowgridCheckBoxdMdH.Layout.Row = 12;
            app.ShowgridCheckBoxdMdH.Layout.Column = 2;
            app.ShowgridCheckBoxdMdH.Value = true;

            % Create AxisScaleDropDowndMdH
            app.AxisScaleDropDowndMdH = uidropdown(app.GridLayout11);
            app.AxisScaleDropDowndMdH.Items = {'linear', 'semilog-x', 'semilog-y', 'log-log'};
            app.AxisScaleDropDowndMdH.ValueChangedFcn = createCallbackFcn(app, @AxisScaleDropDowndMdHValueChanged, true);
            app.AxisScaleDropDowndMdH.Tag = 'InputAxisScaleDropDown';
            app.AxisScaleDropDowndMdH.Layout.Row = 12;
            app.AxisScaleDropDowndMdH.Layout.Column = 6;
            app.AxisScaleDropDowndMdH.Value = 'semilog-x';

            % Create ShowhcrCheckBoxdMdH
            app.ShowhcrCheckBoxdMdH = uicheckbox(app.GridLayout11);
            app.ShowhcrCheckBoxdMdH.ValueChangedFcn = createCallbackFcn(app, @ShowhcrCheckBoxdMdHValueChanged, true);
            app.ShowhcrCheckBoxdMdH.Text = 'Hcr,i';
            app.ShowhcrCheckBoxdMdH.Layout.Row = 12;
            app.ShowhcrCheckBoxdMdH.Layout.Column = 5;
            app.ShowhcrCheckBoxdMdH.Value = true;

            % Create ResidualplotButtondHdMdH
            app.ResidualplotButtondHdMdH = uibutton(app.GridLayout11, 'push');
            app.ResidualplotButtondHdMdH.ButtonPushedFcn = createCallbackFcn(app, @ResidualplotButtondHdMdHPushed, true);
            app.ResidualplotButtondHdMdH.Layout.Row = 18;
            app.ResidualplotButtondHdMdH.Layout.Column = 1;
            app.ResidualplotButtondHdMdH.Text = 'Residuals';

            % Create PlotcomponentsCheckBoxHdMdH
            app.PlotcomponentsCheckBoxHdMdH = uicheckbox(app.GridLayout11);
            app.PlotcomponentsCheckBoxHdMdH.ValueChangedFcn = createCallbackFcn(app, @PlotcomponentsCheckBoxHdMdHValueChanged, true);
            app.PlotcomponentsCheckBoxHdMdH.Text = 'Components';
            app.PlotcomponentsCheckBoxHdMdH.Layout.Row = 18;
            app.PlotcomponentsCheckBoxHdMdH.Layout.Column = [3 4];
            app.PlotcomponentsCheckBoxHdMdH.Value = true;

            % Create ShowgridCheckBoxHdMdH
            app.ShowgridCheckBoxHdMdH = uicheckbox(app.GridLayout11);
            app.ShowgridCheckBoxHdMdH.ValueChangedFcn = createCallbackFcn(app, @ShowgridCheckBoxHdMdHValueChanged, true);
            app.ShowgridCheckBoxHdMdH.Text = 'Grid';
            app.ShowgridCheckBoxHdMdH.Layout.Row = 18;
            app.ShowgridCheckBoxHdMdH.Layout.Column = 2;
            app.ShowgridCheckBoxHdMdH.Value = true;

            % Create AxisScaleDropDownHdMdH
            app.AxisScaleDropDownHdMdH = uidropdown(app.GridLayout11);
            app.AxisScaleDropDownHdMdH.Items = {'linear', 'semilog-x', 'semilog-y', 'log-log'};
            app.AxisScaleDropDownHdMdH.ValueChangedFcn = createCallbackFcn(app, @AxisScaleDropDownHdMdHValueChanged, true);
            app.AxisScaleDropDownHdMdH.Tag = 'InputAxisScaleDropDown';
            app.AxisScaleDropDownHdMdH.Layout.Row = 18;
            app.AxisScaleDropDownHdMdH.Layout.Column = 6;
            app.AxisScaleDropDownHdMdH.Value = 'semilog-x';

            % Create ShowhcrCheckBoxHdMdH
            app.ShowhcrCheckBoxHdMdH = uicheckbox(app.GridLayout11);
            app.ShowhcrCheckBoxHdMdH.ValueChangedFcn = createCallbackFcn(app, @ShowhcrCheckBoxHdMdHValueChanged, true);
            app.ShowhcrCheckBoxHdMdH.Text = 'Hcr,i';
            app.ShowhcrCheckBoxHdMdH.Layout.Row = 18;
            app.ShowhcrCheckBoxHdMdH.Layout.Column = 5;
            app.ShowhcrCheckBoxHdMdH.Value = true;

            % Create FitButton
            app.FitButton = uibutton(app.GridLayout11, 'push');
            app.FitButton.ButtonPushedFcn = createCallbackFcn(app, @FitButtonPushed, true);
            app.FitButton.BackgroundColor = [0.8667 0.3294 0];
            app.FitButton.FontWeight = 'bold';
            app.FitButton.FontColor = [0.9412 0.9412 0.9412];
            app.FitButton.Layout.Row = 18;
            app.FitButton.Layout.Column = 15;
            app.FitButton.Text = 'Fit';

            % Create CalculatePlotButton
            app.CalculatePlotButton = uibutton(app.GridLayout11, 'push');
            app.CalculatePlotButton.ButtonPushedFcn = createCallbackFcn(app, @CalculatePlotButtonPushed, true);
            app.CalculatePlotButton.WordWrap = 'on';
            app.CalculatePlotButton.Layout.Row = 18;
            app.CalculatePlotButton.Layout.Column = [13 14];
            app.CalculatePlotButton.Text = 'Calculate & Plot';

            % Create ErrorDisplay
            app.ErrorDisplay = uieditfield(app.GridLayout11, 'numeric');
            app.ErrorDisplay.ValueDisplayFormat = '%.5e';
            app.ErrorDisplay.AllowEmpty = 'on';
            app.ErrorDisplay.Editable = 'off';
            app.ErrorDisplay.HorizontalAlignment = 'left';
            app.ErrorDisplay.Layout.Row = 18;
            app.ErrorDisplay.Layout.Column = [11 12];
            app.ErrorDisplay.Value = [];

            % Create StopfitButton
            app.StopfitButton = uibutton(app.GridLayout11, 'push');
            app.StopfitButton.ButtonPushedFcn = createCallbackFcn(app, @StopFitButtonPushed, true);
            app.StopfitButton.Layout.Row = 18;
            app.StopfitButton.Layout.Column = 16;
            app.StopfitButton.Text = 'Stop fit';

            % Create CalculatedquantitiesLabel
            app.CalculatedquantitiesLabel = uilabel(app.GridLayout11);
            app.CalculatedquantitiesLabel.FontWeight = 'bold';
            app.CalculatedquantitiesLabel.Layout.Row = 13;
            app.CalculatedquantitiesLabel.Layout.Column = [7 9];
            app.CalculatedquantitiesLabel.Text = 'Calculated quantities';

            % Create chiinField
            app.chiinField = uieditfield(app.GridLayout11, 'numeric');
            app.chiinField.ValueDisplayFormat = '%.6g';
            app.chiinField.AllowEmpty = 'on';
            app.chiinField.Editable = 'off';
            app.chiinField.Layout.Row = 13;
            app.chiinField.Layout.Column = [12 13];
            app.chiinField.Value = [];

            % Create chiinLabel
            app.chiinLabel = uilabel(app.GridLayout11);
            app.chiinLabel.HorizontalAlignment = 'right';
            app.chiinLabel.FontWeight = 'bold';
            app.chiinLabel.Layout.Row = 13;
            app.chiinLabel.Layout.Column = 11;
            app.chiinLabel.Text = 'χᵢₙ';

            % Create PointSpaceDropDown
            app.PointSpaceDropDown = uidropdown(app.GridLayout11);
            app.PointSpaceDropDown.Items = {'Logarithmically spaced', 'Lineraly spaced'};
            app.PointSpaceDropDown.ItemsData = {'log', 'linear'};
            app.PointSpaceDropDown.ValueChangedFcn = createCallbackFcn(app, @PointSpaceDropDownValueChanged, true);
            app.PointSpaceDropDown.Layout.Row = 2;
            app.PointSpaceDropDown.Layout.Column = [13 15];
            app.PointSpaceDropDown.Value = 'log';

            % Create SetcolorsButton
            app.SetcolorsButton = uibutton(app.GridLayout11, 'push');
            app.SetcolorsButton.ButtonPushedFcn = createCallbackFcn(app, @SetcolorsButtonPushed, true);
            app.SetcolorsButton.Layout.Row = 2;
            app.SetcolorsButton.Layout.Column = 16;
            app.SetcolorsButton.Text = 'Set colors';

            % Create TableFittedParameters
            app.TableFittedParameters = uitable(app.GridLayout11);
            app.TableFittedParameters.ColumnName = {'Parameter'; 'Value'; 'Lower bound'; 'Upper bound'; 'Fit'};
            app.TableFittedParameters.RowName = {};
            app.TableFittedParameters.ColumnEditable = [false true true true true];
            app.TableFittedParameters.CellEditCallback = createCallbackFcn(app, @TableFittedParametersCellEdit, true);
            app.TableFittedParameters.CellSelectionCallback = createCallbackFcn(app, @TableFittedParametersCellSelection, true);
            app.TableFittedParameters.Layout.Row = [4 7];
            app.TableFittedParameters.Layout.Column = [7 16];

            % Create PhysicalparametersLabel
            app.PhysicalparametersLabel = uilabel(app.GridLayout11);
            app.PhysicalparametersLabel.FontWeight = 'bold';
            app.PhysicalparametersLabel.Layout.Row = 8;
            app.PhysicalparametersLabel.Layout.Column = [7 16];
            app.PhysicalparametersLabel.Text = 'Physical parameters';

            % Create TableParameters
            app.TableParameters = uitable(app.GridLayout11);
            app.TableParameters.ColumnName = {'Component'; 'Msᵢ [A/m]'; 'αᵢ'; 'aᵢ [A/m]'; 'Select aᵢ'};
            app.TableParameters.RowName = {};
            app.TableParameters.ColumnEditable = [false false false false true];
            app.TableParameters.CellEditCallback = createCallbackFcn(app, @TableParametersCellEdit, true);
            app.TableParameters.CellSelectionCallback = createCallbackFcn(app, @TableParametersCellSelection, true);
            app.TableParameters.Layout.Row = [9 12];
            app.TableParameters.Layout.Column = [7 16];

            % Create TableQuantities
            app.TableQuantities = uitable(app.GridLayout11);
            app.TableQuantities.ColumnName = {'Component'; 'αᵢ⏐Msᵢ⏐/(3aᵢ)'; 'NᵢkвT [J/m³]'; 'Hkᵢ [A/m]'; 'χᵢₙ ᵢ'};
            app.TableQuantities.RowName = {};
            app.TableQuantities.CellSelectionCallback = createCallbackFcn(app, @TableQuantitiesCellSelection, true);
            app.TableQuantities.Layout.Row = [14 17];
            app.TableQuantities.Layout.Column = [7 16];

            % Create MulticomponentLangevinWeissmodelLabel
            app.MulticomponentLangevinWeissmodelLabel = uilabel(app.GridLayout11);
            app.MulticomponentLangevinWeissmodelLabel.FontWeight = 'bold';
            app.MulticomponentLangevinWeissmodelLabel.Layout.Row = 1;
            app.MulticomponentLangevinWeissmodelLabel.Layout.Column = [7 16];
            app.MulticomponentLangevinWeissmodelLabel.Text = 'Multicomponent Langevin-Weiss model';

            % Create MathematicalparametersLabel
            app.MathematicalparametersLabel = uilabel(app.GridLayout11);
            app.MathematicalparametersLabel.FontWeight = 'bold';
            app.MathematicalparametersLabel.Layout.Row = 3;
            app.MathematicalparametersLabel.Layout.Column = [7 16];
            app.MathematicalparametersLabel.Text = 'Mathematical parameters';

            % Create ReduceDofCheckBox
            app.ReduceDofCheckBox = uicheckbox(app.GridLayout11);
            app.ReduceDofCheckBox.ValueChangedFcn = createCallbackFcn(app, @ReduceDofCheckBoxValueChanged, true);
            app.ReduceDofCheckBox.Tooltip = {'Use constraint points at Htip and Hx_(i+1) to reduce the number of degrees of freedom of the optimization problem.'};
            app.ReduceDofCheckBox.Text = 'reduce dof';
            app.ReduceDofCheckBox.Layout.Row = 8;
            app.ReduceDofCheckBox.Layout.Column = [15 16];
            app.ReduceDofCheckBox.Value = true;

            % Create ErrorDropDownLabel
            app.ErrorDropDownLabel = uilabel(app.GridLayout11);
            app.ErrorDropDownLabel.WordWrap = 'on';
            app.ErrorDropDownLabel.FontWeight = 'bold';
            app.ErrorDropDownLabel.Layout.Row = 18;
            app.ErrorDropDownLabel.Layout.Column = 7;
            app.ErrorDropDownLabel.Text = 'Error';

            % Create ErrorDropDown
            app.ErrorDropDown = uidropdown(app.GridLayout11);
            app.ErrorDropDown.Items = {'Diagonal (H, sampled)', 'Diagonal (H, continuous)', 'Diagonal (logH, sampled)', 'Diagonal (logH, continuous)', 'Vertical', 'Horizontal'};
            app.ErrorDropDown.ValueChangedFcn = createCallbackFcn(app, @ErrorDropDownValueChanged, true);
            app.ErrorDropDown.Layout.Row = 18;
            app.ErrorDropDown.Layout.Column = [8 10];
            app.ErrorDropDown.Value = 'Diagonal (logH, continuous)';

            % Create JsField
            app.JsField = uieditfield(app.GridLayout11, 'numeric');
            app.JsField.ValueDisplayFormat = '%.6g';
            app.JsField.AllowEmpty = 'on';
            app.JsField.Editable = 'off';
            app.JsField.Layout.Row = 13;
            app.JsField.Layout.Column = [15 16];
            app.JsField.Value = [];

            % Create JsTLabel
            app.JsTLabel = uilabel(app.GridLayout11);
            app.JsTLabel.HorizontalAlignment = 'right';
            app.JsTLabel.FontWeight = 'bold';
            app.JsTLabel.Layout.Row = 13;
            app.JsTLabel.Layout.Column = 14;
            app.JsTLabel.Text = 'Js [T]';

            % Create NofcompLabel
            app.NofcompLabel = uilabel(app.GridLayout11);
            app.NofcompLabel.Layout.Row = 2;
            app.NofcompLabel.Layout.Column = [7 8];
            app.NofcompLabel.Text = 'N° of comp.';

            % Create NofcompSpinner
            app.NofcompSpinner = uispinner(app.GridLayout11);
            app.NofcompSpinner.Limits = [1 4];
            app.NofcompSpinner.ValueChangedFcn = createCallbackFcn(app, @NofcompSpinnerValueChanged, true);
            app.NofcompSpinner.Layout.Row = 2;
            app.NofcompSpinner.Layout.Column = 9;
            app.NofcompSpinner.Value = 1;

            % Create NofpointsLabel
            app.NofpointsLabel = uilabel(app.GridLayout11);
            app.NofpointsLabel.Tooltip = {'N° of points of modeled anhysteretic curve'};
            app.NofpointsLabel.Layout.Row = 2;
            app.NofpointsLabel.Layout.Column = [10 11];
            app.NofpointsLabel.Text = 'N° of points';

            % Create NofpointsEditField
            app.NofpointsEditField = uieditfield(app.GridLayout11, 'numeric');
            app.NofpointsEditField.Limits = [0 Inf];
            app.NofpointsEditField.ValueDisplayFormat = '%.0f';
            app.NofpointsEditField.ValueChangedFcn = createCallbackFcn(app, @NofpointsEditFieldValueChanged, true);
            app.NofpointsEditField.Tooltip = {'N° of points of modeled anhysteretic curve'};
            app.NofpointsEditField.Layout.Row = 2;
            app.NofpointsEditField.Layout.Column = 12;
            app.NofpointsEditField.Value = 100;

            % Create HystereticfittingTab
            app.HystereticfittingTab = uitab(app.TabGroup);
            app.HystereticfittingTab.Title = 'Hysteretic fitting ';

            % Create GridLayout10
            app.GridLayout10 = uigridlayout(app.HystereticfittingTab);
            app.GridLayout10.ColumnWidth = {'1x', '1x', '1x', '1x', '2x', '1x', '0.4x', '0.4x', '1.2x', '0.4x', '1.2x', '0.4x', '1.2x', '0.4x', '0.7x', '1x'};
            app.GridLayout10.RowHeight = {'1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x'};
            app.GridLayout10.ColumnSpacing = 5.5529390222886;
            app.GridLayout10.RowSpacing = 4.48888736300998;
            app.GridLayout10.Padding = [5.5529390222886 4.48888736300998 5.5529390222886 4.48888736300998];

            % Create AxesM_2
            app.AxesM_2 = uiaxes(app.GridLayout10);
            xlabel(app.AxesM_2, 'H [A/m]')
            ylabel(app.AxesM_2, 'M [A/m]')
            zlabel(app.AxesM_2, 'Z')
            app.AxesM_2.Box = 'on';
            app.AxesM_2.Layout.Row = [2 16];
            app.AxesM_2.Layout.Column = [1 5];

            % Create JilesAthertonrateindependentmodelLabel_2
            app.JilesAthertonrateindependentmodelLabel_2 = uilabel(app.GridLayout10);
            app.JilesAthertonrateindependentmodelLabel_2.FontWeight = 'bold';
            app.JilesAthertonrateindependentmodelLabel_2.Layout.Row = 1;
            app.JilesAthertonrateindependentmodelLabel_2.Layout.Column = [1 4];
            app.JilesAthertonrateindependentmodelLabel_2.Text = 'Jiles-Atherton rate-independent model';

            % Create ModelparametersLabel
            app.ModelparametersLabel = uilabel(app.GridLayout10);
            app.ModelparametersLabel.FontWeight = 'bold';
            app.ModelparametersLabel.Layout.Row = 1;
            app.ModelparametersLabel.Layout.Column = [6 8];
            app.ModelparametersLabel.Text = 'Model parameters';

            % Create Ms_JALabel
            app.Ms_JALabel = uilabel(app.GridLayout10);
            app.Ms_JALabel.Layout.Row = 2;
            app.Ms_JALabel.Layout.Column = [6 7];
            app.Ms_JALabel.Text = 'Ms [A/m]';

            % Create a_JALabel
            app.a_JALabel = uilabel(app.GridLayout10);
            app.a_JALabel.Layout.Row = 3;
            app.a_JALabel.Layout.Column = [6 7];
            app.a_JALabel.Text = 'a [A/m]';

            % Create Ms_JA
            app.Ms_JA = uieditfield(app.GridLayout10, 'numeric');
            app.Ms_JA.ValueDisplayFormat = '%.5e';
            app.Ms_JA.AllowEmpty = 'on';
            app.Ms_JA.ValueChangedFcn = createCallbackFcn(app, @JAParamsHystereticValueChanged, true);
            app.Ms_JA.Layout.Row = 2;
            app.Ms_JA.Layout.Column = [8 9];
            app.Ms_JA.Value = [];

            % Create alpha_JALabel
            app.alpha_JALabel = uilabel(app.GridLayout10);
            app.alpha_JALabel.Layout.Row = 4;
            app.alpha_JALabel.Layout.Column = [6 7];
            app.alpha_JALabel.Text = 'α';

            % Create a_JA
            app.a_JA = uieditfield(app.GridLayout10, 'numeric');
            app.a_JA.ValueDisplayFormat = '%.5g';
            app.a_JA.AllowEmpty = 'on';
            app.a_JA.ValueChangedFcn = createCallbackFcn(app, @JAParamsHystereticValueChanged, true);
            app.a_JA.Layout.Row = 3;
            app.a_JA.Layout.Column = [8 9];
            app.a_JA.Value = [];

            % Create c_JALabel
            app.c_JALabel = uilabel(app.GridLayout10);
            app.c_JALabel.Layout.Row = 5;
            app.c_JALabel.Layout.Column = [6 7];
            app.c_JALabel.Text = 'c';

            % Create alpha_JA
            app.alpha_JA = uieditfield(app.GridLayout10, 'numeric');
            app.alpha_JA.ValueDisplayFormat = '%.5e';
            app.alpha_JA.AllowEmpty = 'on';
            app.alpha_JA.ValueChangedFcn = createCallbackFcn(app, @JAParamsHystereticValueChanged, true);
            app.alpha_JA.Layout.Row = 4;
            app.alpha_JA.Layout.Column = [8 9];
            app.alpha_JA.Value = [];

            % Create k_JALabel
            app.k_JALabel = uilabel(app.GridLayout10);
            app.k_JALabel.Layout.Row = 6;
            app.k_JALabel.Layout.Column = [6 7];
            app.k_JALabel.Text = 'k [A/m]';

            % Create c_JA
            app.c_JA = uieditfield(app.GridLayout10, 'numeric');
            app.c_JA.ValueDisplayFormat = '%.6g';
            app.c_JA.AllowEmpty = 'on';
            app.c_JA.ValueChangedFcn = createCallbackFcn(app, @JAParamsHystereticValueChanged, true);
            app.c_JA.Layout.Row = 5;
            app.c_JA.Layout.Column = [8 9];
            app.c_JA.Value = [];

            % Create FitButton_2
            app.FitButton_2 = uibutton(app.GridLayout10, 'push');
            app.FitButton_2.ButtonPushedFcn = createCallbackFcn(app, @FitButton_2Pushed, true);
            app.FitButton_2.BackgroundColor = [0.8667 0.3294 0];
            app.FitButton_2.FontWeight = 'bold';
            app.FitButton_2.FontColor = [0.9412 0.9412 0.9412];
            app.FitButton_2.Layout.Row = 17;
            app.FitButton_2.Layout.Column = 15;
            app.FitButton_2.Text = 'Fit';

            % Create CalculatePlotButton_2
            app.CalculatePlotButton_2 = uibutton(app.GridLayout10, 'push');
            app.CalculatePlotButton_2.ButtonPushedFcn = createCallbackFcn(app, @CalculatePlotButton_2Pushed, true);
            app.CalculatePlotButton_2.WordWrap = 'on';
            app.CalculatePlotButton_2.Layout.Row = 17;
            app.CalculatePlotButton_2.Layout.Column = [13 14];
            app.CalculatePlotButton_2.Text = 'Calculate & Plot';

            % Create k_JA
            app.k_JA = uieditfield(app.GridLayout10, 'numeric');
            app.k_JA.ValueDisplayFormat = '%.6g';
            app.k_JA.AllowEmpty = 'on';
            app.k_JA.ValueChangedFcn = createCallbackFcn(app, @JAParamsHystereticValueChanged, true);
            app.k_JA.Layout.Row = 6;
            app.k_JA.Layout.Column = [8 9];
            app.k_JA.Value = [];

            % Create ErrortominimizeDropDownLabel_2
            app.ErrortominimizeDropDownLabel_2 = uilabel(app.GridLayout10);
            app.ErrortominimizeDropDownLabel_2.WordWrap = 'on';
            app.ErrortominimizeDropDownLabel_2.FontWeight = 'bold';
            app.ErrortominimizeDropDownLabel_2.Layout.Row = 17;
            app.ErrortominimizeDropDownLabel_2.Layout.Column = 6;
            app.ErrortominimizeDropDownLabel_2.Text = 'Error';

            % Create ErrortominimizeDropDown_2
            app.ErrortominimizeDropDown_2 = uidropdown(app.GridLayout10);
            app.ErrortominimizeDropDown_2.Items = {'Diagonal (H, continuous)', 'Diagonal (H, sampled)', 'Vertical', 'Horizontal'};
            app.ErrortominimizeDropDown_2.ValueChangedFcn = createCallbackFcn(app, @ErrortominimizeDropDown_2ValueChanged, true);
            app.ErrortominimizeDropDown_2.Layout.Row = 17;
            app.ErrortominimizeDropDown_2.Layout.Column = [7 10];
            app.ErrortominimizeDropDown_2.Value = 'Diagonal (H, continuous)';

            % Create RetrieveseedsButton
            app.RetrieveseedsButton = uibutton(app.GridLayout10, 'push');
            app.RetrieveseedsButton.ButtonPushedFcn = createCallbackFcn(app, @RetrieveseedsButtonPushed, true);
            app.RetrieveseedsButton.Layout.Row = 7;
            app.RetrieveseedsButton.Layout.Column = [6 7];
            app.RetrieveseedsButton.Text = 'Retrieve seeds';

            % Create TippointdataLabel
            app.TippointdataLabel = uilabel(app.GridLayout10);
            app.TippointdataLabel.FontWeight = 'bold';
            app.TippointdataLabel.Layout.Row = 9;
            app.TippointdataLabel.Layout.Column = [6 9];
            app.TippointdataLabel.Text = 'Tip point (data)';

            % Create ErrorDisplay_2
            app.ErrorDisplay_2 = uieditfield(app.GridLayout10, 'numeric');
            app.ErrorDisplay_2.ValueDisplayFormat = '%.5e';
            app.ErrorDisplay_2.AllowEmpty = 'on';
            app.ErrorDisplay_2.Editable = 'off';
            app.ErrorDisplay_2.HorizontalAlignment = 'left';
            app.ErrorDisplay_2.Layout.Row = 17;
            app.ErrorDisplay_2.Layout.Column = [11 12];
            app.ErrorDisplay_2.Value = [];

            % Create HtipLabel
            app.HtipLabel = uilabel(app.GridLayout10);
            app.HtipLabel.Layout.Row = 10;
            app.HtipLabel.Layout.Column = [6 7];
            app.HtipLabel.Text = 'Htip [A/m]';

            % Create ShowgridCheckBoxM_2
            app.ShowgridCheckBoxM_2 = uicheckbox(app.GridLayout10);
            app.ShowgridCheckBoxM_2.ValueChangedFcn = createCallbackFcn(app, @ShowgridCheckBoxM_2ValueChanged, true);
            app.ShowgridCheckBoxM_2.Text = 'Grid';
            app.ShowgridCheckBoxM_2.Layout.Row = 17;
            app.ShowgridCheckBoxM_2.Layout.Column = 3;
            app.ShowgridCheckBoxM_2.Value = true;

            % Create ResidualplotButtondMdH_2
            app.ResidualplotButtondMdH_2 = uibutton(app.GridLayout10, 'push');
            app.ResidualplotButtondMdH_2.ButtonPushedFcn = createCallbackFcn(app, @ResidualplotButtondMdH_2Pushed, true);
            app.ResidualplotButtondMdH_2.Layout.Row = 17;
            app.ResidualplotButtondMdH_2.Layout.Column = 1;
            app.ResidualplotButtondMdH_2.Text = 'Residuals';

            % Create Htip
            app.Htip = uieditfield(app.GridLayout10, 'numeric');
            app.Htip.ValueDisplayFormat = '%.5e';
            app.Htip.AllowEmpty = 'on';
            app.Htip.Editable = 'off';
            app.Htip.Layout.Row = 10;
            app.Htip.Layout.Column = [8 9];
            app.Htip.Value = [];

            % Create MtipLabel
            app.MtipLabel = uilabel(app.GridLayout10);
            app.MtipLabel.Layout.Row = 11;
            app.MtipLabel.Layout.Column = [6 7];
            app.MtipLabel.Text = 'Mtip [A/m]';

            % Create MsLower_JA
            app.MsLower_JA = uieditfield(app.GridLayout10, 'numeric');
            app.MsLower_JA.AllowEmpty = 'on';
            app.MsLower_JA.ValueChangedFcn = createCallbackFcn(app, @MsLower_JAValueChanged, true);
            app.MsLower_JA.Layout.Row = 2;
            app.MsLower_JA.Layout.Column = [10 11];

            % Create MsUpper_JA
            app.MsUpper_JA = uieditfield(app.GridLayout10, 'numeric');
            app.MsUpper_JA.ValueDisplayFormat = '%.6g';
            app.MsUpper_JA.AllowEmpty = 'on';
            app.MsUpper_JA.Layout.Row = 2;
            app.MsUpper_JA.Layout.Column = [12 13];
            app.MsUpper_JA.Value = Inf;

            % Create Mtip
            app.Mtip = uieditfield(app.GridLayout10, 'numeric');
            app.Mtip.ValueDisplayFormat = '%.5e';
            app.Mtip.AllowEmpty = 'on';
            app.Mtip.Editable = 'off';
            app.Mtip.Layout.Row = 11;
            app.Mtip.Layout.Column = [8 9];
            app.Mtip.Value = [];

            % Create aLower_JA
            app.aLower_JA = uieditfield(app.GridLayout10, 'numeric');
            app.aLower_JA.ValueDisplayFormat = '%.6g';
            app.aLower_JA.Layout.Row = 3;
            app.aLower_JA.Layout.Column = [10 11];

            % Create aUpper_JA
            app.aUpper_JA = uieditfield(app.GridLayout10, 'numeric');
            app.aUpper_JA.ValueDisplayFormat = '%.6g';
            app.aUpper_JA.AllowEmpty = 'on';
            app.aUpper_JA.Layout.Row = 3;
            app.aUpper_JA.Layout.Column = [12 13];
            app.aUpper_JA.Value = Inf;

            % Create alphaLower_JA
            app.alphaLower_JA = uieditfield(app.GridLayout10, 'numeric');
            app.alphaLower_JA.ValueDisplayFormat = '%.5e';
            app.alphaLower_JA.AllowEmpty = 'on';
            app.alphaLower_JA.Layout.Row = 4;
            app.alphaLower_JA.Layout.Column = [10 11];
            app.alphaLower_JA.Value = -Inf;

            % Create alphaUpper_JA
            app.alphaUpper_JA = uieditfield(app.GridLayout10, 'numeric');
            app.alphaUpper_JA.ValueDisplayFormat = '%.5e';
            app.alphaUpper_JA.AllowEmpty = 'on';
            app.alphaUpper_JA.Layout.Row = 4;
            app.alphaUpper_JA.Layout.Column = [12 13];
            app.alphaUpper_JA.Value = Inf;

            % Create cLower_JA
            app.cLower_JA = uieditfield(app.GridLayout10, 'numeric');
            app.cLower_JA.ValueDisplayFormat = '%.6g';
            app.cLower_JA.AllowEmpty = 'on';
            app.cLower_JA.Layout.Row = 5;
            app.cLower_JA.Layout.Column = [10 11];

            % Create cUpper_JA
            app.cUpper_JA = uieditfield(app.GridLayout10, 'numeric');
            app.cUpper_JA.ValueDisplayFormat = '%.6g';
            app.cUpper_JA.AllowEmpty = 'on';
            app.cUpper_JA.Layout.Row = 5;
            app.cUpper_JA.Layout.Column = [12 13];
            app.cUpper_JA.Value = 1;

            % Create LowerboundLabel
            app.LowerboundLabel = uilabel(app.GridLayout10);
            app.LowerboundLabel.FontWeight = 'bold';
            app.LowerboundLabel.Layout.Row = 1;
            app.LowerboundLabel.Layout.Column = [10 11];
            app.LowerboundLabel.Text = 'Lower bound';

            % Create kLower_JA
            app.kLower_JA = uieditfield(app.GridLayout10, 'numeric');
            app.kLower_JA.ValueDisplayFormat = '%.6g';
            app.kLower_JA.AllowEmpty = 'on';
            app.kLower_JA.Layout.Row = 6;
            app.kLower_JA.Layout.Column = [10 11];

            % Create UpperboundLabel
            app.UpperboundLabel = uilabel(app.GridLayout10);
            app.UpperboundLabel.FontWeight = 'bold';
            app.UpperboundLabel.Layout.Row = 1;
            app.UpperboundLabel.Layout.Column = [12 14];
            app.UpperboundLabel.Text = 'Upper bound';

            % Create kUpper_JA
            app.kUpper_JA = uieditfield(app.GridLayout10, 'numeric');
            app.kUpper_JA.ValueDisplayFormat = '%.6g';
            app.kUpper_JA.AllowEmpty = 'on';
            app.kUpper_JA.Layout.Row = 6;
            app.kUpper_JA.Layout.Column = [12 13];
            app.kUpper_JA.Value = Inf;

            % Create FitLabel
            app.FitLabel = uilabel(app.GridLayout10);
            app.FitLabel.FontWeight = 'bold';
            app.FitLabel.Layout.Row = 1;
            app.FitLabel.Layout.Column = 14;
            app.FitLabel.Text = 'Fit';

            % Create CheckBox
            app.CheckBox = uicheckbox(app.GridLayout10);
            app.CheckBox.Text = '';
            app.CheckBox.Layout.Row = 2;
            app.CheckBox.Layout.Column = 14;
            app.CheckBox.Value = true;

            % Create CheckBox_2
            app.CheckBox_2 = uicheckbox(app.GridLayout10);
            app.CheckBox_2.Text = '';
            app.CheckBox_2.Layout.Row = 3;
            app.CheckBox_2.Layout.Column = 14;
            app.CheckBox_2.Value = true;

            % Create CheckBox_3
            app.CheckBox_3 = uicheckbox(app.GridLayout10);
            app.CheckBox_3.Text = '';
            app.CheckBox_3.Layout.Row = 4;
            app.CheckBox_3.Layout.Column = 14;
            app.CheckBox_3.Value = true;

            % Create CheckBox_4
            app.CheckBox_4 = uicheckbox(app.GridLayout10);
            app.CheckBox_4.Text = '';
            app.CheckBox_4.Layout.Row = 5;
            app.CheckBox_4.Layout.Column = 14;
            app.CheckBox_4.Value = true;

            % Create FitkCheckBox
            app.FitkCheckBox = uicheckbox(app.GridLayout10);
            app.FitkCheckBox.Text = '';
            app.FitkCheckBox.Layout.Row = 6;
            app.FitkCheckBox.Layout.Column = 14;
            app.FitkCheckBox.Value = true;

            % Create kConstrainedCheckBox_2
            app.kConstrainedCheckBox_2 = uicheckbox(app.GridLayout10);
            app.kConstrainedCheckBox_2.ValueChangedFcn = createCallbackFcn(app, @kConstrainedCheckBox_2ValueChanged, true);
            app.kConstrainedCheckBox_2.Text = 'Constrained by Hc';
            app.kConstrainedCheckBox_2.Layout.Row = 6;
            app.kConstrainedCheckBox_2.Layout.Column = [15 16];
            app.kConstrainedCheckBox_2.Value = true;

            % Create StopfitButton_2
            app.StopfitButton_2 = uibutton(app.GridLayout10, 'push');
            app.StopfitButton_2.ButtonPushedFcn = createCallbackFcn(app, @StopfitButton_2Pushed, true);
            app.StopfitButton_2.Layout.Row = 17;
            app.StopfitButton_2.Layout.Column = 16;
            app.StopfitButton_2.Text = 'Stop fit';

            % Create FittingconditionsLabel
            app.FittingconditionsLabel = uilabel(app.GridLayout10);
            app.FittingconditionsLabel.FontWeight = 'bold';
            app.FittingconditionsLabel.Layout.Row = 9;
            app.FittingconditionsLabel.Layout.Column = [12 16];
            app.FittingconditionsLabel.Text = 'Fitting conditions';

            % Create StartingpointDropDown_4Label
            app.StartingpointDropDown_4Label = uilabel(app.GridLayout10);
            app.StartingpointDropDown_4Label.Layout.Row = 10;
            app.StartingpointDropDown_4Label.Layout.Column = [12 14];
            app.StartingpointDropDown_4Label.Text = 'Starting point';

            % Create StartingpointDropDown_4
            app.StartingpointDropDown_4 = uidropdown(app.GridLayout10);
            app.StartingpointDropDown_4.Items = {'Demagnetized', 'Tip point'};
            app.StartingpointDropDown_4.ValueChangedFcn = createCallbackFcn(app, @StartingpointDropDown_4ValueChanged, true);
            app.StartingpointDropDown_4.Layout.Row = 10;
            app.StartingpointDropDown_4.Layout.Column = [14 16];
            app.StartingpointDropDown_4.Value = 'Demagnetized';

            % Create FittingregionDropDownLabel
            app.FittingregionDropDownLabel = uilabel(app.GridLayout10);
            app.FittingregionDropDownLabel.Layout.Row = 11;
            app.FittingregionDropDownLabel.Layout.Column = [12 14];
            app.FittingregionDropDownLabel.Text = 'Fitting region';

            % Create FittingregionDropDown
            app.FittingregionDropDown = uidropdown(app.GridLayout10);
            app.FittingregionDropDown.Items = {'Left branch only', 'Entire loop'};
            app.FittingregionDropDown.ValueChangedFcn = createCallbackFcn(app, @FittingregionDropDownValueChanged, true);
            app.FittingregionDropDown.Layout.Row = 11;
            app.FittingregionDropDown.Layout.Column = [14 16];
            app.FittingregionDropDown.Value = 'Entire loop';

            % Create StopcriterionDropDown_5Label
            app.StopcriterionDropDown_5Label = uilabel(app.GridLayout10);
            app.StopcriterionDropDown_5Label.Layout.Row = 12;
            app.StopcriterionDropDown_5Label.Layout.Column = [12 14];
            app.StopcriterionDropDown_5Label.Text = 'Stop criterion';

            % Create StopcriterionDropDown_5
            app.StopcriterionDropDown_5 = uidropdown(app.GridLayout10);
            app.StopcriterionDropDown_5.Items = {'Fixed repetitions', 'Until convergence'};
            app.StopcriterionDropDown_5.ValueChangedFcn = createCallbackFcn(app, @StopcriterionDropDown_5ValueChanged, true);
            app.StopcriterionDropDown_5.Layout.Row = 12;
            app.StopcriterionDropDown_5.Layout.Column = [14 16];
            app.StopcriterionDropDown_5.Value = 'Fixed repetitions';

            % Create RepetitionsEditField_3Label
            app.RepetitionsEditField_3Label = uilabel(app.GridLayout10);
            app.RepetitionsEditField_3Label.Layout.Row = 13;
            app.RepetitionsEditField_3Label.Layout.Column = [13 15];
            app.RepetitionsEditField_3Label.Text = 'Repetitions';

            % Create RepetitionsEditField_3
            app.RepetitionsEditField_3 = uieditfield(app.GridLayout10, 'numeric');
            app.RepetitionsEditField_3.Limits = [0 Inf];
            app.RepetitionsEditField_3.RoundFractionalValues = 'on';
            app.RepetitionsEditField_3.ValueChangedFcn = createCallbackFcn(app, @RepetitionsEditField_3ValueChanged, true);
            app.RepetitionsEditField_3.Layout.Row = 13;
            app.RepetitionsEditField_3.Layout.Column = [15 16];
            app.RepetitionsEditField_3.Value = 1;

            % Create RelativetoleranceEditFieldLabel
            app.RelativetoleranceEditFieldLabel = uilabel(app.GridLayout10);
            app.RelativetoleranceEditFieldLabel.Layout.Row = 14;
            app.RelativetoleranceEditFieldLabel.Layout.Column = [13 15];
            app.RelativetoleranceEditFieldLabel.Text = 'Relative tolerance';

            % Create RelativetoleranceEditField
            app.RelativetoleranceEditField = uieditfield(app.GridLayout10, 'numeric');
            app.RelativetoleranceEditField.Limits = [0 Inf];
            app.RelativetoleranceEditField.ValueDisplayFormat = '%.3e';
            app.RelativetoleranceEditField.ValueChangedFcn = createCallbackFcn(app, @RelativetoleranceEditFieldValueChanged, true);
            app.RelativetoleranceEditField.Layout.Row = 14;
            app.RelativetoleranceEditField.Layout.Column = [15 16];
            app.RelativetoleranceEditField.Value = 0.001;

            % Create MaximumrepetitionsEditFieldLabel
            app.MaximumrepetitionsEditFieldLabel = uilabel(app.GridLayout10);
            app.MaximumrepetitionsEditFieldLabel.Layout.Row = 15;
            app.MaximumrepetitionsEditFieldLabel.Layout.Column = [13 15];
            app.MaximumrepetitionsEditFieldLabel.Text = 'Maximum repetitions';

            % Create MaximumrepetitionsEditField
            app.MaximumrepetitionsEditField = uieditfield(app.GridLayout10, 'numeric');
            app.MaximumrepetitionsEditField.Limits = [0 Inf];
            app.MaximumrepetitionsEditField.RoundFractionalValues = 'on';
            app.MaximumrepetitionsEditField.ValueChangedFcn = createCallbackFcn(app, @MaximumrepetitionsEditFieldValueChanged, true);
            app.MaximumrepetitionsEditField.Layout.Row = 15;
            app.MaximumrepetitionsEditField.Layout.Column = [15 16];
            app.MaximumrepetitionsEditField.Value = 10;

            % Create PlaygroundTab
            app.PlaygroundTab = uitab(app.TabGroup);
            app.PlaygroundTab.Title = 'Playground';

            % Create GridLayout3
            app.GridLayout3 = uigridlayout(app.PlaygroundTab);
            app.GridLayout3.ColumnWidth = {'1.25x', '1.3x', '0.25x', '1x', '1x', '1x', '1x', '1x', '0.5x', '1x', '1x', '1x', '1x', '1x'};
            app.GridLayout3.RowHeight = {'1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '0.5x'};
            app.GridLayout3.ColumnSpacing = 4.37498664855957;
            app.GridLayout3.RowSpacing = 2.24000155131022;
            app.GridLayout3.Padding = [4.37498664855957 2.24000155131022 4.37498664855957 2.24000155131022];

            % Create AxesM_5
            app.AxesM_5 = uiaxes(app.GridLayout3);
            xlabel(app.AxesM_5, 'H [A/m]')
            ylabel(app.AxesM_5, 'M [A/m]')
            zlabel(app.AxesM_5, 'Z')
            app.AxesM_5.Box = 'on';
            app.AxesM_5.Layout.Row = [3 13];
            app.AxesM_5.Layout.Column = [10 14];

            % Create MajorloopPanel
            app.MajorloopPanel = uipanel(app.GridLayout3);
            app.MajorloopPanel.Title = 'Major loop';
            app.MajorloopPanel.Layout.Row = [2 14];
            app.MajorloopPanel.Layout.Column = [4 8];

            % Create GridLayout4
            app.GridLayout4 = uigridlayout(app.MajorloopPanel);
            app.GridLayout4.ColumnWidth = {'1x', '1x', '1x', '0.5x'};
            app.GridLayout4.RowHeight = {'1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '6x'};
            app.GridLayout4.ColumnSpacing = 5.07975959777832;
            app.GridLayout4.RowSpacing = 2.1945669386122;
            app.GridLayout4.Padding = [5.07975959777832 2.1945669386122 5.07975959777832 2.1945669386122];

            % Create StopcriterionDropDownLabel
            app.StopcriterionDropDownLabel = uilabel(app.GridLayout4);
            app.StopcriterionDropDownLabel.Layout.Row = 5;
            app.StopcriterionDropDownLabel.Layout.Column = [1 2];
            app.StopcriterionDropDownLabel.Text = 'Stop criterion';

            % Create StopcriterionDropDown
            app.StopcriterionDropDown = uidropdown(app.GridLayout4);
            app.StopcriterionDropDown.Items = {'Until convergence', 'Fixed repetitions'};
            app.StopcriterionDropDown.ValueChangedFcn = createCallbackFcn(app, @PlotDropDownValueChanged, true);
            app.StopcriterionDropDown.Layout.Row = 5;
            app.StopcriterionDropDown.Layout.Column = [2 3];
            app.StopcriterionDropDown.Value = 'Fixed repetitions';

            % Create RepetitionsEditFieldLabel
            app.RepetitionsEditFieldLabel = uilabel(app.GridLayout4);
            app.RepetitionsEditFieldLabel.Layout.Row = 6;
            app.RepetitionsEditFieldLabel.Layout.Column = [2 3];
            app.RepetitionsEditFieldLabel.Text = 'Repetitions';

            % Create RepetitionsEditField
            app.RepetitionsEditField = uieditfield(app.GridLayout4, 'numeric');
            app.RepetitionsEditField.Limits = [0 Inf];
            app.RepetitionsEditField.RoundFractionalValues = 'on';
            app.RepetitionsEditField.ValueChangedFcn = createCallbackFcn(app, @PlotDropDownValueChanged, true);
            app.RepetitionsEditField.Layout.Row = 6;
            app.RepetitionsEditField.Layout.Column = 3;
            app.RepetitionsEditField.Value = 1;

            % Create ReltoleranceEditField_6Label
            app.ReltoleranceEditField_6Label = uilabel(app.GridLayout4);
            app.ReltoleranceEditField_6Label.Layout.Row = 7;
            app.ReltoleranceEditField_6Label.Layout.Column = [2 3];
            app.ReltoleranceEditField_6Label.Text = 'Rel. tolerance';

            % Create ReltoleranceEditField_6
            app.ReltoleranceEditField_6 = uieditfield(app.GridLayout4, 'numeric');
            app.ReltoleranceEditField_6.Limits = [0 Inf];
            app.ReltoleranceEditField_6.ValueDisplayFormat = '%.3e';
            app.ReltoleranceEditField_6.ValueChangedFcn = createCallbackFcn(app, @PlotDropDownValueChanged, true);
            app.ReltoleranceEditField_6.Layout.Row = 7;
            app.ReltoleranceEditField_6.Layout.Column = 3;
            app.ReltoleranceEditField_6.Value = 0.001;

            % Create PlotDropDownLabel
            app.PlotDropDownLabel = uilabel(app.GridLayout4);
            app.PlotDropDownLabel.Layout.Row = 9;
            app.PlotDropDownLabel.Layout.Column = 1;
            app.PlotDropDownLabel.Text = 'Plot';

            % Create PlotDropDown
            app.PlotDropDown = uidropdown(app.GridLayout4);
            app.PlotDropDown.Items = {'Last loop only', 'Full history'};
            app.PlotDropDown.ValueChangedFcn = createCallbackFcn(app, @PlotDropDownValueChanged, true);
            app.PlotDropDown.Layout.Row = 9;
            app.PlotDropDown.Layout.Column = [2 3];
            app.PlotDropDown.Value = 'Last loop only';

            % Create StartingpointDropDownLabel
            app.StartingpointDropDownLabel = uilabel(app.GridLayout4);
            app.StartingpointDropDownLabel.Layout.Row = 1;
            app.StartingpointDropDownLabel.Layout.Column = [1 2];
            app.StartingpointDropDownLabel.Text = 'Starting point';

            % Create StartingpointDropDown
            app.StartingpointDropDown = uidropdown(app.GridLayout4);
            app.StartingpointDropDown.Items = {'Demagnetized', 'Tip point (data)', 'User-defined'};
            app.StartingpointDropDown.ValueChangedFcn = createCallbackFcn(app, @PlotDropDownValueChanged, true);
            app.StartingpointDropDown.Layout.Row = 1;
            app.StartingpointDropDown.Layout.Column = [2 3];
            app.StartingpointDropDown.Value = 'Demagnetized';

            % Create MstartAmEditFieldLabel
            app.MstartAmEditFieldLabel = uilabel(app.GridLayout4);
            app.MstartAmEditFieldLabel.Layout.Row = 2;
            app.MstartAmEditFieldLabel.Layout.Column = 2;
            app.MstartAmEditFieldLabel.Text = 'Mstart [A/m]';

            % Create MstartAmEditField
            app.MstartAmEditField = uieditfield(app.GridLayout4, 'numeric');
            app.MstartAmEditField.ValueDisplayFormat = '%.6g';
            app.MstartAmEditField.ValueChangedFcn = createCallbackFcn(app, @PlotDropDownValueChanged, true);
            app.MstartAmEditField.Layout.Row = 2;
            app.MstartAmEditField.Layout.Column = 3;

            % Create HstartAmEditFieldLabel
            app.HstartAmEditFieldLabel = uilabel(app.GridLayout4);
            app.HstartAmEditFieldLabel.Layout.Row = 3;
            app.HstartAmEditFieldLabel.Layout.Column = 2;
            app.HstartAmEditFieldLabel.Text = 'Hstart [A/m]';

            % Create HstartAmEditField
            app.HstartAmEditField = uieditfield(app.GridLayout4, 'numeric');
            app.HstartAmEditField.ValueDisplayFormat = '%.6g';
            app.HstartAmEditField.ValueChangedFcn = createCallbackFcn(app, @PlotDropDownValueChanged, true);
            app.HstartAmEditField.Layout.Row = 3;
            app.HstartAmEditField.Layout.Column = 3;

            % Create HamplitudeAmEditFieldLabel
            app.HamplitudeAmEditFieldLabel = uilabel(app.GridLayout4);
            app.HamplitudeAmEditFieldLabel.Layout.Row = 4;
            app.HamplitudeAmEditFieldLabel.Layout.Column = [1 2];
            app.HamplitudeAmEditFieldLabel.Text = 'H amplitude [A/m]';

            % Create HamplitudeAmEditField
            app.HamplitudeAmEditField = uieditfield(app.GridLayout4, 'numeric');
            app.HamplitudeAmEditField.Limits = [0 Inf];
            app.HamplitudeAmEditField.ValueDisplayFormat = '%.6g';
            app.HamplitudeAmEditField.ValueChangedFcn = createCallbackFcn(app, @PlotDropDownValueChanged, true);
            app.HamplitudeAmEditField.Layout.Row = 4;
            app.HamplitudeAmEditField.Layout.Column = 3;

            % Create MaxrepetitionsEditFieldLabel
            app.MaxrepetitionsEditFieldLabel = uilabel(app.GridLayout4);
            app.MaxrepetitionsEditFieldLabel.Layout.Row = 8;
            app.MaxrepetitionsEditFieldLabel.Layout.Column = 2;
            app.MaxrepetitionsEditFieldLabel.Text = 'Max. repetitions';

            % Create MaxrepetitionsEditField
            app.MaxrepetitionsEditField = uieditfield(app.GridLayout4, 'numeric');
            app.MaxrepetitionsEditField.Limits = [0 Inf];
            app.MaxrepetitionsEditField.RoundFractionalValues = 'on';
            app.MaxrepetitionsEditField.ValueChangedFcn = createCallbackFcn(app, @PlotDropDownValueChanged, true);
            app.MaxrepetitionsEditField.Layout.Row = 8;
            app.MaxrepetitionsEditField.Layout.Column = 3;
            app.MaxrepetitionsEditField.Value = 10;

            % Create MinorloopsPanel
            app.MinorloopsPanel = uipanel(app.GridLayout3);
            app.MinorloopsPanel.Title = 'Minor loops';
            app.MinorloopsPanel.Layout.Row = [2 14];
            app.MinorloopsPanel.Layout.Column = [4 8];
            app.MinorloopsPanel.Scrollable = 'on';

            % Create GridLayout6
            app.GridLayout6 = uigridlayout(app.MinorloopsPanel);
            app.GridLayout6.ColumnWidth = {'1.475x', '1.4x', '1x', '0.5x', '0.5x'};
            app.GridLayout6.RowHeight = {'1x', '1x', '6x', '1x', '1x', '1x', '1x', '1x', '1x'};
            app.GridLayout6.ColumnSpacing = 1.95454515729632;
            app.GridLayout6.RowSpacing = 4.77273786067963;
            app.GridLayout6.Padding = [1.95454515729632 4.77273786067963 1.95454515729632 4.77273786067963];

            % Create UITable
            app.UITable = uitable(app.GridLayout6);
            app.UITable.ColumnName = {'Htip_i'};
            app.UITable.ColumnRearrangeable = 'on';
            app.UITable.RowName = {};
            app.UITable.ColumnSortable = true;
            app.UITable.SelectionType = 'row';
            app.UITable.ColumnEditable = true;
            app.UITable.Multiselect = 'off';
            app.UITable.Layout.Row = [2 4];
            app.UITable.Layout.Column = [2 4];

            % Create StopcriterionDropDown_2Label_2
            app.StopcriterionDropDown_2Label_2 = uilabel(app.GridLayout6);
            app.StopcriterionDropDown_2Label_2.Layout.Row = 2;
            app.StopcriterionDropDown_2Label_2.Layout.Column = [1 3];
            app.StopcriterionDropDown_2Label_2.Text = 'H amplitude [A/m]';

            % Create StopcriterionDropDown_2Label_3
            app.StopcriterionDropDown_2Label_3 = uilabel(app.GridLayout6);
            app.StopcriterionDropDown_2Label_3.Layout.Row = 1;
            app.StopcriterionDropDown_2Label_3.Layout.Column = [1 2];
            app.StopcriterionDropDown_2Label_3.Text = 'Starting point: Demagnetized';

            % Create RepetitionsEditFieldLabel_2
            app.RepetitionsEditFieldLabel_2 = uilabel(app.GridLayout6);
            app.RepetitionsEditFieldLabel_2.Layout.Row = 6;
            app.RepetitionsEditFieldLabel_2.Layout.Column = 2;
            app.RepetitionsEditFieldLabel_2.Text = 'Repetitions';

            % Create RepetitionsEditField_2
            app.RepetitionsEditField_2 = uieditfield(app.GridLayout6, 'numeric');
            app.RepetitionsEditField_2.Limits = [0 Inf];
            app.RepetitionsEditField_2.RoundFractionalValues = 'on';
            app.RepetitionsEditField_2.Layout.Row = 6;
            app.RepetitionsEditField_2.Layout.Column = [3 4];
            app.RepetitionsEditField_2.Value = 1;

            % Create PlotDropDown_2Label
            app.PlotDropDown_2Label = uilabel(app.GridLayout6);
            app.PlotDropDown_2Label.Layout.Row = 9;
            app.PlotDropDown_2Label.Layout.Column = 1;
            app.PlotDropDown_2Label.Text = 'Plot';

            % Create PlotDropDown_2
            app.PlotDropDown_2 = uidropdown(app.GridLayout6);
            app.PlotDropDown_2.Items = {'Last loops only', 'Full history'};
            app.PlotDropDown_2.Layout.Row = 9;
            app.PlotDropDown_2.Layout.Column = [2 4];
            app.PlotDropDown_2.Value = 'Last loops only';

            % Create StopcriterionDropDown_4Label
            app.StopcriterionDropDown_4Label = uilabel(app.GridLayout6);
            app.StopcriterionDropDown_4Label.Layout.Row = 5;
            app.StopcriterionDropDown_4Label.Layout.Column = [1 2];
            app.StopcriterionDropDown_4Label.Text = 'Stop criterion';

            % Create StopcriterionDropDown_4
            app.StopcriterionDropDown_4 = uidropdown(app.GridLayout6);
            app.StopcriterionDropDown_4.Items = {'Until convergence', 'Fixed repetitions'};
            app.StopcriterionDropDown_4.ValueChangedFcn = createCallbackFcn(app, @StopcriterionDropDown_4ValueChanged, true);
            app.StopcriterionDropDown_4.Layout.Row = 5;
            app.StopcriterionDropDown_4.Layout.Column = [2 4];
            app.StopcriterionDropDown_4.Value = 'Fixed repetitions';

            % Create ReltoleranceEditField_5Label
            app.ReltoleranceEditField_5Label = uilabel(app.GridLayout6);
            app.ReltoleranceEditField_5Label.Layout.Row = 7;
            app.ReltoleranceEditField_5Label.Layout.Column = 2;
            app.ReltoleranceEditField_5Label.Text = 'Rel. tolerance';

            % Create ReltoleranceEditField_5
            app.ReltoleranceEditField_5 = uieditfield(app.GridLayout6, 'numeric');
            app.ReltoleranceEditField_5.Limits = [0 Inf];
            app.ReltoleranceEditField_5.ValueDisplayFormat = '%.3e';
            app.ReltoleranceEditField_5.Layout.Row = 7;
            app.ReltoleranceEditField_5.Layout.Column = [3 4];
            app.ReltoleranceEditField_5.Value = 0.001;

            % Create MaxrepetitionsEditField_2
            app.MaxrepetitionsEditField_2 = uieditfield(app.GridLayout6, 'numeric');
            app.MaxrepetitionsEditField_2.Limits = [0 Inf];
            app.MaxrepetitionsEditField_2.RoundFractionalValues = 'on';
            app.MaxrepetitionsEditField_2.ValueChangedFcn = createCallbackFcn(app, @StopcriterionDropDown_4ValueChanged, true);
            app.MaxrepetitionsEditField_2.Layout.Row = 8;
            app.MaxrepetitionsEditField_2.Layout.Column = [3 4];
            app.MaxrepetitionsEditField_2.Value = 10;

            % Create MaxrepetitionsEditFieldLabel_2
            app.MaxrepetitionsEditFieldLabel_2 = uilabel(app.GridLayout6);
            app.MaxrepetitionsEditFieldLabel_2.Layout.Row = 8;
            app.MaxrepetitionsEditFieldLabel_2.Layout.Column = 2;
            app.MaxrepetitionsEditFieldLabel_2.Text = 'Max. repetitions';

            % Create DegaussingPanel
            app.DegaussingPanel = uipanel(app.GridLayout3);
            app.DegaussingPanel.Title = 'Degaussing';
            app.DegaussingPanel.Layout.Row = [2 14];
            app.DegaussingPanel.Layout.Column = [4 8];

            % Create GridLayout5
            app.GridLayout5 = uigridlayout(app.DegaussingPanel);
            app.GridLayout5.ColumnWidth = {'0.8x', '1x', '0.7x'};
            app.GridLayout5.RowHeight = {'1x', '1x', '1x', '1x', '1x', '1x', '1x', '6x'};
            app.GridLayout5.ColumnSpacing = 7.59856033325195;
            app.GridLayout5.RowSpacing = 6.15151267581516;
            app.GridLayout5.Padding = [7.59856033325195 6.15151267581516 7.59856033325195 6.15151267581516];

            % Create StartingpointDropDown_3Label
            app.StartingpointDropDown_3Label = uilabel(app.GridLayout5);
            app.StartingpointDropDown_3Label.Layout.Row = 1;
            app.StartingpointDropDown_3Label.Layout.Column = 1;
            app.StartingpointDropDown_3Label.Text = 'Starting point';

            % Create StartingpointDropDown_3
            app.StartingpointDropDown_3 = uidropdown(app.GridLayout5);
            app.StartingpointDropDown_3.Items = {'Remanence (data)', 'Tip point (data)', 'User-defined'};
            app.StartingpointDropDown_3.ValueChangedFcn = createCallbackFcn(app, @DegaussingModeChanged, true);
            app.StartingpointDropDown_3.Layout.Row = 1;
            app.StartingpointDropDown_3.Layout.Column = [2 3];
            app.StartingpointDropDown_3.Value = 'Remanence (data)';

            % Create MstartAmEditField_2Label
            app.MstartAmEditField_2Label = uilabel(app.GridLayout5);
            app.MstartAmEditField_2Label.Layout.Row = 2;
            app.MstartAmEditField_2Label.Layout.Column = 2;
            app.MstartAmEditField_2Label.Text = 'Mstart [A/m]';

            % Create MstartAmEditField_2
            app.MstartAmEditField_2 = uieditfield(app.GridLayout5, 'numeric');
            app.MstartAmEditField_2.ValueDisplayFormat = '%.6g';
            app.MstartAmEditField_2.ValueChangedFcn = createCallbackFcn(app, @DegaussingValueChanged, true);
            app.MstartAmEditField_2.Layout.Row = 2;
            app.MstartAmEditField_2.Layout.Column = 3;

            % Create HstartAmEditField_2Label
            app.HstartAmEditField_2Label = uilabel(app.GridLayout5);
            app.HstartAmEditField_2Label.Layout.Row = 3;
            app.HstartAmEditField_2Label.Layout.Column = 2;
            app.HstartAmEditField_2Label.Text = 'Hstart [A/m]';

            % Create HstartAmEditField_2
            app.HstartAmEditField_2 = uieditfield(app.GridLayout5, 'numeric');
            app.HstartAmEditField_2.ValueDisplayFormat = '%.6g';
            app.HstartAmEditField_2.ValueChangedFcn = createCallbackFcn(app, @DegaussingValueChanged, true);
            app.HstartAmEditField_2.Layout.Row = 3;
            app.HstartAmEditField_2.Layout.Column = 3;

            % Create HamplitudeDropDownLabel
            app.HamplitudeDropDownLabel = uilabel(app.GridLayout5);
            app.HamplitudeDropDownLabel.Layout.Row = 4;
            app.HamplitudeDropDownLabel.Layout.Column = 1;
            app.HamplitudeDropDownLabel.Text = 'H amplitude';

            % Create HamplitudeDropDown
            app.HamplitudeDropDown = uidropdown(app.GridLayout5);
            app.HamplitudeDropDown.Items = {'Automatic', 'User-defined'};
            app.HamplitudeDropDown.ValueChangedFcn = createCallbackFcn(app, @DegaussingModeChanged, true);
            app.HamplitudeDropDown.Layout.Row = 4;
            app.HamplitudeDropDown.Layout.Column = [2 3];
            app.HamplitudeDropDown.Value = 'Automatic';

            % Create NofstepsEditFieldLabel
            app.NofstepsEditFieldLabel = uilabel(app.GridLayout5);
            app.NofstepsEditFieldLabel.Layout.Row = 5;
            app.NofstepsEditFieldLabel.Layout.Column = 2;
            app.NofstepsEditFieldLabel.Text = 'N° of steps';

            % Create NofstepsEditField
            app.NofstepsEditField = uieditfield(app.GridLayout5, 'numeric');
            app.NofstepsEditField.Limits = [1 Inf];
            app.NofstepsEditField.RoundFractionalValues = 'on';
            app.NofstepsEditField.ValueChangedFcn = createCallbackFcn(app, @DegaussingValueChanged, true);
            app.NofstepsEditField.Layout.Row = 5;
            app.NofstepsEditField.Layout.Column = 3;
            app.NofstepsEditField.Value = 5;

            % Create InitialamplitudeAmEditFieldLabel
            app.InitialamplitudeAmEditFieldLabel = uilabel(app.GridLayout5);
            app.InitialamplitudeAmEditFieldLabel.Layout.Row = 6;
            app.InitialamplitudeAmEditFieldLabel.Layout.Column = 2;
            app.InitialamplitudeAmEditFieldLabel.Text = 'Initial amplitude [A/m]';

            % Create InitialamplitudeAmEditField
            app.InitialamplitudeAmEditField = uieditfield(app.GridLayout5, 'numeric');
            app.InitialamplitudeAmEditField.Limits = [0 Inf];
            app.InitialamplitudeAmEditField.ValueDisplayFormat = '%.6g';
            app.InitialamplitudeAmEditField.ValueChangedFcn = createCallbackFcn(app, @DegaussingValueChanged, true);
            app.InitialamplitudeAmEditField.Layout.Row = 6;
            app.InitialamplitudeAmEditField.Layout.Column = 3;
            app.InitialamplitudeAmEditField.Value = 1;

            % Create FinalamplitudeAmEditFieldLabel
            app.FinalamplitudeAmEditFieldLabel = uilabel(app.GridLayout5);
            app.FinalamplitudeAmEditFieldLabel.Layout.Row = 7;
            app.FinalamplitudeAmEditFieldLabel.Layout.Column = 2;
            app.FinalamplitudeAmEditFieldLabel.Text = 'Final amplitude [A/m]';

            % Create FinalamplitudeAmEditField
            app.FinalamplitudeAmEditField = uieditfield(app.GridLayout5, 'numeric');
            app.FinalamplitudeAmEditField.Limits = [0 Inf];
            app.FinalamplitudeAmEditField.ValueDisplayFormat = '%.6g';
            app.FinalamplitudeAmEditField.ValueChangedFcn = createCallbackFcn(app, @DegaussingValueChanged, true);
            app.FinalamplitudeAmEditField.Layout.Row = 7;
            app.FinalamplitudeAmEditField.Layout.Column = 3;
            app.FinalamplitudeAmEditField.Value = 1;

            % Create UITable_3
            app.UITable_3 = uitable(app.GridLayout5);
            app.UITable_3.ColumnName = {'Htip_i'};
            app.UITable_3.ColumnRearrangeable = 'on';
            app.UITable_3.RowName = {};
            app.UITable_3.ColumnSortable = true;
            app.UITable_3.SelectionType = 'row';
            app.UITable_3.ColumnEditable = true;
            app.UITable_3.CellEditCallback = createCallbackFcn(app, @DegaussingTableCellEdit, true);
            app.UITable_3.Multiselect = 'off';
            app.UITable_3.Layout.Row = 8;
            app.UITable_3.Layout.Column = [2 3];

            % Create MajorloopwithharmonicsPanel
            app.MajorloopwithharmonicsPanel = uipanel(app.GridLayout3);
            app.MajorloopwithharmonicsPanel.Title = 'Major loop with harmonics';
            app.MajorloopwithharmonicsPanel.Layout.Row = [2 14];
            app.MajorloopwithharmonicsPanel.Layout.Column = [4 8];

            % Create GridLayout7
            app.GridLayout7 = uigridlayout(app.MajorloopwithharmonicsPanel);
            app.GridLayout7.ColumnWidth = {'1x', '1x', '1x', '0.5x'};
            app.GridLayout7.RowHeight = {'1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '3x'};

            % Create StartingpointDropDown_5Label
            app.StartingpointDropDown_5Label = uilabel(app.GridLayout7);
            app.StartingpointDropDown_5Label.Layout.Row = 1;
            app.StartingpointDropDown_5Label.Layout.Column = 1;
            app.StartingpointDropDown_5Label.Text = 'Starting point';

            % Create StartingpointDropDown_5
            app.StartingpointDropDown_5 = uidropdown(app.GridLayout7);
            app.StartingpointDropDown_5.Items = {'Demagnetized', 'Tip point (data)', 'User-defined'};
            app.StartingpointDropDown_5.ValueChangedFcn = createCallbackFcn(app, @HarmonicsValueChanged, true);
            app.StartingpointDropDown_5.Layout.Row = 1;
            app.StartingpointDropDown_5.Layout.Column = [2 3];
            app.StartingpointDropDown_5.Value = 'Tip point (data)';

            % Create MstartAmEditField_3Label
            app.MstartAmEditField_3Label = uilabel(app.GridLayout7);
            app.MstartAmEditField_3Label.Layout.Row = 2;
            app.MstartAmEditField_3Label.Layout.Column = 2;
            app.MstartAmEditField_3Label.Text = 'Mstart [A/m]';

            % Create MstartAmEditField_3
            app.MstartAmEditField_3 = uieditfield(app.GridLayout7, 'numeric');
            app.MstartAmEditField_3.ValueDisplayFormat = '%.6g';
            app.MstartAmEditField_3.ValueChangedFcn = createCallbackFcn(app, @HarmonicsValueChanged, true);
            app.MstartAmEditField_3.Layout.Row = 2;
            app.MstartAmEditField_3.Layout.Column = 3;

            % Create HstartAmEditField_3Label
            app.HstartAmEditField_3Label = uilabel(app.GridLayout7);
            app.HstartAmEditField_3Label.Layout.Row = 3;
            app.HstartAmEditField_3Label.Layout.Column = 2;
            app.HstartAmEditField_3Label.Text = 'Hstart [A/m]';

            % Create HstartAmEditField_3
            app.HstartAmEditField_3 = uieditfield(app.GridLayout7, 'numeric');
            app.HstartAmEditField_3.ValueDisplayFormat = '%.6g';
            app.HstartAmEditField_3.ValueChangedFcn = createCallbackFcn(app, @HarmonicsValueChanged, true);
            app.HstartAmEditField_3.Layout.Row = 3;
            app.HstartAmEditField_3.Layout.Column = 3;

            % Create UITable2
            app.UITable2 = uitable(app.GridLayout7);
            app.UITable2.ColumnName = {'Order'; 'Amplitude [A/m]'; 'Phase [deg]'};
            app.UITable2.RowName = {};
            app.UITable2.ColumnSortable = [true false false];
            app.UITable2.SelectionType = 'column';
            app.UITable2.ColumnEditable = [true true true];
            app.UITable2.CellEditCallback = createCallbackFcn(app, @HarmonicsTableCellEdit, true);
            app.UITable2.Multiselect = 'off';
            app.UITable2.Layout.Row = [7 10];
            app.UITable2.Layout.Column = [1 4];

            % Create Htsum_kA_ksinkomegatphi_kLabel
            app.Htsum_kA_ksinkomegatphi_kLabel = uilabel(app.GridLayout7);
            app.Htsum_kA_ksinkomegatphi_kLabel.Layout.Row = 6;
            app.Htsum_kA_ksinkomegatphi_kLabel.Layout.Column = [1 3];
            app.Htsum_kA_ksinkomegatphi_kLabel.Text = 'H(t) = sum_k[A_k*sin(k*omega*t + phi_k)]';

            % Create DistortedmajorloopwithharmoniccomponentsLabel
            app.DistortedmajorloopwithharmoniccomponentsLabel = uilabel(app.GridLayout7);
            app.DistortedmajorloopwithharmoniccomponentsLabel.FontWeight = 'bold';
            app.DistortedmajorloopwithharmoniccomponentsLabel.Layout.Row = 5;
            app.DistortedmajorloopwithharmoniccomponentsLabel.Layout.Column = [1 3];
            app.DistortedmajorloopwithharmoniccomponentsLabel.Text = 'Distorted major loop with harmonic components';

            % Create JilesAthertonrateindependentmodelLabel
            app.JilesAthertonrateindependentmodelLabel = uilabel(app.GridLayout3);
            app.JilesAthertonrateindependentmodelLabel.FontWeight = 'bold';
            app.JilesAthertonrateindependentmodelLabel.Layout.Row = 1;
            app.JilesAthertonrateindependentmodelLabel.Layout.Column = [1 4];
            app.JilesAthertonrateindependentmodelLabel.Text = 'Jiles-Atherton rate-independent model';

            % Create ModelparametersLabel_2
            app.ModelparametersLabel_2 = uilabel(app.GridLayout3);
            app.ModelparametersLabel_2.FontWeight = 'bold';
            app.ModelparametersLabel_2.Layout.Row = 2;
            app.ModelparametersLabel_2.Layout.Column = [1 2];
            app.ModelparametersLabel_2.Text = 'Model parameters';

            % Create Ms_JA_PlaygroundLabel
            app.Ms_JA_PlaygroundLabel = uilabel(app.GridLayout3);
            app.Ms_JA_PlaygroundLabel.Layout.Row = 3;
            app.Ms_JA_PlaygroundLabel.Layout.Column = 1;
            app.Ms_JA_PlaygroundLabel.Text = 'Ms [A/m]';

            % Create Ms_JA_Playground
            app.Ms_JA_Playground = uieditfield(app.GridLayout3, 'numeric');
            app.Ms_JA_Playground.ValueDisplayFormat = '%.5e';
            app.Ms_JA_Playground.AllowEmpty = 'on';
            app.Ms_JA_Playground.ValueChangedFcn = createCallbackFcn(app, @JAParamsPlaygroundValueChanged, true);
            app.Ms_JA_Playground.Layout.Row = 3;
            app.Ms_JA_Playground.Layout.Column = 2;
            app.Ms_JA_Playground.Value = [];

            % Create a_JA_PlaygroundLabel
            app.a_JA_PlaygroundLabel = uilabel(app.GridLayout3);
            app.a_JA_PlaygroundLabel.Layout.Row = 4;
            app.a_JA_PlaygroundLabel.Layout.Column = 1;
            app.a_JA_PlaygroundLabel.Text = 'a [A/m]';

            % Create a_JA_Playground
            app.a_JA_Playground = uieditfield(app.GridLayout3, 'numeric');
            app.a_JA_Playground.ValueDisplayFormat = '%.6g';
            app.a_JA_Playground.AllowEmpty = 'on';
            app.a_JA_Playground.ValueChangedFcn = createCallbackFcn(app, @JAParamsPlaygroundValueChanged, true);
            app.a_JA_Playground.Layout.Row = 4;
            app.a_JA_Playground.Layout.Column = 2;
            app.a_JA_Playground.Value = [];

            % Create alpha_JA_PlaygroundLabel
            app.alpha_JA_PlaygroundLabel = uilabel(app.GridLayout3);
            app.alpha_JA_PlaygroundLabel.Layout.Row = 5;
            app.alpha_JA_PlaygroundLabel.Layout.Column = 1;
            app.alpha_JA_PlaygroundLabel.Text = 'α';

            % Create alpha_JA_Playground
            app.alpha_JA_Playground = uieditfield(app.GridLayout3, 'numeric');
            app.alpha_JA_Playground.ValueDisplayFormat = '%.5e';
            app.alpha_JA_Playground.AllowEmpty = 'on';
            app.alpha_JA_Playground.ValueChangedFcn = createCallbackFcn(app, @JAParamsPlaygroundValueChanged, true);
            app.alpha_JA_Playground.Layout.Row = 5;
            app.alpha_JA_Playground.Layout.Column = 2;
            app.alpha_JA_Playground.Value = [];

            % Create c_JA_PlaygroundLabel
            app.c_JA_PlaygroundLabel = uilabel(app.GridLayout3);
            app.c_JA_PlaygroundLabel.Layout.Row = 6;
            app.c_JA_PlaygroundLabel.Layout.Column = 1;
            app.c_JA_PlaygroundLabel.Text = 'c';

            % Create c_JA_Playground
            app.c_JA_Playground = uieditfield(app.GridLayout3, 'numeric');
            app.c_JA_Playground.ValueDisplayFormat = '%.6g';
            app.c_JA_Playground.AllowEmpty = 'on';
            app.c_JA_Playground.ValueChangedFcn = createCallbackFcn(app, @JAParamsPlaygroundValueChanged, true);
            app.c_JA_Playground.Layout.Row = 6;
            app.c_JA_Playground.Layout.Column = 2;
            app.c_JA_Playground.Value = [];

            % Create k_JA_PlaygroundLabel
            app.k_JA_PlaygroundLabel = uilabel(app.GridLayout3);
            app.k_JA_PlaygroundLabel.Layout.Row = 7;
            app.k_JA_PlaygroundLabel.Layout.Column = 1;
            app.k_JA_PlaygroundLabel.Text = 'k [A/m]';

            % Create k_JA_Playground
            app.k_JA_Playground = uieditfield(app.GridLayout3, 'numeric');
            app.k_JA_Playground.ValueDisplayFormat = '%.6g';
            app.k_JA_Playground.AllowEmpty = 'on';
            app.k_JA_Playground.ValueChangedFcn = createCallbackFcn(app, @JAParamsPlaygroundValueChanged, true);
            app.k_JA_Playground.Layout.Row = 7;
            app.k_JA_Playground.Layout.Column = 2;
            app.k_JA_Playground.Value = [];

            % Create RetrieveparametersButton
            app.RetrieveparametersButton = uibutton(app.GridLayout3, 'push');
            app.RetrieveparametersButton.ButtonPushedFcn = createCallbackFcn(app, @RetrieveparametersButtonPushed, true);
            app.RetrieveparametersButton.Layout.Row = 8;
            app.RetrieveparametersButton.Layout.Column = [1 2];
            app.RetrieveparametersButton.Text = 'Retrieve parameters';

            % Create DrivingfieldLabel_2
            app.DrivingfieldLabel_2 = uilabel(app.GridLayout3);
            app.DrivingfieldLabel_2.FontWeight = 'bold';
            app.DrivingfieldLabel_2.Layout.Row = 10;
            app.DrivingfieldLabel_2.Layout.Column = 1;
            app.DrivingfieldLabel_2.Text = 'Driving field';

            % Create ShowgridCheckBoxM_4
            app.ShowgridCheckBoxM_4 = uicheckbox(app.GridLayout3);
            app.ShowgridCheckBoxM_4.ValueChangedFcn = createCallbackFcn(app, @ShowgridCheckBoxM_4ValueChanged, true);
            app.ShowgridCheckBoxM_4.Text = 'Data curve';
            app.ShowgridCheckBoxM_4.Layout.Row = 14;
            app.ShowgridCheckBoxM_4.Layout.Column = [11 12];

            % Create HcaseDropDown
            app.HcaseDropDown = uidropdown(app.GridLayout3);
            app.HcaseDropDown.Items = {'Major loop', 'Minor loops', 'Degaussing', 'Major loop with harmonics'};
            app.HcaseDropDown.ValueChangedFcn = createCallbackFcn(app, @HcaseDropDownValueChanged, true);
            app.HcaseDropDown.Layout.Row = 10;
            app.HcaseDropDown.Layout.Column = [2 3];
            app.HcaseDropDown.Value = 'Major loop';

            % Create ShowgridCheckBoxM_5
            app.ShowgridCheckBoxM_5 = uicheckbox(app.GridLayout3);
            app.ShowgridCheckBoxM_5.ValueChangedFcn = createCallbackFcn(app, @ShowgridCheckBoxM_5ValueChanged, true);
            app.ShowgridCheckBoxM_5.Text = 'Grid';
            app.ShowgridCheckBoxM_5.Layout.Row = 14;
            app.ShowgridCheckBoxM_5.Layout.Column = 10;
            app.ShowgridCheckBoxM_5.Value = true;

            % Create CalculatePlotButton_3
            app.CalculatePlotButton_3 = uibutton(app.GridLayout3, 'push');
            app.CalculatePlotButton_3.ButtonPushedFcn = createCallbackFcn(app, @CalculatePlotButton_3Pushed, true);
            app.CalculatePlotButton_3.WordWrap = 'on';
            app.CalculatePlotButton_3.Layout.Row = 14;
            app.CalculatePlotButton_3.Layout.Column = [13 14];
            app.CalculatePlotButton_3.Text = 'Calculate & Plot';

            % Create HorizontalaxisfieldDropDown_2Label
            app.HorizontalaxisfieldDropDown_2Label = uilabel(app.GridLayout3);
            app.HorizontalaxisfieldDropDown_2Label.FontWeight = 'bold';
            app.HorizontalaxisfieldDropDown_2Label.Layout.Row = 1;
            app.HorizontalaxisfieldDropDown_2Label.Layout.Column = [10 11];
            app.HorizontalaxisfieldDropDown_2Label.Text = 'Horizontal axis field';

            % Create HorizontalaxisfieldDropDown_2
            app.HorizontalaxisfieldDropDown_2 = uidropdown(app.GridLayout3);
            app.HorizontalaxisfieldDropDown_2.Items = {'H [A/m]', 'H [kA/m]', 'H [Oe]', 'H [kOe]', 'Bext [T]', 'Bext [G]', 'Bext [kG]'};
            app.HorizontalaxisfieldDropDown_2.ValueChangedFcn = createCallbackFcn(app, @HorizontalaxisfieldDropDown_2ValueChanged, true);
            app.HorizontalaxisfieldDropDown_2.Layout.Row = 2;
            app.HorizontalaxisfieldDropDown_2.Layout.Column = [10 11];
            app.HorizontalaxisfieldDropDown_2.Value = 'H [A/m]';

            % Create VerticalaxisfieldDropDown_2Label
            app.VerticalaxisfieldDropDown_2Label = uilabel(app.GridLayout3);
            app.VerticalaxisfieldDropDown_2Label.FontWeight = 'bold';
            app.VerticalaxisfieldDropDown_2Label.Layout.Row = 1;
            app.VerticalaxisfieldDropDown_2Label.Layout.Column = [13 14];
            app.VerticalaxisfieldDropDown_2Label.Text = 'Vertical axis field';

            % Create VerticalaxisfieldDropDown_2
            app.VerticalaxisfieldDropDown_2 = uidropdown(app.GridLayout3);
            app.VerticalaxisfieldDropDown_2.Items = {'M [A/m]', 'M [kA/m]', 'M [MA/m]', 'M [emu/cm^3]', 'J [T]', 'B [T]', 'B [G]', 'B [kG]'};
            app.VerticalaxisfieldDropDown_2.ValueChangedFcn = createCallbackFcn(app, @VerticalaxisfieldDropDown_2ValueChanged, true);
            app.VerticalaxisfieldDropDown_2.Layout.Row = 2;
            app.VerticalaxisfieldDropDown_2.Layout.Column = [13 14];
            app.VerticalaxisfieldDropDown_2.Value = 'M [A/m]';

            % Create MessagesTabPanel
            app.MessagesTabPanel = uitabgroup(app.AppGridLayout);
            app.MessagesTabPanel.Layout.Row = 2;
            app.MessagesTabPanel.Layout.Column = 1;

            % Create ActivitylogTab
            app.ActivitylogTab = uitab(app.MessagesTabPanel);
            app.ActivitylogTab.Title = 'Activity log';

            % Create MessagesGridLayout
            app.MessagesGridLayout = uigridlayout(app.ActivitylogTab);
            app.MessagesGridLayout.ColumnWidth = {'1x'};
            app.MessagesGridLayout.RowHeight = {'1x'};

            % Create MessagesTextArea
            app.MessagesTextArea = uitextarea(app.MessagesGridLayout);
            app.MessagesTextArea.Editable = 'off';
            app.MessagesTextArea.Layout.Row = 1;
            app.MessagesTextArea.Layout.Column = 1;

            % Create ContextMenu
            app.ContextMenu = uicontextmenu(app.MagAnalystUIFigure);

            % Create Menu
            app.Menu = uimenu(app.ContextMenu);
            app.Menu.Text = 'Menu';

            % Create Menu2
            app.Menu2 = uimenu(app.ContextMenu);
            app.Menu2.Text = 'Menu2';

            % Show the figure after all components are created
            app.MagAnalystUIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = app_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.MagAnalystUIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.MagAnalystUIFigure)
        end
    end
end