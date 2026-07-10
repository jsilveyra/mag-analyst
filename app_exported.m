classdef app_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        MagAnalystUIFigure              matlab.ui.Figure
        ProjectMenu                     matlab.ui.container.Menu
        OpenMenu                        matlab.ui.container.Menu
        SaveMenu                        matlab.ui.container.Menu
        SaveasMenu                      matlab.ui.container.Menu
        AppGridLayout                   matlab.ui.container.GridLayout
        MessagesTabPanel                matlab.ui.container.TabGroup
        ActivitylogTab                  matlab.ui.container.Tab
        MessagesGridLayout              matlab.ui.container.GridLayout
        MessagesTextArea                matlab.ui.control.TextArea
        TabGroup                        matlab.ui.container.TabGroup
        InputdataTab                    matlab.ui.container.Tab
        GridLayoutMagnetizationInputData  matlab.ui.container.GridLayout
        GridLayoutInputPlot             matlab.ui.container.GridLayout
        GridLayoutInputTipsAndPlotButton  matlab.ui.container.GridLayout
        GridLayoutTips_3                matlab.ui.container.GridLayout
        InputNumberofPointsLabel        matlab.ui.control.Label
        InputNumberofPointsEditField    matlab.ui.control.NumericEditField
        GridLayoutTips_2                matlab.ui.container.GridLayout
        AxisscaleLabel                  matlab.ui.control.Label
        InputAxisScaleDropDown          matlab.ui.control.DropDown
        GridLayoutTips                  matlab.ui.container.GridLayout
        MtipAmLabel                     matlab.ui.control.Label
        MTipField                       matlab.ui.control.NumericEditField
        HtipAmLabel                     matlab.ui.control.Label
        HTipField                       matlab.ui.control.NumericEditField
        GridLayoutInputPlots            matlab.ui.container.GridLayout
        AxesRawInputData                matlab.ui.control.UIAxes
        AxesProcessedInputData          matlab.ui.control.UIAxes
        GridLayoutInputAxisScale        matlab.ui.container.GridLayout
        GridLayoutInput                 matlab.ui.container.GridLayout
        GridLayoutDatasetPath           matlab.ui.container.GridLayout
        InputDatasetPath                matlab.ui.control.EditField
        InputBrowseButton               matlab.ui.control.Button
        InputDatasetpathLabel           matlab.ui.control.Label
        DescriptionLabel                matlab.ui.control.Label
        GridLayout                      matlab.ui.container.GridLayout
        DescriptionTextArea             matlab.ui.control.TextArea
        GridLayoutInputCurve            matlab.ui.container.GridLayout
        CurveDropDown                   matlab.ui.control.DropDown
        CurveDropDownLabel              matlab.ui.control.Label
        GridLayoutInputVerticalAxis     matlab.ui.container.GridLayout
        VerticalaxisfieldDropDown       matlab.ui.control.DropDown
        VerticalaxisfieldDropDownLabel  matlab.ui.control.Label
        GridLayoutInputHorizontalAxis   matlab.ui.container.GridLayout
        HorizontalaxisfieldDropDown     matlab.ui.control.DropDown
        HorizontalaxisfieldDropDownLabel  matlab.ui.control.Label
        AnhystereticfittingTab          matlab.ui.container.Tab
        AnhystereticmagnetizationfittingTabGridLayout  matlab.ui.container.GridLayout
        GridLayoutNumbers               matlab.ui.container.GridLayout
        FittingparametersLabel          matlab.ui.control.Label
        GridLayoutModeledCurve          matlab.ui.container.GridLayout
        SetcolorsButton                 matlab.ui.control.Button
        PointSpaceDropDown              matlab.ui.control.DropDown
        NofpointsEditField              matlab.ui.control.NumericEditField
        NofpointsLabel                  matlab.ui.control.Label
        NofcompSpinner                  matlab.ui.control.Spinner
        NofcompLabel                    matlab.ui.control.Label
        ModeledcurveLabel               matlab.ui.control.Label
        TableQuantities                 matlab.ui.control.Table
        GridLayoutOtherQuantities       matlab.ui.container.GridLayout
        JsTLabel                        matlab.ui.control.Label
        chiinLabel                      matlab.ui.control.Label
        JsField                         matlab.ui.control.NumericEditField
        chiinField                      matlab.ui.control.NumericEditField
        CalculatedquantitiesLabel       matlab.ui.control.Label
        GridLayoutButtons               matlab.ui.container.GridLayout
        StopfitButton                   matlab.ui.control.Button
        ErrorDisplay                    matlab.ui.control.NumericEditField
        ErrorDropDown                   matlab.ui.control.DropDown
        ErrorDropDownLabel              matlab.ui.control.Label
        CalculatePlotButton             matlab.ui.control.Button
        FitButton                       matlab.ui.control.Button
        TableParameters                 matlab.ui.control.Table
        ModelparametersLabel_3          matlab.ui.control.Label
        TableFittedParameters           matlab.ui.control.Table
        GridLayoutAxes                  matlab.ui.container.GridLayout
        GridLayoutOptionsHdMdH          matlab.ui.container.GridLayout
        ShowhcrCheckBoxHdMdH            matlab.ui.control.CheckBox
        AxisScaleDropDownHdMdH          matlab.ui.control.DropDown
        ShowgridCheckBoxHdMdH           matlab.ui.control.CheckBox
        PlotcomponentsCheckBoxHdMdH     matlab.ui.control.CheckBox
        ResidualplotButtondHdMdH        matlab.ui.control.Button
        GridLayoutOptionsdMdH           matlab.ui.container.GridLayout
        ShowhcrCheckBoxdMdH             matlab.ui.control.CheckBox
        AxisScaleDropDowndMdH           matlab.ui.control.DropDown
        ShowgridCheckBoxdMdH            matlab.ui.control.CheckBox
        PlotcomponentsCheckBoxdMdH      matlab.ui.control.CheckBox
        ResidualplotButtondMdH          matlab.ui.control.Button
        GridLayoutOptionsM              matlab.ui.container.GridLayout
        ShowhcrCheckBoxM                matlab.ui.control.CheckBox
        AxisScaleDropDownM              matlab.ui.control.DropDown
        ShowgridCheckBoxM               matlab.ui.control.CheckBox
        PlotcomponentsCheckBoxM         matlab.ui.control.CheckBox
        ResidualplotButtonM             matlab.ui.control.Button
        AxesHdMdH                       matlab.ui.control.UIAxes
        AxesdMdH                        matlab.ui.control.UIAxes
        AxesM                           matlab.ui.control.UIAxes
        HystereticfittingTab            matlab.ui.container.Tab
        GridLayout8                     matlab.ui.container.GridLayout
        FittingconditionsLabel          matlab.ui.control.Label
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
        StopfitButton_2                 matlab.ui.control.Button
        kConstrainedCheckBox_2          matlab.ui.control.CheckBox
        Label                           matlab.ui.control.Label
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
        JsTEditFieldLabel_8             matlab.ui.control.Label
        Htip                            matlab.ui.control.NumericEditField
        ResidualplotButtondMdH_2        matlab.ui.control.Button
        ShowgridCheckBoxM_2             matlab.ui.control.CheckBox
        JsTEditFieldLabel_7             matlab.ui.control.Label
        ErrorDisplay_2                  matlab.ui.control.NumericEditField
        TippointdataLabel               matlab.ui.control.Label
        RetrieveseedsButton             matlab.ui.control.Button
        ErrortominimizeDropDown_2       matlab.ui.control.DropDown
        ErrortominimizeDropDownLabel_2  matlab.ui.control.Label
        k_JA                            matlab.ui.control.NumericEditField
        CalculatePlotButton_2           matlab.ui.control.Button
        FitButton_2                     matlab.ui.control.Button
        c_JA                            matlab.ui.control.NumericEditField
        JsTEditFieldLabel_6             matlab.ui.control.Label
        alpha_JA                        matlab.ui.control.NumericEditField
        JsTEditFieldLabel_5             matlab.ui.control.Label
        a_JA                            matlab.ui.control.NumericEditField
        JsTEditFieldLabel_4             matlab.ui.control.Label
        Ms_JA                           matlab.ui.control.NumericEditField
        JsTEditFieldLabel_3             matlab.ui.control.Label
        JsTEditFieldLabel_2             matlab.ui.control.Label
        ModelparametersLabel            matlab.ui.control.Label
        JilesAthertonmodelrateindependentLabel  matlab.ui.control.Label
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
        JsField_13                      matlab.ui.control.NumericEditField
        JsTEditFieldLabel_13            matlab.ui.control.Label
        JsField_12                      matlab.ui.control.NumericEditField
        JsTEditFieldLabel_12            matlab.ui.control.Label
        JsField_11                      matlab.ui.control.NumericEditField
        JsTEditFieldLabel_11            matlab.ui.control.Label
        JsField_10                      matlab.ui.control.NumericEditField
        JsTEditFieldLabel_10            matlab.ui.control.Label
        JsField_9                       matlab.ui.control.NumericEditField
        JsTEditFieldLabel_9             matlab.ui.control.Label
        ModelparametersLabel_2          matlab.ui.control.Label
        JilesAthertonmodelrateindependentLabel_2  matlab.ui.control.Label
        MinorloopPanel                  matlab.ui.container.Panel
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
        MajorloopwithharmonicsPanel     matlab.ui.container.Panel
        GridLayout7                     matlab.ui.container.GridLayout
        HarmoniccompHtsum_kA_ksinkomegatphi_kLabel  matlab.ui.control.Label
        UITable2                        matlab.ui.control.Table
        PlotDropDown_3                  matlab.ui.control.DropDown
        PlotDropDown_3Label             matlab.ui.control.Label
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
        AxesM_5                         matlab.ui.control.UIAxes
        OutputdataTab                   matlab.ui.container.Tab
        GridLayoutMagnetizationoutputdata  matlab.ui.container.GridLayout
        GridLayoutExperimentalMagnetizationData  matlab.ui.container.GridLayout
        DropDownOutputExperimentalMagnetizationData  matlab.ui.control.DropDown
        EditFieldFileNameExperimentalMagnetizationData  matlab.ui.control.EditField
        ExperimentalanhystereticmagnetizationLabel  matlab.ui.control.Label
        CheckBoxExperimentalMagnetization  matlab.ui.control.CheckBox
        GridLayoutExportResiduesButton  matlab.ui.container.GridLayout
        ExportResiduesButton            matlab.ui.control.Button
        GridLayoutExportResiduesSemiLogMagDerivative  matlab.ui.container.GridLayout
        DropDownResiduesSemiLogMagDerivativeExtension  matlab.ui.control.DropDown
        EditFieldFileNameResiduesSemiLogMagDerivative  matlab.ui.control.EditField
        CheckBoxExportResiduesSemiLogMagDerivative  matlab.ui.control.CheckBox
        SemilogmagnetizationderivativeResiduesExportLabel  matlab.ui.control.Label
        GridLayoutExportResiduesSusceptibility  matlab.ui.container.GridLayout
        DropDownResiduesSusceptibilityExtension  matlab.ui.control.DropDown
        EditFieldFileNameResiduesSusceptibility  matlab.ui.control.EditField
        CheckBoxExportResiduesSusceptibility  matlab.ui.control.CheckBox
        SusceptibilityResiduesExportLabel  matlab.ui.control.Label
        ResidualplotsdataLabel          matlab.ui.control.Label
        GridLayoutExportResiduesMagnetization  matlab.ui.container.GridLayout
        DropDownResiduesMagnetizacionExtension  matlab.ui.control.DropDown
        EditFieldFileNameResiduesMagnetization  matlab.ui.control.EditField
        CheckBoxExportResiduesMagnetization  matlab.ui.control.CheckBox
        MagnetizationExportResiduesLabel  matlab.ui.control.Label
        GridLayoutExportPlotsButton     matlab.ui.container.GridLayout
        ExportPlotsButton               matlab.ui.control.Button
        GridLayoutExportPlotSemiLogMagDerivative  matlab.ui.container.GridLayout
        DropDownPlotSemiLogMagDerivativeExtension  matlab.ui.control.DropDown
        EditFieldFileNamePlotSemiLogMagDerivative  matlab.ui.control.EditField
        CheckBoxExportPlotSemiLogMagDerivative  matlab.ui.control.CheckBox
        SemilogmagnetizationderivativePlotExportLabel  matlab.ui.control.Label
        GridLayoutExportPlotSusceptibility  matlab.ui.container.GridLayout
        DropDownPlotSusceptibilityExtension  matlab.ui.control.DropDown
        EditFieldFileNamePlotSusceptibility  matlab.ui.control.EditField
        CheckBoxExportPlotSusceptibility  matlab.ui.control.CheckBox
        SusceptibilityPlotExportLabel   matlab.ui.control.Label
        GridLayoutExportPlotMagnetization  matlab.ui.container.GridLayout
        DropDownPlotMagnetizacionExtension  matlab.ui.control.DropDown
        EditFieldFileNamePlotMagnetization  matlab.ui.control.EditField
        CheckBoxExportPlotMagnetization  matlab.ui.control.CheckBox
        MagnetizationPlotExportLabel    matlab.ui.control.Label
        PlotsLabel                      matlab.ui.control.Label
        GridLayoutExportParametersButton  matlab.ui.container.GridLayout
        ExportErrorsCheckBox            matlab.ui.control.CheckBox
        ExportOtherquantitiesCheckBox   matlab.ui.control.CheckBox
        ExportParametersButton          matlab.ui.control.Button
        GridLayoutExportParametersFile  matlab.ui.container.GridLayout
        ExportModelparametersCheckBox   matlab.ui.control.CheckBox
        ExportFittedparametersCheckBox  matlab.ui.control.CheckBox
        DropDownOutputParametersExtension  matlab.ui.control.DropDown
        EditFieldFileNameParameters     matlab.ui.control.EditField
        ParametersLabel                 matlab.ui.control.Label
        GridLayoutExportData            matlab.ui.container.GridLayout
        ModeledanhystereticmagnetizationcomponentsLabel  matlab.ui.control.Label
        OutputSeparateComponentsCheckBox  matlab.ui.control.CheckBox
        ExportdataButton                matlab.ui.control.Button
        GridLayoutMagnetizationDataFittedAnhystereticMagnetization  matlab.ui.container.GridLayout
        DropDownOutputModeledAnhystereticMagnetizationExtension  matlab.ui.control.DropDown
        EditFieldFileNameModeledAnhystereticMagnetization  matlab.ui.control.EditField
        ModeledanhystereticmagnetizationLabel  matlab.ui.control.Label
        CheckBoxOutputMagnetizationDataFittedAnhystereticMagnetization  matlab.ui.control.CheckBox
        MagnetizationdataLabel          matlab.ui.control.Label
        GridLayoutOutputDatasetPath     matlab.ui.container.GridLayout
        OutputBrowseButton              matlab.ui.control.Button
        OutputDatasetPath               matlab.ui.control.EditField
        OutputDatasetpathLabel          matlab.ui.control.Label
        ContextMenu                     matlab.ui.container.ContextMenu
        Menu                            matlab.ui.container.Menu
        Menu2                           matlab.ui.container.Menu
    end

    
    properties (Access = public)
        AppRoot string                % MOD: root folder of the app
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
        minor_loop_table_user_edited logical = false   % MOD: true once the user manually edits the Htip_i table
        degaussing_user_edited logical = false          % MOD: true once the user edits any Degaussing amplitude field/table
        harmonics_user_edited logical = false           % MOD: true once the user edits any harmonic drive field/table
        hysteretic_ms_lower_bound_user_edited logical = false   % MOD: true once the user edits the Ms lower bound; stops auto-filling it from Mtip
        number_components
        lb
        ub
        select_fit
        Colors
        ColorDialogApp
        ProjectPath
        fitted_parameter_values
        component_row_types
        data_curve
        stop_fit_requested logical = false   % set by "Stop fit" buttons to abort a running fit
        last_import_folder string = ""   % MOD: remembers the last folder browsed for a dataset this session
    end
    
    methods (Access = public)
        %% =====================================================
        %  Safe file & folder helpers (cancel-safe, portable)
        %  =====================================================
        %  MOD: New helpers to centralize file dialogs and paths

        function fullpath = safe_getfile(app, filter, startpath, dialog_title) % MOD
            fullpath = FileDialogUtils.safe_getfile(app, filter, startpath, dialog_title);
        end

        function fullpath = safe_putfile(app, filter, startpath, dialog_title, default_name) % MOD
            fullpath = FileDialogUtils.safe_putfile(app, filter, startpath, dialog_title, default_name);
        end

        function folder = safe_getdir(app, startpath, dialog_title) % MOD
            folder = FileDialogUtils.safe_getdir(app, startpath, dialog_title);
        end

        function folder = default_data_folder(app) % MOD
            folder = FileDialogUtils.default_data_folder(app);
        end

        function folder = default_import_folder(app) % MOD
            folder = FileDialogUtils.default_import_folder(app);
        end

        function ensure_folder(app, folder) % MOD
            FileDialogUtils.ensure_folder(app, folder);
        end

        function write_dataset_not_found_message(app, path) % MOD
            FileDialogUtils.write_dataset_not_found_message(app, path);
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
        
        function stop = fit_stop_output_fcn(app, ~, ~, ~)
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

        function apply_axis_scale(app, ax, selection)
            selection = string(selection);
            if app.axis_scale_has_x(selection)
                ax.XScale = 'log';
            else
                ax.XScale = 'linear';
            end
            if app.axis_scale_has_y(selection)
                ax.YScale = 'log';
            else
                ax.YScale = 'linear';
            end
        end

        function has_x = axis_scale_has_x(~, selection)
            selection = string(selection);
            has_x = selection == "semilog-x" || selection == "log-log";
        end

        function has_y = axis_scale_has_y(~, selection)
            selection = string(selection);
            has_y = selection == "semilog-y" || selection == "log-log";
        end
        
        function init_parameters_table(app, default_values)
            AnhystereticUtils.init_parameters_table(app, default_values);
        end

        function init_quantities_table(app, default_values)
            AnhystereticUtils.init_quantities_table(app, default_values);
        end

        function ret = format_short(~, v)
            string_value = char(sprintf("%0.4f",v));
            aux = regexp(string_value,'\.','split');
            aux{1} = fliplr(regexprep(fliplr(aux{1}),'\d{3}(?=\d)', '$0,'));
            ret = [aux{1},'.',aux{2}];
        end

        function ret = format_long(~, v)
            string_value = char(sprintf("%0.10f",v));
            aux = regexp(string_value,'\.','split');
            aux{1} = fliplr(regexprep(fliplr(aux{1}),'\d{3}(?=\d)', '$0,'));
            ret = [aux{1},'.',aux{2}];
        end

        function ret = format_engineering(~, v)
            ret = char(sprintf("%0.4e",v));
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

        function ret = format_thousands_only(~, v)
            string_value = char(sprintf("%d",round(v)));
            ret = fliplr(regexprep(fliplr(string_value),'\d{3}(?=\d)', '$0,'));
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
        
        function results = get_time_string(~)
            results = string(datetime(datetime, 'Format', 'yy/MM/dd HH:mm:ss'));
        end
        
        function write_message(app, message)
            msg = sprintf("[%s] %s", app.get_time_string(), message);
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

        function [H_left, M_left] = extract_left_branch_uniform_arc(~, H_in, M_in, number_points)
            % MagAnalyst already relies on this branch implicitly:
            % the anhysteretic curve is built from averaging left and right
            % hysteresis branches, so robust left-branch extraction here
            % directly improves that downstream anhysteretic construction.
            H = H_in(:)';
            M = M_in(:)';
            valid = isfinite(H) & isfinite(M);
            H = H(valid);
            M = M(valid);

            if numel(H) < 2
                H_left = H;
                M_left = M;
                return;
            end

            [~, H_min_index] = min(H);
            H_sorted = [H(H_min_index:end) H(1:H_min_index)];
            M_sorted = [M(H_min_index:end) M(1:H_min_index)];

            denom_H = max(H_sorted.^2);
            denom_M = max(M_sorted.^2);
            if denom_H == 0
                denom_H = 1;
            end
            if denom_M == 0
                denom_M = 1;
            end

            H2M2 = sign(H_sorted).*(H_sorted).^2./denom_H + sign(M_sorted).*(M_sorted).^2./denom_M;
            [~, max_index] = max(H2M2);
            H_left_raw = H_sorted(max_index:end);
            M_left_raw = M_sorted(max_index:end);

            if nargin < 4 || isempty(number_points) || number_points < 2
                number_points = numel(H_left_raw);
            end

            ds = hypot(diff(H_left_raw), diff(M_left_raw));
            s = [0 cumsum(ds)];
            [s_unique, idx_unique] = unique(s, 'stable');

            if numel(s_unique) < 2
                H_left = H_left_raw;
                M_left = M_left_raw;
                return;
            end

            H_unique = H_left_raw(idx_unique);
            M_unique = M_left_raw(idx_unique);
            s_query = linspace(s_unique(1), s_unique(end), round(number_points));
            H_left = interp1(s_unique, H_unique, s_query, 'linear');
            M_left = interp1(s_unique, M_unique, s_query, 'linear');
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

        function export_residual(app, residue, file_name)
            AnhystereticUtils.export_residual(app, residue, file_name);
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

        % =====================================================
        %  Degaussing (Playground) — MOD: new subsystem
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
        %  Major loop with harmonics (Playground) — MOD: new subsystem
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

        function a = calculate_and_plot(app)
            a = AnhystereticUtils.calculate_and_plot(app);
        end
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            % MOD (refactored). Startup function

            % Determine application root
            app.AppRoot = string(fileparts(mfilename('fullpath')));
        
            % Add src folder (portable)
            src_folder = fullfile(app.AppRoot, "src");
            if isfolder(src_folder)
                addpath(genpath(char(src_folder)));
            end

            % import_src(); %Legacy: genpath makes this line redundant
            
            app.ProjectPath = "";
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
            app.apply_detailed_grid(app.AxesM, app.ShowgridCheckBoxM.Value == 1);   % MOD: grid checkbox defaults to checked but was never applied until Calculate&Plot
            app.apply_detailed_grid(app.AxesdMdH, app.ShowgridCheckBoxdMdH.Value == 1);   % MOD: grid checkbox defaults to checked but was never applied until Calculate&Plot
            app.apply_detailed_grid(app.AxesHdMdH, app.ShowgridCheckBoxHdMdH.Value == 1);   % MOD: grid checkbox defaults to checked but was never applied until Calculate&Plot
            app.apply_detailed_grid(app.AxesM_2, app.ShowgridCheckBoxM_2.Value == 1);   % MOD: grid checkbox defaults to checked but was never applied until Calculate&Plot
            PlaygroundUtils.clear_simulation(app);
            PlaygroundUtils.sync_major_ui(app);
            PlaygroundUtils.sync_minor_ui(app);   % MOD: grey minor-loop stop-criterion fields+labels
            app.sync_playground_mode_ui();
            app.sync_degaussing_ui();   % MOD: ADD this line
            app.apply_detailed_grid(app.AxesM_5, app.ShowgridCheckBoxM_5.Value == 1);   % MOD: grid checkbox defaults to checked but was never applied until Calculate&Plot
            app.sync_harmonics_ui();

            % MOD: note the convergence-mode repetition cap in the Rel. tolerance
            % labels (the solver still stops after Max. repetitions loops even
            % in "Until convergence" mode).
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
        
            % Default output folder
            out_folder = app.default_data_folder();
            app.ensure_folder(out_folder);
            app.OutputDatasetPath.Value = char(out_folder);
        
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

        % Callback function
        function logCheckBoxMValueChanged(app, event)
            app.plot_M()
        end

        % Callback function
        function logCheckBoxdMdHValueChanged(app, event)
            app.plot_dMdH()
        end

        % Callback function
        function logCheckBoxHdMdHValueChanged(app, event)
            app.plot_HdMdH()
        end

        % Value changed function: NofcompSpinner
        function NofcompSpinnerValueChanged(app, event)
            app.number_components = app.NofcompSpinner.Value;
            app.init_components();
            app.configure_minor_loop_table();
        end

        % Button pushed function: InputBrowseButton
        function InputBrowseButtonPushed(app, event)
            % MOD: Callback modified for safe file handling
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
            catch e
                app.write_message("Import failed: " + e.message);
            end
        end

        % Callback function
        function logCheckBoxInputPlotValueChanged(app, event)
            if app.InputDatasetPath.Value == ""
                return
            end
            app.plot_input()
        end

        % Button pushed function: ResidualplotButtonM
        function ResidualplotButtonMPushed(app, event)
            residue_calculator = MagnetizationResidueCalculator(app.data_curve, app.modeled_curve);
            residue = residue_calculator.get_residue();
            log_flag = app.axis_scale_has_x(string(app.AxisScaleDropDownM.Value));
            residue_plotter = ResiduePlotter(app.data_curve.H, app.data_curve.M, app.modeled_curve.H, app.modeled_curve.M, residue, log_flag, "M [A/m]", 5, [0 0 0], app.Colors(1,:), app.Colors(1,:));
            residue_plotter.plot()
        end

        % Button pushed function: ResidualplotButtondMdH
        function ResidualplotButtondMdHPushed(app, event)
            residue_calculator = SusceptibilityResidueCalculator(app.data_curve, app.modeled_curve);
            residue = residue_calculator.get_residue();
            log_flag = app.axis_scale_has_x(string(app.AxisScaleDropDowndMdH.Value));
            residue_plotter = ResiduePlotter(app.data_curve.H, app.data_curve.dMdH, app.modeled_curve.H, app.modeled_curve.dMdH, residue, log_flag, "∂M/∂H", 5, [0 0 0], app.Colors(1,:), app.Colors(1,:));
            residue_plotter.plot()
        end

        % Button pushed function: ResidualplotButtondHdMdH
        function ResidualplotButtondHdMdHPushed(app, event)
            residue_calculator = SemilogDerivativeResidueCalculator(app.data_curve, app.modeled_curve);
            residue = residue_calculator.get_residue();
            log_flag = app.axis_scale_has_x(string(app.AxisScaleDropDownHdMdH.Value));
            residue_plotter = ResiduePlotter(app.data_curve.H, app.data_curve.HdMdH, app.modeled_curve.H, app.modeled_curve.HdMdH, residue, log_flag, "∂M/∂(logH) [A/m]", 5, [0 0 0], app.Colors(1,:), app.Colors(1,:));
            residue_plotter.plot()
        end

        % Button pushed function: OutputBrowseButton
        function OutputBrowseButtonPushed(app, event)
            % MOD: Callback modified for safe file handling
            start_folder = string(app.OutputDatasetPath.Value);
            folder = app.safe_getdir(start_folder, ...
                "Select output folder");

            if folder == ""
                return;
            end

            app.ensure_folder(folder);
            app.OutputDatasetPath.Value = char(folder);
        end

        % Button pushed function: ExportdataButton
        function ExportdataButtonPushed(app, event)
            if (app.CheckBoxOutputMagnetizationDataFittedAnhystereticMagnetization.Value == 0 && app.CheckBoxExperimentalMagnetization.Value == 0)
                app.write_message("No magnetization data was selected to be exported.");
                return;
            end
            if (app.CheckBoxOutputMagnetizationDataFittedAnhystereticMagnetization.Value == 1)
                if(app.OutputSeparateComponentsCheckBox.Value == 0)
                    t = table(transpose(app.modeled_curve.H), transpose(app.modeled_curve.M), transpose(app.modeled_curve.dMdH), transpose(app.modeled_curve.HdMdH));
                    t.Properties.VariableNames(:) = {'H [A/m]' 'M [A/m]' 'dM/dH' 'dM/dlogH [A/m]' };
                elseif(app.OutputSeparateComponentsCheckBox.Value == 1)
                    t = table(transpose(app.modeled_curve.H), transpose(app.modeled_curve.M), array2table(transpose(app.modeled_curve.Mi)), transpose(app.modeled_curve.dMdH), array2table(transpose(app.modeled_curve.dMidH)), transpose(app.modeled_curve.HdMdH), array2table(transpose(app.modeled_curve.HdMidH)));
                    t = splitvars(t);
                    variable_names = cell(4 + app.number_components*3, 1);
                    variable_names(1) = {'H [A/m]'};
                    variable_names(2) = {'M [A/m]'};
                    variable_names(app.number_components + 3) = {'dM/dH'};
                    variable_names(2*app.number_components + 4) = {'dM/dlogH [A/m]'};
                    for i=1:app.number_components
                        variable_names(i + 2) = cellstr(strcat('M', string(i), ' [A/m]'));
                        variable_names(i + app.number_components + 3) = cellstr(strcat('dM', string(i), '/dH'));
                        variable_names(i + 2*app.number_components + 4) = cellstr(strcat('dM', string(i), '/dlogH [A/m]'));
                    end
                    t.Properties.VariableNames = variable_names;
                end
                file_name = strcat(app.EditFieldFileNameModeledAnhystereticMagnetization.Value, app.DropDownOutputModeledAnhystereticMagnetizationExtension.Value);
                path = strcat(app.OutputDatasetPath.Value, '\', file_name);
                writetable(t,path, 'Delimiter', ';');
                app.write_message("Modeled data saved as " + file_name);
            end
            %Separate into two functions
            if(app.CheckBoxExperimentalMagnetization.Value == 1)
                t = table(transpose(app.data_curve.H), transpose(app.data_curve.M));
                t.Properties.VariableNames(:) = {'H [A/m]' 'M [A/m]'};
                file_name = strcat(app.EditFieldFileNameExperimentalMagnetizationData.Value, app.DropDownOutputExperimentalMagnetizationData.Value);
                path = strcat(app.OutputDatasetPath.Value, '\', file_name);
                writetable(t,path, 'Delimiter', ';');
                app.write_message("Experimental data saved as " + file_name);
            end
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
            delete(app.ColorDialogApp)
            delete(app)
        end

        % Button pushed function: ExportParametersButton
        function ExportParametersButtonPushed(app, event)
            if(app.ExportFittedparametersCheckBox.Value == 0 && app.ExportModelparametersCheckBox.Value == 0 && app.ExportOtherquantitiesCheckBox.Value == 0 && app.ExportErrorsCheckBox.Value == 0)
                app.write_message("No parameters were selected to be exported");
                return;
            end
            file_name = strcat(app.EditFieldFileNameParameters.Value, app.DropDownOutputParametersExtension.Value);
            path = strcat(app.OutputDatasetPath.Value, '\', file_name);
            file = fopen(path,'w');
            fprintf(file, "Parameters:" + newline);
            if(app.ExportFittedparametersCheckBox.Value == 1)
                fprintf(file, "Fitted Parameters:" + newline);
                for i = 1:height(app.TableFittedParameters.Data)
                    name = string(app.TableFittedParameters.Data(i, 1));
                    name = subscript_to_number(app, name);
                    value = app.fitted_parameter_values(i);
                    s = sprintf("%s: \t%f", name, value);
                    fprintf(file, s + newline);
                end
                fprintf(file, newline);
            end
            if(app.ExportModelparametersCheckBox.Value == 1)
                fprintf(file, "Model-Retrieved Parameters:" + newline);
                for i = 1:height(app.TableParameters.Data)
                    Ms_value = app.magnetic_parameters.Ms(i);
                    alpha_value = app.magnetic_parameters.alpha(i);
                    a_value = app.magnetic_parameters.a(i);
                    s_component = sprintf("Component: %i", i);
                    s_Ms_value = sprintf("    Ms%i [A/m]: \t%0.4f", i, Ms_value);
                    s_alpha_value = sprintf("            α: \t%0.4e", alpha_value);
                    s_a_value = sprintf("     a%i [A/m]: \t%0.4f", i, a_value);
                    fprintf(file, s_component + newline + s_Ms_value + newline + s_alpha_value + newline + s_a_value + newline);
                end
                fprintf(file, newline);
            end
            if(app.ExportOtherquantitiesCheckBox.Value == 1)
            fprintf(file, "Calculated Quantities:" + newline);
                for i = 1:height(app.TableQuantities.Data)
                    alpha_Ms_value = app.magnetic_parameters.dimensionless_alphaMs(i);
                    density_product_value = app.magnetic_parameters.density_product(i);
                    Hk_value = app.magnetic_parameters.Hk(i);
                    chi_in_value = app.magnetic_parameters.chi_in(i);
                    s_component = sprintf("Component: %i", i);
                    s_alpha_Ms_value = sprintf("    α%i|Ms%i|/(3a%i): \t%0.4f", i, i, i, alpha_Ms_value);
                    s_density_product_value = sprintf("    N%ikBT [J/m^3]: \t%0.4f", i, density_product_value);
                    s_Hk = sprintf("        Hk%i [A/m]: \t%0.4f", i, Hk_value);
                    s_chi_in_value = sprintf("            χin%i: \t%i", i, chi_in_value);
                    fprintf(file, s_component + newline + s_alpha_Ms_value + newline + s_density_product_value + newline + s_Hk + newline + s_chi_in_value + newline);
                end
                fprintf(file, newline);
            end

            if (app.ExportErrorsCheckBox.Value == 1)
                diagonal_error = DiagonalErrorCalculator(app.data_curve, app.modeled_curve).get_error();
                horizontal_error = HorizontalErrorCalculator(app.data_curve, app.modeled_curve).get_error();
                vertical_error = VerticalErrorCalculator(app.data_curve, app.modeled_curve).get_error();
                s_diagonal_error = sprintf("  Diagonal error: \t%10.4e", diagonal_error);
                s_horizontal_error = sprintf("Horizontal error: \t%10.4e", horizontal_error);
                s_vertical_error = sprintf("  Vertical error: \t%10.4e", vertical_error);
                s = "Errors:" + newline + s_diagonal_error + newline + s_horizontal_error + newline + s_vertical_error + newline;
                fprintf(file, s + newline);
            end

            fclose(file);
            app.write_message("Parameter data saved as " + file_name);
        end

        % Button pushed function: ExportPlotsButton
        function ExportPlotsButtonPushed(app, event)
            if (app.CheckBoxExportPlotMagnetization.Value == 0 && app.CheckBoxExportPlotSusceptibility.Value == 0 && app.CheckBoxExportPlotSemiLogMagDerivative.Value == 0)
                app.write_message("No plots were selected to be exported");
                return;
            end
            app.write_message("Exporting plots");

            if (app.CheckBoxExportPlotMagnetization.Value == 1)
                file_name = strcat(app.EditFieldFileNamePlotMagnetization.Value, app.DropDownPlotMagnetizacionExtension.Value);
                path = strcat(app.OutputDatasetPath.Value, '\', file_name);
                exportgraphics(app.AxesM,path,'Resolution',400);
                message = strcat("Magnetization plots exported as ",file_name);
                app.write_message(message);
            end

            if (app.CheckBoxExportPlotSusceptibility.Value == 1)
                file_name = strcat(app.EditFieldFileNamePlotSusceptibility.Value, app.DropDownPlotSusceptibilityExtension.Value);
                path = strcat(app.OutputDatasetPath.Value, '\', file_name);
                exportgraphics(app.AxesdMdH,path,'Resolution',400);
                message = strcat("Susceptibility plots exported as ",file_name);
                app.write_message(message);
            end

            if(app.CheckBoxExportPlotSemiLogMagDerivative.Value == 1)
                file_name = strcat(app.EditFieldFileNamePlotSemiLogMagDerivative.Value, app.DropDownPlotSemiLogMagDerivativeExtension.Value);
                path = strcat(app.OutputDatasetPath.Value, '\', file_name);
                exportgraphics(app.AxesHdMdH,path,'Resolution',400);
                message = strcat("Semi-Log Magnetization Derivative plots exported as ",file_name);
                app.write_message(message);
            end
        end

        % Menu selected function: SaveasMenu
        function SaveasMenuSelected(app, event)
            MenuUtils.select_output_folder(app);
        end

        % Menu selected function: OpenMenu
        function OpenMenuSelected(app, event)
            MenuUtils.open_project(app);
        end

        % Button pushed function: ExportResiduesButton
        function ExportResiduesButtonPushed(app, event)
            if (app.CheckBoxExportResiduesMagnetization.Value == 0 && app.CheckBoxExportResiduesSusceptibility.Value == 0 && app.CheckBoxExportResiduesSemiLogMagDerivative.Value == 0)
                app.write_message("No residual plots were selected to be exported");
                return;
            end
            if (app.CheckBoxExportResiduesMagnetization.Value == 1)
                residue = MagnetizationResidueCalculator(app.data_curve, app.modeled_curve).get_residue();
                file_name = strcat(app.EditFieldFileNameResiduesMagnetization.Value, app.DropDownResiduesMagnetizacionExtension.Value);
                app.export_residual(residue, file_name);
            end

            if(app.CheckBoxExportResiduesSusceptibility.Value == 1)
                residue = SusceptibilityResidueCalculator(app.data_curve, app.modeled_curve).get_residue();
                file_name = strcat(app.EditFieldFileNameResiduesSusceptibility.Value, app.DropDownResiduesSusceptibilityExtension.Value);
                app.export_residual(residue, file_name);
            end

            if(app.CheckBoxExportResiduesSemiLogMagDerivative.Value == 1)
                residue = SemilogDerivativeResidueCalculator(app.data_curve, app.modeled_curve).get_residue();
                file_name = strcat(app.EditFieldFileNameResiduesSemiLogMagDerivative.Value, app.DropDownResiduesSemiLogMagDerivativeExtension.Value);
                app.export_residual(residue, file_name);
            end
        end

        % Menu selected function: SaveMenu
        function SaveMenuSelected(app, event)
            MenuUtils.save_project(app);
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

        % Callback function
        function InputAxisScaleDropDownValueChanged(app, event)

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

        % Value changed function: CurveDropDown
        function CurveDropDownValueChanged(app, event)
            app.reprocess_dataset();
        end

        % Value changed function: InputNumberofPointsEditField
        function InputApplyPointsButtonPushed(app, event)
            app.reprocess_dataset();
        end

        % Callback function
        function InputAxisScaleDropDownValueChanged2(app, event)

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
            path = app.InputDatasetPath.Value;
            if isfile(path)
                app.import_data(path);
                app.plot_hysteretic_tab_data();
                app.update_hysteretic_error_display();
            else
                app.write_dataset_not_found_message(path);
            end
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
            path = app.InputDatasetPath.Value;
            if isfile(path)
                app.import_data(path);
                app.fit_ja_parameters();
            else
                app.write_dataset_not_found_message(path);
            end
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
                app.JsField_9.Value = app.Ms_JA.Value;
                app.JsField_10.Value = app.a_JA.Value;
                app.JsField_11.Value = app.alpha_JA.Value;
                app.JsField_12.Value = app.c_JA.Value;
                app.JsField_13.Value = app.k_JA.Value;
                app.write_message("Jiles-Atherton parameters retrieved from Hysteretic Fitting tab.");
                return;
            end

            [ms_seed, a_seed, alpha_seed, has_seeds] = app.get_first_anhysteretic_seeds();
            if has_seeds
                app.JsField_9.Value = ms_seed;
                app.JsField_10.Value = a_seed;
                app.JsField_11.Value = alpha_seed;
                app.JsField_12.Value = 0;
                app.JsField_13.Value = 0;
                app.write_message("Anhysteretic parameters retrieved from Anhysteretic Fitting tab.");
                return;
            end

            app.write_message("No parameters available to retrieve.");
        end

        % Value changed function: RepetitionsEditField_3
        function RepetitionsEditField_3ValueChanged(app, event)
            app.plot_hysteretic_tab_data()
        end

        % Value changed function: RelativetoleranceEditField
        function RelativetoleranceEditFieldValueChanged(app, event)
            app.plot_hysteretic_tab_data()
        end

        % Value changed function: StartingpointDropDown_4
        function StartingpointDropDown_4ValueChanged(app, event)
            app.plot_hysteretic_tab_data()
        end

        % Value changed function: FittingregionDropDown
        function FittingregionDropDownValueChanged(app, event)
            app.sync_hysteretic_fitting_ui();
            app.plot_hysteretic_tab_data();
        end

        % Value changed function: StopcriterionDropDown_5
        function StopcriterionDropDown_5ValueChanged(app, event)
            app.sync_hysteretic_stop_criterion_ui();
            app.plot_hysteretic_tab_data();
        end

        % Value changed function: MaximumrepetitionsEditField
        function MaximumrepetitionsEditFieldValueChanged(app, event)
            app.plot_hysteretic_tab_data();
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
            PlaygroundUtils.clear_simulation(app);
            PlaygroundUtils.sync_major_ui(app);
            app.plot_playground();
        end

        % Value changed function: HcaseDropDown
        function HcaseDropDownValueChanged(app, event)
            app.sync_playground_mode_ui();
            if PlaygroundUtils.is_minor_mode(app)
                app.maybe_refresh_minor_loop_defaults();   % MOD: fill Htip_i defaults from data tip when switching to Minor Loops
            elseif PlaygroundUtils.is_degaussing_mode(app)     % MOD: ADD
                app.maybe_refresh_degaussing_defaults();       % MOD: ADD
                app.sync_degaussing_ui();                      % MOD: ADD
            elseif PlaygroundUtils.is_harmonics_mode(app)      % MOD: ADD
                app.maybe_refresh_harmonics_defaults();        % MOD: ADD
                app.sync_harmonics_ui();                       % MOD: ADD
            end
            PlaygroundUtils.clear_simulation(app);
            PlaygroundUtils.sync_major_ui(app);
            app.plot_playground();
        end

        % Callback function
        function UITableCellEdit(app, event)
            app.minor_loop_table_user_edited = true;   % MOD: stop auto-filling defaults once edited
            app.expand_minor_loop_table_if_needed(event);
            PlaygroundUtils.clear_simulation(app);
            app.plot_playground();
        end

        % Value changed function: FinalamplitudeAmEditField, 
        % ...and 4 other components
        function DegaussingValueChanged(app, event)
            app.degaussing_user_edited = true;   % MOD: stop auto-filling defaults once edited
            PlaygroundUtils.clear_simulation(app);
            app.plot_playground();
        end

        % Value changed function: HamplitudeDropDown, 
        % ...and 1 other component
        function DegaussingModeChanged(app, event)
            app.sync_degaussing_ui();
            PlaygroundUtils.clear_simulation(app);
            app.plot_playground();
        end

        % Cell edit callback: UITable_3
        function DegaussingTableCellEdit(app, event)
            app.degaussing_user_edited = true;   % MOD: stop auto-filling defaults once edited
            app.expand_degaussing_table_if_needed(event);
            PlaygroundUtils.clear_simulation(app);
            app.plot_playground();
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
            % MOD: shared value-changed callback for the harmonic-drive controls
            % (everything except the harmonics table). Re-syncs enable states,
            % invalidates the cached simulation and redraws.
            app.sync_harmonics_ui();
            PlaygroundUtils.clear_simulation(app);
            app.plot_playground();
        end

        % Cell edit callback: UITable2
        function HarmonicsTableCellEdit(app, event)
            app.harmonics_user_edited = true;   % MOD: stop auto-filling defaults once edited
            app.expand_harmonics_table_if_needed(event);
            PlaygroundUtils.clear_simulation(app);
            app.plot_playground();
        end

        % Value changed function: MaxrepetitionsEditField_2, 
        % ...and 1 other component
        function StopcriterionDropDown_4ValueChanged(app, event)
            % MOD: grey the minor-loop Repetitions / Rel. tolerance fields (and
            % labels) to match the chosen stop criterion, then invalidate the
            % cached simulation and redraw.
            PlaygroundUtils.sync_minor_ui(app);
            PlaygroundUtils.clear_simulation(app);
            app.plot_playground();
        end

        % Value changed function: MsLower_JA
        function MsLower_JAValueChanged(app, event)
            app.hysteretic_ms_lower_bound_user_edited = true;   % MOD: stop auto-filling the Ms lower bound from Mtip once edited
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

            % Create AppGridLayout
            app.AppGridLayout = uigridlayout(app.MagAnalystUIFigure);
            app.AppGridLayout.ColumnWidth = {'1x'};
            app.AppGridLayout.RowHeight = {'3x', '1x'};
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

            % Create GridLayoutMagnetizationInputData
            app.GridLayoutMagnetizationInputData = uigridlayout(app.InputdataTab);
            app.GridLayoutMagnetizationInputData.ColumnWidth = {'1x', '2x'};
            app.GridLayoutMagnetizationInputData.RowHeight = {'1x'};

            % Create GridLayoutInput
            app.GridLayoutInput = uigridlayout(app.GridLayoutMagnetizationInputData);
            app.GridLayoutInput.ColumnWidth = {'1x'};
            app.GridLayoutInput.RowHeight = {'1x', '1x', '1x', '1x', '1x', '10x'};
            app.GridLayoutInput.Layout.Row = 1;
            app.GridLayoutInput.Layout.Column = 1;

            % Create GridLayoutInputHorizontalAxis
            app.GridLayoutInputHorizontalAxis = uigridlayout(app.GridLayoutInput);
            app.GridLayoutInputHorizontalAxis.ColumnWidth = {'1x', '1.4x'};
            app.GridLayoutInputHorizontalAxis.RowHeight = {'1x'};
            app.GridLayoutInputHorizontalAxis.Padding = [0 0 0 0];
            app.GridLayoutInputHorizontalAxis.Layout.Row = 2;
            app.GridLayoutInputHorizontalAxis.Layout.Column = 1;

            % Create HorizontalaxisfieldDropDownLabel
            app.HorizontalaxisfieldDropDownLabel = uilabel(app.GridLayoutInputHorizontalAxis);
            app.HorizontalaxisfieldDropDownLabel.FontWeight = 'bold';
            app.HorizontalaxisfieldDropDownLabel.Layout.Row = 1;
            app.HorizontalaxisfieldDropDownLabel.Layout.Column = 1;
            app.HorizontalaxisfieldDropDownLabel.Text = 'Horizontal axis field';

            % Create HorizontalaxisfieldDropDown
            app.HorizontalaxisfieldDropDown = uidropdown(app.GridLayoutInputHorizontalAxis);
            app.HorizontalaxisfieldDropDown.Items = {'H [A/m]', 'H [kA/m]', 'H [Oe]', 'H [kOe]', 'Bext [T]', 'Bext [G]', 'Bext [kG]'};
            app.HorizontalaxisfieldDropDown.ValueChangedFcn = createCallbackFcn(app, @HorizontalaxisfieldDropDownValueChanged, true);
            app.HorizontalaxisfieldDropDown.Layout.Row = 1;
            app.HorizontalaxisfieldDropDown.Layout.Column = 2;
            app.HorizontalaxisfieldDropDown.Value = 'H [A/m]';

            % Create GridLayoutInputVerticalAxis
            app.GridLayoutInputVerticalAxis = uigridlayout(app.GridLayoutInput);
            app.GridLayoutInputVerticalAxis.ColumnWidth = {'1x', '1.4x'};
            app.GridLayoutInputVerticalAxis.RowHeight = {'1x'};
            app.GridLayoutInputVerticalAxis.Padding = [0 0 0 0];
            app.GridLayoutInputVerticalAxis.Layout.Row = 3;
            app.GridLayoutInputVerticalAxis.Layout.Column = 1;

            % Create VerticalaxisfieldDropDownLabel
            app.VerticalaxisfieldDropDownLabel = uilabel(app.GridLayoutInputVerticalAxis);
            app.VerticalaxisfieldDropDownLabel.FontWeight = 'bold';
            app.VerticalaxisfieldDropDownLabel.Layout.Row = 1;
            app.VerticalaxisfieldDropDownLabel.Layout.Column = 1;
            app.VerticalaxisfieldDropDownLabel.Text = 'Vertical axis field';

            % Create VerticalaxisfieldDropDown
            app.VerticalaxisfieldDropDown = uidropdown(app.GridLayoutInputVerticalAxis);
            app.VerticalaxisfieldDropDown.Items = {'M [A/m]', 'M [kA/m]', 'M [MA/m]', 'M [emu/cm^3]', 'J [T]', 'B [T]', 'B [G]', 'B [kG]'};
            app.VerticalaxisfieldDropDown.ValueChangedFcn = createCallbackFcn(app, @VerticalaxisfieldDropDownValueChanged, true);
            app.VerticalaxisfieldDropDown.Layout.Row = 1;
            app.VerticalaxisfieldDropDown.Layout.Column = 2;
            app.VerticalaxisfieldDropDown.Value = 'B [T]';

            % Create GridLayoutInputCurve
            app.GridLayoutInputCurve = uigridlayout(app.GridLayoutInput);
            app.GridLayoutInputCurve.ColumnWidth = {'1x', '1.4x'};
            app.GridLayoutInputCurve.RowHeight = {'1x'};
            app.GridLayoutInputCurve.Padding = [0 0 0 0];
            app.GridLayoutInputCurve.Layout.Row = 4;
            app.GridLayoutInputCurve.Layout.Column = 1;

            % Create CurveDropDownLabel
            app.CurveDropDownLabel = uilabel(app.GridLayoutInputCurve);
            app.CurveDropDownLabel.FontWeight = 'bold';
            app.CurveDropDownLabel.Layout.Row = 1;
            app.CurveDropDownLabel.Layout.Column = 1;
            app.CurveDropDownLabel.Text = 'Curve';

            % Create CurveDropDown
            app.CurveDropDown = uidropdown(app.GridLayoutInputCurve);
            app.CurveDropDown.Items = {'Anhysteretic curve', 'Hysteresis loop'};
            app.CurveDropDown.ValueChangedFcn = createCallbackFcn(app, @CurveDropDownValueChanged, true);
            app.CurveDropDown.Layout.Row = 1;
            app.CurveDropDown.Layout.Column = 2;
            app.CurveDropDown.Value = 'Hysteresis loop';

            % Create GridLayout
            app.GridLayout = uigridlayout(app.GridLayoutInput);
            app.GridLayout.ColumnWidth = {'1x'};
            app.GridLayout.RowHeight = {'1x'};
            app.GridLayout.Padding = [0 0 0 0];
            app.GridLayout.Layout.Row = 6;
            app.GridLayout.Layout.Column = 1;

            % Create DescriptionTextArea
            app.DescriptionTextArea = uitextarea(app.GridLayout);
            app.DescriptionTextArea.Layout.Row = 1;
            app.DescriptionTextArea.Layout.Column = 1;

            % Create DescriptionLabel
            app.DescriptionLabel = uilabel(app.GridLayoutInput);
            app.DescriptionLabel.FontWeight = 'bold';
            app.DescriptionLabel.Layout.Row = 5;
            app.DescriptionLabel.Layout.Column = 1;
            app.DescriptionLabel.Text = 'Description';

            % Create GridLayoutDatasetPath
            app.GridLayoutDatasetPath = uigridlayout(app.GridLayoutInput);
            app.GridLayoutDatasetPath.ColumnWidth = {'16x', '14x', '7x'};
            app.GridLayoutDatasetPath.RowHeight = {'1x'};
            app.GridLayoutDatasetPath.Padding = [0 0 0 0];
            app.GridLayoutDatasetPath.Layout.Row = 1;
            app.GridLayoutDatasetPath.Layout.Column = 1;

            % Create InputDatasetpathLabel
            app.InputDatasetpathLabel = uilabel(app.GridLayoutDatasetPath);
            app.InputDatasetpathLabel.FontWeight = 'bold';
            app.InputDatasetpathLabel.Layout.Row = 1;
            app.InputDatasetpathLabel.Layout.Column = 1;
            app.InputDatasetpathLabel.Text = 'Dataset path';

            % Create InputBrowseButton
            app.InputBrowseButton = uibutton(app.GridLayoutDatasetPath, 'push');
            app.InputBrowseButton.ButtonPushedFcn = createCallbackFcn(app, @InputBrowseButtonPushed, true);
            app.InputBrowseButton.Layout.Row = 1;
            app.InputBrowseButton.Layout.Column = 3;
            app.InputBrowseButton.Text = 'Browse';

            % Create InputDatasetPath
            app.InputDatasetPath = uieditfield(app.GridLayoutDatasetPath, 'text');
            app.InputDatasetPath.ValueChangedFcn = createCallbackFcn(app, @InputDatasetPathValueChanged, true);
            app.InputDatasetPath.Layout.Row = 1;
            app.InputDatasetPath.Layout.Column = 2;

            % Create GridLayoutInputPlot
            app.GridLayoutInputPlot = uigridlayout(app.GridLayoutMagnetizationInputData);
            app.GridLayoutInputPlot.ColumnWidth = {'1x'};
            app.GridLayoutInputPlot.RowHeight = {'20x', '1x', '3x'};
            app.GridLayoutInputPlot.RowSpacing = 0;
            app.GridLayoutInputPlot.Padding = [0 10 0 0];
            app.GridLayoutInputPlot.Layout.Row = 1;
            app.GridLayoutInputPlot.Layout.Column = 2;

            % Create GridLayoutInputAxisScale
            app.GridLayoutInputAxisScale = uigridlayout(app.GridLayoutInputPlot);
            app.GridLayoutInputAxisScale.ColumnWidth = {'0.7x', '0.3x', '0.5x', '1x', '0.5x'};
            app.GridLayoutInputAxisScale.RowHeight = {'3x'};
            app.GridLayoutInputAxisScale.Padding = [0 0 0 0];
            app.GridLayoutInputAxisScale.Layout.Row = 2;
            app.GridLayoutInputAxisScale.Layout.Column = 1;

            % Create GridLayoutInputPlots
            app.GridLayoutInputPlots = uigridlayout(app.GridLayoutInputPlot);
            app.GridLayoutInputPlots.RowHeight = {'1x'};
            app.GridLayoutInputPlots.Layout.Row = 1;
            app.GridLayoutInputPlots.Layout.Column = 1;

            % Create AxesProcessedInputData
            app.AxesProcessedInputData = uiaxes(app.GridLayoutInputPlots);
            title(app.AxesProcessedInputData, 'Processed input data')
            app.AxesProcessedInputData.Box = 'on';
            app.AxesProcessedInputData.Layout.Row = 1;
            app.AxesProcessedInputData.Layout.Column = 2;

            % Create AxesRawInputData
            app.AxesRawInputData = uiaxes(app.GridLayoutInputPlots);
            title(app.AxesRawInputData, 'Raw input data')
            zlabel(app.AxesRawInputData, 'Z')
            app.AxesRawInputData.Box = 'on';
            app.AxesRawInputData.Layout.Row = 1;
            app.AxesRawInputData.Layout.Column = 1;

            % Create GridLayoutInputTipsAndPlotButton
            app.GridLayoutInputTipsAndPlotButton = uigridlayout(app.GridLayoutInputPlot);
            app.GridLayoutInputTipsAndPlotButton.ColumnWidth = {'1x', '0.8x', '1.2x'};
            app.GridLayoutInputTipsAndPlotButton.RowHeight = {'1x'};
            app.GridLayoutInputTipsAndPlotButton.Padding = [0 0 0 0];
            app.GridLayoutInputTipsAndPlotButton.Layout.Row = 3;
            app.GridLayoutInputTipsAndPlotButton.Layout.Column = 1;

            % Create GridLayoutTips
            app.GridLayoutTips = uigridlayout(app.GridLayoutInputTipsAndPlotButton);
            app.GridLayoutTips.ColumnWidth = {'0.5x', '1x'};
            app.GridLayoutTips.Padding = [0 0 0 0];
            app.GridLayoutTips.Layout.Row = 1;
            app.GridLayoutTips.Layout.Column = 1;

            % Create HTipField
            app.HTipField = uieditfield(app.GridLayoutTips, 'numeric');
            app.HTipField.ValueDisplayFormat = '%.6g';
            app.HTipField.AllowEmpty = 'on';
            app.HTipField.Editable = 'off';
            app.HTipField.Layout.Row = 1;
            app.HTipField.Layout.Column = 2;
            app.HTipField.Value = [];

            % Create HtipAmLabel
            app.HtipAmLabel = uilabel(app.GridLayoutTips);
            app.HtipAmLabel.HorizontalAlignment = 'right';
            app.HtipAmLabel.FontWeight = 'bold';
            app.HtipAmLabel.Layout.Row = 1;
            app.HtipAmLabel.Layout.Column = 1;
            app.HtipAmLabel.Text = 'Htip [A/m]';

            % Create MTipField
            app.MTipField = uieditfield(app.GridLayoutTips, 'numeric');
            app.MTipField.ValueDisplayFormat = '%.6g';
            app.MTipField.AllowEmpty = 'on';
            app.MTipField.Editable = 'off';
            app.MTipField.Layout.Row = 2;
            app.MTipField.Layout.Column = 2;
            app.MTipField.Value = [];

            % Create MtipAmLabel
            app.MtipAmLabel = uilabel(app.GridLayoutTips);
            app.MtipAmLabel.HorizontalAlignment = 'right';
            app.MtipAmLabel.FontWeight = 'bold';
            app.MtipAmLabel.Layout.Row = 2;
            app.MtipAmLabel.Layout.Column = 1;
            app.MtipAmLabel.Text = 'Mtip [A/m]';

            % Create GridLayoutTips_2
            app.GridLayoutTips_2 = uigridlayout(app.GridLayoutInputTipsAndPlotButton);
            app.GridLayoutTips_2.ColumnWidth = {'0.8x', '1x'};
            app.GridLayoutTips_2.Padding = [0 0 0 0];
            app.GridLayoutTips_2.Layout.Row = 1;
            app.GridLayoutTips_2.Layout.Column = 2;

            % Create InputAxisScaleDropDown
            app.InputAxisScaleDropDown = uidropdown(app.GridLayoutTips_2);
            app.InputAxisScaleDropDown.Items = {'linear', 'semilog-x', 'semilog-y', 'log-log'};
            app.InputAxisScaleDropDown.ValueChangedFcn = createCallbackFcn(app, @DropDownValueChanged, true);
            app.InputAxisScaleDropDown.Tag = 'InputAxisScaleDropDown';
            app.InputAxisScaleDropDown.Layout.Row = 1;
            app.InputAxisScaleDropDown.Layout.Column = 2;
            app.InputAxisScaleDropDown.Value = 'linear';

            % Create AxisscaleLabel
            app.AxisscaleLabel = uilabel(app.GridLayoutTips_2);
            app.AxisscaleLabel.HorizontalAlignment = 'right';
            app.AxisscaleLabel.FontWeight = 'bold';
            app.AxisscaleLabel.Layout.Row = 1;
            app.AxisscaleLabel.Layout.Column = 1;
            app.AxisscaleLabel.Text = 'Axis scale';

            % Create GridLayoutTips_3
            app.GridLayoutTips_3 = uigridlayout(app.GridLayoutInputTipsAndPlotButton);
            app.GridLayoutTips_3.ColumnWidth = {'0.5x', '0.5x', '0.5x'};
            app.GridLayoutTips_3.Padding = [0 0 0 0];
            app.GridLayoutTips_3.Layout.Row = 1;
            app.GridLayoutTips_3.Layout.Column = 3;

            % Create InputNumberofPointsEditField
            app.InputNumberofPointsEditField = uieditfield(app.GridLayoutTips_3, 'numeric');
            app.InputNumberofPointsEditField.Limits = [2 Inf];
            app.InputNumberofPointsEditField.RoundFractionalValues = 'on';
            app.InputNumberofPointsEditField.ValueDisplayFormat = '%.0f';
            app.InputNumberofPointsEditField.ValueChangedFcn = createCallbackFcn(app, @InputApplyPointsButtonPushed, true);
            app.InputNumberofPointsEditField.Tooltip = {'N° of points of processed anhysteretic curve'};
            app.InputNumberofPointsEditField.Layout.Row = 1;
            app.InputNumberofPointsEditField.Layout.Column = 3;
            app.InputNumberofPointsEditField.Value = 50;

            % Create InputNumberofPointsLabel
            app.InputNumberofPointsLabel = uilabel(app.GridLayoutTips_3);
            app.InputNumberofPointsLabel.HorizontalAlignment = 'right';
            app.InputNumberofPointsLabel.FontWeight = 'bold';
            app.InputNumberofPointsLabel.Tooltip = {'N° of points of processed anhysteretic curve'};
            app.InputNumberofPointsLabel.Layout.Row = 1;
            app.InputNumberofPointsLabel.Layout.Column = 2;
            app.InputNumberofPointsLabel.Text = 'N° of points';

            % Create AnhystereticfittingTab
            app.AnhystereticfittingTab = uitab(app.TabGroup);
            app.AnhystereticfittingTab.AutoResizeChildren = 'off';
            app.AnhystereticfittingTab.Title = 'Anhysteretic fitting';

            % Create AnhystereticmagnetizationfittingTabGridLayout
            app.AnhystereticmagnetizationfittingTabGridLayout = uigridlayout(app.AnhystereticfittingTab);
            app.AnhystereticmagnetizationfittingTabGridLayout.ColumnWidth = {'0.8x', '1x'};
            app.AnhystereticmagnetizationfittingTabGridLayout.RowHeight = {'1x'};

            % Create GridLayoutAxes
            app.GridLayoutAxes = uigridlayout(app.AnhystereticmagnetizationfittingTabGridLayout);
            app.GridLayoutAxes.ColumnWidth = {'1x'};
            app.GridLayoutAxes.RowHeight = {'1x', '0.15x', '1x', '0.15x', '1x', '0.15x'};
            app.GridLayoutAxes.RowSpacing = 3;
            app.GridLayoutAxes.Padding = [0 0 0 0];
            app.GridLayoutAxes.Layout.Row = 1;
            app.GridLayoutAxes.Layout.Column = 1;

            % Create AxesM
            app.AxesM = uiaxes(app.GridLayoutAxes);
            xlabel(app.AxesM, 'H [A/m]')
            ylabel(app.AxesM, 'M [A/m]')
            zlabel(app.AxesM, 'Z')
            app.AxesM.Box = 'on';
            app.AxesM.Layout.Row = 1;
            app.AxesM.Layout.Column = 1;

            % Create AxesdMdH
            app.AxesdMdH = uiaxes(app.GridLayoutAxes);
            xlabel(app.AxesdMdH, 'H [A/m]')
            ylabel(app.AxesdMdH, '∂M/∂H')
            zlabel(app.AxesdMdH, 'Z')
            app.AxesdMdH.Box = 'on';
            app.AxesdMdH.Layout.Row = 3;
            app.AxesdMdH.Layout.Column = 1;

            % Create AxesHdMdH
            app.AxesHdMdH = uiaxes(app.GridLayoutAxes);
            xlabel(app.AxesHdMdH, 'H [A/m]')
            ylabel(app.AxesHdMdH, '∂M/∂(lnH) [A/m]')
            zlabel(app.AxesHdMdH, 'Z')
            app.AxesHdMdH.Box = 'on';
            app.AxesHdMdH.Layout.Row = 5;
            app.AxesHdMdH.Layout.Column = 1;

            % Create GridLayoutOptionsM
            app.GridLayoutOptionsM = uigridlayout(app.GridLayoutAxes);
            app.GridLayoutOptionsM.ColumnWidth = {'2.9x', '0.5x', '2.1x', '3x', '2x', '2x', '0.5x'};
            app.GridLayoutOptionsM.RowHeight = {'1x'};
            app.GridLayoutOptionsM.Padding = [0 0 0 0];
            app.GridLayoutOptionsM.Layout.Row = 2;
            app.GridLayoutOptionsM.Layout.Column = 1;

            % Create ResidualplotButtonM
            app.ResidualplotButtonM = uibutton(app.GridLayoutOptionsM, 'push');
            app.ResidualplotButtonM.ButtonPushedFcn = createCallbackFcn(app, @ResidualplotButtonMPushed, true);
            app.ResidualplotButtonM.Layout.Row = 1;
            app.ResidualplotButtonM.Layout.Column = 1;
            app.ResidualplotButtonM.Text = 'Residuals';

            % Create PlotcomponentsCheckBoxM
            app.PlotcomponentsCheckBoxM = uicheckbox(app.GridLayoutOptionsM);
            app.PlotcomponentsCheckBoxM.ValueChangedFcn = createCallbackFcn(app, @PlotcomponentsCheckBoxMValueChanged, true);
            app.PlotcomponentsCheckBoxM.Text = 'Components';
            app.PlotcomponentsCheckBoxM.Layout.Row = 1;
            app.PlotcomponentsCheckBoxM.Layout.Column = 4;
            app.PlotcomponentsCheckBoxM.Value = true;

            % Create ShowgridCheckBoxM
            app.ShowgridCheckBoxM = uicheckbox(app.GridLayoutOptionsM);
            app.ShowgridCheckBoxM.ValueChangedFcn = createCallbackFcn(app, @ShowgridCheckBoxMValueChanged, true);
            app.ShowgridCheckBoxM.Text = 'Grid';
            app.ShowgridCheckBoxM.Layout.Row = 1;
            app.ShowgridCheckBoxM.Layout.Column = 3;
            app.ShowgridCheckBoxM.Value = true;

            % Create AxisScaleDropDownM
            app.AxisScaleDropDownM = uidropdown(app.GridLayoutOptionsM);
            app.AxisScaleDropDownM.Items = {'linear', 'semilog-x', 'semilog-y', 'log-log'};
            app.AxisScaleDropDownM.ValueChangedFcn = createCallbackFcn(app, @AxisScaleDropDownMValueChanged, true);
            app.AxisScaleDropDownM.Tag = 'InputAxisScaleDropDown';
            app.AxisScaleDropDownM.Layout.Row = 1;
            app.AxisScaleDropDownM.Layout.Column = [6 7];
            app.AxisScaleDropDownM.Value = 'semilog-x';

            % Create ShowhcrCheckBoxM
            app.ShowhcrCheckBoxM = uicheckbox(app.GridLayoutOptionsM);
            app.ShowhcrCheckBoxM.ValueChangedFcn = createCallbackFcn(app, @ShowhcrCheckBoxMValueChanged, true);
            app.ShowhcrCheckBoxM.Text = 'Hcr,i';
            app.ShowhcrCheckBoxM.Layout.Row = 1;
            app.ShowhcrCheckBoxM.Layout.Column = 5;
            app.ShowhcrCheckBoxM.Value = true;

            % Create GridLayoutOptionsdMdH
            app.GridLayoutOptionsdMdH = uigridlayout(app.GridLayoutAxes);
            app.GridLayoutOptionsdMdH.ColumnWidth = {'2.9x', '0.5x', '2.1x', '3x', '2x', '2x', '0.5x'};
            app.GridLayoutOptionsdMdH.RowHeight = {'1x'};
            app.GridLayoutOptionsdMdH.Padding = [0 0 0 0];
            app.GridLayoutOptionsdMdH.Layout.Row = 4;
            app.GridLayoutOptionsdMdH.Layout.Column = 1;

            % Create ResidualplotButtondMdH
            app.ResidualplotButtondMdH = uibutton(app.GridLayoutOptionsdMdH, 'push');
            app.ResidualplotButtondMdH.ButtonPushedFcn = createCallbackFcn(app, @ResidualplotButtondMdHPushed, true);
            app.ResidualplotButtondMdH.Layout.Row = 1;
            app.ResidualplotButtondMdH.Layout.Column = 1;
            app.ResidualplotButtondMdH.Text = 'Residuals';

            % Create PlotcomponentsCheckBoxdMdH
            app.PlotcomponentsCheckBoxdMdH = uicheckbox(app.GridLayoutOptionsdMdH);
            app.PlotcomponentsCheckBoxdMdH.ValueChangedFcn = createCallbackFcn(app, @PlotcomponentsCheckBoxdMdHValueChanged, true);
            app.PlotcomponentsCheckBoxdMdH.Text = 'Components';
            app.PlotcomponentsCheckBoxdMdH.Layout.Row = 1;
            app.PlotcomponentsCheckBoxdMdH.Layout.Column = 4;
            app.PlotcomponentsCheckBoxdMdH.Value = true;

            % Create ShowgridCheckBoxdMdH
            app.ShowgridCheckBoxdMdH = uicheckbox(app.GridLayoutOptionsdMdH);
            app.ShowgridCheckBoxdMdH.ValueChangedFcn = createCallbackFcn(app, @ShowgridCheckBoxdMdHValueChanged, true);
            app.ShowgridCheckBoxdMdH.Text = 'Grid';
            app.ShowgridCheckBoxdMdH.Layout.Row = 1;
            app.ShowgridCheckBoxdMdH.Layout.Column = 3;
            app.ShowgridCheckBoxdMdH.Value = true;

            % Create AxisScaleDropDowndMdH
            app.AxisScaleDropDowndMdH = uidropdown(app.GridLayoutOptionsdMdH);
            app.AxisScaleDropDowndMdH.Items = {'linear', 'semilog-x', 'semilog-y', 'log-log'};
            app.AxisScaleDropDowndMdH.ValueChangedFcn = createCallbackFcn(app, @AxisScaleDropDowndMdHValueChanged, true);
            app.AxisScaleDropDowndMdH.Tag = 'InputAxisScaleDropDown';
            app.AxisScaleDropDowndMdH.Layout.Row = 1;
            app.AxisScaleDropDowndMdH.Layout.Column = [6 7];
            app.AxisScaleDropDowndMdH.Value = 'semilog-x';

            % Create ShowhcrCheckBoxdMdH
            app.ShowhcrCheckBoxdMdH = uicheckbox(app.GridLayoutOptionsdMdH);
            app.ShowhcrCheckBoxdMdH.ValueChangedFcn = createCallbackFcn(app, @ShowhcrCheckBoxdMdHValueChanged, true);
            app.ShowhcrCheckBoxdMdH.Text = 'Hcr,i';
            app.ShowhcrCheckBoxdMdH.Layout.Row = 1;
            app.ShowhcrCheckBoxdMdH.Layout.Column = 5;
            app.ShowhcrCheckBoxdMdH.Value = true;

            % Create GridLayoutOptionsHdMdH
            app.GridLayoutOptionsHdMdH = uigridlayout(app.GridLayoutAxes);
            app.GridLayoutOptionsHdMdH.ColumnWidth = {'2.9x', '0.5x', '2.1x', '3x', '2x', '2x', '0.5x'};
            app.GridLayoutOptionsHdMdH.RowHeight = {'1x'};
            app.GridLayoutOptionsHdMdH.Padding = [0 0 0 0];
            app.GridLayoutOptionsHdMdH.Layout.Row = 6;
            app.GridLayoutOptionsHdMdH.Layout.Column = 1;

            % Create ResidualplotButtondHdMdH
            app.ResidualplotButtondHdMdH = uibutton(app.GridLayoutOptionsHdMdH, 'push');
            app.ResidualplotButtondHdMdH.ButtonPushedFcn = createCallbackFcn(app, @ResidualplotButtondHdMdHPushed, true);
            app.ResidualplotButtondHdMdH.Layout.Row = 1;
            app.ResidualplotButtondHdMdH.Layout.Column = 1;
            app.ResidualplotButtondHdMdH.Text = 'Residuals';

            % Create PlotcomponentsCheckBoxHdMdH
            app.PlotcomponentsCheckBoxHdMdH = uicheckbox(app.GridLayoutOptionsHdMdH);
            app.PlotcomponentsCheckBoxHdMdH.ValueChangedFcn = createCallbackFcn(app, @PlotcomponentsCheckBoxHdMdHValueChanged, true);
            app.PlotcomponentsCheckBoxHdMdH.Text = 'Components';
            app.PlotcomponentsCheckBoxHdMdH.Layout.Row = 1;
            app.PlotcomponentsCheckBoxHdMdH.Layout.Column = 4;
            app.PlotcomponentsCheckBoxHdMdH.Value = true;

            % Create ShowgridCheckBoxHdMdH
            app.ShowgridCheckBoxHdMdH = uicheckbox(app.GridLayoutOptionsHdMdH);
            app.ShowgridCheckBoxHdMdH.ValueChangedFcn = createCallbackFcn(app, @ShowgridCheckBoxHdMdHValueChanged, true);
            app.ShowgridCheckBoxHdMdH.Text = 'Grid';
            app.ShowgridCheckBoxHdMdH.Layout.Row = 1;
            app.ShowgridCheckBoxHdMdH.Layout.Column = 3;
            app.ShowgridCheckBoxHdMdH.Value = true;

            % Create AxisScaleDropDownHdMdH
            app.AxisScaleDropDownHdMdH = uidropdown(app.GridLayoutOptionsHdMdH);
            app.AxisScaleDropDownHdMdH.Items = {'linear', 'semilog-x', 'semilog-y', 'log-log'};
            app.AxisScaleDropDownHdMdH.ValueChangedFcn = createCallbackFcn(app, @AxisScaleDropDownHdMdHValueChanged, true);
            app.AxisScaleDropDownHdMdH.Tag = 'InputAxisScaleDropDown';
            app.AxisScaleDropDownHdMdH.Layout.Row = 1;
            app.AxisScaleDropDownHdMdH.Layout.Column = [6 7];
            app.AxisScaleDropDownHdMdH.Value = 'semilog-x';

            % Create ShowhcrCheckBoxHdMdH
            app.ShowhcrCheckBoxHdMdH = uicheckbox(app.GridLayoutOptionsHdMdH);
            app.ShowhcrCheckBoxHdMdH.ValueChangedFcn = createCallbackFcn(app, @ShowhcrCheckBoxHdMdHValueChanged, true);
            app.ShowhcrCheckBoxHdMdH.Text = 'Hcr,i';
            app.ShowhcrCheckBoxHdMdH.Layout.Row = 1;
            app.ShowhcrCheckBoxHdMdH.Layout.Column = 5;
            app.ShowhcrCheckBoxHdMdH.Value = true;

            % Create GridLayoutNumbers
            app.GridLayoutNumbers = uigridlayout(app.AnhystereticmagnetizationfittingTabGridLayout);
            app.GridLayoutNumbers.ColumnWidth = {'1x'};
            app.GridLayoutNumbers.RowHeight = {'0.2x', '0.3x', '0.2x', '1.7x', '0.2x', '1x', '0.2x', '1x', '0.3x'};
            app.GridLayoutNumbers.RowSpacing = 5;
            app.GridLayoutNumbers.Padding = [10 0 10 0];
            app.GridLayoutNumbers.Layout.Row = 1;
            app.GridLayoutNumbers.Layout.Column = 2;
            app.GridLayoutNumbers.Scrollable = 'on';

            % Create TableFittedParameters
            app.TableFittedParameters = uitable(app.GridLayoutNumbers);
            app.TableFittedParameters.ColumnName = {'Parameter'; 'Value'; 'Lower bound'; 'Upper bound'; 'Fit'};
            app.TableFittedParameters.RowName = {};
            app.TableFittedParameters.ColumnEditable = [false true true true true];
            app.TableFittedParameters.CellEditCallback = createCallbackFcn(app, @TableFittedParametersCellEdit, true);
            app.TableFittedParameters.CellSelectionCallback = createCallbackFcn(app, @TableFittedParametersCellSelection, true);
            app.TableFittedParameters.Layout.Row = 4;
            app.TableFittedParameters.Layout.Column = 1;

            % Create ModelparametersLabel_3
            app.ModelparametersLabel_3 = uilabel(app.GridLayoutNumbers);
            app.ModelparametersLabel_3.FontWeight = 'bold';
            app.ModelparametersLabel_3.Layout.Row = 5;
            app.ModelparametersLabel_3.Layout.Column = 1;
            app.ModelparametersLabel_3.Text = 'Model parameters';

            % Create TableParameters
            app.TableParameters = uitable(app.GridLayoutNumbers);
            app.TableParameters.ColumnName = {'Component'; 'Msᵢ [A/m]'; 'αᵢ'; 'aᵢ [A/m]'; 'Select aᵢ'};
            app.TableParameters.RowName = {};
            app.TableParameters.ColumnEditable = [false false false false true];
            app.TableParameters.CellSelectionCallback = createCallbackFcn(app, @TableParametersCellSelection, true);
            app.TableParameters.Layout.Row = 6;
            app.TableParameters.Layout.Column = 1;

            % Create GridLayoutButtons
            app.GridLayoutButtons = uigridlayout(app.GridLayoutNumbers);
            app.GridLayoutButtons.ColumnWidth = {'0.3x', '1.4x', '0.8x', '0.9x', '0.4x', '0.4x'};
            app.GridLayoutButtons.RowHeight = {'0.7x'};
            app.GridLayoutButtons.Padding = [0 0 0 0];
            app.GridLayoutButtons.Layout.Row = 9;
            app.GridLayoutButtons.Layout.Column = 1;

            % Create FitButton
            app.FitButton = uibutton(app.GridLayoutButtons, 'push');
            app.FitButton.ButtonPushedFcn = createCallbackFcn(app, @FitButtonPushed, true);
            app.FitButton.BackgroundColor = [0.8667 0.3294 0];
            app.FitButton.FontWeight = 'bold';
            app.FitButton.FontColor = [0.9412 0.9412 0.9412];
            app.FitButton.Layout.Row = 1;
            app.FitButton.Layout.Column = 5;
            app.FitButton.Text = 'Fit';

            % Create CalculatePlotButton
            app.CalculatePlotButton = uibutton(app.GridLayoutButtons, 'push');
            app.CalculatePlotButton.ButtonPushedFcn = createCallbackFcn(app, @CalculatePlotButtonPushed, true);
            app.CalculatePlotButton.WordWrap = 'on';
            app.CalculatePlotButton.Layout.Row = 1;
            app.CalculatePlotButton.Layout.Column = 4;
            app.CalculatePlotButton.Text = 'Calculate & Plot';

            % Create ErrorDropDownLabel
            app.ErrorDropDownLabel = uilabel(app.GridLayoutButtons);
            app.ErrorDropDownLabel.WordWrap = 'on';
            app.ErrorDropDownLabel.FontWeight = 'bold';
            app.ErrorDropDownLabel.Layout.Row = 1;
            app.ErrorDropDownLabel.Layout.Column = 1;
            app.ErrorDropDownLabel.Text = 'Error';

            % Create ErrorDropDown
            app.ErrorDropDown = uidropdown(app.GridLayoutButtons);
            app.ErrorDropDown.Items = {'Diagonal (H, sampled)', 'Diagonal (H, continuous)', 'Diagonal (logH, sampled)', 'Diagonal (logH, continuous)', 'Vertical', 'Horizontal'};
            app.ErrorDropDown.ValueChangedFcn = createCallbackFcn(app, @ErrorDropDownValueChanged, true);
            app.ErrorDropDown.Layout.Row = 1;
            app.ErrorDropDown.Layout.Column = 2;
            app.ErrorDropDown.Value = 'Diagonal (logH, continuous)';

            % Create ErrorDisplay
            app.ErrorDisplay = uieditfield(app.GridLayoutButtons, 'numeric');
            app.ErrorDisplay.ValueDisplayFormat = '%.5e';
            app.ErrorDisplay.AllowEmpty = 'on';
            app.ErrorDisplay.Editable = 'off';
            app.ErrorDisplay.HorizontalAlignment = 'left';
            app.ErrorDisplay.Layout.Row = 1;
            app.ErrorDisplay.Layout.Column = 3;
            app.ErrorDisplay.Value = [];

            % Create StopfitButton
            app.StopfitButton = uibutton(app.GridLayoutButtons, 'push');
            app.StopfitButton.ButtonPushedFcn = createCallbackFcn(app, @StopFitButtonPushed, true);
            app.StopfitButton.Layout.Row = 1;
            app.StopfitButton.Layout.Column = 6;
            app.StopfitButton.Text = 'Stop fit';

            % Create GridLayoutOtherQuantities
            app.GridLayoutOtherQuantities = uigridlayout(app.GridLayoutNumbers);
            app.GridLayoutOtherQuantities.ColumnWidth = {'1.8x', '0.4x', '1x', '0.4x', '1x'};
            app.GridLayoutOtherQuantities.RowHeight = {'1x'};
            app.GridLayoutOtherQuantities.Padding = [0 0 0 0];
            app.GridLayoutOtherQuantities.Layout.Row = 7;
            app.GridLayoutOtherQuantities.Layout.Column = 1;

            % Create CalculatedquantitiesLabel
            app.CalculatedquantitiesLabel = uilabel(app.GridLayoutOtherQuantities);
            app.CalculatedquantitiesLabel.FontWeight = 'bold';
            app.CalculatedquantitiesLabel.Layout.Row = 1;
            app.CalculatedquantitiesLabel.Layout.Column = 1;
            app.CalculatedquantitiesLabel.Text = 'Calculated quantities';

            % Create chiinField
            app.chiinField = uieditfield(app.GridLayoutOtherQuantities, 'numeric');
            app.chiinField.ValueDisplayFormat = '%.6g';
            app.chiinField.AllowEmpty = 'on';
            app.chiinField.Editable = 'off';
            app.chiinField.Layout.Row = 1;
            app.chiinField.Layout.Column = 3;
            app.chiinField.Value = [];

            % Create JsField
            app.JsField = uieditfield(app.GridLayoutOtherQuantities, 'numeric');
            app.JsField.ValueDisplayFormat = '%.6g';
            app.JsField.AllowEmpty = 'on';
            app.JsField.Editable = 'off';
            app.JsField.Layout.Row = 1;
            app.JsField.Layout.Column = 5;
            app.JsField.Value = [];

            % Create chiinLabel
            app.chiinLabel = uilabel(app.GridLayoutOtherQuantities);
            app.chiinLabel.HorizontalAlignment = 'right';
            app.chiinLabel.FontWeight = 'bold';
            app.chiinLabel.Layout.Row = 1;
            app.chiinLabel.Layout.Column = 2;
            app.chiinLabel.Text = 'χᵢₙ';

            % Create JsTLabel
            app.JsTLabel = uilabel(app.GridLayoutOtherQuantities);
            app.JsTLabel.HorizontalAlignment = 'right';
            app.JsTLabel.FontWeight = 'bold';
            app.JsTLabel.Layout.Row = 1;
            app.JsTLabel.Layout.Column = 4;
            app.JsTLabel.Text = 'Js [T]';

            % Create TableQuantities
            app.TableQuantities = uitable(app.GridLayoutNumbers);
            app.TableQuantities.ColumnName = {'Component'; 'αᵢ⏐Msᵢ⏐/(3aᵢ)'; 'NᵢkвT [J/m³]'; 'Hkᵢ [A/m]'; 'χᵢₙ ᵢ'};
            app.TableQuantities.RowName = {};
            app.TableQuantities.CellSelectionCallback = createCallbackFcn(app, @TableQuantitiesCellSelection, true);
            app.TableQuantities.Layout.Row = 8;
            app.TableQuantities.Layout.Column = 1;

            % Create ModeledcurveLabel
            app.ModeledcurveLabel = uilabel(app.GridLayoutNumbers);
            app.ModeledcurveLabel.FontWeight = 'bold';
            app.ModeledcurveLabel.Layout.Row = 1;
            app.ModeledcurveLabel.Layout.Column = 1;
            app.ModeledcurveLabel.Text = 'Modeled curve';

            % Create GridLayoutModeledCurve
            app.GridLayoutModeledCurve = uigridlayout(app.GridLayoutNumbers);
            app.GridLayoutModeledCurve.ColumnWidth = {'0.5x', '0.4x', '0.5x', '0.3x', '1.2x', '0.45x'};
            app.GridLayoutModeledCurve.RowHeight = {'1x'};
            app.GridLayoutModeledCurve.ColumnSpacing = 3;
            app.GridLayoutModeledCurve.Padding = [0 0 0 0];
            app.GridLayoutModeledCurve.Layout.Row = 2;
            app.GridLayoutModeledCurve.Layout.Column = 1;

            % Create NofcompLabel
            app.NofcompLabel = uilabel(app.GridLayoutModeledCurve);
            app.NofcompLabel.Layout.Row = 1;
            app.NofcompLabel.Layout.Column = 1;
            app.NofcompLabel.Text = 'N° of comp.';

            % Create NofcompSpinner
            app.NofcompSpinner = uispinner(app.GridLayoutModeledCurve);
            app.NofcompSpinner.Limits = [1 4];
            app.NofcompSpinner.ValueChangedFcn = createCallbackFcn(app, @NofcompSpinnerValueChanged, true);
            app.NofcompSpinner.Layout.Row = 1;
            app.NofcompSpinner.Layout.Column = 2;
            app.NofcompSpinner.Value = 1;

            % Create NofpointsLabel
            app.NofpointsLabel = uilabel(app.GridLayoutModeledCurve);
            app.NofpointsLabel.Tooltip = {'N° of points of modeled anhysteretic curve'};
            app.NofpointsLabel.Layout.Row = 1;
            app.NofpointsLabel.Layout.Column = 3;
            app.NofpointsLabel.Text = 'N° of points';

            % Create NofpointsEditField
            app.NofpointsEditField = uieditfield(app.GridLayoutModeledCurve, 'numeric');
            app.NofpointsEditField.Limits = [0 Inf];
            app.NofpointsEditField.ValueDisplayFormat = '%.0f';
            app.NofpointsEditField.Tooltip = {'N° of points of modeled anhysteretic curve'};
            app.NofpointsEditField.Layout.Row = 1;
            app.NofpointsEditField.Layout.Column = 4;
            app.NofpointsEditField.Value = 100;

            % Create PointSpaceDropDown
            app.PointSpaceDropDown = uidropdown(app.GridLayoutModeledCurve);
            app.PointSpaceDropDown.Items = {'Logarithmically spaced', 'Lineraly spaced'};
            app.PointSpaceDropDown.ItemsData = {'log', 'linear'};
            app.PointSpaceDropDown.Layout.Row = 1;
            app.PointSpaceDropDown.Layout.Column = 5;
            app.PointSpaceDropDown.Value = 'log';

            % Create SetcolorsButton
            app.SetcolorsButton = uibutton(app.GridLayoutModeledCurve, 'push');
            app.SetcolorsButton.ButtonPushedFcn = createCallbackFcn(app, @SetcolorsButtonPushed, true);
            app.SetcolorsButton.Layout.Row = 1;
            app.SetcolorsButton.Layout.Column = 6;
            app.SetcolorsButton.Text = 'Set colors';

            % Create FittingparametersLabel
            app.FittingparametersLabel = uilabel(app.GridLayoutNumbers);
            app.FittingparametersLabel.FontWeight = 'bold';
            app.FittingparametersLabel.Layout.Row = 3;
            app.FittingparametersLabel.Layout.Column = 1;
            app.FittingparametersLabel.Text = 'Fitting parameters';

            % Create HystereticfittingTab
            app.HystereticfittingTab = uitab(app.TabGroup);
            app.HystereticfittingTab.Title = 'Hysteretic fitting ';

            % Create GridLayout8
            app.GridLayout8 = uigridlayout(app.HystereticfittingTab);
            app.GridLayout8.ColumnWidth = {93, 90, 96, 90, 93, 63, 108, 34, 49, 38, 52, 68, 32, 42, 68};
            app.GridLayout8.RowHeight = {1, '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x'};
            app.GridLayout8.ColumnSpacing = 1.46249389648438;
            app.GridLayout8.RowSpacing = 4.83749580383301;
            app.GridLayout8.Padding = [1.46249389648438 4.83749580383301 1.46249389648438 4.83749580383301];

            % Create AxesM_2
            app.AxesM_2 = uiaxes(app.GridLayout8);
            xlabel(app.AxesM_2, 'H [A/m]')
            ylabel(app.AxesM_2, 'M [A/m]')
            zlabel(app.AxesM_2, 'Z')
            app.AxesM_2.Box = 'on';
            app.AxesM_2.Layout.Row = [2 15];
            app.AxesM_2.Layout.Column = [1 5];

            % Create JilesAthertonmodelrateindependentLabel
            app.JilesAthertonmodelrateindependentLabel = uilabel(app.GridLayout8);
            app.JilesAthertonmodelrateindependentLabel.FontWeight = 'bold';
            app.JilesAthertonmodelrateindependentLabel.Layout.Row = 1;
            app.JilesAthertonmodelrateindependentLabel.Layout.Column = [1 5];
            app.JilesAthertonmodelrateindependentLabel.Text = 'Jiles-Atherton model (rate-independent)';

            % Create ModelparametersLabel
            app.ModelparametersLabel = uilabel(app.GridLayout8);
            app.ModelparametersLabel.FontWeight = 'bold';
            app.ModelparametersLabel.Layout.Row = 2;
            app.ModelparametersLabel.Layout.Column = [6 7];
            app.ModelparametersLabel.Text = 'Model parameters';

            % Create JsTEditFieldLabel_2
            app.JsTEditFieldLabel_2 = uilabel(app.GridLayout8);
            app.JsTEditFieldLabel_2.Layout.Row = 3;
            app.JsTEditFieldLabel_2.Layout.Column = 6;
            app.JsTEditFieldLabel_2.Text = 'Ms [A/m]';

            % Create JsTEditFieldLabel_3
            app.JsTEditFieldLabel_3 = uilabel(app.GridLayout8);
            app.JsTEditFieldLabel_3.Layout.Row = 4;
            app.JsTEditFieldLabel_3.Layout.Column = 6;
            app.JsTEditFieldLabel_3.Text = 'a [A/m]';

            % Create Ms_JA
            app.Ms_JA = uieditfield(app.GridLayout8, 'numeric');
            app.Ms_JA.ValueDisplayFormat = '%.6g';
            app.Ms_JA.AllowEmpty = 'on';
            app.Ms_JA.Layout.Row = 3;
            app.Ms_JA.Layout.Column = 7;
            app.Ms_JA.Value = [];

            % Create JsTEditFieldLabel_4
            app.JsTEditFieldLabel_4 = uilabel(app.GridLayout8);
            app.JsTEditFieldLabel_4.Layout.Row = 5;
            app.JsTEditFieldLabel_4.Layout.Column = 6;
            app.JsTEditFieldLabel_4.Text = 'α';

            % Create a_JA
            app.a_JA = uieditfield(app.GridLayout8, 'numeric');
            app.a_JA.ValueDisplayFormat = '%.6g';
            app.a_JA.AllowEmpty = 'on';
            app.a_JA.Layout.Row = 4;
            app.a_JA.Layout.Column = 7;
            app.a_JA.Value = [];

            % Create JsTEditFieldLabel_5
            app.JsTEditFieldLabel_5 = uilabel(app.GridLayout8);
            app.JsTEditFieldLabel_5.Layout.Row = 6;
            app.JsTEditFieldLabel_5.Layout.Column = 6;
            app.JsTEditFieldLabel_5.Text = 'c';

            % Create alpha_JA
            app.alpha_JA = uieditfield(app.GridLayout8, 'numeric');
            app.alpha_JA.ValueDisplayFormat = '%.5e';
            app.alpha_JA.AllowEmpty = 'on';
            app.alpha_JA.Layout.Row = 5;
            app.alpha_JA.Layout.Column = 7;
            app.alpha_JA.Value = [];

            % Create JsTEditFieldLabel_6
            app.JsTEditFieldLabel_6 = uilabel(app.GridLayout8);
            app.JsTEditFieldLabel_6.Layout.Row = 7;
            app.JsTEditFieldLabel_6.Layout.Column = 6;
            app.JsTEditFieldLabel_6.Text = 'k [A/m]';

            % Create c_JA
            app.c_JA = uieditfield(app.GridLayout8, 'numeric');
            app.c_JA.ValueDisplayFormat = '%.6g';
            app.c_JA.AllowEmpty = 'on';
            app.c_JA.Layout.Row = 6;
            app.c_JA.Layout.Column = 7;
            app.c_JA.Value = [];

            % Create FitButton_2
            app.FitButton_2 = uibutton(app.GridLayout8, 'push');
            app.FitButton_2.ButtonPushedFcn = createCallbackFcn(app, @FitButton_2Pushed, true);
            app.FitButton_2.BackgroundColor = [0.8667 0.3294 0];
            app.FitButton_2.FontWeight = 'bold';
            app.FitButton_2.FontColor = [0.9412 0.9412 0.9412];
            app.FitButton_2.Layout.Row = 16;
            app.FitButton_2.Layout.Column = 14;
            app.FitButton_2.Text = 'Fit';

            % Create CalculatePlotButton_2
            app.CalculatePlotButton_2 = uibutton(app.GridLayout8, 'push');
            app.CalculatePlotButton_2.ButtonPushedFcn = createCallbackFcn(app, @CalculatePlotButton_2Pushed, true);
            app.CalculatePlotButton_2.WordWrap = 'on';
            app.CalculatePlotButton_2.Layout.Row = 16;
            app.CalculatePlotButton_2.Layout.Column = [12 13];
            app.CalculatePlotButton_2.Text = 'Calculate & Plot';

            % Create k_JA
            app.k_JA = uieditfield(app.GridLayout8, 'numeric');
            app.k_JA.ValueDisplayFormat = '%.6g';
            app.k_JA.AllowEmpty = 'on';
            app.k_JA.Layout.Row = 7;
            app.k_JA.Layout.Column = 7;
            app.k_JA.Value = [];

            % Create ErrortominimizeDropDownLabel_2
            app.ErrortominimizeDropDownLabel_2 = uilabel(app.GridLayout8);
            app.ErrortominimizeDropDownLabel_2.WordWrap = 'on';
            app.ErrortominimizeDropDownLabel_2.FontWeight = 'bold';
            app.ErrortominimizeDropDownLabel_2.Layout.Row = 16;
            app.ErrortominimizeDropDownLabel_2.Layout.Column = 6;
            app.ErrortominimizeDropDownLabel_2.Text = 'Error';

            % Create ErrortominimizeDropDown_2
            app.ErrortominimizeDropDown_2 = uidropdown(app.GridLayout8);
            app.ErrortominimizeDropDown_2.Items = {'Diagonal (H, continuous)', 'Vertical', 'Horizontal'};
            app.ErrortominimizeDropDown_2.ValueChangedFcn = createCallbackFcn(app, @ErrortominimizeDropDown_2ValueChanged, true);
            app.ErrortominimizeDropDown_2.Layout.Row = 16;
            app.ErrortominimizeDropDown_2.Layout.Column = [7 9];
            app.ErrortominimizeDropDown_2.Value = 'Diagonal (H, continuous)';

            % Create RetrieveseedsButton
            app.RetrieveseedsButton = uibutton(app.GridLayout8, 'push');
            app.RetrieveseedsButton.ButtonPushedFcn = createCallbackFcn(app, @RetrieveseedsButtonPushed, true);
            app.RetrieveseedsButton.Layout.Row = 2;
            app.RetrieveseedsButton.Layout.Column = [13 15];
            app.RetrieveseedsButton.Text = 'Retrieve seeds';

            % Create TippointdataLabel
            app.TippointdataLabel = uilabel(app.GridLayout8);
            app.TippointdataLabel.FontWeight = 'bold';
            app.TippointdataLabel.Layout.Row = 9;
            app.TippointdataLabel.Layout.Column = [6 7];
            app.TippointdataLabel.Text = 'Tip point (data)';

            % Create ErrorDisplay_2
            app.ErrorDisplay_2 = uieditfield(app.GridLayout8, 'numeric');
            app.ErrorDisplay_2.ValueDisplayFormat = '%.5e';
            app.ErrorDisplay_2.AllowEmpty = 'on';
            app.ErrorDisplay_2.Editable = 'off';
            app.ErrorDisplay_2.HorizontalAlignment = 'left';
            app.ErrorDisplay_2.Layout.Row = 16;
            app.ErrorDisplay_2.Layout.Column = [10 11];
            app.ErrorDisplay_2.Value = [];

            % Create JsTEditFieldLabel_7
            app.JsTEditFieldLabel_7 = uilabel(app.GridLayout8);
            app.JsTEditFieldLabel_7.Layout.Row = 10;
            app.JsTEditFieldLabel_7.Layout.Column = 6;
            app.JsTEditFieldLabel_7.Text = 'Htip [A/m]';

            % Create ShowgridCheckBoxM_2
            app.ShowgridCheckBoxM_2 = uicheckbox(app.GridLayout8);
            app.ShowgridCheckBoxM_2.ValueChangedFcn = createCallbackFcn(app, @ShowgridCheckBoxM_2ValueChanged, true);
            app.ShowgridCheckBoxM_2.Text = 'Grid';
            app.ShowgridCheckBoxM_2.Layout.Row = 16;
            app.ShowgridCheckBoxM_2.Layout.Column = 4;
            app.ShowgridCheckBoxM_2.Value = true;

            % Create ResidualplotButtondMdH_2
            app.ResidualplotButtondMdH_2 = uibutton(app.GridLayout8, 'push');
            app.ResidualplotButtondMdH_2.ButtonPushedFcn = createCallbackFcn(app, @ResidualplotButtondMdH_2Pushed, true);
            app.ResidualplotButtondMdH_2.Layout.Row = 16;
            app.ResidualplotButtondMdH_2.Layout.Column = 2;
            app.ResidualplotButtondMdH_2.Text = 'Residuals';

            % Create Htip
            app.Htip = uieditfield(app.GridLayout8, 'numeric');
            app.Htip.ValueDisplayFormat = '%.6g';
            app.Htip.AllowEmpty = 'on';
            app.Htip.Editable = 'off';
            app.Htip.Layout.Row = 10;
            app.Htip.Layout.Column = 7;
            app.Htip.Value = [];

            % Create JsTEditFieldLabel_8
            app.JsTEditFieldLabel_8 = uilabel(app.GridLayout8);
            app.JsTEditFieldLabel_8.Layout.Row = 11;
            app.JsTEditFieldLabel_8.Layout.Column = 6;
            app.JsTEditFieldLabel_8.Text = 'Mtip [A/m]';

            % Create MsLower_JA
            app.MsLower_JA = uieditfield(app.GridLayout8, 'numeric');
            app.MsLower_JA.AllowEmpty = 'on';
            app.MsLower_JA.ValueChangedFcn = createCallbackFcn(app, @MsLower_JAValueChanged, true);
            app.MsLower_JA.Layout.Row = 3;
            app.MsLower_JA.Layout.Column = [8 9];

            % Create MsUpper_JA
            app.MsUpper_JA = uieditfield(app.GridLayout8, 'numeric');
            app.MsUpper_JA.ValueDisplayFormat = '%.6g';
            app.MsUpper_JA.AllowEmpty = 'on';
            app.MsUpper_JA.Layout.Row = 3;
            app.MsUpper_JA.Layout.Column = [10 11];
            app.MsUpper_JA.Value = Inf;

            % Create Mtip
            app.Mtip = uieditfield(app.GridLayout8, 'numeric');
            app.Mtip.ValueDisplayFormat = '%.6g';
            app.Mtip.AllowEmpty = 'on';
            app.Mtip.Editable = 'off';
            app.Mtip.Layout.Row = 11;
            app.Mtip.Layout.Column = 7;
            app.Mtip.Value = [];

            % Create aLower_JA
            app.aLower_JA = uieditfield(app.GridLayout8, 'numeric');
            app.aLower_JA.ValueDisplayFormat = '%.6g';
            app.aLower_JA.Layout.Row = 4;
            app.aLower_JA.Layout.Column = [8 9];

            % Create aUpper_JA
            app.aUpper_JA = uieditfield(app.GridLayout8, 'numeric');
            app.aUpper_JA.ValueDisplayFormat = '%.6g';
            app.aUpper_JA.AllowEmpty = 'on';
            app.aUpper_JA.Layout.Row = 4;
            app.aUpper_JA.Layout.Column = [10 11];
            app.aUpper_JA.Value = Inf;

            % Create alphaLower_JA
            app.alphaLower_JA = uieditfield(app.GridLayout8, 'numeric');
            app.alphaLower_JA.ValueDisplayFormat = '%.5e';
            app.alphaLower_JA.AllowEmpty = 'on';
            app.alphaLower_JA.Layout.Row = 5;
            app.alphaLower_JA.Layout.Column = [8 9];
            app.alphaLower_JA.Value = -Inf;

            % Create alphaUpper_JA
            app.alphaUpper_JA = uieditfield(app.GridLayout8, 'numeric');
            app.alphaUpper_JA.ValueDisplayFormat = '%.5e';
            app.alphaUpper_JA.AllowEmpty = 'on';
            app.alphaUpper_JA.Layout.Row = 5;
            app.alphaUpper_JA.Layout.Column = [10 11];
            app.alphaUpper_JA.Value = Inf;

            % Create cLower_JA
            app.cLower_JA = uieditfield(app.GridLayout8, 'numeric');
            app.cLower_JA.ValueDisplayFormat = '%.6g';
            app.cLower_JA.AllowEmpty = 'on';
            app.cLower_JA.Layout.Row = 6;
            app.cLower_JA.Layout.Column = [8 9];

            % Create cUpper_JA
            app.cUpper_JA = uieditfield(app.GridLayout8, 'numeric');
            app.cUpper_JA.ValueDisplayFormat = '%.6g';
            app.cUpper_JA.AllowEmpty = 'on';
            app.cUpper_JA.Layout.Row = 6;
            app.cUpper_JA.Layout.Column = [10 11];
            app.cUpper_JA.Value = 1;

            % Create LowerboundLabel
            app.LowerboundLabel = uilabel(app.GridLayout8);
            app.LowerboundLabel.FontWeight = 'bold';
            app.LowerboundLabel.Layout.Row = 2;
            app.LowerboundLabel.Layout.Column = [8 9];
            app.LowerboundLabel.Text = 'Lower bound';

            % Create kLower_JA
            app.kLower_JA = uieditfield(app.GridLayout8, 'numeric');
            app.kLower_JA.ValueDisplayFormat = '%.6g';
            app.kLower_JA.AllowEmpty = 'on';
            app.kLower_JA.Layout.Row = 7;
            app.kLower_JA.Layout.Column = [8 9];

            % Create UpperboundLabel
            app.UpperboundLabel = uilabel(app.GridLayout8);
            app.UpperboundLabel.FontWeight = 'bold';
            app.UpperboundLabel.Layout.Row = 2;
            app.UpperboundLabel.Layout.Column = [10 11];
            app.UpperboundLabel.Text = 'Upper bound';

            % Create kUpper_JA
            app.kUpper_JA = uieditfield(app.GridLayout8, 'numeric');
            app.kUpper_JA.ValueDisplayFormat = '%.6g';
            app.kUpper_JA.AllowEmpty = 'on';
            app.kUpper_JA.Layout.Row = 7;
            app.kUpper_JA.Layout.Column = [10 11];
            app.kUpper_JA.Value = Inf;

            % Create FitLabel
            app.FitLabel = uilabel(app.GridLayout8);
            app.FitLabel.FontWeight = 'bold';
            app.FitLabel.Layout.Row = 2;
            app.FitLabel.Layout.Column = 12;
            app.FitLabel.Text = 'Fit';

            % Create CheckBox
            app.CheckBox = uicheckbox(app.GridLayout8);
            app.CheckBox.Text = '';
            app.CheckBox.Layout.Row = 3;
            app.CheckBox.Layout.Column = 12;
            app.CheckBox.Value = true;

            % Create CheckBox_2
            app.CheckBox_2 = uicheckbox(app.GridLayout8);
            app.CheckBox_2.Text = '';
            app.CheckBox_2.Layout.Row = 4;
            app.CheckBox_2.Layout.Column = 12;
            app.CheckBox_2.Value = true;

            % Create CheckBox_3
            app.CheckBox_3 = uicheckbox(app.GridLayout8);
            app.CheckBox_3.Text = '';
            app.CheckBox_3.Layout.Row = 5;
            app.CheckBox_3.Layout.Column = 12;
            app.CheckBox_3.Value = true;

            % Create CheckBox_4
            app.CheckBox_4 = uicheckbox(app.GridLayout8);
            app.CheckBox_4.Text = '';
            app.CheckBox_4.Layout.Row = 6;
            app.CheckBox_4.Layout.Column = 12;
            app.CheckBox_4.Value = true;

            % Create FitkCheckBox
            app.FitkCheckBox = uicheckbox(app.GridLayout8);
            app.FitkCheckBox.Text = '';
            app.FitkCheckBox.Layout.Row = 7;
            app.FitkCheckBox.Layout.Column = 12;
            app.FitkCheckBox.Value = true;

            % Create Label
            app.Label = uilabel(app.GridLayout8);
            app.Label.Layout.Row = 2;
            app.Label.Layout.Column = 15;
            app.Label.Text = '';

            % Create kConstrainedCheckBox_2
            app.kConstrainedCheckBox_2 = uicheckbox(app.GridLayout8);
            app.kConstrainedCheckBox_2.ValueChangedFcn = createCallbackFcn(app, @kConstrainedCheckBox_2ValueChanged, true);
            app.kConstrainedCheckBox_2.Text = 'Constrained by Hc';
            app.kConstrainedCheckBox_2.Layout.Row = 7;
            app.kConstrainedCheckBox_2.Layout.Column = [13 15];
            app.kConstrainedCheckBox_2.Value = true;

            % Create StopfitButton_2
            app.StopfitButton_2 = uibutton(app.GridLayout8, 'push');
            app.StopfitButton_2.ButtonPushedFcn = createCallbackFcn(app, @StopfitButton_2Pushed, true);
            app.StopfitButton_2.Layout.Row = 16;
            app.StopfitButton_2.Layout.Column = 15;
            app.StopfitButton_2.Text = 'Stop fit';

            % Create StartingpointDropDown_4Label
            app.StartingpointDropDown_4Label = uilabel(app.GridLayout8);
            app.StartingpointDropDown_4Label.Layout.Row = 10;
            app.StartingpointDropDown_4Label.Layout.Column = [10 11];
            app.StartingpointDropDown_4Label.Text = 'Starting point';

            % Create StartingpointDropDown_4
            app.StartingpointDropDown_4 = uidropdown(app.GridLayout8);
            app.StartingpointDropDown_4.Items = {'Demagnetized', 'Tip point'};
            app.StartingpointDropDown_4.ValueChangedFcn = createCallbackFcn(app, @StartingpointDropDown_4ValueChanged, true);
            app.StartingpointDropDown_4.Layout.Row = 10;
            app.StartingpointDropDown_4.Layout.Column = [12 14];
            app.StartingpointDropDown_4.Value = 'Demagnetized';

            % Create FittingregionDropDownLabel
            app.FittingregionDropDownLabel = uilabel(app.GridLayout8);
            app.FittingregionDropDownLabel.Layout.Row = 11;
            app.FittingregionDropDownLabel.Layout.Column = [10 11];
            app.FittingregionDropDownLabel.Text = 'Fitting region';

            % Create FittingregionDropDown
            app.FittingregionDropDown = uidropdown(app.GridLayout8);
            app.FittingregionDropDown.Items = {'Left branch only', 'Entire loop'};
            app.FittingregionDropDown.ValueChangedFcn = createCallbackFcn(app, @FittingregionDropDownValueChanged, true);
            app.FittingregionDropDown.Layout.Row = 11;
            app.FittingregionDropDown.Layout.Column = [12 14];
            app.FittingregionDropDown.Value = 'Entire loop';

            % Create StopcriterionDropDown_5Label
            app.StopcriterionDropDown_5Label = uilabel(app.GridLayout8);
            app.StopcriterionDropDown_5Label.Layout.Row = 12;
            app.StopcriterionDropDown_5Label.Layout.Column = [10 11];
            app.StopcriterionDropDown_5Label.Text = 'Stop criterion';

            % Create StopcriterionDropDown_5
            app.StopcriterionDropDown_5 = uidropdown(app.GridLayout8);
            app.StopcriterionDropDown_5.Items = {'Fixed repetitions', 'Until convergence'};
            app.StopcriterionDropDown_5.ValueChangedFcn = createCallbackFcn(app, @StopcriterionDropDown_5ValueChanged, true);
            app.StopcriterionDropDown_5.Layout.Row = 12;
            app.StopcriterionDropDown_5.Layout.Column = [12 14];
            app.StopcriterionDropDown_5.Value = 'Fixed repetitions';

            % Create RepetitionsEditField_3Label
            app.RepetitionsEditField_3Label = uilabel(app.GridLayout8);
            app.RepetitionsEditField_3Label.Layout.Row = 13;
            app.RepetitionsEditField_3Label.Layout.Column = [11 12];
            app.RepetitionsEditField_3Label.Text = 'Repetitions';

            % Create RepetitionsEditField_3
            app.RepetitionsEditField_3 = uieditfield(app.GridLayout8, 'numeric');
            app.RepetitionsEditField_3.Limits = [0 Inf];
            app.RepetitionsEditField_3.RoundFractionalValues = 'on';
            app.RepetitionsEditField_3.ValueChangedFcn = createCallbackFcn(app, @RepetitionsEditField_3ValueChanged, true);
            app.RepetitionsEditField_3.Layout.Row = 13;
            app.RepetitionsEditField_3.Layout.Column = [13 14];
            app.RepetitionsEditField_3.Value = 1;

            % Create RelativetoleranceEditFieldLabel
            app.RelativetoleranceEditFieldLabel = uilabel(app.GridLayout8);
            app.RelativetoleranceEditFieldLabel.Layout.Row = 14;
            app.RelativetoleranceEditFieldLabel.Layout.Column = [11 12];
            app.RelativetoleranceEditFieldLabel.Text = 'Relative tolerance';

            % Create RelativetoleranceEditField
            app.RelativetoleranceEditField = uieditfield(app.GridLayout8, 'numeric');
            app.RelativetoleranceEditField.Limits = [0 Inf];
            app.RelativetoleranceEditField.ValueDisplayFormat = '%.3e';
            app.RelativetoleranceEditField.ValueChangedFcn = createCallbackFcn(app, @RelativetoleranceEditFieldValueChanged, true);
            app.RelativetoleranceEditField.Layout.Row = 14;
            app.RelativetoleranceEditField.Layout.Column = [13 14];
            app.RelativetoleranceEditField.Value = 0.001;

            % Create MaximumrepetitionsEditFieldLabel
            app.MaximumrepetitionsEditFieldLabel = uilabel(app.GridLayout8);
            app.MaximumrepetitionsEditFieldLabel.Layout.Row = 15;
            app.MaximumrepetitionsEditFieldLabel.Layout.Column = [11 12];
            app.MaximumrepetitionsEditFieldLabel.Text = 'Maximum repetitions';

            % Create MaximumrepetitionsEditField
            app.MaximumrepetitionsEditField = uieditfield(app.GridLayout8, 'numeric');
            app.MaximumrepetitionsEditField.Limits = [0 Inf];
            app.MaximumrepetitionsEditField.RoundFractionalValues = 'on';
            app.MaximumrepetitionsEditField.ValueChangedFcn = createCallbackFcn(app, @MaximumrepetitionsEditFieldValueChanged, true);
            app.MaximumrepetitionsEditField.Layout.Row = 15;
            app.MaximumrepetitionsEditField.Layout.Column = [13 14];
            app.MaximumrepetitionsEditField.Value = 10;

            % Create FittingconditionsLabel
            app.FittingconditionsLabel = uilabel(app.GridLayout8);
            app.FittingconditionsLabel.FontWeight = 'bold';
            app.FittingconditionsLabel.Layout.Row = 9;
            app.FittingconditionsLabel.Layout.Column = [10 14];
            app.FittingconditionsLabel.Text = 'Fitting conditions';

            % Create PlaygroundTab
            app.PlaygroundTab = uitab(app.TabGroup);
            app.PlaygroundTab.Title = 'Playground';

            % Create GridLayout3
            app.GridLayout3 = uigridlayout(app.PlaygroundTab);
            app.GridLayout3.ColumnWidth = {'1x', '1.3x', '0.5x', '1x', '1x', '1x', '1x', '1x', '0.5x', '1x', '1x', '1x', '1x', '1x'};
            app.GridLayout3.RowHeight = {'1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1.5x'};
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

            % Create PlotDropDown_3Label
            app.PlotDropDown_3Label = uilabel(app.GridLayout7);
            app.PlotDropDown_3Label.Layout.Row = 4;
            app.PlotDropDown_3Label.Layout.Column = 1;
            app.PlotDropDown_3Label.Text = 'Plot';

            % Create PlotDropDown_3
            app.PlotDropDown_3 = uidropdown(app.GridLayout7);
            app.PlotDropDown_3.Items = {'Last period only', 'Full history'};
            app.PlotDropDown_3.Layout.Row = 4;
            app.PlotDropDown_3.Layout.Column = [2 3];
            app.PlotDropDown_3.Value = 'Full history';

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

            % Create HarmoniccompHtsum_kA_ksinkomegatphi_kLabel
            app.HarmoniccompHtsum_kA_ksinkomegatphi_kLabel = uilabel(app.GridLayout7);
            app.HarmoniccompHtsum_kA_ksinkomegatphi_kLabel.Layout.Row = 6;
            app.HarmoniccompHtsum_kA_ksinkomegatphi_kLabel.Layout.Column = [1 4];
            app.HarmoniccompHtsum_kA_ksinkomegatphi_kLabel.Text = 'Harmonic comp.: H(t) = sum_k[A_k*sin(k*omega*t + phi_k)]';

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

            % Create MinorloopPanel
            app.MinorloopPanel = uipanel(app.GridLayout3);
            app.MinorloopPanel.Title = 'Minor loop';
            app.MinorloopPanel.Layout.Row = [2 14];
            app.MinorloopPanel.Layout.Column = [4 8];
            app.MinorloopPanel.Scrollable = 'on';

            % Create GridLayout6
            app.GridLayout6 = uigridlayout(app.MinorloopPanel);
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
            app.StopcriterionDropDown_2Label_3.Layout.Column = [1 4];
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

            % Create JilesAthertonmodelrateindependentLabel_2
            app.JilesAthertonmodelrateindependentLabel_2 = uilabel(app.GridLayout3);
            app.JilesAthertonmodelrateindependentLabel_2.FontWeight = 'bold';
            app.JilesAthertonmodelrateindependentLabel_2.Layout.Row = 1;
            app.JilesAthertonmodelrateindependentLabel_2.Layout.Column = [1 4];
            app.JilesAthertonmodelrateindependentLabel_2.Text = 'Jiles-Atherton model (rate-independent)';

            % Create ModelparametersLabel_2
            app.ModelparametersLabel_2 = uilabel(app.GridLayout3);
            app.ModelparametersLabel_2.FontWeight = 'bold';
            app.ModelparametersLabel_2.Layout.Row = 2;
            app.ModelparametersLabel_2.Layout.Column = [1 2];
            app.ModelparametersLabel_2.Text = 'Model parameters';

            % Create JsTEditFieldLabel_9
            app.JsTEditFieldLabel_9 = uilabel(app.GridLayout3);
            app.JsTEditFieldLabel_9.Layout.Row = 3;
            app.JsTEditFieldLabel_9.Layout.Column = 1;
            app.JsTEditFieldLabel_9.Text = 'Ms [A/m]';

            % Create JsField_9
            app.JsField_9 = uieditfield(app.GridLayout3, 'numeric');
            app.JsField_9.ValueDisplayFormat = '%.6g';
            app.JsField_9.AllowEmpty = 'on';
            app.JsField_9.Layout.Row = 3;
            app.JsField_9.Layout.Column = 2;
            app.JsField_9.Value = [];

            % Create JsTEditFieldLabel_10
            app.JsTEditFieldLabel_10 = uilabel(app.GridLayout3);
            app.JsTEditFieldLabel_10.Layout.Row = 4;
            app.JsTEditFieldLabel_10.Layout.Column = 1;
            app.JsTEditFieldLabel_10.Text = 'a [A/m]';

            % Create JsField_10
            app.JsField_10 = uieditfield(app.GridLayout3, 'numeric');
            app.JsField_10.ValueDisplayFormat = '%.6g';
            app.JsField_10.AllowEmpty = 'on';
            app.JsField_10.Layout.Row = 4;
            app.JsField_10.Layout.Column = 2;
            app.JsField_10.Value = [];

            % Create JsTEditFieldLabel_11
            app.JsTEditFieldLabel_11 = uilabel(app.GridLayout3);
            app.JsTEditFieldLabel_11.Layout.Row = 5;
            app.JsTEditFieldLabel_11.Layout.Column = 1;
            app.JsTEditFieldLabel_11.Text = 'α';

            % Create JsField_11
            app.JsField_11 = uieditfield(app.GridLayout3, 'numeric');
            app.JsField_11.ValueDisplayFormat = '%.5e';
            app.JsField_11.AllowEmpty = 'on';
            app.JsField_11.Layout.Row = 5;
            app.JsField_11.Layout.Column = 2;
            app.JsField_11.Value = [];

            % Create JsTEditFieldLabel_12
            app.JsTEditFieldLabel_12 = uilabel(app.GridLayout3);
            app.JsTEditFieldLabel_12.Layout.Row = 6;
            app.JsTEditFieldLabel_12.Layout.Column = 1;
            app.JsTEditFieldLabel_12.Text = 'c';

            % Create JsField_12
            app.JsField_12 = uieditfield(app.GridLayout3, 'numeric');
            app.JsField_12.ValueDisplayFormat = '%.6g';
            app.JsField_12.AllowEmpty = 'on';
            app.JsField_12.Layout.Row = 6;
            app.JsField_12.Layout.Column = 2;
            app.JsField_12.Value = [];

            % Create JsTEditFieldLabel_13
            app.JsTEditFieldLabel_13 = uilabel(app.GridLayout3);
            app.JsTEditFieldLabel_13.Layout.Row = 7;
            app.JsTEditFieldLabel_13.Layout.Column = 1;
            app.JsTEditFieldLabel_13.Text = 'k [A/m]';

            % Create JsField_13
            app.JsField_13 = uieditfield(app.GridLayout3, 'numeric');
            app.JsField_13.ValueDisplayFormat = '%.6g';
            app.JsField_13.AllowEmpty = 'on';
            app.JsField_13.Layout.Row = 7;
            app.JsField_13.Layout.Column = 2;
            app.JsField_13.Value = [];

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

            % Create OutputdataTab
            app.OutputdataTab = uitab(app.TabGroup);
            app.OutputdataTab.Title = 'Output data';

            % Create GridLayoutMagnetizationoutputdata
            app.GridLayoutMagnetizationoutputdata = uigridlayout(app.OutputdataTab);
            app.GridLayoutMagnetizationoutputdata.ColumnWidth = {'1x'};
            app.GridLayoutMagnetizationoutputdata.RowHeight = {'1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x'};
            app.GridLayoutMagnetizationoutputdata.RowSpacing = 5;

            % Create GridLayoutOutputDatasetPath
            app.GridLayoutOutputDatasetPath = uigridlayout(app.GridLayoutMagnetizationoutputdata);
            app.GridLayoutOutputDatasetPath.ColumnWidth = {'1.1x', '3x', '1x'};
            app.GridLayoutOutputDatasetPath.RowHeight = {'1x'};
            app.GridLayoutOutputDatasetPath.Padding = [0 0 0 0];
            app.GridLayoutOutputDatasetPath.Layout.Row = 1;
            app.GridLayoutOutputDatasetPath.Layout.Column = 1;

            % Create OutputDatasetpathLabel
            app.OutputDatasetpathLabel = uilabel(app.GridLayoutOutputDatasetPath);
            app.OutputDatasetpathLabel.FontWeight = 'bold';
            app.OutputDatasetpathLabel.Layout.Row = 1;
            app.OutputDatasetpathLabel.Layout.Column = 1;
            app.OutputDatasetpathLabel.Text = 'Dataset path';

            % Create OutputDatasetPath
            app.OutputDatasetPath = uieditfield(app.GridLayoutOutputDatasetPath, 'text');
            app.OutputDatasetPath.Layout.Row = 1;
            app.OutputDatasetPath.Layout.Column = 2;

            % Create OutputBrowseButton
            app.OutputBrowseButton = uibutton(app.GridLayoutOutputDatasetPath, 'push');
            app.OutputBrowseButton.ButtonPushedFcn = createCallbackFcn(app, @OutputBrowseButtonPushed, true);
            app.OutputBrowseButton.Layout.Row = 1;
            app.OutputBrowseButton.Layout.Column = 3;
            app.OutputBrowseButton.Text = 'Browse';

            % Create MagnetizationdataLabel
            app.MagnetizationdataLabel = uilabel(app.GridLayoutMagnetizationoutputdata);
            app.MagnetizationdataLabel.FontWeight = 'bold';
            app.MagnetizationdataLabel.Layout.Row = 2;
            app.MagnetizationdataLabel.Layout.Column = 1;
            app.MagnetizationdataLabel.Text = 'Magnetization data:';

            % Create GridLayoutMagnetizationDataFittedAnhystereticMagnetization
            app.GridLayoutMagnetizationDataFittedAnhystereticMagnetization = uigridlayout(app.GridLayoutMagnetizationoutputdata);
            app.GridLayoutMagnetizationDataFittedAnhystereticMagnetization.ColumnWidth = {'1.5x', '0.1x', '2.4x', '1x'};
            app.GridLayoutMagnetizationDataFittedAnhystereticMagnetization.RowHeight = {'1x'};
            app.GridLayoutMagnetizationDataFittedAnhystereticMagnetization.Padding = [0 0 0 0];
            app.GridLayoutMagnetizationDataFittedAnhystereticMagnetization.Layout.Row = 4;
            app.GridLayoutMagnetizationDataFittedAnhystereticMagnetization.Layout.Column = 1;

            % Create CheckBoxOutputMagnetizationDataFittedAnhystereticMagnetization
            app.CheckBoxOutputMagnetizationDataFittedAnhystereticMagnetization = uicheckbox(app.GridLayoutMagnetizationDataFittedAnhystereticMagnetization);
            app.CheckBoxOutputMagnetizationDataFittedAnhystereticMagnetization.Text = '';
            app.CheckBoxOutputMagnetizationDataFittedAnhystereticMagnetization.Layout.Row = 1;
            app.CheckBoxOutputMagnetizationDataFittedAnhystereticMagnetization.Layout.Column = 2;
            app.CheckBoxOutputMagnetizationDataFittedAnhystereticMagnetization.Value = true;

            % Create ModeledanhystereticmagnetizationLabel
            app.ModeledanhystereticmagnetizationLabel = uilabel(app.GridLayoutMagnetizationDataFittedAnhystereticMagnetization);
            app.ModeledanhystereticmagnetizationLabel.Layout.Row = 1;
            app.ModeledanhystereticmagnetizationLabel.Layout.Column = 1;
            app.ModeledanhystereticmagnetizationLabel.Text = 'Modeled anhysteretic magnetization';

            % Create EditFieldFileNameModeledAnhystereticMagnetization
            app.EditFieldFileNameModeledAnhystereticMagnetization = uieditfield(app.GridLayoutMagnetizationDataFittedAnhystereticMagnetization, 'text');
            app.EditFieldFileNameModeledAnhystereticMagnetization.HorizontalAlignment = 'right';
            app.EditFieldFileNameModeledAnhystereticMagnetization.Layout.Row = 1;
            app.EditFieldFileNameModeledAnhystereticMagnetization.Layout.Column = 3;
            app.EditFieldFileNameModeledAnhystereticMagnetization.Value = 'modeled_anhysteretic_magnetization';

            % Create DropDownOutputModeledAnhystereticMagnetizationExtension
            app.DropDownOutputModeledAnhystereticMagnetizationExtension = uidropdown(app.GridLayoutMagnetizationDataFittedAnhystereticMagnetization);
            app.DropDownOutputModeledAnhystereticMagnetizationExtension.Items = {'.csv'};
            app.DropDownOutputModeledAnhystereticMagnetizationExtension.Layout.Row = 1;
            app.DropDownOutputModeledAnhystereticMagnetizationExtension.Layout.Column = 4;
            app.DropDownOutputModeledAnhystereticMagnetizationExtension.Value = '.csv';

            % Create GridLayoutExportData
            app.GridLayoutExportData = uigridlayout(app.GridLayoutMagnetizationoutputdata);
            app.GridLayoutExportData.ColumnWidth = {'1.5x', '0.1x', '2.4x', '1x'};
            app.GridLayoutExportData.RowHeight = {'1x'};
            app.GridLayoutExportData.Padding = [0 0 0 0];
            app.GridLayoutExportData.Layout.Row = 5;
            app.GridLayoutExportData.Layout.Column = 1;

            % Create ExportdataButton
            app.ExportdataButton = uibutton(app.GridLayoutExportData, 'push');
            app.ExportdataButton.ButtonPushedFcn = createCallbackFcn(app, @ExportdataButtonPushed, true);
            app.ExportdataButton.Layout.Row = 1;
            app.ExportdataButton.Layout.Column = 4;
            app.ExportdataButton.Text = 'Export data';

            % Create OutputSeparateComponentsCheckBox
            app.OutputSeparateComponentsCheckBox = uicheckbox(app.GridLayoutExportData);
            app.OutputSeparateComponentsCheckBox.Text = '';
            app.OutputSeparateComponentsCheckBox.Layout.Row = 1;
            app.OutputSeparateComponentsCheckBox.Layout.Column = 2;
            app.OutputSeparateComponentsCheckBox.Value = true;

            % Create ModeledanhystereticmagnetizationcomponentsLabel
            app.ModeledanhystereticmagnetizationcomponentsLabel = uilabel(app.GridLayoutExportData);
            app.ModeledanhystereticmagnetizationcomponentsLabel.Layout.Row = 1;
            app.ModeledanhystereticmagnetizationcomponentsLabel.Layout.Column = 1;
            app.ModeledanhystereticmagnetizationcomponentsLabel.Text = 'Modeled anhysteretic magnetization components';

            % Create ParametersLabel
            app.ParametersLabel = uilabel(app.GridLayoutMagnetizationoutputdata);
            app.ParametersLabel.FontWeight = 'bold';
            app.ParametersLabel.Layout.Row = 6;
            app.ParametersLabel.Layout.Column = 1;
            app.ParametersLabel.Text = 'Parameters:';

            % Create GridLayoutExportParametersFile
            app.GridLayoutExportParametersFile = uigridlayout(app.GridLayoutMagnetizationoutputdata);
            app.GridLayoutExportParametersFile.ColumnWidth = {'0.8x', '0.8x', '2.4x', '1x'};
            app.GridLayoutExportParametersFile.RowHeight = {'1x'};
            app.GridLayoutExportParametersFile.Padding = [0 0 0 0];
            app.GridLayoutExportParametersFile.Layout.Row = 7;
            app.GridLayoutExportParametersFile.Layout.Column = 1;

            % Create EditFieldFileNameParameters
            app.EditFieldFileNameParameters = uieditfield(app.GridLayoutExportParametersFile, 'text');
            app.EditFieldFileNameParameters.HorizontalAlignment = 'right';
            app.EditFieldFileNameParameters.Layout.Row = 1;
            app.EditFieldFileNameParameters.Layout.Column = 3;
            app.EditFieldFileNameParameters.Value = 'parameters';

            % Create DropDownOutputParametersExtension
            app.DropDownOutputParametersExtension = uidropdown(app.GridLayoutExportParametersFile);
            app.DropDownOutputParametersExtension.Items = {'.txt'};
            app.DropDownOutputParametersExtension.Layout.Row = 1;
            app.DropDownOutputParametersExtension.Layout.Column = 4;
            app.DropDownOutputParametersExtension.Value = '.txt';

            % Create ExportFittedparametersCheckBox
            app.ExportFittedparametersCheckBox = uicheckbox(app.GridLayoutExportParametersFile);
            app.ExportFittedparametersCheckBox.Text = 'Fitted parameters';
            app.ExportFittedparametersCheckBox.Layout.Row = 1;
            app.ExportFittedparametersCheckBox.Layout.Column = 1;
            app.ExportFittedparametersCheckBox.Value = true;

            % Create ExportModelparametersCheckBox
            app.ExportModelparametersCheckBox = uicheckbox(app.GridLayoutExportParametersFile);
            app.ExportModelparametersCheckBox.Text = 'Model parameters';
            app.ExportModelparametersCheckBox.Layout.Row = 1;
            app.ExportModelparametersCheckBox.Layout.Column = 2;
            app.ExportModelparametersCheckBox.Value = true;

            % Create GridLayoutExportParametersButton
            app.GridLayoutExportParametersButton = uigridlayout(app.GridLayoutMagnetizationoutputdata);
            app.GridLayoutExportParametersButton.ColumnWidth = {'0.8x', '0.8x', '2.4x', '1x'};
            app.GridLayoutExportParametersButton.RowHeight = {'1x'};
            app.GridLayoutExportParametersButton.Padding = [0 0 0 0];
            app.GridLayoutExportParametersButton.Layout.Row = 8;
            app.GridLayoutExportParametersButton.Layout.Column = 1;

            % Create ExportParametersButton
            app.ExportParametersButton = uibutton(app.GridLayoutExportParametersButton, 'push');
            app.ExportParametersButton.ButtonPushedFcn = createCallbackFcn(app, @ExportParametersButtonPushed, true);
            app.ExportParametersButton.Layout.Row = 1;
            app.ExportParametersButton.Layout.Column = 4;
            app.ExportParametersButton.Text = 'Export data';

            % Create ExportOtherquantitiesCheckBox
            app.ExportOtherquantitiesCheckBox = uicheckbox(app.GridLayoutExportParametersButton);
            app.ExportOtherquantitiesCheckBox.Text = 'Other quantities';
            app.ExportOtherquantitiesCheckBox.Layout.Row = 1;
            app.ExportOtherquantitiesCheckBox.Layout.Column = 1;
            app.ExportOtherquantitiesCheckBox.Value = true;

            % Create ExportErrorsCheckBox
            app.ExportErrorsCheckBox = uicheckbox(app.GridLayoutExportParametersButton);
            app.ExportErrorsCheckBox.Text = 'Errors';
            app.ExportErrorsCheckBox.Layout.Row = 1;
            app.ExportErrorsCheckBox.Layout.Column = 2;
            app.ExportErrorsCheckBox.Value = true;

            % Create PlotsLabel
            app.PlotsLabel = uilabel(app.GridLayoutMagnetizationoutputdata);
            app.PlotsLabel.FontWeight = 'bold';
            app.PlotsLabel.Layout.Row = 9;
            app.PlotsLabel.Layout.Column = 1;
            app.PlotsLabel.Text = 'Plots:';

            % Create GridLayoutExportPlotMagnetization
            app.GridLayoutExportPlotMagnetization = uigridlayout(app.GridLayoutMagnetizationoutputdata);
            app.GridLayoutExportPlotMagnetization.ColumnWidth = {'1.5x', '0.1x', '2.4x', '1x'};
            app.GridLayoutExportPlotMagnetization.RowHeight = {'1x'};
            app.GridLayoutExportPlotMagnetization.Padding = [0 0 0 0];
            app.GridLayoutExportPlotMagnetization.Layout.Row = 10;
            app.GridLayoutExportPlotMagnetization.Layout.Column = 1;

            % Create MagnetizationPlotExportLabel
            app.MagnetizationPlotExportLabel = uilabel(app.GridLayoutExportPlotMagnetization);
            app.MagnetizationPlotExportLabel.Layout.Row = 1;
            app.MagnetizationPlotExportLabel.Layout.Column = 1;
            app.MagnetizationPlotExportLabel.Text = 'Magnetization';

            % Create CheckBoxExportPlotMagnetization
            app.CheckBoxExportPlotMagnetization = uicheckbox(app.GridLayoutExportPlotMagnetization);
            app.CheckBoxExportPlotMagnetization.Text = '';
            app.CheckBoxExportPlotMagnetization.Layout.Row = 1;
            app.CheckBoxExportPlotMagnetization.Layout.Column = 2;
            app.CheckBoxExportPlotMagnetization.Value = true;

            % Create EditFieldFileNamePlotMagnetization
            app.EditFieldFileNamePlotMagnetization = uieditfield(app.GridLayoutExportPlotMagnetization, 'text');
            app.EditFieldFileNamePlotMagnetization.HorizontalAlignment = 'right';
            app.EditFieldFileNamePlotMagnetization.Layout.Row = 1;
            app.EditFieldFileNamePlotMagnetization.Layout.Column = 3;
            app.EditFieldFileNamePlotMagnetization.Value = 'M';

            % Create DropDownPlotMagnetizacionExtension
            app.DropDownPlotMagnetizacionExtension = uidropdown(app.GridLayoutExportPlotMagnetization);
            app.DropDownPlotMagnetizacionExtension.Items = {'.png'};
            app.DropDownPlotMagnetizacionExtension.Layout.Row = 1;
            app.DropDownPlotMagnetizacionExtension.Layout.Column = 4;
            app.DropDownPlotMagnetizacionExtension.Value = '.png';

            % Create GridLayoutExportPlotSusceptibility
            app.GridLayoutExportPlotSusceptibility = uigridlayout(app.GridLayoutMagnetizationoutputdata);
            app.GridLayoutExportPlotSusceptibility.ColumnWidth = {'1.5x', '0.1x', '2.4x', '1x'};
            app.GridLayoutExportPlotSusceptibility.RowHeight = {'1x'};
            app.GridLayoutExportPlotSusceptibility.Padding = [0 0 0 0];
            app.GridLayoutExportPlotSusceptibility.Layout.Row = 11;
            app.GridLayoutExportPlotSusceptibility.Layout.Column = 1;

            % Create SusceptibilityPlotExportLabel
            app.SusceptibilityPlotExportLabel = uilabel(app.GridLayoutExportPlotSusceptibility);
            app.SusceptibilityPlotExportLabel.Layout.Row = 1;
            app.SusceptibilityPlotExportLabel.Layout.Column = 1;
            app.SusceptibilityPlotExportLabel.Text = 'Susceptibility';

            % Create CheckBoxExportPlotSusceptibility
            app.CheckBoxExportPlotSusceptibility = uicheckbox(app.GridLayoutExportPlotSusceptibility);
            app.CheckBoxExportPlotSusceptibility.Text = '';
            app.CheckBoxExportPlotSusceptibility.Layout.Row = 1;
            app.CheckBoxExportPlotSusceptibility.Layout.Column = 2;
            app.CheckBoxExportPlotSusceptibility.Value = true;

            % Create EditFieldFileNamePlotSusceptibility
            app.EditFieldFileNamePlotSusceptibility = uieditfield(app.GridLayoutExportPlotSusceptibility, 'text');
            app.EditFieldFileNamePlotSusceptibility.HorizontalAlignment = 'right';
            app.EditFieldFileNamePlotSusceptibility.Layout.Row = 1;
            app.EditFieldFileNamePlotSusceptibility.Layout.Column = 3;
            app.EditFieldFileNamePlotSusceptibility.Value = 'dMdH';

            % Create DropDownPlotSusceptibilityExtension
            app.DropDownPlotSusceptibilityExtension = uidropdown(app.GridLayoutExportPlotSusceptibility);
            app.DropDownPlotSusceptibilityExtension.Items = {'.png'};
            app.DropDownPlotSusceptibilityExtension.Layout.Row = 1;
            app.DropDownPlotSusceptibilityExtension.Layout.Column = 4;
            app.DropDownPlotSusceptibilityExtension.Value = '.png';

            % Create GridLayoutExportPlotSemiLogMagDerivative
            app.GridLayoutExportPlotSemiLogMagDerivative = uigridlayout(app.GridLayoutMagnetizationoutputdata);
            app.GridLayoutExportPlotSemiLogMagDerivative.ColumnWidth = {'1.5x', '0.1x', '2.4x', '1x'};
            app.GridLayoutExportPlotSemiLogMagDerivative.RowHeight = {'1x'};
            app.GridLayoutExportPlotSemiLogMagDerivative.Padding = [0 0 0 0];
            app.GridLayoutExportPlotSemiLogMagDerivative.Layout.Row = 12;
            app.GridLayoutExportPlotSemiLogMagDerivative.Layout.Column = 1;

            % Create SemilogmagnetizationderivativePlotExportLabel
            app.SemilogmagnetizationderivativePlotExportLabel = uilabel(app.GridLayoutExportPlotSemiLogMagDerivative);
            app.SemilogmagnetizationderivativePlotExportLabel.Layout.Row = 1;
            app.SemilogmagnetizationderivativePlotExportLabel.Layout.Column = 1;
            app.SemilogmagnetizationderivativePlotExportLabel.Text = 'Semi-log magnetization derivative';

            % Create CheckBoxExportPlotSemiLogMagDerivative
            app.CheckBoxExportPlotSemiLogMagDerivative = uicheckbox(app.GridLayoutExportPlotSemiLogMagDerivative);
            app.CheckBoxExportPlotSemiLogMagDerivative.Text = '';
            app.CheckBoxExportPlotSemiLogMagDerivative.Layout.Row = 1;
            app.CheckBoxExportPlotSemiLogMagDerivative.Layout.Column = 2;
            app.CheckBoxExportPlotSemiLogMagDerivative.Value = true;

            % Create EditFieldFileNamePlotSemiLogMagDerivative
            app.EditFieldFileNamePlotSemiLogMagDerivative = uieditfield(app.GridLayoutExportPlotSemiLogMagDerivative, 'text');
            app.EditFieldFileNamePlotSemiLogMagDerivative.HorizontalAlignment = 'right';
            app.EditFieldFileNamePlotSemiLogMagDerivative.Layout.Row = 1;
            app.EditFieldFileNamePlotSemiLogMagDerivative.Layout.Column = 3;
            app.EditFieldFileNamePlotSemiLogMagDerivative.Value = 'dMdlnH';

            % Create DropDownPlotSemiLogMagDerivativeExtension
            app.DropDownPlotSemiLogMagDerivativeExtension = uidropdown(app.GridLayoutExportPlotSemiLogMagDerivative);
            app.DropDownPlotSemiLogMagDerivativeExtension.Items = {'.png'};
            app.DropDownPlotSemiLogMagDerivativeExtension.Layout.Row = 1;
            app.DropDownPlotSemiLogMagDerivativeExtension.Layout.Column = 4;
            app.DropDownPlotSemiLogMagDerivativeExtension.Value = '.png';

            % Create GridLayoutExportPlotsButton
            app.GridLayoutExportPlotsButton = uigridlayout(app.GridLayoutMagnetizationoutputdata);
            app.GridLayoutExportPlotsButton.ColumnWidth = {'0.8x', '0.8x', '2.4x', '1x'};
            app.GridLayoutExportPlotsButton.RowHeight = {'1x'};
            app.GridLayoutExportPlotsButton.Padding = [0 0 0 0];
            app.GridLayoutExportPlotsButton.Layout.Row = 13;
            app.GridLayoutExportPlotsButton.Layout.Column = 1;

            % Create ExportPlotsButton
            app.ExportPlotsButton = uibutton(app.GridLayoutExportPlotsButton, 'push');
            app.ExportPlotsButton.ButtonPushedFcn = createCallbackFcn(app, @ExportPlotsButtonPushed, true);
            app.ExportPlotsButton.Layout.Row = 1;
            app.ExportPlotsButton.Layout.Column = 4;
            app.ExportPlotsButton.Text = 'Export plots';

            % Create GridLayoutExportResiduesMagnetization
            app.GridLayoutExportResiduesMagnetization = uigridlayout(app.GridLayoutMagnetizationoutputdata);
            app.GridLayoutExportResiduesMagnetization.ColumnWidth = {'1.5x', '0.1x', '2.4x', '1x'};
            app.GridLayoutExportResiduesMagnetization.RowHeight = {'1x'};
            app.GridLayoutExportResiduesMagnetization.Padding = [0 0 0 0];
            app.GridLayoutExportResiduesMagnetization.Layout.Row = 15;
            app.GridLayoutExportResiduesMagnetization.Layout.Column = 1;

            % Create MagnetizationExportResiduesLabel
            app.MagnetizationExportResiduesLabel = uilabel(app.GridLayoutExportResiduesMagnetization);
            app.MagnetizationExportResiduesLabel.Layout.Row = 1;
            app.MagnetizationExportResiduesLabel.Layout.Column = 1;
            app.MagnetizationExportResiduesLabel.Text = 'Magnetization';

            % Create CheckBoxExportResiduesMagnetization
            app.CheckBoxExportResiduesMagnetization = uicheckbox(app.GridLayoutExportResiduesMagnetization);
            app.CheckBoxExportResiduesMagnetization.Text = '';
            app.CheckBoxExportResiduesMagnetization.Layout.Row = 1;
            app.CheckBoxExportResiduesMagnetization.Layout.Column = 2;
            app.CheckBoxExportResiduesMagnetization.Value = true;

            % Create EditFieldFileNameResiduesMagnetization
            app.EditFieldFileNameResiduesMagnetization = uieditfield(app.GridLayoutExportResiduesMagnetization, 'text');
            app.EditFieldFileNameResiduesMagnetization.HorizontalAlignment = 'right';
            app.EditFieldFileNameResiduesMagnetization.Layout.Row = 1;
            app.EditFieldFileNameResiduesMagnetization.Layout.Column = 3;
            app.EditFieldFileNameResiduesMagnetization.Value = 'residual_M';

            % Create DropDownResiduesMagnetizacionExtension
            app.DropDownResiduesMagnetizacionExtension = uidropdown(app.GridLayoutExportResiduesMagnetization);
            app.DropDownResiduesMagnetizacionExtension.Items = {'.csv'};
            app.DropDownResiduesMagnetizacionExtension.Layout.Row = 1;
            app.DropDownResiduesMagnetizacionExtension.Layout.Column = 4;
            app.DropDownResiduesMagnetizacionExtension.Value = '.csv';

            % Create ResidualplotsdataLabel
            app.ResidualplotsdataLabel = uilabel(app.GridLayoutMagnetizationoutputdata);
            app.ResidualplotsdataLabel.FontWeight = 'bold';
            app.ResidualplotsdataLabel.Layout.Row = 14;
            app.ResidualplotsdataLabel.Layout.Column = 1;
            app.ResidualplotsdataLabel.Text = 'Residual plots data:';

            % Create GridLayoutExportResiduesSusceptibility
            app.GridLayoutExportResiduesSusceptibility = uigridlayout(app.GridLayoutMagnetizationoutputdata);
            app.GridLayoutExportResiduesSusceptibility.ColumnWidth = {'1.5x', '0.1x', '2.4x', '1x'};
            app.GridLayoutExportResiduesSusceptibility.RowHeight = {'1x'};
            app.GridLayoutExportResiduesSusceptibility.Padding = [0 0 0 0];
            app.GridLayoutExportResiduesSusceptibility.Layout.Row = 16;
            app.GridLayoutExportResiduesSusceptibility.Layout.Column = 1;

            % Create SusceptibilityResiduesExportLabel
            app.SusceptibilityResiduesExportLabel = uilabel(app.GridLayoutExportResiduesSusceptibility);
            app.SusceptibilityResiduesExportLabel.Layout.Row = 1;
            app.SusceptibilityResiduesExportLabel.Layout.Column = 1;
            app.SusceptibilityResiduesExportLabel.Text = 'Susceptibility';

            % Create CheckBoxExportResiduesSusceptibility
            app.CheckBoxExportResiduesSusceptibility = uicheckbox(app.GridLayoutExportResiduesSusceptibility);
            app.CheckBoxExportResiduesSusceptibility.Text = '';
            app.CheckBoxExportResiduesSusceptibility.Layout.Row = 1;
            app.CheckBoxExportResiduesSusceptibility.Layout.Column = 2;
            app.CheckBoxExportResiduesSusceptibility.Value = true;

            % Create EditFieldFileNameResiduesSusceptibility
            app.EditFieldFileNameResiduesSusceptibility = uieditfield(app.GridLayoutExportResiduesSusceptibility, 'text');
            app.EditFieldFileNameResiduesSusceptibility.HorizontalAlignment = 'right';
            app.EditFieldFileNameResiduesSusceptibility.Layout.Row = 1;
            app.EditFieldFileNameResiduesSusceptibility.Layout.Column = 3;
            app.EditFieldFileNameResiduesSusceptibility.Value = 'residual_dMdH';

            % Create DropDownResiduesSusceptibilityExtension
            app.DropDownResiduesSusceptibilityExtension = uidropdown(app.GridLayoutExportResiduesSusceptibility);
            app.DropDownResiduesSusceptibilityExtension.Items = {'.csv'};
            app.DropDownResiduesSusceptibilityExtension.Layout.Row = 1;
            app.DropDownResiduesSusceptibilityExtension.Layout.Column = 4;
            app.DropDownResiduesSusceptibilityExtension.Value = '.csv';

            % Create GridLayoutExportResiduesSemiLogMagDerivative
            app.GridLayoutExportResiduesSemiLogMagDerivative = uigridlayout(app.GridLayoutMagnetizationoutputdata);
            app.GridLayoutExportResiduesSemiLogMagDerivative.ColumnWidth = {'1.5x', '0.1x', '2.4x', '1x'};
            app.GridLayoutExportResiduesSemiLogMagDerivative.RowHeight = {'1x'};
            app.GridLayoutExportResiduesSemiLogMagDerivative.Padding = [0 0 0 0];
            app.GridLayoutExportResiduesSemiLogMagDerivative.Layout.Row = 17;
            app.GridLayoutExportResiduesSemiLogMagDerivative.Layout.Column = 1;

            % Create SemilogmagnetizationderivativeResiduesExportLabel
            app.SemilogmagnetizationderivativeResiduesExportLabel = uilabel(app.GridLayoutExportResiduesSemiLogMagDerivative);
            app.SemilogmagnetizationderivativeResiduesExportLabel.Layout.Row = 1;
            app.SemilogmagnetizationderivativeResiduesExportLabel.Layout.Column = 1;
            app.SemilogmagnetizationderivativeResiduesExportLabel.Text = 'Semi-log magnetization derivative';

            % Create CheckBoxExportResiduesSemiLogMagDerivative
            app.CheckBoxExportResiduesSemiLogMagDerivative = uicheckbox(app.GridLayoutExportResiduesSemiLogMagDerivative);
            app.CheckBoxExportResiduesSemiLogMagDerivative.Text = '';
            app.CheckBoxExportResiduesSemiLogMagDerivative.Layout.Row = 1;
            app.CheckBoxExportResiduesSemiLogMagDerivative.Layout.Column = 2;
            app.CheckBoxExportResiduesSemiLogMagDerivative.Value = true;

            % Create EditFieldFileNameResiduesSemiLogMagDerivative
            app.EditFieldFileNameResiduesSemiLogMagDerivative = uieditfield(app.GridLayoutExportResiduesSemiLogMagDerivative, 'text');
            app.EditFieldFileNameResiduesSemiLogMagDerivative.HorizontalAlignment = 'right';
            app.EditFieldFileNameResiduesSemiLogMagDerivative.Layout.Row = 1;
            app.EditFieldFileNameResiduesSemiLogMagDerivative.Layout.Column = 3;
            app.EditFieldFileNameResiduesSemiLogMagDerivative.Value = 'residual_dMdlnH';

            % Create DropDownResiduesSemiLogMagDerivativeExtension
            app.DropDownResiduesSemiLogMagDerivativeExtension = uidropdown(app.GridLayoutExportResiduesSemiLogMagDerivative);
            app.DropDownResiduesSemiLogMagDerivativeExtension.Items = {'.csv'};
            app.DropDownResiduesSemiLogMagDerivativeExtension.Layout.Row = 1;
            app.DropDownResiduesSemiLogMagDerivativeExtension.Layout.Column = 4;
            app.DropDownResiduesSemiLogMagDerivativeExtension.Value = '.csv';

            % Create GridLayoutExportResiduesButton
            app.GridLayoutExportResiduesButton = uigridlayout(app.GridLayoutMagnetizationoutputdata);
            app.GridLayoutExportResiduesButton.ColumnWidth = {'0.8x', '0.8x', '2.4x', '1x'};
            app.GridLayoutExportResiduesButton.RowHeight = {'1x'};
            app.GridLayoutExportResiduesButton.Padding = [0 0 0 0];
            app.GridLayoutExportResiduesButton.Layout.Row = 18;
            app.GridLayoutExportResiduesButton.Layout.Column = 1;

            % Create ExportResiduesButton
            app.ExportResiduesButton = uibutton(app.GridLayoutExportResiduesButton, 'push');
            app.ExportResiduesButton.ButtonPushedFcn = createCallbackFcn(app, @ExportResiduesButtonPushed, true);
            app.ExportResiduesButton.Layout.Row = 1;
            app.ExportResiduesButton.Layout.Column = 4;
            app.ExportResiduesButton.Text = 'Export data';

            % Create GridLayoutExperimentalMagnetizationData
            app.GridLayoutExperimentalMagnetizationData = uigridlayout(app.GridLayoutMagnetizationoutputdata);
            app.GridLayoutExperimentalMagnetizationData.ColumnWidth = {'1.5x', '0.1x', '2.4x', '1x'};
            app.GridLayoutExperimentalMagnetizationData.RowHeight = {'1x'};
            app.GridLayoutExperimentalMagnetizationData.Padding = [0 0 0 0];
            app.GridLayoutExperimentalMagnetizationData.Layout.Row = 3;
            app.GridLayoutExperimentalMagnetizationData.Layout.Column = 1;

            % Create CheckBoxExperimentalMagnetization
            app.CheckBoxExperimentalMagnetization = uicheckbox(app.GridLayoutExperimentalMagnetizationData);
            app.CheckBoxExperimentalMagnetization.Text = '';
            app.CheckBoxExperimentalMagnetization.Layout.Row = 1;
            app.CheckBoxExperimentalMagnetization.Layout.Column = 2;
            app.CheckBoxExperimentalMagnetization.Value = true;

            % Create ExperimentalanhystereticmagnetizationLabel
            app.ExperimentalanhystereticmagnetizationLabel = uilabel(app.GridLayoutExperimentalMagnetizationData);
            app.ExperimentalanhystereticmagnetizationLabel.Layout.Row = 1;
            app.ExperimentalanhystereticmagnetizationLabel.Layout.Column = 1;
            app.ExperimentalanhystereticmagnetizationLabel.Text = 'Experimental anhysteretic magnetization';

            % Create EditFieldFileNameExperimentalMagnetizationData
            app.EditFieldFileNameExperimentalMagnetizationData = uieditfield(app.GridLayoutExperimentalMagnetizationData, 'text');
            app.EditFieldFileNameExperimentalMagnetizationData.HorizontalAlignment = 'right';
            app.EditFieldFileNameExperimentalMagnetizationData.Layout.Row = 1;
            app.EditFieldFileNameExperimentalMagnetizationData.Layout.Column = 3;
            app.EditFieldFileNameExperimentalMagnetizationData.Value = 'experimental_anhysteretic_magnetization';

            % Create DropDownOutputExperimentalMagnetizationData
            app.DropDownOutputExperimentalMagnetizationData = uidropdown(app.GridLayoutExperimentalMagnetizationData);
            app.DropDownOutputExperimentalMagnetizationData.Items = {'.csv'};
            app.DropDownOutputExperimentalMagnetizationData.Layout.Row = 1;
            app.DropDownOutputExperimentalMagnetizationData.Layout.Column = 4;
            app.DropDownOutputExperimentalMagnetizationData.Value = '.csv';

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