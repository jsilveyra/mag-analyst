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
        MessagesTab                     matlab.ui.container.Tab
        MessagesGridLayout              matlab.ui.container.GridLayout
        MessagesTextArea                matlab.ui.control.TextArea
        TabGroup                        matlab.ui.container.TabGroup
        InputdataTab                    matlab.ui.container.Tab
        GridLayoutMagnetizationInputData  matlab.ui.container.GridLayout
        GridLayoutInputPlot             matlab.ui.container.GridLayout
        GridLayoutInputTipsAndPlotButton  matlab.ui.container.GridLayout
        GridLayoutTips_3                matlab.ui.container.GridLayout
        InputApplyPointsButton          matlab.ui.control.Button
        InputNumberofPointsLabel        matlab.ui.control.Label
        InputNumberofPointsEditField    matlab.ui.control.NumericEditField
        GridLayoutTips_2                matlab.ui.container.GridLayout
        AxisscaleLabel                  matlab.ui.control.Label
        InputAxisScaleDropDown          matlab.ui.control.DropDown
        GridLayoutTips                  matlab.ui.container.GridLayout
        MTipField                       matlab.ui.control.EditField
        MtipAmLabel                     matlab.ui.control.Label
        HTipField                       matlab.ui.control.EditField
        HtipAmLabel                     matlab.ui.control.Label
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
        FittedparametersLabel           matlab.ui.control.Label
        GridLayoutModeledCurve          matlab.ui.container.GridLayout
        SetColorsButton                 matlab.ui.control.Button
        PointSpaceDropDown              matlab.ui.control.DropDown
        NofpointsEditField              matlab.ui.control.NumericEditField
        NofpointsEditFieldLabel         matlab.ui.control.Label
        NofcompSpinner                  matlab.ui.control.Spinner
        NofcompSpinnerLabel             matlab.ui.control.Label
        ModeledcurveLabel               matlab.ui.control.Label
        TableQuantities                 matlab.ui.control.Table
        GridLayoutOtherQuantities       matlab.ui.container.GridLayout
        murinLabel                      matlab.ui.control.Label
        murinField                      matlab.ui.control.EditField
        JsField                         matlab.ui.control.EditField
        JsTEditFieldLabel               matlab.ui.control.Label
        OthercalculatedquantitiesLabel  matlab.ui.control.Label
        GridLayoutButtons               matlab.ui.container.GridLayout
        StopfitButton                   matlab.ui.control.Button
        ErrorDisplay                    matlab.ui.control.EditField
        ErrortominimizeDropDown         matlab.ui.control.DropDown
        ErrortominimizeDropDownLabel    matlab.ui.control.Label
        CalculatePlotButton             matlab.ui.control.Button
        FitButton                       matlab.ui.control.Button
        TableParameters                 matlab.ui.control.Table
        ModelretrievedparametersLabel   matlab.ui.control.Label
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
        AxesM                           matlab.ui.control.UIAxes
        AxesdMdH                        matlab.ui.control.UIAxes
        AxesHdMdH                       matlab.ui.control.UIAxes
        HystereticfittingTab            matlab.ui.container.Tab
        GridLayout2                     matlab.ui.container.GridLayout
        StopfitButton_2                 matlab.ui.control.Button
        MaxrepetEditField               matlab.ui.control.NumericEditField
        MaxrepetEditFieldLabel          matlab.ui.control.Label
        ReltoleranceEditField_3         matlab.ui.control.NumericEditField
        ReltoleranceEditField_3Label    matlab.ui.control.Label
        RepetitionsEditField_3          matlab.ui.control.NumericEditField
        RepetitionsEditField_3Label     matlab.ui.control.Label
        StopcriterionDropDown_5         matlab.ui.control.DropDown
        StopcriterionDropDown_5Label    matlab.ui.control.Label
        FittingregionDropDown           matlab.ui.control.DropDown
        FittingregionDropDownLabel      matlab.ui.control.Label
        StartingpointDropDown_4         matlab.ui.control.DropDown
        StartingpointDropDown_4Label    matlab.ui.control.Label
        kConstrainedCheckBox_2          matlab.ui.control.CheckBox
        Label                           matlab.ui.control.Label
        FitkCheckBox                    matlab.ui.control.CheckBox
        CheckBox_4                      matlab.ui.control.CheckBox
        CheckBox_3                      matlab.ui.control.CheckBox
        CheckBox_2                      matlab.ui.control.CheckBox
        CheckBox                        matlab.ui.control.CheckBox
        FitLabel                        matlab.ui.control.Label
        UpperboundLabel                 matlab.ui.control.Label
        LowerboundLabel                 matlab.ui.control.Label
        kUpperField_2                   matlab.ui.control.EditField
        kLowerField_2                   matlab.ui.control.EditField
        cUpperField_2                   matlab.ui.control.EditField
        cLowerField_2                   matlab.ui.control.EditField
        alphaUpperField_2               matlab.ui.control.EditField
        alphaLowerField_2               matlab.ui.control.EditField
        aUpperField_2                   matlab.ui.control.EditField
        aLowerField_2                   matlab.ui.control.EditField
        MsUpperField_2                  matlab.ui.control.EditField
        MsLowerField_2                  matlab.ui.control.EditField
        JsField_8                       matlab.ui.control.EditField
        JsTEditFieldLabel_8             matlab.ui.control.Label
        ResidualplotButtondMdH_2        matlab.ui.control.Button
        ShowgridCheckBoxM_2             matlab.ui.control.CheckBox
        JsField_7                       matlab.ui.control.EditField
        JsTEditFieldLabel_7             matlab.ui.control.Label
        DrivingfieldLabel               matlab.ui.control.Label
        RetrieveseedsButton             matlab.ui.control.Button
        ErrorDisplay_2                  matlab.ui.control.EditField
        ErrortominimizeDropDown_2       matlab.ui.control.DropDown
        ErrortominimizeDropDownLabel_2  matlab.ui.control.Label
        CalculatePlotButton_2           matlab.ui.control.Button
        FitButton_2                     matlab.ui.control.Button
        JsField_6                       matlab.ui.control.EditField
        JsTEditFieldLabel_6             matlab.ui.control.Label
        JsField_5                       matlab.ui.control.EditField
        JsTEditFieldLabel_5             matlab.ui.control.Label
        JsField_4                       matlab.ui.control.EditField
        JsTEditFieldLabel_4             matlab.ui.control.Label
        JsField_3                       matlab.ui.control.EditField
        JsTEditFieldLabel_3             matlab.ui.control.Label
        JsField_2                       matlab.ui.control.EditField
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
        JsField_13                      matlab.ui.control.EditField
        JsTEditFieldLabel_13            matlab.ui.control.Label
        JsField_12                      matlab.ui.control.EditField
        JsTEditFieldLabel_12            matlab.ui.control.Label
        JsField_11                      matlab.ui.control.EditField
        JsTEditFieldLabel_11            matlab.ui.control.Label
        JsField_10                      matlab.ui.control.EditField
        JsTEditFieldLabel_10            matlab.ui.control.Label
        JsField_9                       matlab.ui.control.EditField
        JsTEditFieldLabel_9             matlab.ui.control.Label
        ModelparametersLabel_2          matlab.ui.control.Label
        JilesAthertonmodelrateindependentLabel_2  matlab.ui.control.Label
        MajorloopwithharmonicsPanel     matlab.ui.container.Panel
        GridLayout7                     matlab.ui.container.GridLayout
        HarmoniccompHtsum_kA_ksinkomegatphi_kLabel  matlab.ui.control.Label
        UITable2                        matlab.ui.control.Table
        PlotDropDown_3                  matlab.ui.control.DropDown
        PlotDropDown_3Label             matlab.ui.control.Label
        ReltoleranceEditField_4         matlab.ui.control.NumericEditField
        ReltoleranceEditField_4Label    matlab.ui.control.Label
        PeriodsEditField                matlab.ui.control.NumericEditField
        PeriodsEditFieldLabel           matlab.ui.control.Label
        StopcriterionDropDown_6         matlab.ui.control.DropDown
        StopcriterionDropDown_6Label    matlab.ui.control.Label
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
        MinorloopPanel                  matlab.ui.container.Panel
        GridLayout6                     matlab.ui.container.GridLayout
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
    end
    
    methods (Access = public)
        %% =====================================================
        %  Safe file & folder helpers (cancel-safe, portable)
        %  =====================================================
        %  MOD: New helpers to centralize file dialogs and paths

        function fullpath = safe_getfile(app, filter, startpath, dialogTitle) % MOD
            if nargin < 4 || strlength(string(dialogTitle)) == 0
                dialogTitle = "Select file";
            end
            if nargin < 3 || strlength(string(startpath)) == 0
                startpath = pwd;
            end

            [file, path] = uigetfile(filter, char(dialogTitle), char(startpath));

            if isequal(file,0) || isequal(path,0)
                fullpath = "";
                return;
            end

            fullpath = string(fullfile(path, file));
        end


        function fullpath = safe_putfile(app, filter, startpath, dialogTitle, defaultName) % MOD
            if nargin < 5
                defaultName = "";
            end
            if nargin < 4 || strlength(string(dialogTitle)) == 0
                dialogTitle = "Save file";
            end
            if nargin < 3 || strlength(string(startpath)) == 0
                startpath = pwd;
            end

            if strlength(string(defaultName)) > 0
                startpath = fullfile(startpath, char(defaultName));
            end

            [file, path] = uiputfile(filter, char(dialogTitle), char(startpath));

            if isequal(file,0) || isequal(path,0)
                fullpath = "";
                return;
            end

            fullpath = string(fullfile(path, file));
        end


        function folder = safe_getdir(app, startpath, dialogTitle) % MOD
            if nargin < 3 || strlength(string(dialogTitle)) == 0
                dialogTitle = "Select folder";
            end
            if nargin < 2 || strlength(string(startpath)) == 0
                startpath = pwd;
            end

            p = uigetdir(char(startpath), char(dialogTitle));

            if isequal(p,0)
                folder = "";
            else
                folder = string(p);
            end
        end


        function folder = default_data_folder(app) % MOD
            base = "";
            if ~isempty(app.AppRoot)
                candidate = fullfile(app.AppRoot, "data");
                if isfolder(candidate)
                    base = candidate;
                end
            end

            if strlength(string(base)) == 0
                base = fullfile(pwd, "data");
            end

            folder = string(base);
        end


        function ensure_folder(~, folder) % MOD
            if strlength(string(folder)) == 0
                return;
            end
            if ~isfolder(folder)
                mkdir(folder);
            end
        end
%%
        function adjustWindow(app)
        
            scr = get(groot,'ScreenSize');
            pos = app.MagAnalystUIFigure.Position;
        
            maxHeight = scr(4) * 0.85;
            if pos(4) > maxHeight
                pos(4) = maxHeight;
            end
        
            pos(1) = max(40, (scr(3) - pos(3))/2);
            pos(2) = max(40, (scr(4) - pos(4))/2);
        
            app.MagAnalystUIFigure.Position = pos;
            figure(app.MagAnalystUIFigure);  % devolver foco
        end

        function plot(app)
            AnhystereticUtils.plot(app);
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
            [HTip, MTip] = Utils().find_tip(app.data_curve.H, app.data_curve.M);
            app.MTipField.Value = app.format_short(MTip);
            app.HTipField.Value = app.format_short(HTip);
            app.JsField_7.Value = app.format_short(HTip);
            app.JsField_8.Value = app.format_short(MTip);
            cla(app.AxesProcessedInputData, 'reset')
            cla(app.AxesRawInputData, 'reset')
            plotter = Plotter(app.data_curve, app.modeled_curve, [], app.Colors, 5);

            axis_scale = string(app.InputAxisScaleDropDown.Value);
            if app.axis_scale_has_x(axis_scale)
                plotter.plot_raw_log(app.AxesProcessedInputData, app.data_curve.H, app.data_curve.M, 'H [A/m]', 'M [A/m]', 'Processed input data');
                plotter.plot_raw_log(app.AxesRawInputData, app.H_raw, app.M_raw, app.HorizontalaxisfieldDropDown.Value, app.VerticalaxisfieldDropDown.Value, 'Raw input data');
            else
                plotter.plot_raw(app.AxesProcessedInputData, app.data_curve.H, app.data_curve.M, 'H [A/m]', 'M [A/m]', 'Processed input data');
                plotter.plot_raw(app.AxesRawInputData, app.H_raw, app.M_raw, app.HorizontalaxisfieldDropDown.Value, app.VerticalaxisfieldDropDown.Value, 'Raw input data');
            end

            app.apply_axis_scale(app.AxesProcessedInputData, axis_scale);
            app.apply_axis_scale(app.AxesRawInputData, axis_scale);
        end

        function plot_playground(app)
            ax = app.AxesM_5;
            cla(ax, 'reset');
            hold(ax, 'on');
            
            [H_label, M_label] = app.get_playground_axis_units();
            if app.ShowgridCheckBoxM_4.Value == 1
                [H_plot, M_plot, has_data] = app.get_playground_data_curve();
                if has_data
                    [H_plot, M_plot] = app.convert_playground_curve_units( ...
                        H_plot, M_plot, ...
                        "H [A/m]", "M [A/m]", ...
                        H_label, M_label);
                    plot(ax, H_plot, M_plot, '.', 'Color', [0 0 0], 'LineWidth', 1.0, 'MarkerSize', 7, 'DisplayName', 'Measured');
                else
                    app.write_message("Warning: No input curve is available to plot in Playground.");
                end
            end

            [H_sim, M_sim, has_sim] = PlaygroundUtils.get_simulation_curve(app);
            if has_sim
                [H_sim, M_sim] = app.convert_playground_curve_units( ...
                    H_sim, M_sim, ...
                    "H [A/m]", "M [A/m]", ...
                    H_label, M_label);
                plot(ax, H_sim, M_sim, 'r-', 'LineWidth', 1.2, 'DisplayName', 'JA simulated');
            end

            xline(ax, 0, 'k-', 'LineWidth', 1.2);
            yline(ax, 0, 'k-', 'LineWidth', 1.2);
            app.apply_detailed_grid(ax, app.ShowgridCheckBoxM_5.Value == 1);

            xlabel(ax, H_label);
            ylabel(ax, M_label);
            box(ax, 'on');
            ax.LineWidth = 1.2;
            legend(ax, 'off');
            hold(ax, 'off');
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
            mode = lower(string(app.HcaseDropDown.Value));

            if contains(mode, "harmonic")
                app.MajorloopPanel.Visible = 'off';
                app.MinorloopPanel.Visible = 'off';
                app.DegaussingPanel.Visible = 'off';
                app.MajorloopwithharmonicsPanel.Visible = 'on';
            elseif contains(mode, "major loop")
                app.MajorloopPanel.Visible = 'on';
                app.MinorloopPanel.Visible = 'off';
                app.DegaussingPanel.Visible = 'off';
                app.MajorloopwithharmonicsPanel.Visible = 'off';
            elseif contains(mode, "minor loop")
                app.MajorloopPanel.Visible = 'off';
                app.MinorloopPanel.Visible = 'on';
                app.DegaussingPanel.Visible = 'off';
                app.MajorloopwithharmonicsPanel.Visible = 'off';
            elseif contains(mode, "degaussing")
                app.MajorloopPanel.Visible = 'off';
                app.MinorloopPanel.Visible = 'off';
                app.DegaussingPanel.Visible = 'on';
                app.MajorloopwithharmonicsPanel.Visible = 'off';
            else
                app.MajorloopPanel.Visible = 'on';
                app.MinorloopPanel.Visible = 'on';
                app.DegaussingPanel.Visible = 'on';
                app.MajorloopwithharmonicsPanel.Visible = 'on';
            end
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
            if ~isfinite(v)
                ret = "not available";
                return;
            end
            if abs(v) < 5e-5
                v = 0;
            end
            if abs(v) < 1e-3 && v ~= 0
                ret = string(sprintf("%0.4e", v));
            else
                ret = string(app.format_short(v));
            end
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
        end

        function import_data(app, path)
            number_of_points = app.InputNumberofPointsEditField.Value;
            H_unit = app.HorizontalaxisfieldDropDown.Value;
            M_unit = app.VerticalaxisfieldDropDown.Value;
            curve_type = app.CurveDropDown.Value;
            app.imported_curve_type = string(curve_type);
            [H, M, app.H_raw, app.M_raw] = Parser(path, H_unit, M_unit, curve_type, number_of_points).import();
            
            app.data_curve = DataAnhystereticCurve(H, M);
            app.refresh_playground_data_curve();
            app.maybe_refresh_minor_loop_defaults();   % MOD: update Htip_i defaults from the newly imported data tip
            app.maybe_refresh_degaussing_defaults();   % MOD: update Degaussing amplitude defaults from the newly imported data tip
            app.sync_degaussing_ui();                  % MOD: refresh Degaussing start-point display from the new data
            app.maybe_refresh_harmonics_defaults();    % MOD: update harmonic amplitude defaults from the newly imported data tip
            app.sync_harmonics_ui();                   % MOD: refresh harmonic start-point display from the new data
            PlaygroundUtils.sync_major_ui(app);
            PlaygroundUtils.clear_simulation(app);
        end
        
        function is_anhysteretic = is_last_import_anhysteretic(app)
            parser_constants = ParserConstants();
            curve_type = string(app.imported_curve_type);
            if strlength(curve_type) == 0
                curve_type = string(app.CurveDropDown.Value);
            end
            is_anhysteretic = curve_type == parser_constants.ANHYSTERETIC_CURVE_TYPE;
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
            H_unit = app.HorizontalaxisfieldDropDown.Value;
            M_unit = app.VerticalaxisfieldDropDown.Value;
            [H_conv, M_conv] = UnitConvertor().convert_H_M(app.H_raw, H_unit, app.M_raw, M_unit);

            n_left = max(2, round(app.InputNumberofPointsEditField.Value));
            [H_left, M_left] = app.extract_left_branch_uniform_arc(H_conv, M_conv, n_left);
            H_right = -H_left;
            M_right = -M_left;

            H_cycle = [H_left H_right(2:end)];
            M_cycle = [M_left M_right(2:end)];
        end

        function [H_left, M_left] = get_hysteretic_left_branch_data(app)
            H_unit = app.HorizontalaxisfieldDropDown.Value;
            M_unit = app.VerticalaxisfieldDropDown.Value;
            [H_conv, M_conv] = UnitConvertor().convert_H_M(app.H_raw, H_unit, app.M_raw, M_unit);

            n_left = max(2, round(app.InputNumberofPointsEditField.Value));
            [H_left, M_left] = app.extract_left_branch_uniform_arc(H_conv, M_conv, n_left);
        end

        function [H_model_left, M_model_left, has_model] = get_hysteretic_left_branch_model(app)
            [H_model_left, M_model_left, has_model] = app.get_hysteretic_modeled_region();
            if ~has_model
                H_model_left = [];
                M_model_left = [];
            end
        end

        function [H_model, M_model, has_model] = get_hysteretic_modeled_region(app)
            [params, has_params] = app.get_ja_params_from_tab();
            [Htip, Mtip, has_tip] = app.get_ja_tip_from_tab_or_data();

            has_model = has_params && has_tip;
            H_model = [];
            M_model = [];
            if ~has_model
                return;
            end

            try
                opts = odeset('RelTol', 1e-7, 'AbsTol', 1e-6);
                [Hsim, Msim] = solveJA_hysteretic_region( ...
                    Htip, Mtip, params, ...
                    app.StartingpointDropDown_4.Value, ...
                    app.FittingregionDropDown.Value, ...
                    app.StopcriterionDropDown_5.Value, ...
                    app.get_hysteretic_repetition_value(), ...
                    app.ReltoleranceEditField_3.Value, ...
                    app.get_hysteretic_max_repetitions_value(), ...
                    opts);
                if isempty(Hsim) || isempty(Msim)
                    has_model = false;
                    return;
                end

                H_model = Hsim;
                M_model = Msim;
                has_model = numel(H_model) >= 2 && numel(M_model) >= 2;
            catch
                H_model = [];
                M_model = [];
                has_model = false;
            end
        end

        function repetitions = get_hysteretic_repetition_value(app)
            repetitions = max(1, round(app.RepetitionsEditField_3.Value));
        end

        function max_repetitions = get_hysteretic_max_repetitions_value(app)
            max_repetitions = max(1, round(app.MaxrepetEditField.Value));
        end

        function sync_hysteretic_fitting_ui(app)
            is_entire_loop = string(app.FittingregionDropDown.Value) == "Entire loop";

            if is_entire_loop
                app.StopcriterionDropDown_5Label.Enable = 'on';
                app.StopcriterionDropDown_5.Enable = 'on';
            else
                app.StopcriterionDropDown_5Label.Enable = 'off';
                app.StopcriterionDropDown_5.Enable = 'off';
            end

            app.RepetitionsEditField_3Label.Enable = 'off';
            app.RepetitionsEditField_3.Enable = 'off';
            app.ReltoleranceEditField_3Label.Enable = 'off';
            app.ReltoleranceEditField_3.Enable = 'off';
            if isprop(app, 'MaxrepetitionsEditField_3Label')
                app.MaxrepetitionsEditField_3Label.Enable = 'off';
            end
            if isprop(app, 'MaxrepetitionsEditField_3')
                app.MaxrepetEditField.Enable = 'off';
            end

            if is_entire_loop
                app.sync_hysteretic_stop_criterion_ui();
            end
        end

        function sync_hysteretic_stop_criterion_ui(app)
            is_entire_loop = string(app.FittingregionDropDown.Value) == "Entire loop";
            is_fixed = string(app.StopcriterionDropDown_5.Value) == "Fixed repetitions";

            if ~is_entire_loop
                app.StopcriterionDropDown_5Label.Enable = 'off';
                app.StopcriterionDropDown_5.Enable = 'off';
                app.RepetitionsEditField_3Label.Enable = 'off';
                app.RepetitionsEditField_3.Enable = 'off';
                app.ReltoleranceEditField_3Label.Enable = 'off';
                app.ReltoleranceEditField_3.Enable = 'off';
                if isprop(app, 'MaxrepetitionsEditField_3Label')
                    app.MaxrepetitionsEditField_3Label.Enable = 'off';
                end
                if isprop(app, 'MaxrepetitionsEditField_3')
                    app.MaxrepetEditField.Enable = 'off';
                end
                return;
            end

            app.StopcriterionDropDown_5Label.Enable = 'on';
            app.StopcriterionDropDown_5.Enable = 'on';

            if is_fixed
                app.RepetitionsEditField_3Label.Enable = 'on';
                app.RepetitionsEditField_3.Enable = 'on';
                app.ReltoleranceEditField_3Label.Enable = 'off';
                app.ReltoleranceEditField_3.Enable = 'off';
                if isprop(app, 'MaxrepetitionsEditField_3Label')
                    app.MaxrepetitionsEditField_3Label.Enable = 'off';
                end
                if isprop(app, 'MaxrepetitionsEditField_3')
                    app.MaxrepetEditField.Enable = 'off';
                end
            else
                app.RepetitionsEditField_3Label.Enable = 'off';
                app.RepetitionsEditField_3.Enable = 'off';
                app.ReltoleranceEditField_3Label.Enable = 'on';
                app.ReltoleranceEditField_3.Enable = 'on';
                if isprop(app, 'MaxrepetitionsEditField_3Label')
                    app.MaxrepetitionsEditField_3Label.Enable = 'on';
                end
                if isprop(app, 'MaxrepetitionsEditField_3')
                    app.MaxrepetEditField.Enable = 'on';
                end
            end
        end

        function plot_hysteretic_residuals(app)
            has_raw_data = ~isempty(app.H_raw) && ~isempty(app.M_raw);
            if ~has_raw_data
                app.write_message("Warning: No hysteresis loop data is currently available.");
                return;
            end
            if app.is_last_import_anhysteretic()
                app.write_message("Warning: Hysteretic residuals require a hysteresis loop dataset.");
                return;
            end

            fitting_region = string(app.FittingregionDropDown.Value);
            if fitting_region == "Left branch only"
                [H_left, M_left] = app.get_hysteretic_left_branch_data();
                [H_model_left, M_model_left, has_model] = app.get_hysteretic_modeled_region();
                if ~has_model
                    app.write_message("Warning: No hysteretic modeled curve is available.");
                    return;
                end

                residue_calculator = HystereticLeftBranchResidueCalculator(H_left, M_left, H_model_left, M_model_left);
                residue = residue_calculator.get_residue();
                residue_plotter = ResiduePlotter(H_left, M_left, H_model_left, M_model_left, residue, false, "M [A/m]", 5, [0 0 0], [1 0 0]);
                residue_plotter.plot()
            else
                [H_left, M_left] = app.get_hysteretic_left_branch_data();
                H_right = -H_left;
                M_right = -M_left;

                [H_model, M_model, has_model] = app.get_hysteretic_modeled_region();
                if ~has_model
                    app.write_message("Warning: No hysteretic modeled curve is available.");
                    return;
                end

                [H_model_left, M_model_left, H_model_right, M_model_right, has_branches] = app.split_hysteretic_model_branches(H_model, M_model);
                if ~has_branches
                    app.write_message("Warning: The hysteretic modeled curve cannot be separated into branches.");
                    return;
                end

                residue_calculator_left = HystereticLeftBranchResidueCalculator(H_left, M_left, H_model_left, M_model_left);
                residue_calculator_right = HystereticLeftBranchResidueCalculator(H_right, M_right, H_model_right, M_model_right);
                residue_left = residue_calculator_left.get_residue();
                residue_right = residue_calculator_right.get_residue();
                app.plot_hysteretic_branch_residuals(H_left, M_left, H_right, M_right, H_model_left, M_model_left, H_model_right, M_model_right, residue_left, residue_right);
            end
        end

        function update_hysteretic_error_display(app)
            app.ErrorDisplay_2.Value = "";

            has_raw_data = ~isempty(app.H_raw) && ~isempty(app.M_raw);
            if ~has_raw_data || app.is_last_import_anhysteretic()
                return;
            end

            try
                fitting_region = string(app.FittingregionDropDown.Value);
                if fitting_region == "Left branch only"
                    [H_data, M_data] = app.get_hysteretic_left_branch_data();
                else
                    [H_data, M_data] = app.build_ja_data_cycle();
                end

                [H_model, M_model, has_model] = app.get_hysteretic_modeled_region();
                if ~has_model
                    return;
                end

                error_type = string(app.ErrortominimizeDropDown_2.Value);
                [J, ok] = app.compute_ja_left_branch_error_core(error_type, H_data, M_data, H_model, M_model);
                if ok
                    app.ErrorDisplay_2.Value = app.format_engineering(J);
                end
            catch
                app.ErrorDisplay_2.Value = "";
            end
        end

        function [H_left, M_left, H_right, M_right, has_branches] = split_hysteretic_model_branches(~, H_model, M_model)
            H_model = H_model(:);
            M_model = M_model(:);
            valid = isfinite(H_model) & isfinite(M_model);
            H_model = H_model(valid);
            M_model = M_model(valid);

            has_branches = false;
            H_left = [];
            M_left = [];
            H_right = [];
            M_right = [];

            if numel(H_model) < 4 || numel(M_model) < 4
                return;
            end

            [~, min_index] = min(H_model);
            if min_index <= 1 || min_index >= numel(H_model)
                return;
            end

            H_left = H_model(1:min_index);
            M_left = M_model(1:min_index);
            H_right = H_model(min_index:end);
            M_right = M_model(min_index:end);
            has_branches = numel(H_left) >= 2 && numel(H_right) >= 2;
        end

        function plot_hysteretic_branch_residuals(~, H_left, M_left, H_right, M_right, H_model_left, M_model_left, H_model_right, M_model_right, residue_left, residue_right)
            left_color = [0 0.4470 0.7410];
            right_color = [0.8500 0.3250 0.0980];

            figure('Name', "Residual plot: M [A/m]", 'NumberTitle', 'off');
            tiledlayout(4, 1);

            ax1 = nexttile([3 1]);
            box(ax1, 'on');
            hold(ax1, 'on');
            plot(ax1, H_left, M_left, '.', 'MarkerSize', 5, 'Color', left_color, 'DisplayName', 'Measured left branch');
            plot(ax1, H_model_left, M_model_left, '-', 'LineWidth', 1.2, 'Color', left_color, 'DisplayName', 'Modeled left branch');
            plot(ax1, H_right, M_right, '.', 'MarkerSize', 5, 'Color', right_color, 'DisplayName', 'Measured right branch');
            plot(ax1, H_model_right, M_model_right, '-', 'LineWidth', 1.2, 'Color', right_color, 'DisplayName', 'Modeled right branch');
            xlabel(ax1, 'H (A/m)');
            ylabel(ax1, 'M [A/m]');
            legend(ax1, 'Location', 'best');
            hold(ax1, 'off');

            ax2 = nexttile;
            box(ax2, 'on');
            hold(ax2, 'on');
            yline(ax2, 0, 'k-', 'LineWidth', 0.8, 'HandleVisibility', 'off');
            stem(ax2, H_left, residue_left, '.', 'MarkerSize', 5, 'Color', left_color, 'DisplayName', 'Left branch residual');
            stem(ax2, H_right, residue_right, '.', 'MarkerSize', 5, 'Color', right_color, 'DisplayName', 'Right branch residual');
            xlabel(ax2, 'H (A/m)');
            ylabel(ax2, 'Residual');
            set(ax2, 'yticklabels', []);
            legend(ax2, 'Location', 'best');
            hold(ax2, 'off');
        end

        function plot_hysteretic_tab_data(app)
            ax = app.AxesM_2;
            cla(ax, 'reset');
            hold(ax, 'on');
            H_label = "H [A/m]";
            M_label = "M [A/m]";

            has_raw_data = ~isempty(app.H_raw) && ~isempty(app.M_raw);
            if has_raw_data && app.is_last_import_anhysteretic()
                plot(ax, app.data_curve.H, app.data_curve.M, '.', 'Color', [0 0 0], 'LineWidth', 1.0, 'MarkerSize', 7, 'DisplayName', 'Measured');
                app.write_message("Warning: Anhysteretic magnetization data detected. The curve can be used for Jiles–Atherton (rate‑independent) model testing, but parameter fitting is not possible.");
            elseif has_raw_data
                [H_plot, M_plot] = app.build_ja_data_cycle();
                plot(ax, H_plot, M_plot, '.', 'Color', [0 0 0], 'LineWidth', 1.0, 'MarkerSize', 7, 'DisplayName', 'Measured');
                app.write_message("Hysteresis loop data in M (A/m) vs H (A/m) successfully retrieved.");
            else
                app.write_message("Warning: No hysteresis loop data is currently available.");
            end

            [Hsim, Msim, has_model] = app.get_hysteretic_modeled_region();
            if has_model
                plot(ax, Hsim, Msim, 'r-', 'LineWidth', 1.2, 'DisplayName', 'JA simulated');
            end
            xline(ax, 0, 'k-', 'LineWidth', 1.2);
            yline(ax, 0, 'k-', 'LineWidth', 1.2);
            hx0 = xline(ax, 0, 'k-', 'LineWidth', 1.2);
            hy0 = yline(ax, 0, 'k-', 'LineWidth', 1.2);
            hx0.Annotation.LegendInformation.IconDisplayStyle = 'off';
            hy0.Annotation.LegendInformation.IconDisplayStyle = 'off';
            app.apply_detailed_grid(ax, app.ShowgridCheckBoxM_2.Value == 1);
            xlabel(ax, H_label);
            ylabel(ax, M_label);
            box(ax, 'on');
            ax.LineWidth = 1.2;
            legend(ax, 'off');
            hold(ax, 'off');
        end
       
        function [params, ok] = get_ja_params_from_tab(app)
            params = struct('Ms', NaN, 'a', NaN, 'alpha', NaN, 'k', NaN, 'c', NaN);
            ok = false;

            Ms = str2double(replace(string(app.JsField_2.Value), ",", ""));
            a = str2double(replace(string(app.JsField_3.Value), ",", ""));
            alpha = str2double(replace(string(app.JsField_4.Value), ",", ""));
            c = str2double(replace(string(app.JsField_5.Value), ",", ""));
            k = str2double(replace(string(app.JsField_6.Value), ",", ""));

            if any(~isfinite([Ms, a, alpha, c, k]))
                return;
            end

            if Ms <= 0 || a <= 0 || k <= 0 || c < 0 || c > 1
                return;
            end

            params = struct('Ms', Ms, 'a', a, 'alpha', alpha, 'k', k, 'c', c);
            ok = true;
        end
        
        function [params, ok] = get_playground_hysteretic_params(app)
            [params, ok] = app.get_ja_params_from_tab();
        end

        function [Htip, Mtip, ok] = get_ja_tip_from_tab_or_data(app)
            ok = false;
            Htip = NaN;
            Mtip = NaN;

            Htip_tab = str2double(replace(string(app.JsField_7.Value), ",", ""));
            Mtip_tab = str2double(replace(string(app.JsField_8.Value), ",", ""));
            if isfinite(Htip_tab) && isfinite(Mtip_tab)
                Htip = Htip_tab;
                Mtip = Mtip_tab;
                ok = true;
                return;
            end

            try
                if ~isempty(app.data_curve) && ~isempty(app.data_curve.H) && ~isempty(app.data_curve.M)
                    [Htip, Mtip] = Utils().find_tip(app.data_curve.H, app.data_curve.M);
                    ok = isfinite(Htip) && isfinite(Mtip);
                end
            catch
                ok = false;
            end
        end

        function [ms_seed, a_seed, alpha_seed, has_seeds] = get_first_anhysteretic_seeds(app)
            [ms_seed, a_seed, alpha_seed, has_seeds] = AnhystereticUtils.get_first_anhysteretic_seeds(app);
        end

        function retrieve_ja_seeds(app)
            [ms_seed, a_seed, alpha_seed, has_seeds] = app.get_first_anhysteretic_seeds();
            c_seed = 1/3;
            parser_constants = ParserConstants();
        
            has_curve_data = ~isempty(app.data_curve) && ~isempty(app.data_curve.H) && ~isempty(app.data_curve.M);
            is_hysteretic_context = ~app.is_last_import_anhysteretic() || ...
                (strlength(string(app.CurveDropDown.Value)) > 0 && string(app.CurveDropDown.Value) ~= parser_constants.ANHYSTERETIC_CURVE_TYPE);
        
            if has_seeds && is_hysteretic_context
                app.JsField_2.Value = char(ms_seed);
                app.JsField_3.Value = char(a_seed);
                app.JsField_4.Value = char(alpha_seed);
        
                ms_num = str2double(replace(ms_seed, ",", ""));
                a_num = str2double(replace(a_seed, ",", ""));
                alpha_num = str2double(replace(alpha_seed, ",", ""));
        
                k_value = NaN;
                if has_curve_data && isfinite(ms_num) && isfinite(a_num) && isfinite(alpha_num) && a_num ~= 0
                    try
                        [H_cycle, M_cycle] = app.build_ja_data_cycle();
                        n_left = max(2, round(app.InputNumberofPointsEditField.Value));
                        [H_left, M_left] = app.extract_left_branch_uniform_arc(H_cycle, M_cycle, n_left);
                        k_value = app.estimateK_fromCoercivePoint(H_left, M_left, ms_num, a_num, alpha_num, c_seed);
                    catch ME
                        k_value = NaN;
                        app.write_message("k-seed debug: " + string(ME.message));
                    end
                end
        
                if isfinite(k_value)
                    % Default bounds are set here (unbounded: -Inf to +Inf).
                    k_display = app.format_k_seed_display(k_value);
                    app.JsField_6.Value = char(k_display);
                    app.JsField_5.Value = app.format_short(c_seed);
                    app.MsLowerField_2.Value = "-Inf";
                    app.MsUpperField_2.Value = "Inf";
                    app.aLowerField_2.Value = "-Inf";
                    app.aUpperField_2.Value = "Inf";
                    app.alphaLowerField_2.Value = "-Inf";
                    app.alphaUpperField_2.Value = "Inf";
                    app.cLowerField_2.Value = "0";
                    app.cUpperField_2.Value = "1";
                    app.kLowerField_2.Value = "-Inf";
                    app.kUpperField_2.Value = "Inf";
                    app.write_message("Jiles–Atherton seeds retrieved: Ms=" + ms_seed + " [A/m], a=" + a_seed + " [A/m], α=" + alpha_seed + ", c=" + app.format_short(c_seed) + ", k=" + k_display + " [A/m].");
                else
                    app.JsField_6.Value = "";
                    app.JsField_5.Value = app.format_short(c_seed);
                    app.write_message("Jiles–Atherton seeds retrieved: Ms=" + ms_seed + " [A/m], a=" + a_seed + " [A/m], α=" + alpha_seed + ", c=" + app.format_short(c_seed) + ", k=not available.");
                end
            else
                app.JsField_2.Value = "";
                app.JsField_3.Value = "";
                app.JsField_4.Value = "";
                app.JsField_6.Value = "";
                app.MsLowerField_2.Value = "";
                app.MsUpperField_2.Value = "";
                app.aLowerField_2.Value = "";
                app.aUpperField_2.Value = "";
                app.alphaLowerField_2.Value = "";
                app.alphaUpperField_2.Value = "";
                app.cLowerField_2.Value = "";
                app.cUpperField_2.Value = "";
                app.kLowerField_2.Value = "";
                app.kUpperField_2.Value = "";
                app.JsField_5.Value = app.format_short(c_seed);
                app.write_message("Warning: No anhysteretic magnetization modelling has been performed.");
                app.write_message("Jiles–Atherton seeds for Ms, a, α, and k were not initialized; the coupling parameter c was set to 1/3.");
            end
            drawnow;
        end

        function [J, ok] = compute_ja_left_branch_error_core(~, error_type, Hleft, Mleft, Hhat, Mhat)
            BIG = 1e6;
            J = BIG;
            ok = false;
            try
                Hleft = Hleft(:);
                Mleft = Mleft(:);
                Hhat = Hhat(:);
                Mhat = Mhat(:);

                valid_data = isfinite(Hleft) & isfinite(Mleft);
                valid_model = isfinite(Hhat) & isfinite(Mhat);
                Hleft = Hleft(valid_data);
                Mleft = Mleft(valid_data);
                Hhat = Hhat(valid_model);
                Mhat = Mhat(valid_model);
                if numel(Hleft) < 2 || numel(Hhat) < 2
                    return;
                end

                if error_type == "Diagonal (H, continuous)"
                    Sx = (max(Hleft) - min(Hleft)) / 2; % Legacy (needs a Matlab extra Toolbox) Sx = range(Hleft) / 2;
                    Sy = (max(Mleft) - min(Mleft)) / 2; % Legacy (needs a Matlab extra Toolbox) Sy = range(Mleft) / 2;
                    if Sx <= 0 || ~isfinite(Sx), Sx = 1; end
                    if Sy <= 0 || ~isfinite(Sy), Sy = 1; end
                    curv = [Hhat / Sx, Mhat / Sy];
                    data = [Hleft / Sx, Mleft / Sy];
                    [~, d] = distance2curve(curv, data, 'linear');
                    J = sqrt(mean(d.^2));
                elseif error_type == "Vertical"
                    [Hhat_s, idxH] = sort(Hhat, 'ascend');
                    Mhat_s = Mhat(idxH);
                    [Hhat_u, idxHu] = unique(Hhat_s, 'stable');
                    Mhat_u = Mhat_s(idxHu);
                    Minterp = interp1(Hhat_u, Mhat_u, Hleft, 'linear', 'extrap');
                    J = sqrt(mean((Mleft - Minterp).^2));
                elseif error_type == "Horizontal"
                    [Mhat_s, idxM] = sort(Mhat, 'ascend');
                    Hhat_s = Hhat(idxM);
                    [Mhat_u, idxMu] = unique(Mhat_s, 'stable');
                    Hhat_u = Hhat_s(idxMu);
                    Hinterp = interp1(Mhat_u, Hhat_u, Mleft, 'linear', 'extrap');
                    J = sqrt(mean((Hleft - Hinterp).^2));
                else
                    return;
                end

                if ~isfinite(J)
                    J = BIG;
                    return;
                end
                ok = true;
            catch
                J = BIG;
                ok = false;
            end
        end

        function [v, ok] = read_numeric_field(~, fieldHandle)
            s = string(fieldHandle.Value);
            v = str2double(replace(s, ",", ""));
            ok = isfinite(v);
        end

        function sync_k_fit_mode_ui(app)
            if app.kConstrainedCheckBox_2.Value
                app.FitkCheckBox.Value = false;
                app.FitkCheckBox.Enable = 'off';
            else
                app.FitkCheckBox.Value = true;
                app.FitkCheckBox.Enable = 'on';
            end
        end

        function fit_ja_parameters(app)
            mask = struct( ...
                'fitMs', logical(app.CheckBox.Value), ...
                'fita', logical(app.CheckBox_2.Value), ...
                'fitalpha', logical(app.CheckBox_3.Value), ...
                'fitc', logical(app.CheckBox_4.Value), ...
                'kDependent', logical(app.kConstrainedCheckBox_2.Value), ...
                'fitk', logical(app.FitkCheckBox.Value) && ~logical(app.kConstrainedCheckBox_2.Value));

            [params_seed, has_params] = app.get_ja_params_from_tab();
            if ~has_params && mask.kDependent
                [msVal, okMs] = app.read_numeric_field(app.JsField_2);
                [aVal, okA] = app.read_numeric_field(app.JsField_3);
                [alphaVal, okAlpha] = app.read_numeric_field(app.JsField_4);
                [cVal, okC] = app.read_numeric_field(app.JsField_5);
                if okMs && okA && okAlpha && okC && aVal ~= 0
                    params_seed = struct('Ms', msVal, 'a', aVal, 'alpha', alphaVal, 'c', cVal, 'k', 1);
                    has_params = true;
                end
            end

            [Htip, Mtip, has_tip] = app.get_ja_tip_from_tab_or_data();
            has_fit_data = false;
            H_cycle = [];
            M_cycle = [];
            try
                [H_cycle, M_cycle] = app.build_ja_data_cycle();
                has_fit_data = ~isempty(H_cycle) && ~isempty(M_cycle) && numel(H_cycle) >= 2 && numel(M_cycle) >= 2;
            catch
                has_fit_data = false;
            end

            if ~has_tip && has_fit_data
                try
                    [Htip, Mtip] = Utils().find_tip(H_cycle, M_cycle);
                    has_tip = isfinite(Htip) && isfinite(Mtip);
                catch
                    has_tip = false;
                end
            end

            if ~has_params || ~has_tip || ~has_fit_data
                app.write_message("JA fit skipped: missing parameters, tip, or input data.");
                return;
            end

            [H_conv, M_conv] = deal(H_cycle, M_cycle);
            n_left = max(2, round(app.InputNumberofPointsEditField.Value));
            [Hleft, Mleft] = app.extract_left_branch_uniform_arc(H_conv, M_conv, n_left);
            fitting_region = string(app.FittingregionDropDown.Value);
            start_mode = string(app.StartingpointDropDown_4.Value);
            stop_criterion = string(app.StopcriterionDropDown_5.Value);
            repetitions = app.get_hysteretic_repetition_value();
            rel_tolerance = app.ReltoleranceEditField_3.Value;
            max_repetitions = app.get_hysteretic_max_repetitions_value();
            opts = odeset('RelTol', 1e-7, 'AbsTol', 1e-6);
            if fitting_region == "Left branch only"
                HfitData = Hleft;
                MfitData = Mleft;
            else
                HfitData = H_cycle;
                MfitData = M_cycle;
            end
        
            [msLB, ok1] = JAFitUtils.readBoundFieldValue(app.MsLowerField_2);
            [msUB, ok2] = JAFitUtils.readBoundFieldValue(app.MsUpperField_2);
            [aLB, ok3] = JAFitUtils.readBoundFieldValue(app.aLowerField_2);
            [aUB, ok4] = JAFitUtils.readBoundFieldValue(app.aUpperField_2);
            [alphaLB, ok5] = JAFitUtils.readBoundFieldValue(app.alphaLowerField_2);
            [alphaUB, ok6] = JAFitUtils.readBoundFieldValue(app.alphaUpperField_2);
            [cLB, ok7] = JAFitUtils.readBoundFieldValue(app.cLowerField_2);
            [cUB, ok8] = JAFitUtils.readBoundFieldValue(app.cUpperField_2);
            [kLB, ok9] = JAFitUtils.readBoundFieldValue(app.kLowerField_2);
            [kUB, ok10] = JAFitUtils.readBoundFieldValue(app.kUpperField_2);
        
            if ~(ok1 && ok2 && ok3 && ok4 && ok5 && ok6 && ok7 && ok8 && ok9 && ok10)
                app.write_message("JA fit skipped: invalid bounds.");
                return;
            end
        
            bounds = struct( ...
                'Ms', JAFitUtils.makeBoundPair(msLB, msUB), ...
                'a', JAFitUtils.makeBoundPair(aLB, aUB), ...
                'alpha', JAFitUtils.makeBoundPair(alphaLB, alphaUB), ...
                'c', JAFitUtils.makeBoundPair(cLB, cUB), ...
                'k', JAFitUtils.makeBoundPair(kLB, kUB));
        
            [lb, ub] = JAFitUtils.packBounds(bounds, mask);
            if any(lb > ub)
                app.write_message("JA fit skipped: lower bound is greater than upper bound.");
                return;
            end
        
             error_type = string(app.ErrortominimizeDropDown_2.Value);

             app.stop_fit_requested = false;
             fit_timer = tic;
            try
                modelFn = @(p) solveJA_hysteretic_region( ...
                    Htip, Mtip, p, start_mode, fitting_region, stop_criterion, ...
                    repetitions, rel_tolerance, max_repetitions, opts);

                outputFcn = @(x, optimValues, state) app.fit_stop_output_fcn(x, optimValues, state);
                fit_result = JAFitter.fit( ...
                    params_seed, mask, bounds, HfitData, MfitData, Htip, Mtip, error_type, ...
                    @(p) app.estimateK_fromCoercivePoint(Hleft, Mleft, p.Ms, p.a, p.alpha, p.c), ...
                    modelFn, ...
                    @(errType, hL, mL, hHat, mHat) app.compute_ja_left_branch_error_core(errType, hL, mL, hHat, mHat), ...
                    outputFcn);
        
                if ~fit_result.ok
                    error(char(fit_result.errorMessage));
                end
        
                params_opt = fit_result.params_opt;
                app.JsField_2.Value = app.format_short(params_opt.Ms);
                app.JsField_3.Value = app.format_short(params_opt.a);
                app.JsField_4.Value = app.format_short(params_opt.alpha);
                app.JsField_5.Value = app.format_short(params_opt.c);
                app.JsField_6.Value = app.format_short(params_opt.k);
        
                app.plot_hysteretic_tab_data();
                app.ErrorDisplay_2.Value = app.format_engineering(fit_result.Jopt);
        
                t = toc(fit_timer);
                if app.stop_fit_requested
                    app.write_message("Fitting stopped by user after " + app.format_short(t) + " s");
                else
                    app.write_message("Fitting finished after " + app.format_short(t) + " s");
                end
            catch ME
                t = toc(fit_timer);
                app.write_message("Fitting failed after " + app.format_short(t) + " s: " + string(ME.message));
            end
        end

        function k_est = estimateK_fromCoercivePoint(app, Hleft, Mleft, Ms, a, alpha, c)
            Hleft = Hleft(:);
            Mleft = Mleft(:);

            valid = isfinite(Hleft) & isfinite(Mleft);
            Hleft = Hleft(valid);
            Mleft = Mleft(valid);

            if numel(Hleft) < 3 || numel(Mleft) < 3
                error('Insufficient left-branch points to estimate k.');
            end

            [Mleft, idxSort] = sort(Mleft, 'ascend');
            Hleft = Hleft(idxSort);

            Hc = -interp1(Mleft, Hleft, 0, 'linear', 'extrap');

            polyOrder = 3;
            W = 21;

            [~, i0] = min(abs(Mleft));
            N = numel(Mleft);
            half = floor(W/2);
            i1 = max(1, i0 - half);
            i2 = min(N, i0 + half);

            if (i2 - i1 + 1) < W
                if i1 == 1
                    i2 = min(N, i1 + W - 1);
                elseif i2 == N
                    i1 = max(1, i2 - W + 1);
                end
            end

            Mseg = Mleft(i1:i2);
            Hseg = Hleft(i1:i2);
            pOrd = min(polyOrder, numel(Mseg) - 1);

            M0 = mean(Mseg);
            Mscl = max(abs(Mseg - M0));
            if Mscl == 0
                error('Degenerate magnetization window near coercive point.');
            end

            x = (Mseg - M0) / Mscl;
            y = Hseg;

            p = polyfit(x, y, pOrd);
            dp = polyder(p);
            chi_inv_c = polyval(dp, (0 - M0)/Mscl) / Mscl;
            if ~isfinite(chi_inv_c)
                error('chi_inv_c is not finite.');
            end

            h = -Hc / a;
            Lh = Langevin(h, 0);
            dLdh = Langevin(h, 1);
            if ~isfinite(Lh) || ~isfinite(dLdh)
                error('Langevin terms are not finite.');
            end

            num = Ms * Lh;
            den = c * (Ms/a) * dLdh - 1/(chi_inv_c + alpha);
            if ~isfinite(den) || abs(den) < eps
                error("Invalid denominator in k estimation. Hc=" + string(Hc) + ", chi_inv_c=" + string(chi_inv_c) + ", alpha=" + string(alpha));
            end
            k_est = num / den;
            if ~isfinite(k_est)
                error("k_est is not finite. num=" + string(num) + ", den=" + string(den));
            end
        end

        function ret = subscript_to_number(app, str)
            ret = AnhystereticUtils.subscript_to_number(app, str);
        end

        function export_residual(app, residue, file_name)
            AnhystereticUtils.export_residual(app, residue, file_name);
        end
        
        function save(app)
            file = fopen(app.ProjectPath,'w');

            s.fitted_parameters_value = app.fitted_parameter_values(:);
            s.fitted_parameters_lower_bound = app.TableFittedParameters.Data(:,3);
            s.fitted_parameters_upper_bound = app.TableFittedParameters.Data(:,4);
            s.number_components = app.number_components;
            s.select_a = app.TableParameters.Data.(5);
            s.number_points = app.NofpointsEditField.Value;
            s.point_space = app.PointSpaceDropDown.Value;
            s.error_type = app.ErrortominimizeDropDown.Value;
            s.input_path = app.InputDatasetPath.Value;
            s.horizontal_axis = app.HorizontalaxisfieldDropDown.Value;
            s.vertical_axis = app.VerticalaxisfieldDropDown.Value;
            s.curve_type = app.CurveDropDown.Value;
            s.description = app.DescriptionTextArea.Value;
            s.data_set_path = app.OutputDatasetPath.Value;

            s.experimental_anhysteretic_magnetization_file_name = app.EditFieldFileNameExperimentalMagnetizationData.Value;
            s.magnetization_file_name = app.EditFieldFileNameModeledAnhystereticMagnetization.Value;
            s.parameters_file_name = app.EditFieldFileNameParameters.Value;
            s.magnetization_plots_file_name = app.EditFieldFileNamePlotMagnetization.Value;
            s.suceptibility_plots_file_name = app.EditFieldFileNamePlotSusceptibility.Value;
            s.magnetization_derivative_file_name = app.EditFieldFileNamePlotSemiLogMagDerivative.Value;
            s.magnetization_residual_file_name = app.EditFieldFileNameResiduesMagnetization.Value;
            s.susceptibility_residual_file_name = app.EditFieldFileNameResiduesSusceptibility.Value;
            s.semi_log_derivative_file_name = app.EditFieldFileNameResiduesSemiLogMagDerivative.Value;

            s.input_axis_scale = app.InputAxisScaleDropDown.Value;
            s.axis_scale_m = app.AxisScaleDropDownM.Value;
            s.axis_scale_dMdH = app.AxisScaleDropDowndMdH.Value;
            s.axis_scale_hdMdH = app.AxisScaleDropDownHdMdH.Value;
            s.fitting_show_grid_checkbox = app.ShowgridCheckBoxHdMdH.Value;
            s.fitting_plot_components_checkbox = app.PlotcomponentsCheckBoxHdMdH.Value;
            s.fitting_show_hcr_checkbox = app.ShowhcrCheckBoxHdMdH.Value;

            s.model_magnetization_checkbox = app.CheckBoxOutputMagnetizationDataFittedAnhystereticMagnetization.Value;
            s.model_magnetization_components_checkbox = app.OutputSeparateComponentsCheckBox.Value;
            s.fitted_parameters_checkbox = app.ExportFittedparametersCheckBox.Value;
            s.model_parameters_checkbox = app.ExportModelparametersCheckBox.Value;
            s.other_quantities_checkbox = app.ExportOtherquantitiesCheckBox.Value;
            s.errors_checkbox = app.ExportErrorsCheckBox.Value;
            s.magnetization_plots_checkbox = app.CheckBoxExportPlotMagnetization.Value;
            s.susceptibility_plots_checkbox = app.CheckBoxExportPlotSusceptibility.Value;
            s.magnetization_derivatives_checkbox = app.CheckBoxExportPlotSemiLogMagDerivative.Value;

            s.experimental_anhysteretic_magnetization_checkbox = app.CheckBoxExperimentalMagnetization.Value;
            s.magnetization_residual_checkbox = app.CheckBoxExportResiduesMagnetization.Value;
            s.susceptibility_residual_checkbox = app.CheckBoxExportResiduesSusceptibility.Value;
            s.semi_log_derivative_residual_checkbox = app.CheckBoxExportResiduesSemiLogMagDerivative.Value;

            s.params = struct( ...
                'Ms', app.JsField_2.Value, ...
                'a', app.JsField_3.Value, ...
                'alpha', app.JsField_4.Value, ...
                'c', app.JsField_5.Value, ...
                'k', app.JsField_6.Value ...
            );

            data = jsonencode(s, PrettyPrint=true);
            fprintf(file, "%s", data);
            fclose(file);
            app.write_message("Project saved at " + app.ProjectPath);
        end
    end
    
    methods (Access = public)
        
        function [H_unit, M_unit] = get_playground_axis_units(app)
            H_unit = string(app.HorizontalaxisfieldDropDown_2.Value);
            M_unit = string(app.VerticalaxisfieldDropDown_2.Value);
        end

        function values = get_minor_loop_default_values(app)
            % MOD: default Htip_i are derived from the measured-curve tip
            % (Htip, Htip*2/3, Htip*1/3) when data is available; otherwise
            % fall back to a plain 1/2/3 placeholder. Display order is
            % cosmetic: the solver sorts the tips ascending and simulates
            % the smallest tip first.
            [Htip, ~, ok] = PlaygroundUtils.get_data_tip(app);
            if ok && isfinite(Htip) && Htip > 0
                values = [Htip; Htip*2/3; Htip*1/3; NaN];
            else
                values = [1; 2; 3; NaN];
            end
        end

        function configure_minor_loop_table(app)
            if ~isprop(app, 'UITable') || isempty(app.UITable) || ~isvalid(app.UITable)
                return;
            end

            app.UITable.SelectionType = 'cell';
            app.UITable.ColumnEditable = [true];
            app.UITable.Data = app.get_minor_loop_default_values();
            app.minor_loop_table_user_edited = false;   % MOD: table now holds untouched defaults
            app.UITable.CellEditCallback = createCallbackFcn(app, @UITableCellEdit, true);
        end

        function maybe_refresh_minor_loop_defaults(app)
            % MOD: re-fill the Htip_i table with data-tip-based defaults, but
            % only while the user has not manually edited it (so we never
            % clobber user-entered tip fields).
            if ~isprop(app, 'UITable') || isempty(app.UITable) || ~isvalid(app.UITable)
                return;
            end
            if app.minor_loop_table_user_edited
                return;
            end
            app.UITable.Data = app.get_minor_loop_default_values();
            app.minor_loop_table_user_edited = false;
        end

        function expand_minor_loop_table_if_needed(app, event)
            if nargin < 2 || isempty(event) || ~isprop(app, 'UITable') || isempty(app.UITable) || ~isvalid(app.UITable)
                return;
            end

            if ~isprop(event, 'Indices') || isempty(event.Indices) || ~isprop(event, 'NewData')
                return;
            end

            row = event.Indices(1);
            newValue = event.NewData;
            if ~(isscalar(row) && isfinite(row) && row >= 1 && isfinite(newValue) && newValue > 0)
                return;
            end

            data = app.UITable.Data;
            if isempty(data) || ~isnumeric(data)
                return;
            end

            data = data(:);
            if row == numel(data)
                app.UITable.Data = [data; NaN];
            end
        end

        function refresh_playground_data_curve(app)
            app.playground_curve_H = [];
            app.playground_curve_M = [];
            app.playground_curve_ready = false;

            if isempty(app.H_raw) || isempty(app.M_raw)
                return;
            end

            if app.is_last_import_anhysteretic()
                H_plot = app.data_curve.H(:).';
                M_plot = app.data_curve.M(:).';
            else
                [H_plot, M_plot] = app.build_ja_data_cycle();
            end

            if ~isempty(H_plot) && ~isempty(M_plot) && numel(H_plot) >= 2 && numel(M_plot) >= 2
                app.playground_curve_H = H_plot;
                app.playground_curve_M = M_plot;
                app.playground_curve_ready = true;
            end
        end

        function [H_plot, M_plot, has_data] = get_playground_data_curve(app)
            if ~app.playground_curve_ready
                app.refresh_playground_data_curve();
            end

            H_plot = app.playground_curve_H;
            M_plot = app.playground_curve_M;
            has_data = app.playground_curve_ready && ~isempty(H_plot) && ~isempty(M_plot) ...
                && numel(H_plot) >= 2 && numel(M_plot) >= 2;
        end

        function [H_out, M_out] = convert_playground_curve_units(app, H_in, M_in, H_source_unit, M_source_unit, H_target_unit, M_target_unit)
            uc = UnitConvertor();
            H_source_unit = string(H_source_unit);
            M_source_unit = string(M_source_unit);
            H_target_unit = string(H_target_unit);
            M_target_unit = string(M_target_unit);

            H_source_factor = uc.UnitConversions(H_source_unit);
            H_target_factor = uc.UnitConversions(H_target_unit);
            M_source_factor = uc.UnitConversions(M_source_unit);
            M_target_factor = uc.UnitConversions(M_target_unit);

            H_base = H_in .* H_source_factor;
            H_out = H_base ./ H_target_factor;

            source_is_B = M_source_unit == "B [T]" || M_source_unit == "B [G]" || M_source_unit == "B [kG]";
            target_is_B = M_target_unit == "B [T]" || M_target_unit == "B [G]" || M_target_unit == "B [kG]";

            if source_is_B
                M_base = (M_in .* M_source_factor) - H_base;
            else
                M_base = M_in .* M_source_factor;
            end

            if target_is_B
                M_out = (M_base + H_base) ./ M_target_factor;
            else
                M_out = M_base ./ M_target_factor;
            end
        end

        function [Htips, ok] = get_minor_loop_inputs(app)
            Htips = [];
            ok = false;

            if ~isprop(app, 'UITable') || isempty(app.UITable) || ~isvalid(app.UITable)
                return;
            end

            raw = [];
            if isprop(app.UITable, 'Data')
                raw = app.UITable.Data;
            elseif isprop(app.UITable, 'Value')
                raw = app.UITable.Value;
            end

            if isempty(raw)
                return;
            end

            if isnumeric(raw)
                values = raw(:);
            else
                raw = string(raw);
                
                tokens = split(strjoin(raw(:).', newline), {newline, ",", ";", " "});
                tokens = tokens(strlength(strtrim(tokens)) > 0);
                values = str2double(replace(strtrim(tokens), ",", ""));
            end

            values = values(isfinite(values) & values > 0);
            if isempty(values)
                return;
            end

            Htips = sort(values(:), 'ascend');
            ok = true;
        end

        function run_playground_minor_loop(app)
            failure_message = "The magnetization path cannot be computed with the current initial condition M(Hstart) and model parameters.";
            try
                [params, ok_params] = PlaygroundUtils.get_playground_params(app);
                if ~ok_params
                    PlaygroundUtils.clear_simulation(app);
                    app.plot_playground();
                    app.write_message(failure_message);
                    return;
                end

                [Htips, ok_inputs] = app.get_minor_loop_inputs();
                if ~ok_inputs
                    PlaygroundUtils.clear_simulation(app);
                    app.plot_playground();
                    app.write_message(failure_message);
                    return;
                end
                PlaygroundUtils.sync_minor_ui(app);

                app.write_message("Calculate & Plot started");
                pause(0.01);
                calc_timer = tic;

                [Hsim, Msim, info] = solveJA_minorLoop_playground( ...
                    Htips, params, ...
                    string(app.StopcriterionDropDown_4.Value), ...
                    app.RepetitionsEditField_2.Value, ...
                    app.ReltoleranceEditField_5.Value, ...
                    odeset('RelTol', 1e-7, 'AbsTol', 1e-6));
                info.status = "ok";
                PlaygroundUtils.set_simulation(app, Hsim, Msim, info);
                app.plot_playground();
                t = sprintf("%0.2f", toc(calc_timer));
                app.write_message("Calculate & Plot finished after " + t + " s");
            catch
                PlaygroundUtils.clear_simulation(app);
                app.plot_playground();
                app.write_message(failure_message);
            end
        end

        % =====================================================
        %  Degaussing (Playground) — MOD: new subsystem
        % =====================================================

        function [Mr, ok] = get_data_remanence(app)
            % MOD: retrieve the remanence M(H=0)=Mr from the measured
            % hysteresis loop. The upper (descending) branch is extracted from
            % the raw data (converted to A/m) and M is interpolated at H = 0
            % with interp1. Only available when a hysteretic dataset has been
            % imported; an anhysteretic import carries no hysteresis loop.
            Mr = NaN;
            ok = false;

            if isempty(app.H_raw) || isempty(app.M_raw) || app.is_last_import_anhysteretic()
                return;
            end

            try
                H_unit = app.HorizontalaxisfieldDropDown.Value;
                M_unit = app.VerticalaxisfieldDropDown.Value;
                [H_conv, M_conv] = UnitConvertor().convert_H_M(app.H_raw, H_unit, app.M_raw, M_unit);

                % Upper (descending) branch, from the +tip corner through H=0
                % down to the -tip corner, in base units (A/m).
                [H_up, M_up] = app.extract_left_branch_uniform_arc(H_conv, M_conv, []);

                H_up = H_up(:);
                M_up = M_up(:);
                valid = isfinite(H_up) & isfinite(M_up);
                H_up = H_up(valid);
                M_up = M_up(valid);
                if numel(H_up) < 2 || min(H_up) > 0 || max(H_up) < 0
                    return;
                end

                % interp1 needs distinct sample points: sort by H and drop dups.
                [H_sorted, idx] = unique(H_up);
                M_sorted = M_up(idx);
                Mr = interp1(H_sorted, M_sorted, 0, 'linear');
                ok = isfinite(Mr);
            catch
                Mr = NaN;
                ok = false;
            end
        end

        function [amps, ok] = get_degaussing_amplitudes_auto(app)
            % MOD: build the automatic decaying degaussing envelope from the
            % user's N-of-steps, initial and final amplitude settings. A
            % geometric (exponential) decay is used when both amplitudes are
            % positive, which matches the physical AC-demagnetization envelope;
            % otherwise a linear ramp is used.
            amps = [];
            ok = false;

            N = round(app.NofstepsEditField.Value);
            A0 = app.InitialamplitudeAmEditField.Value;
            Af = app.FinalamplitudeAmEditField.Value;

            if ~isfinite(N) || N < 1 || ~isfinite(A0) || A0 <= 0 || ~isfinite(Af) || Af < 0
                return;
            end

            if N == 1
                amps = A0;
            elseif A0 > 0 && Af > 0
                amps = logspace(log10(A0), log10(Af), N);
            else
                amps = linspace(A0, Af, N);
            end

            amps = amps(isfinite(amps) & amps > 0);
            amps = sort(amps(:), 'descend');
            ok = ~isempty(amps);
        end

        function [amps, ok] = get_degaussing_table_inputs(app)
            % MOD: read the user-defined Htip_i amplitude table (UITable_3) and
            % return the reversal amplitudes sorted in descending order (largest
            % swing first) so they form a decaying degaussing envelope.
            amps = [];
            ok = false;

            if ~isprop(app, 'UITable_3') || isempty(app.UITable_3) || ~isvalid(app.UITable_3)
                return;
            end

            raw = [];
            if isprop(app.UITable_3, 'Data')
                raw = app.UITable_3.Data;
            elseif isprop(app.UITable_3, 'Value')
                raw = app.UITable_3.Value;
            end

            if isempty(raw)
                return;
            end

            if isnumeric(raw)
                values = raw(:);
            else
                raw = string(raw);
                tokens = split(strjoin(raw(:).', newline), {newline, ",", ";", " "});
                tokens = tokens(strlength(strtrim(tokens)) > 0);
                values = str2double(replace(strtrim(tokens), ",", ""));
            end

            values = values(isfinite(values) & values > 0);
            if isempty(values)
                return;
            end

            amps = sort(values(:), 'descend');
            ok = true;
        end

        function values = get_degaussing_default_table_values(app)
            % MOD: default Htip_i amplitudes derived from the measured-curve tip
            % (Htip, Htip*2/3, Htip*1/3) when data is available; otherwise a
            % plain placeholder. Display order is cosmetic — the solver sorts
            % the amplitudes descending.
            [Htip, ~, ok] = PlaygroundUtils.get_data_tip(app);
            if ok && isfinite(Htip) && Htip > 0
                values = [Htip; Htip*2/3; Htip*1/3; NaN];
            else
                values = [3; 2; 1; NaN];
            end
        end

        function configure_degaussing_table(app)
            % MOD: initialise the Degaussing user-defined amplitude table.
            if ~isprop(app, 'UITable_3') || isempty(app.UITable_3) || ~isvalid(app.UITable_3)
                return;
            end

            app.UITable_3.SelectionType = 'cell';
            app.UITable_3.ColumnEditable = [true];
            app.UITable_3.Data = app.get_degaussing_default_table_values();
            app.degaussing_user_edited = false;
            app.UITable_3.CellEditCallback = createCallbackFcn(app, @DegaussingTableCellEdit, true);
        end

        function maybe_refresh_degaussing_defaults(app)
            % MOD: re-fill the Degaussing amplitude settings (N of steps,
            % initial = Htip, final = 0.02*Htip) and the amplitude table with
            % data-tip-based defaults, but only while the user has not manually
            % edited them (mirrors the minor-loop default behaviour).
            if app.degaussing_user_edited
                return;
            end

            [Htip, ~, ok] = PlaygroundUtils.get_data_tip(app);
            if ok && isfinite(Htip) && Htip > 0
                app.NofstepsEditField.Value = 10;
                app.InitialamplitudeAmEditField.Value = Htip;
                app.FinalamplitudeAmEditField.Value = 0.02 * Htip;
            end

            if isprop(app, 'UITable_3') && ~isempty(app.UITable_3) && isvalid(app.UITable_3)
                app.UITable_3.Data = app.get_degaussing_default_table_values();
            end
        end

        function sync_degaussing_ui(app)
            % MOD: enable/disable and populate the Degaussing controls according
            % to the selected starting-point and H-amplitude options.
            if ~PlaygroundUtils.is_degaussing_mode(app)
                return;
            end

            start_mode = lower(string(app.StartingpointDropDown_3.Value));
            if contains(start_mode, "remanence")
                [Mr, ok_r] = app.get_data_remanence();
                app.HstartAmEditField_2.Value = 0;
                if ok_r
                    app.MstartAmEditField_2.Value = Mr;
                else
                    app.MstartAmEditField_2.Value = 0;
                end
                app.set_degaussing_start_enable('off');
            elseif contains(start_mode, "tip")
                [Htip, Mtip, ok_t] = PlaygroundUtils.get_data_tip(app);
                if ok_t
                    app.HstartAmEditField_2.Value = Htip;
                    app.MstartAmEditField_2.Value = Mtip;
                else
                    app.HstartAmEditField_2.Value = 0;
                    app.MstartAmEditField_2.Value = 0;
                end
                app.set_degaussing_start_enable('off');
            else
                app.set_degaussing_start_enable('on');
            end

            amp_mode = lower(string(app.HamplitudeDropDown.Value));
            if contains(amp_mode, "automatic")
                app.set_degaussing_auto_enable('on');
                app.set_degaussing_table_enable('off');
            else
                app.set_degaussing_auto_enable('off');
                app.set_degaussing_table_enable('on');
            end
        end

        function set_degaussing_start_enable(app, state)
            app.set_enable_safe(app.MstartAmEditField_2, state);
            app.set_enable_safe(app.HstartAmEditField_2, state);
            app.set_enable_safe(app.MstartAmEditField_2Label, state);
            app.set_enable_safe(app.HstartAmEditField_2Label, state);
        end

        function set_degaussing_auto_enable(app, state)
            app.set_enable_safe(app.NofstepsEditField, state);
            app.set_enable_safe(app.InitialamplitudeAmEditField, state);
            app.set_enable_safe(app.FinalamplitudeAmEditField, state);
            app.set_enable_safe(app.NofstepsEditFieldLabel, state);
            app.set_enable_safe(app.InitialamplitudeAmEditFieldLabel, state);
            app.set_enable_safe(app.FinalamplitudeAmEditFieldLabel, state);
        end

        function set_degaussing_table_enable(app, state)
            if isprop(app, 'UITable_3') && ~isempty(app.UITable_3) && isvalid(app.UITable_3)
                app.set_enable_safe(app.UITable_3, state);
            end
        end

        function set_enable_safe(~, component, state)
            % MOD: set the Enable property only when the component actually has
            % one (uilabel gained Enable only in recent releases), so greying
            % out never errors on older MATLAB.
            if ~isempty(component) && isvalid(component) && isprop(component, 'Enable')
                component.Enable = state;
            end
        end

        function [Hstart, Mstart, amplitudes, ok, message] = get_degaussing_inputs(app)
            % MOD: gather the degaussing starting point and amplitude schedule
            % from the UI. Returns ok=false plus a user-facing warning message
            % when a required data-derived quantity is unavailable.
            Hstart = NaN;
            Mstart = NaN;
            amplitudes = [];
            ok = false;
            message = "";

            start_mode = lower(string(app.StartingpointDropDown_3.Value));
            if contains(start_mode, "remanence")
                [Mr, ok_r] = app.get_data_remanence();
                if ~ok_r
                    message = "Warning: The data hysteresis loop is unavailable; the remanence (H=0, Mr) starting point cannot be retrieved. Import a hysteretic dataset or choose another starting point.";
                    return;
                end
                Hstart = 0;
                Mstart = Mr;
            elseif contains(start_mode, "tip")
                [Htip, Mtip, ok_t] = PlaygroundUtils.get_data_tip(app);
                if ~ok_t
                    message = "Warning: The data tip point (Htip, Mtip) is unavailable; import a dataset or choose another starting point.";
                    return;
                end
                Hstart = Htip;
                Mstart = Mtip;
            else
                Hstart = app.HstartAmEditField_2.Value;
                Mstart = app.MstartAmEditField_2.Value;
                if ~isfinite(Hstart) || ~isfinite(Mstart)
                    message = "Warning: User-defined Hstart and Mstart must be finite numbers.";
                    return;
                end
            end

            amp_mode = lower(string(app.HamplitudeDropDown.Value));
            if contains(amp_mode, "automatic")
                [amplitudes, ok_a] = app.get_degaussing_amplitudes_auto();
                if ~ok_a
                    message = "Warning: Invalid automatic H amplitude settings (need N >= 1 steps and a positive initial amplitude).";
                    return;
                end
            else
                [amplitudes, ok_a] = app.get_degaussing_table_inputs();
                if ~ok_a
                    message = "Warning: The user-defined H amplitude table must contain at least one positive value.";
                    return;
                end
            end

            ok = true;
        end

        function run_playground_degaussing(app)
            failure_message = "The magnetization path cannot be computed with the current initial condition M(Hstart) and model parameters.";
            try
                [params, ok_params] = PlaygroundUtils.get_playground_params(app);
                if ~ok_params
                    PlaygroundUtils.clear_simulation(app);
                    app.plot_playground();
                    app.write_message(failure_message);
                    return;
                end

                [Hstart, Mstart, amplitudes, ok_inputs, message] = app.get_degaussing_inputs();
                if ~ok_inputs
                    PlaygroundUtils.clear_simulation(app);
                    app.plot_playground();
                    if strlength(message) > 0
                        app.write_message(message);
                    else
                        app.write_message(failure_message);
                    end
                    return;
                end

                app.sync_degaussing_ui();   % keep displayed start values consistent

                app.write_message("Calculate & Plot started");
                pause(0.01);
                calc_timer = tic;

                [Hsim, Msim, info] = solveJA_degaussing_playground( ...
                    Hstart, Mstart, amplitudes, params, ...
                    odeset('RelTol', 1e-7, 'AbsTol', 1e-6));
                info.status = "ok";
                PlaygroundUtils.set_simulation(app, Hsim, Msim, info);
                app.plot_playground();
                t = sprintf("%0.2f", toc(calc_timer));
                app.write_message("Calculate & Plot finished after " + t + " s");
            catch
                PlaygroundUtils.clear_simulation(app);
                app.plot_playground();
                app.write_message(failure_message);
            end
        end

        function expand_degaussing_table_if_needed(app, event)
            % MOD: auto-grow the Degaussing amplitude table by one empty row when
            % the last row receives a valid positive value (mirrors the minor
            % loop table's growing behaviour).
            if nargin < 2 || isempty(event) || ~isprop(app, 'UITable_3') || isempty(app.UITable_3) || ~isvalid(app.UITable_3)
                return;
            end

            if ~isprop(event, 'Indices') || isempty(event.Indices) || ~isprop(event, 'NewData')
                return;
            end

            row = event.Indices(1);
            newValue = event.NewData;
            if ~(isscalar(row) && isfinite(row) && row >= 1 && isfinite(newValue) && newValue > 0)
                return;
            end
            data = app.UITable_3.Data;
            if isempty(data) || ~isnumeric(data)
                return;
            end

            data = data(:);
            if row == numel(data)
                app.UITable_3.Data = [data; NaN];
            end
        end
        
        % =====================================================
        %  Major loop with harmonics (Playground) — MOD: new subsystem
        % =====================================================

        function [orders, amplitudes, phases, ok] = get_harmonics_table_inputs(app)
            % MOD: read the harmonic drive table (UITable2). Columns are
            % [Order k, Amplitude [A/m], Phase [deg]]. Rows with a non-integer
            % or missing order, or a missing amplitude, are dropped; a blank
            % phase is treated as 0 deg. Returns phases in DEGREES.
            orders = [];
            amplitudes = [];
            phases = [];
            ok = false;

            if ~isprop(app, 'UITable2') || isempty(app.UITable2) || ~isvalid(app.UITable2)
                return;
            end

            data = app.UITable2.Data;
            if isempty(data) || ~isnumeric(data) || size(data, 2) < 2
                return;
            end

            ord = data(:, 1);
            amp = data(:, 2);
            if size(data, 2) >= 3
                ph = data(:, 3);
            else
                ph = zeros(size(ord));
            end
            ph(~isfinite(ph)) = 0;   % blank phase => 0 deg

            keep = isfinite(ord) & ord >= 1 & isfinite(amp);
            ord = round(ord(keep));
            amp = amp(keep);
            ph = ph(keep);

            if isempty(ord) || ~any(abs(amp) > 0)
                return;
            end

            orders = ord(:);
            amplitudes = amp(:);
            phases = ph(:);
            ok = true;
        end

        function [Hstart, Mstart, orders, amplitudes, phases, ok, message] = get_harmonics_inputs(app)
            % MOD: gather the harmonic-drive starting point and the Fourier
            % components from the UI. Returns ok=false plus a user-facing
            % warning when a required data-derived quantity is unavailable or
            % the harmonics table is empty. phases are returned in RADIANS.
            Hstart = NaN;
            Mstart = NaN;
            orders = [];
            amplitudes = [];
            phases = [];
            ok = false;
            message = "";

            start_mode = lower(string(app.StartingpointDropDown_5.Value));
            if contains(start_mode, "demagnetized")
                Hstart = 0;
                Mstart = 0;
            elseif contains(start_mode, "tip")
                [Htip, Mtip, ok_t] = PlaygroundUtils.get_data_tip(app);
                if ~ok_t
                    message = "Warning: The data tip point (Htip, Mtip) is unavailable; import a dataset or choose another starting point.";
                    return;
                end
                Hstart = Htip;
                Mstart = Mtip;
            else
                Hstart = app.HstartAmEditField_3.Value;
                Mstart = app.MstartAmEditField_3.Value;
                if ~isfinite(Hstart) || ~isfinite(Mstart)
                    message = "Warning: User-defined Hstart and Mstart must be finite numbers.";
                    return;
                end
            end

            [orders, amplitudes, phases_deg, ok_tbl] = app.get_harmonics_table_inputs();
            if ~ok_tbl
                message = "Warning: The harmonics table must contain at least one row with an integer order >= 1 and a non-zero amplitude.";
                return;
            end

            phases = phases_deg * pi / 180;   % degrees -> radians
            ok = true;
        end

        function values = get_harmonics_default_table_values(app)
            % Default harmonic drive chosen to resemble the example waveform
            % more closely: a fundamental plus a few lower-amplitude odd harmonics
            % with zero phase, which already create nested minor loops without
            % overcomplicating the initial pattern.
            [Htip, ~, ok] = PlaygroundUtils.get_data_tip(app);
            if ok && isfinite(Htip) && Htip > 0
                A1 = Htip;
            else
                A1 = 1;
            end
            values = [1, A1,     0; ...
                      5, A1 / 2, 60; ...
                      NaN, NaN, NaN];
        end

        function configure_harmonics_table(app)
            % MOD: initialise the harmonic drive table.
            if ~isprop(app, 'UITable2') || isempty(app.UITable2) || ~isvalid(app.UITable2)
                return;
            end

            app.UITable2.ColumnEditable = [true true true];
            app.UITable2.Data = app.get_harmonics_default_table_values();
            app.harmonics_user_edited = false;
            app.UITable2.CellEditCallback = createCallbackFcn(app, @HarmonicsTableCellEdit, true);
        end

        function maybe_refresh_harmonics_defaults(app)
            % MOD: re-fill the harmonic drive table with data-tip-based
            % defaults, but only while the user has not manually edited it
            % (mirrors the minor-loop / degaussing default behaviour).
            if app.harmonics_user_edited
                return;
            end

            if isprop(app, 'UITable2') && ~isempty(app.UITable2) && isvalid(app.UITable2)
                app.UITable2.Data = app.get_harmonics_default_table_values();
            end
        end

        function sync_harmonics_ui(app)
            % MOD: enable/disable and populate the harmonic-drive controls
            % according to the selected starting-point and stop criterion.
            if ~PlaygroundUtils.is_harmonics_mode(app)
                return;
            end

            start_mode = lower(string(app.StartingpointDropDown_5.Value));
            if contains(start_mode, "demagnetized")
                app.HstartAmEditField_3.Value = 0;
                app.MstartAmEditField_3.Value = 0;
                app.set_harmonics_start_enable('off');
            elseif contains(start_mode, "tip")
                [Htip, Mtip, ok_t] = PlaygroundUtils.get_data_tip(app);
                if ok_t
                    app.HstartAmEditField_3.Value = Htip;
                    app.MstartAmEditField_3.Value = Mtip;
                else
                    app.HstartAmEditField_3.Value = 0;
                    app.MstartAmEditField_3.Value = 0;
                end
                app.set_harmonics_start_enable('off');
            else
                app.set_harmonics_start_enable('on');
            end

            is_fixed = string(app.StopcriterionDropDown_6.Value) == "Fixed repetitions";
            if is_fixed
                app.set_enable_safe(app.PeriodsEditField, 'on');
                app.set_enable_safe(app.PeriodsEditFieldLabel, 'on');
                app.set_enable_safe(app.ReltoleranceEditField_4, 'off');
                app.set_enable_safe(app.ReltoleranceEditField_4Label, 'off');
            else
                app.set_enable_safe(app.PeriodsEditField, 'off');
                app.set_enable_safe(app.PeriodsEditFieldLabel, 'off');
                app.set_enable_safe(app.ReltoleranceEditField_4, 'on');
                app.set_enable_safe(app.ReltoleranceEditField_4Label, 'on');
            end
        end

        function set_harmonics_start_enable(app, state)
            app.set_enable_safe(app.MstartAmEditField_3, state);
            app.set_enable_safe(app.HstartAmEditField_3, state);
            app.set_enable_safe(app.MstartAmEditField_3Label, state);
            app.set_enable_safe(app.HstartAmEditField_3Label, state);
        end

        function expand_harmonics_table_if_needed(app, event)
            % MOD: auto-grow the harmonics table by one empty row when the last
            % row receives a valid (order, amplitude) pair (mirrors the minor
            % loop / degaussing growing tables).
            if nargin < 2 || isempty(event) || ~isprop(app, 'UITable2') || isempty(app.UITable2) || ~isvalid(app.UITable2)
                return;
            end
            if ~isprop(event, 'Indices') || isempty(event.Indices)
                return;
            end

            data = app.UITable2.Data;
            if isempty(data) || ~isnumeric(data)
                return;
            end

            row = event.Indices(1);
            lastRow = size(data, 1);
            if row == lastRow
                ord = data(lastRow, 1);
                amp = data(lastRow, 2);
                if isfinite(ord) && ord >= 1 && isfinite(amp)
                    app.UITable2.Data = [data; NaN(1, size(data, 2))];
                end
            end
        end

        function run_playground_major_harmonics(app)
            failure_message = "The magnetization path cannot be computed with the current initial condition M(Hstart) and model parameters.";
            try
                [params, ok_params] = PlaygroundUtils.get_playground_params(app);
                if ~ok_params
                    PlaygroundUtils.clear_simulation(app);
                    app.plot_playground();
                    app.write_message(failure_message);
                    return;
                end

                [Hstart, Mstart, orders, amplitudes, phases, ok_inputs, message] = app.get_harmonics_inputs();
                if ~ok_inputs
                    PlaygroundUtils.clear_simulation(app);
                    app.plot_playground();
                    if strlength(message) > 0
                        app.write_message(message);
                    else
                        app.write_message(failure_message);
                    end
                    return;
                end

                app.sync_harmonics_ui();   % keep displayed start values consistent

                app.write_message("Calculate & Plot started");
                pause(0.01);
                calc_timer = tic;

                [Hsim, Msim, info] = solveJA_majorHarmonics_playground( ...
                    Hstart, Mstart, orders, amplitudes, phases, params, ...
                    string(app.StopcriterionDropDown_6.Value), ...
                    app.PeriodsEditField.Value, ...
                    app.ReltoleranceEditField_4.Value, ...
                    odeset('RelTol', 1e-7, 'AbsTol', 1e-6));
                info.startMode = string(app.StartingpointDropDown_5.Value);
                info.status = "ok";
                PlaygroundUtils.set_simulation(app, Hsim, Msim, info);
                app.plot_playground();
                t = sprintf("%0.2f", toc(calc_timer));
                app.write_message("Calculate & Plot finished after " + t + " s");
            catch
                PlaygroundUtils.clear_simulation(app);
                app.plot_playground();
                app.write_message(failure_message);
            end
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
            srcFolder = fullfile(app.AppRoot, "src");
            if isfolder(srcFolder)
                addpath(genpath(char(srcFolder)));
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
            PlaygroundUtils.clear_simulation(app);
            PlaygroundUtils.sync_major_ui(app);
            PlaygroundUtils.sync_minor_ui(app);   % MOD: grey minor-loop stop-criterion fields+labels
            app.sync_playground_mode_ui();
            app.sync_degaussing_ui();   % MOD: ADD this line
            app.sync_harmonics_ui();

            % MOD: note the convergence-mode repetition cap in the Rel. tolerance
            % labels (the solver still stops after at most 100 loops even in
            % "Until convergence" mode).
            % Legacy: this overrides the label from Design View. app.ReltoleranceEditField_6Label.Text = 'Rel. tolerance (max 100 loops)';
            % Legacy: this overrides the label from Design View. app.ReltoleranceEditField_5Label.Text = 'Rel. tolerance (max 100 loops/tip)';
            conv_tip = 'In "Until convergence" mode the loop still stops after at most 100 iterations.'; % (or the Repetitions value, if larger)
            app.ReltoleranceEditField_6.Tooltip = conv_tip;
            app.ReltoleranceEditField_6Label.Tooltip = conv_tip;
            app.ReltoleranceEditField_5.Tooltip = [conv_tip ' Applied per tip.'];
            app.ReltoleranceEditField_5Label.Tooltip = [conv_tip ' Applied per tip.'];
            app.ReltoleranceEditField_4.Tooltip = conv_tip;
            app.ReltoleranceEditField_4Label.Tooltip = conv_tip;

        
            % Default colors
            app.Colors = [
                0.58 0    0.70
                0.70 0    0
                0    0    0.70
                0    0.70 0
                1    0.50 0
            ];
        
            % Default output folder
            outFolder = app.default_data_folder();
            app.ensure_folder(outFolder);
            app.OutputDatasetPath.Value = char(outFolder);
        
            app.write_message("MagAnalyst 1.0.3-beta");
        
            drawnow;
            
            t = timer( ...
                'StartDelay', 0.05, ...
                'ExecutionMode', 'singleShot', ...
                'TimerFcn', @(~,~) adjustWindow(app) );
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
            update_components(app)
            calculate_parameters(app)
            plot(app)
            % Ensure hysteretic tip fields are populated from data so error can be computed
            try
                [Htip, Mtip, okTip] = app.get_ja_tip_from_tab_or_data();
                if okTip
                    app.JsField_7.Value = app.format_short(Htip);
                    app.JsField_8.Value = app.format_short(Mtip);
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
            startFolder = app.default_data_folder();
            fullpath = app.safe_getfile('*.csv', startFolder, ...
                "Select dataset file");

            if fullpath == ""
                return;
            end

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
            residue_plotter = ResiduePlotter(app.data_curve.H, app.data_curve.M, app.modeled_curve.H, app.modeled_curve.M, residue, log_flag, "M [A/m]");
            residue_plotter.plot()
        end

        % Button pushed function: ResidualplotButtondMdH
        function ResidualplotButtondMdHPushed(app, event)
            residue_calculator = SusceptibilityResidueCalculator(app.data_curve, app.modeled_curve);
            residue = residue_calculator.get_residue();
            log_flag = app.axis_scale_has_x(string(app.AxisScaleDropDowndMdH.Value));
            residue_plotter = ResiduePlotter(app.data_curve.H, app.data_curve.dMdH, app.modeled_curve.H, app.modeled_curve.dMdH, residue, log_flag, "∂M/∂H");
            residue_plotter.plot()
        end

        % Button pushed function: ResidualplotButtondHdMdH
        function ResidualplotButtondHdMdHPushed(app, event)
            residue_calculator = SemilogDerivativeResidueCalculator(app.data_curve, app.modeled_curve);
            residue = residue_calculator.get_residue();
            log_flag = app.axis_scale_has_x(string(app.AxisScaleDropDownHdMdH.Value));
            residue_plotter = ResiduePlotter(app.data_curve.H, app.data_curve.HdMdH, app.modeled_curve.H, app.modeled_curve.HdMdH, residue, log_flag, "∂M/∂(logH) [A/m]");
            residue_plotter.plot()
        end

        % Button pushed function: OutputBrowseButton
        function OutputBrowseButtonPushed(app, event)
            % MOD: Callback modified for safe file handling
            startFolder = string(app.OutputDatasetPath.Value);
            folder = app.safe_getdir(startFolder, ...
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
            grid(app.AxesM,"off");
            if(app.ShowgridCheckBoxM.Value == 1)
                grid(app.AxesM,"on");
                app.AxesM.YMinorGrid = 'on';  % Restore minor grid explicitly (grid on does not re-enable it)
            end 
        end

        % Value changed function: ShowgridCheckBoxdMdH
        function ShowgridCheckBoxdMdHValueChanged(app, event)
            grid(app.AxesdMdH,"off");
            if(app.ShowgridCheckBoxdMdH.Value == 1)
                grid(app.AxesdMdH,"on");
                app.AxesdMdH.YMinorGrid = 'on';  % Restore minor grid explicitly (grid on does not re-enable it)
            end
        end

        % Value changed function: ShowgridCheckBoxHdMdH
        function ShowgridCheckBoxHdMdHValueChanged(app, event)
            grid(app.AxesHdMdH,"off");
            if(app.ShowgridCheckBoxHdMdH.Value == 1)
                grid(app.AxesHdMdH,"on");
                app.AxesHdMdH.YMinorGrid = 'on';  % Restore minor grid explicitly (grid on does not re-enable it)
            end
        end

        % Button pushed function: SetColorsButton
        function SetColorsButtonPushed(app, event)
            app.SetColorsButton.Enable = false;
            app.ColorDialogApp = colorDialog(app, app.Colors, app.number_components);
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
                    value = str2double(app.TableFittedParameters.Data(i, 2));
                    s = sprintf("%s: \t%f", name, value);
                    fprintf(file, s + newline);
                end
                fprintf(file, newline);
            end     
            if(app.ExportModelparametersCheckBox.Value == 1)
                fprintf(file, "Model-Retrieved Parameters:" + newline);
                for i = 1:height(app.TableParameters.Data)
                    Ms_value = str2double(app.TableParameters.Data(i, 2).Ms_col);
                    alpha_value = str2double(app.TableParameters.Data(i, 3).alpha_col);
                    a_value = str2double(app.TableParameters.Data(i, 4).a_col);
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
                    alpha_Ms_value = str2double(app.TableQuantities.Data(i, 2).dimensionless_alphaMs_col);
                    density_product_value = str2double(app.TableQuantities.Data(i, 3).density_product_col);
                    Hk_value = str2double(app.TableQuantities.Data(i, 4).Hk_col);
                    magnetic_permeability_value = str2double(app.TableQuantities.Data(i, 5).initial_relative_magnetic_permeability_col);
                    s_component = sprintf("Component: %i", i);
                    s_alpha_Ms_value = sprintf("    α%i|Ms%i|/(3a%i): \t%0.4f", i, i, i, alpha_Ms_value);
                    s_density_product_value = sprintf("    N%ikBT [J/m^3]: \t%0.4f", i, density_product_value);
                    s_Hk = sprintf("        Hk%i [A/m]: \t%0.4f", i, Hk_value);
                    s_magnetic_permeability_value = sprintf("            μrin%i: \t%i", i, magnetic_permeability_value);
                    fprintf(file, s_component + newline + s_alpha_Ms_value + newline + s_density_product_value + newline + s_Hk + newline + s_magnetic_permeability_value + newline);
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
          % MOD: Callback modified for safe file handling

            startFolder = string(app.OutputDatasetPath.Value);
            folder = app.safe_getdir(startFolder, ...
                "Select output folder");

            if folder == ""
                return;
            end

            app.ensure_folder(folder);
            app.OutputDatasetPath.Value = char(folder);
        end

        % Menu selected function: OpenMenu
        function OpenMenuSelected(app, event)
            app.write_message("Opening new project");
            pause(0.01);
            
            % MOD: Callback modified for safe file handling
            fullpath = app.safe_getfile('*.txt', ...
                app.default_data_folder(), ...
                "Select project");
        
            if fullpath == ""
                app.write_message("Open cancelled");
                return;
            end
        
            app.ProjectPath = fullpath;

            data = fileread(app.ProjectPath);
            s = jsondecode(data);

            app.number_components = s.number_components;
            app.init_components();
            app.configure_minor_loop_table();
            app.init_parameters_table(true);
            app.init_quantities_table(true);
            app.NofcompSpinner.Value = app.number_components;

            app.TableFittedParameters.Data(:,2) = s.fitted_parameters_value;
            app.TableFittedParameters.Data(:,3) = s.fitted_parameters_lower_bound;
            app.TableFittedParameters.Data(:,4) = s.fitted_parameters_upper_bound;


            app.TableParameters.Data.(5) = cellstr(s.select_a);
            app.TableParameters.Data.(5) = categorical(app.TableParameters.Data.(5), {'high', 'low'}, 'Ordinal', true);
            
            app.NofpointsEditField.Value = s.number_points;
            app.PointSpaceDropDown.Value = s.point_space;
            loaded_error_type = string(s.error_type);
            if (loaded_error_type == "Diagonal") || (loaded_error_type == "Diagonal (continuous)")
                loaded_error_type = "Diagonal (logH, continuous)";
            elseif (loaded_error_type == "Diagonal (sampled)")
                loaded_error_type = "Diagonal (logH, sampled)";
            end
            if any(strcmp(app.ErrortominimizeDropDown.Items, char(loaded_error_type)))
                app.ErrortominimizeDropDown.Value = char(loaded_error_type);
            else
                app.ErrortominimizeDropDown.Value = app.ErrortominimizeDropDown.Items{1};
            end
            app.InputDatasetPath.Value = s.input_path;
            app.HorizontalaxisfieldDropDown.Value = s.horizontal_axis;
            app.VerticalaxisfieldDropDown.Value = s.vertical_axis;
            app.CurveDropDown.Value = s.curve_type;
            app.DescriptionTextArea.Value = s.description;
            
            app.OutputDatasetPath.Value = s.data_set_path;
            app.EditFieldFileNameExperimentalMagnetizationData.Value = s.experimental_anhysteretic_magnetization_file_name;
            app.EditFieldFileNameModeledAnhystereticMagnetization.Value = s.magnetization_file_name; 
            app.EditFieldFileNameParameters.Value = s.parameters_file_name;
            app.EditFieldFileNamePlotMagnetization.Value = s.magnetization_plots_file_name;
            app.EditFieldFileNamePlotSusceptibility.Value = s.suceptibility_plots_file_name;
            app.EditFieldFileNamePlotSemiLogMagDerivative.Value = s.magnetization_derivative_file_name;
            app.EditFieldFileNameResiduesMagnetization.Value = s.magnetization_residual_file_name;
            app.EditFieldFileNameResiduesSusceptibility.Value = s.susceptibility_residual_file_name;
            app.EditFieldFileNameResiduesSemiLogMagDerivative.Value = s.semi_log_derivative_file_name;

            app.ShowgridCheckBoxHdMdH.Value = s.fitting_show_grid_checkbox;
            app.PlotcomponentsCheckBoxHdMdH.Value = s.fitting_plot_components_checkbox;
            if isfield(s, 'fitting_show_hcr_checkbox')
                show_hcr_value = s.fitting_show_hcr_checkbox;
            else
                show_hcr_value = 1;
            end
            app.ShowhcrCheckBoxM.Value = show_hcr_value;
            app.ShowhcrCheckBoxdMdH.Value = show_hcr_value;
            app.ShowhcrCheckBoxHdMdH.Value = show_hcr_value;
            app.CheckBoxOutputMagnetizationDataFittedAnhystereticMagnetization.Value = s.model_magnetization_checkbox;
            app.OutputSeparateComponentsCheckBox.Value = s.model_magnetization_components_checkbox;
            app.ExportFittedparametersCheckBox.Value = s.fitted_parameters_checkbox;
            app.ExportModelparametersCheckBox.Value = s.model_parameters_checkbox;
            app.ExportOtherquantitiesCheckBox.Value = s.other_quantities_checkbox;
            app.ExportErrorsCheckBox.Value = s.errors_checkbox;
            app.CheckBoxExportPlotMagnetization.Value = s.magnetization_plots_checkbox;
            app.CheckBoxExportPlotSusceptibility.Value = s.susceptibility_plots_checkbox;
            app.CheckBoxExportPlotSemiLogMagDerivative.Value = s.magnetization_derivatives_checkbox;

            app.CheckBoxExperimentalMagnetization.Value = s.experimental_anhysteretic_magnetization_checkbox;
            app.CheckBoxExportResiduesMagnetization.Value = s.magnetization_residual_checkbox;
            app.CheckBoxExportResiduesSusceptibility.Value = s.susceptibility_residual_checkbox;
            app.CheckBoxExportResiduesSemiLogMagDerivative.Value = s.semi_log_derivative_residual_checkbox;

            if isfield(s, 'params')
                if isfield(s.params, 'Ms'); app.JsField_2.Value = char(string(s.params.Ms)); end
                if isfield(s.params, 'a'); app.JsField_3.Value = char(string(s.params.a)); end
                if isfield(s.params, 'alpha'); app.JsField_4.Value = char(string(s.params.alpha)); end
                if isfield(s.params, 'c'); app.JsField_5.Value = char(string(s.params.c)); end
                if isfield(s.params, 'k'); app.JsField_6.Value = char(string(s.params.k)); end
            end

            if isfield(s, 'hysteretic_starting_point'); app.StartingpointDropDown_4.Value = s.hysteretic_starting_point; end
            if isfield(s, 'hysteretic_fitting_region'); app.FittingregionDropDown.Value = s.hysteretic_fitting_region; end
            if isfield(s, 'hysteretic_stop_criterion'); app.StopcriterionDropDown_5.Value = s.hysteretic_stop_criterion; end
            if isfield(s, 'hysteretic_repetitions')
                app.RepetitionsEditField_3.Value = max(1, round(s.hysteretic_repetitions));
            end
            if isfield(s, 'hysteretic_rel_tolerance')
                app.ReltoleranceEditField_3.Value = max(0, s.hysteretic_rel_tolerance);
            end
            if isfield(s, 'hysteretic_max_repetitions')
                app.MaxrepetEditField.Value = max(1, round(s.hysteretic_max_repetitions));
            end
            app.sync_hysteretic_fitting_ui();
            
            if (app.calculate_and_plot() == -1)
                return
            end
            app.CalculatePlotButtonPushed();

            % MOD: Callback modified for safe file handling
            [~, name, ext] = fileparts(app.ProjectPath);
            app.write_message(name + ext + " was opened successfully");
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
            % MOD: Callback modified for safe file handling
            startFolder = app.default_data_folder();
            fullpath = app.safe_putfile('*.txt', startFolder, ...
                "Save project", "project.txt");

            if fullpath == ""
                return;
            end

            app.ProjectPath = fullpath;
            app.save();
        end

        % Value changed function: HorizontalaxisfieldDropDown
        function HorizontalaxisfieldDropDownValueChanged(app, event)
            app.calculate_and_plot();
        end

        % Value changed function: VerticalaxisfieldDropDown
        function VerticalaxisfieldDropDownValueChanged(app, event)
            app.calculate_and_plot();
        end

        % Callback function
        function DropDownValueChanged(app, event)
            value = app.InputAxisScaleDropDown.Value;
            app.plot_input();
            app.apply_axis_scale(app.AxesProcessedInputData, value);
            app.apply_axis_scale(app.AxesRawInputData, value);
        end

        % Callback function
        function InputAxisScaleDropDownValueChanged(app, event)
            app.InputAxisScaleDropDown.Value;
            app.plot_HdMdH();
            axis_scale = string(app.AxisScaleDropDownHdMdH.Value);
            app.apply_axis_scale(app.AxesHdMdH, axis_scale);
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
            
        end

        % Value changed function: CurveDropDown
        function CurveDropDownValueChanged(app, event)
            value = app.CurveDropDown.Value;
            dataset_path = app.InputDatasetPath.Value;
            if dataset_path == ""
                app.write_message("Select a dataset before applying point count.");
                return
            end
        
            try
                app.import_data(dataset_path);
                update_components(app)
                calculate_parameters(app)
                app.plot_input();
            catch e
                app.write_message("Reprocessing failed: " + e.message);
            end
        end

        % Button pushed function: InputApplyPointsButton
        function InputApplyPointsButtonPushed(app, event)
            
            dataset_path = app.InputDatasetPath.Value;
            if dataset_path == ""
                app.write_message("Select a dataset before applying point count.");
                return
            end
        
            try
                app.import_data(dataset_path);
                update_components(app)
                calculate_parameters(app)
                app.plot_input();
            catch e
                app.write_message("Reprocessing failed: " + e.message);
            end
        
        end

        % Callback function
        function InputAxisScaleDropDownValueChanged2(app, event)

            dataset_path = app.InputDatasetPath.Value;
            if dataset_path == ""
                app.write_message("Select a dataset before applying point count.");
                return
            end
        
            try
                app.import_data(dataset_path);
                update_components(app)
                calculate_parameters(app)
                app.plot_input();
            catch e
                app.write_message("Reprocessing failed: " + e.message);
            end
        end

        % Cell edit callback: TableFittedParameters
        function TableFittedParametersCellEdit(app, event)
            if isempty(event.Indices)
                return
            end
            row = event.Indices(1,1);
            col = event.Indices(1,2);
            if col ~= 2 || row > size(app.TableFittedParameters.Data, 1) || row > numel(app.fitted_parameter_values)
                return
            end
            new_text = string(event.NewData);
            new_text = strrep(new_text, ',', '');
            new_value = str2double(new_text);
            if isnan(new_value) || ~isfinite(new_value)
                app.write_message("Invalid fitted parameter value");
            else
                app.fitted_parameter_values(row) = new_value;
                update_components(app);
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
            if col == 2 && app.is_m_row(row)
                app.TableFittedParameters.Data(row, 2) = {app.format_value_for_edit(row)};
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
                app.write_message(path + " was not found, please browse the dataseth path again");
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
                app.write_message(path + " was not found, please browse the dataseth path again");
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
                app.JsField_9.Value = app.JsField_2.Value;
                app.JsField_10.Value = app.JsField_3.Value;
                app.JsField_11.Value = app.JsField_4.Value;
                app.JsField_12.Value = app.JsField_5.Value;
                app.JsField_13.Value = app.JsField_6.Value;
                app.write_message("Jiles-Atherton parameters retrieved from Hysteretic Fitting tab.");
                return;
            end

            [ms_seed, a_seed, alpha_seed, has_seeds] = app.get_first_anhysteretic_seeds();
            if has_seeds
                app.JsField_9.Value = ms_seed;
                app.JsField_10.Value = a_seed;
                app.JsField_11.Value = alpha_seed;
                app.JsField_12.Value = "0";
                app.JsField_13.Value = "0";
                app.write_message("Anhysteretic parameters retrieved from Anhysteretic Fitting tab.");
                return;
            end

            app.write_message("No parameters available to retrieve.");
        end

        % Value changed function: RepetitionsEditField_3
        function RepetitionsEditField_3ValueChanged(app, event)
            app.plot_hysteretic_tab_data()
        end

        % Value changed function: ReltoleranceEditField_3
        function ReltoleranceEditField_3ValueChanged(app, event)
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

        % Value changed function: MaxrepetEditField
        function MaxrepetEditFieldValueChanged(app, event)
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
            failure_message = "The magnetization path cannot be computed with the current initial condition M(Hstart) and model parameters.";
            
            if PlaygroundUtils.is_minor_mode(app)
                app.run_playground_minor_loop();
            elseif PlaygroundUtils.is_degaussing_mode(app)     % MOD: ADD these two lines
                app.run_playground_degaussing();               % MOD: ADD
            elseif PlaygroundUtils.is_harmonics_mode(app)      % MOD: ADD these two lines
                app.run_playground_major_harmonics();          % MOD: ADD
            else
                [params, ok_params] = PlaygroundUtils.get_playground_params(app);
                if ~ok_params
                    PlaygroundUtils.clear_simulation(app);
                    app.plot_playground();
                    app.write_message(failure_message);
                    return;
                end

                [Hstart, Mstart, Htip, ok_inputs] = PlaygroundUtils.get_major_inputs(app);
                if ~ok_inputs
                    PlaygroundUtils.clear_simulation(app);
                    app.plot_playground();
                    app.write_message(failure_message);
                    return;
                end

                PlaygroundUtils.sync_major_ui(app);
                app.write_message("Calculate & Plot started");
                pause(0.01);
                calc_timer = tic;
                try
                    [Hsim, Msim, info] = solveJA_majorLoop_playground( ...
                        Hstart, Mstart, Htip, params, ...
                        string(app.StartingpointDropDown.Value), ...
                        string(app.StopcriterionDropDown.Value), ...
                        app.RepetitionsEditField.Value, ...
                        app.ReltoleranceEditField_6.Value, ...
                        odeset('RelTol', 1e-7, 'AbsTol', 1e-6));
                    info.status = "ok";
                    PlaygroundUtils.set_simulation(app, Hsim, Msim, info);
                    app.plot_playground();
                    t = sprintf("%0.2f", toc(calc_timer));
                    app.write_message("Calculate & Plot finished after " + t + " s");
                catch
                    PlaygroundUtils.clear_simulation(app);
                    app.plot_playground();
                    t = sprintf("%0.2f", toc(calc_timer));
                    app.write_message("Calculate & Plot failed after " + t + " s: " + failure_message);
                end
            end
        end

        % Value changed function: ShowgridCheckBoxM_5
        function ShowgridCheckBoxM_5ValueChanged(app, event)
            app.apply_detailed_grid(app.AxesM_5, app.ShowgridCheckBoxM_5.Value == 1);
            app.plot_playground();
        end

        % Value changed function: HamplitudeAmEditField, 
        % ...and 7 other components
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
        % ...and 5 other components
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

        % Value changed function: StopcriterionDropDown_4
        function StopcriterionDropDown_4ValueChanged(app, event)
            % MOD: grey the minor-loop Repetitions / Rel. tolerance fields (and
            % labels) to match the chosen stop criterion, then invalidate the
            % cached simulation and redraw.
            PlaygroundUtils.sync_minor_ui(app);
            PlaygroundUtils.clear_simulation(app);
            app.plot_playground();
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

            % Create HtipAmLabel
            app.HtipAmLabel = uilabel(app.GridLayoutTips);
            app.HtipAmLabel.HorizontalAlignment = 'right';
            app.HtipAmLabel.FontWeight = 'bold';
            app.HtipAmLabel.Layout.Row = 1;
            app.HtipAmLabel.Layout.Column = 1;
            app.HtipAmLabel.Text = 'Htip [A/m]';

            % Create HTipField
            app.HTipField = uieditfield(app.GridLayoutTips, 'text');
            app.HTipField.Editable = 'off';
            app.HTipField.HorizontalAlignment = 'right';
            app.HTipField.Layout.Row = 1;
            app.HTipField.Layout.Column = 2;

            % Create MtipAmLabel
            app.MtipAmLabel = uilabel(app.GridLayoutTips);
            app.MtipAmLabel.HorizontalAlignment = 'right';
            app.MtipAmLabel.FontWeight = 'bold';
            app.MtipAmLabel.Layout.Row = 2;
            app.MtipAmLabel.Layout.Column = 1;
            app.MtipAmLabel.Text = 'Mtip [A/m]';

            % Create MTipField
            app.MTipField = uieditfield(app.GridLayoutTips, 'text');
            app.MTipField.Editable = 'off';
            app.MTipField.HorizontalAlignment = 'right';
            app.MTipField.Layout.Row = 2;
            app.MTipField.Layout.Column = 2;

            % Create GridLayoutTips_2
            app.GridLayoutTips_2 = uigridlayout(app.GridLayoutInputTipsAndPlotButton);
            app.GridLayoutTips_2.ColumnWidth = {'0.8x', '1x'};
            app.GridLayoutTips_2.Padding = [0 0 0 0];
            app.GridLayoutTips_2.Layout.Row = 1;
            app.GridLayoutTips_2.Layout.Column = 2;

            % Create InputAxisScaleDropDown
            app.InputAxisScaleDropDown = uidropdown(app.GridLayoutTips_2);
            app.InputAxisScaleDropDown.Items = {'linear', 'semilog-x', 'semilog-y', 'log-log'};
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
            app.InputNumberofPointsEditField.Layout.Row = 1;
            app.InputNumberofPointsEditField.Layout.Column = 2;
            app.InputNumberofPointsEditField.Value = 50;

            % Create InputNumberofPointsLabel
            app.InputNumberofPointsLabel = uilabel(app.GridLayoutTips_3);
            app.InputNumberofPointsLabel.HorizontalAlignment = 'right';
            app.InputNumberofPointsLabel.FontWeight = 'bold';
            app.InputNumberofPointsLabel.Layout.Row = 1;
            app.InputNumberofPointsLabel.Layout.Column = 1;
            app.InputNumberofPointsLabel.Text = 'N° of points';

            % Create InputApplyPointsButton
            app.InputApplyPointsButton = uibutton(app.GridLayoutTips_3, 'push');
            app.InputApplyPointsButton.ButtonPushedFcn = createCallbackFcn(app, @InputApplyPointsButtonPushed, true);
            app.InputApplyPointsButton.FontWeight = 'bold';
            app.InputApplyPointsButton.Layout.Row = 1;
            app.InputApplyPointsButton.Layout.Column = 3;
            app.InputApplyPointsButton.Text = 'Apply';

            % Create AnhystereticfittingTab
            app.AnhystereticfittingTab = uitab(app.TabGroup);
            app.AnhystereticfittingTab.AutoResizeChildren = 'off';
            app.AnhystereticfittingTab.Title = 'Anhysteretic fitting';

            % Create AnhystereticmagnetizationfittingTabGridLayout
            app.AnhystereticmagnetizationfittingTabGridLayout = uigridlayout(app.AnhystereticfittingTab);
            app.AnhystereticmagnetizationfittingTabGridLayout.RowHeight = {'1x'};

            % Create GridLayoutAxes
            app.GridLayoutAxes = uigridlayout(app.AnhystereticmagnetizationfittingTabGridLayout);
            app.GridLayoutAxes.ColumnWidth = {'1x'};
            app.GridLayoutAxes.RowHeight = {'1x', '0.15x', '1x', '0.15x', '1x', '0.15x'};
            app.GridLayoutAxes.RowSpacing = 3;
            app.GridLayoutAxes.Padding = [0 0 0 0];
            app.GridLayoutAxes.Layout.Row = 1;
            app.GridLayoutAxes.Layout.Column = 1;

            % Create AxesHdMdH
            app.AxesHdMdH = uiaxes(app.GridLayoutAxes);
            xlabel(app.AxesHdMdH, 'H [A/m]')
            ylabel(app.AxesHdMdH, '∂M/∂(lnH) [A/m]')
            zlabel(app.AxesHdMdH, 'Z')
            app.AxesHdMdH.Box = 'on';
            app.AxesHdMdH.Layout.Row = 5;
            app.AxesHdMdH.Layout.Column = 1;

            % Create AxesdMdH
            app.AxesdMdH = uiaxes(app.GridLayoutAxes);
            xlabel(app.AxesdMdH, 'H [A/m]')
            ylabel(app.AxesdMdH, '∂M/∂H')
            zlabel(app.AxesdMdH, 'Z')
            app.AxesdMdH.Box = 'on';
            app.AxesdMdH.Layout.Row = 3;
            app.AxesdMdH.Layout.Column = 1;

            % Create AxesM
            app.AxesM = uiaxes(app.GridLayoutAxes);
            xlabel(app.AxesM, 'H [A/m]')
            ylabel(app.AxesM, 'M [A/m]')
            zlabel(app.AxesM, 'Z')
            app.AxesM.Box = 'on';
            app.AxesM.Layout.Row = 1;
            app.AxesM.Layout.Column = 1;

            % Create GridLayoutOptionsM
            app.GridLayoutOptionsM = uigridlayout(app.GridLayoutAxes);
            app.GridLayoutOptionsM.ColumnWidth = {'2.9x', '2.1x', '3x', '2x', '2x', '1x', '1.3x'};
            app.GridLayoutOptionsM.RowHeight = {'1x'};
            app.GridLayoutOptionsM.Padding = [0 0 0 0];
            app.GridLayoutOptionsM.Layout.Row = 2;
            app.GridLayoutOptionsM.Layout.Column = 1;

            % Create ResidualplotButtonM
            app.ResidualplotButtonM = uibutton(app.GridLayoutOptionsM, 'push');
            app.ResidualplotButtonM.ButtonPushedFcn = createCallbackFcn(app, @ResidualplotButtonMPushed, true);
            app.ResidualplotButtonM.Layout.Row = 1;
            app.ResidualplotButtonM.Layout.Column = 2;
            app.ResidualplotButtonM.Text = 'Residuals';

            % Create PlotcomponentsCheckBoxM
            app.PlotcomponentsCheckBoxM = uicheckbox(app.GridLayoutOptionsM);
            app.PlotcomponentsCheckBoxM.ValueChangedFcn = createCallbackFcn(app, @PlotcomponentsCheckBoxMValueChanged, true);
            app.PlotcomponentsCheckBoxM.Text = 'Plot comp.';
            app.PlotcomponentsCheckBoxM.Layout.Row = 1;
            app.PlotcomponentsCheckBoxM.Layout.Column = 3;
            app.PlotcomponentsCheckBoxM.Value = true;

            % Create ShowgridCheckBoxM
            app.ShowgridCheckBoxM = uicheckbox(app.GridLayoutOptionsM);
            app.ShowgridCheckBoxM.ValueChangedFcn = createCallbackFcn(app, @ShowgridCheckBoxMValueChanged, true);
            app.ShowgridCheckBoxM.Text = 'Grid';
            app.ShowgridCheckBoxM.Layout.Row = 1;
            app.ShowgridCheckBoxM.Layout.Column = 4;
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
            app.GridLayoutOptionsdMdH.ColumnWidth = {'2.9x', '2.1x', '3x', '2x', '2x', '1x', '1.3x'};
            app.GridLayoutOptionsdMdH.RowHeight = {'1x'};
            app.GridLayoutOptionsdMdH.Padding = [0 0 0 0];
            app.GridLayoutOptionsdMdH.Layout.Row = 4;
            app.GridLayoutOptionsdMdH.Layout.Column = 1;

            % Create ResidualplotButtondMdH
            app.ResidualplotButtondMdH = uibutton(app.GridLayoutOptionsdMdH, 'push');
            app.ResidualplotButtondMdH.ButtonPushedFcn = createCallbackFcn(app, @ResidualplotButtondMdHPushed, true);
            app.ResidualplotButtondMdH.Layout.Row = 1;
            app.ResidualplotButtondMdH.Layout.Column = 2;
            app.ResidualplotButtondMdH.Text = 'Residuals';

            % Create PlotcomponentsCheckBoxdMdH
            app.PlotcomponentsCheckBoxdMdH = uicheckbox(app.GridLayoutOptionsdMdH);
            app.PlotcomponentsCheckBoxdMdH.ValueChangedFcn = createCallbackFcn(app, @PlotcomponentsCheckBoxdMdHValueChanged, true);
            app.PlotcomponentsCheckBoxdMdH.Text = 'Plot comp.';
            app.PlotcomponentsCheckBoxdMdH.Layout.Row = 1;
            app.PlotcomponentsCheckBoxdMdH.Layout.Column = 3;
            app.PlotcomponentsCheckBoxdMdH.Value = true;

            % Create ShowgridCheckBoxdMdH
            app.ShowgridCheckBoxdMdH = uicheckbox(app.GridLayoutOptionsdMdH);
            app.ShowgridCheckBoxdMdH.ValueChangedFcn = createCallbackFcn(app, @ShowgridCheckBoxdMdHValueChanged, true);
            app.ShowgridCheckBoxdMdH.Text = 'Grid';
            app.ShowgridCheckBoxdMdH.Layout.Row = 1;
            app.ShowgridCheckBoxdMdH.Layout.Column = 4;
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
            app.GridLayoutOptionsHdMdH.ColumnWidth = {'2.9x', '2.1x', '3x', '2x', '2x', '1x', '1.3x'};
            app.GridLayoutOptionsHdMdH.RowHeight = {'1x'};
            app.GridLayoutOptionsHdMdH.Padding = [0 0 0 0];
            app.GridLayoutOptionsHdMdH.Layout.Row = 6;
            app.GridLayoutOptionsHdMdH.Layout.Column = 1;

            % Create ResidualplotButtondHdMdH
            app.ResidualplotButtondHdMdH = uibutton(app.GridLayoutOptionsHdMdH, 'push');
            app.ResidualplotButtondHdMdH.ButtonPushedFcn = createCallbackFcn(app, @ResidualplotButtondHdMdHPushed, true);
            app.ResidualplotButtondHdMdH.Layout.Row = 1;
            app.ResidualplotButtondHdMdH.Layout.Column = 2;
            app.ResidualplotButtondHdMdH.Text = 'Residuals';

            % Create PlotcomponentsCheckBoxHdMdH
            app.PlotcomponentsCheckBoxHdMdH = uicheckbox(app.GridLayoutOptionsHdMdH);
            app.PlotcomponentsCheckBoxHdMdH.ValueChangedFcn = createCallbackFcn(app, @PlotcomponentsCheckBoxHdMdHValueChanged, true);
            app.PlotcomponentsCheckBoxHdMdH.Text = 'Plot comp.';
            app.PlotcomponentsCheckBoxHdMdH.Layout.Row = 1;
            app.PlotcomponentsCheckBoxHdMdH.Layout.Column = 3;
            app.PlotcomponentsCheckBoxHdMdH.Value = true;

            % Create ShowgridCheckBoxHdMdH
            app.ShowgridCheckBoxHdMdH = uicheckbox(app.GridLayoutOptionsHdMdH);
            app.ShowgridCheckBoxHdMdH.ValueChangedFcn = createCallbackFcn(app, @ShowgridCheckBoxHdMdHValueChanged, true);
            app.ShowgridCheckBoxHdMdH.Text = 'Grid';
            app.ShowgridCheckBoxHdMdH.Layout.Row = 1;
            app.ShowgridCheckBoxHdMdH.Layout.Column = 4;
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

            % Create ModelretrievedparametersLabel
            app.ModelretrievedparametersLabel = uilabel(app.GridLayoutNumbers);
            app.ModelretrievedparametersLabel.FontWeight = 'bold';
            app.ModelretrievedparametersLabel.Layout.Row = 5;
            app.ModelretrievedparametersLabel.Layout.Column = 1;
            app.ModelretrievedparametersLabel.Text = 'Model retrieved parameters';

            % Create TableParameters
            app.TableParameters = uitable(app.GridLayoutNumbers);
            app.TableParameters.ColumnName = {'Component'; 'Msᵢ [A/m]'; 'αᵢ'; 'aᵢ [A/m]'; 'Select aᵢ'};
            app.TableParameters.RowName = {};
            app.TableParameters.ColumnEditable = [false false false false true];
            app.TableParameters.Layout.Row = 6;
            app.TableParameters.Layout.Column = 1;

            % Create GridLayoutButtons
            app.GridLayoutButtons = uigridlayout(app.GridLayoutNumbers);
            app.GridLayoutButtons.ColumnWidth = {'0.65x', '1.1x', '0.8x', '1x', '0.5x', '0.5x'};
            app.GridLayoutButtons.RowHeight = {'1.1x'};
            app.GridLayoutButtons.Padding = [0 0 0 0];
            app.GridLayoutButtons.Layout.Row = 9;
            app.GridLayoutButtons.Layout.Column = 1;

            % Create FitButton
            app.FitButton = uibutton(app.GridLayoutButtons, 'push');
            app.FitButton.ButtonPushedFcn = createCallbackFcn(app, @FitButtonPushed, true);
            app.FitButton.FontWeight = 'bold';
            app.FitButton.FontColor = [0.8667 0.3294 0];
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

            % Create ErrortominimizeDropDownLabel
            app.ErrortominimizeDropDownLabel = uilabel(app.GridLayoutButtons);
            app.ErrortominimizeDropDownLabel.WordWrap = 'on';
            app.ErrortominimizeDropDownLabel.FontWeight = 'bold';
            app.ErrortominimizeDropDownLabel.Layout.Row = 1;
            app.ErrortominimizeDropDownLabel.Layout.Column = 1;
            app.ErrortominimizeDropDownLabel.Text = 'Error to minimize';

            % Create ErrortominimizeDropDown
            app.ErrortominimizeDropDown = uidropdown(app.GridLayoutButtons);
            app.ErrortominimizeDropDown.Items = {'Diagonal (H, sampled)', 'Diagonal (H, continuous)', 'Diagonal (logH, sampled)', 'Diagonal (logH, continuous)', 'Vertical', 'Horizontal'};
            app.ErrortominimizeDropDown.Layout.Row = 1;
            app.ErrortominimizeDropDown.Layout.Column = 2;
            app.ErrortominimizeDropDown.Value = 'Diagonal (logH, continuous)';

            % Create ErrorDisplay
            app.ErrorDisplay = uieditfield(app.GridLayoutButtons, 'text');
            app.ErrorDisplay.Editable = 'off';
            app.ErrorDisplay.Layout.Row = 1;
            app.ErrorDisplay.Layout.Column = 3;

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

            % Create OthercalculatedquantitiesLabel
            app.OthercalculatedquantitiesLabel = uilabel(app.GridLayoutOtherQuantities);
            app.OthercalculatedquantitiesLabel.FontWeight = 'bold';
            app.OthercalculatedquantitiesLabel.Layout.Row = 1;
            app.OthercalculatedquantitiesLabel.Layout.Column = 1;
            app.OthercalculatedquantitiesLabel.Text = 'Other calculated quantities';

            % Create JsTEditFieldLabel
            app.JsTEditFieldLabel = uilabel(app.GridLayoutOtherQuantities);
            app.JsTEditFieldLabel.HorizontalAlignment = 'right';
            app.JsTEditFieldLabel.FontWeight = 'bold';
            app.JsTEditFieldLabel.Layout.Row = 1;
            app.JsTEditFieldLabel.Layout.Column = 4;
            app.JsTEditFieldLabel.Text = 'Js [T]';

            % Create JsField
            app.JsField = uieditfield(app.GridLayoutOtherQuantities, 'text');
            app.JsField.Editable = 'off';
            app.JsField.HorizontalAlignment = 'right';
            app.JsField.Layout.Row = 1;
            app.JsField.Layout.Column = 5;

            % Create murinField
            app.murinField = uieditfield(app.GridLayoutOtherQuantities, 'text');
            app.murinField.Editable = 'off';
            app.murinField.HorizontalAlignment = 'right';
            app.murinField.Layout.Row = 1;
            app.murinField.Layout.Column = 3;

            % Create murinLabel
            app.murinLabel = uilabel(app.GridLayoutOtherQuantities);
            app.murinLabel.HorizontalAlignment = 'right';
            app.murinLabel.FontWeight = 'bold';
            app.murinLabel.Layout.Row = 1;
            app.murinLabel.Layout.Column = 2;
            app.murinLabel.Text = 'μrᵢₙ';

            % Create TableQuantities
            app.TableQuantities = uitable(app.GridLayoutNumbers);
            app.TableQuantities.ColumnName = {'Component'; 'αᵢ⏐Msᵢ⏐/(3aᵢ)'; 'NᵢkвT [J/m³]'; 'Hkᵢ [A/m]'; 'μrᵢₙ ᵢ'};
            app.TableQuantities.RowName = {};
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

            % Create NofcompSpinnerLabel
            app.NofcompSpinnerLabel = uilabel(app.GridLayoutModeledCurve);
            app.NofcompSpinnerLabel.Layout.Row = 1;
            app.NofcompSpinnerLabel.Layout.Column = 1;
            app.NofcompSpinnerLabel.Text = 'N. of comp.';

            % Create NofcompSpinner
            app.NofcompSpinner = uispinner(app.GridLayoutModeledCurve);
            app.NofcompSpinner.Limits = [1 4];
            app.NofcompSpinner.ValueChangedFcn = createCallbackFcn(app, @NofcompSpinnerValueChanged, true);
            app.NofcompSpinner.Layout.Row = 1;
            app.NofcompSpinner.Layout.Column = 2;
            app.NofcompSpinner.Value = 1;

            % Create NofpointsEditFieldLabel
            app.NofpointsEditFieldLabel = uilabel(app.GridLayoutModeledCurve);
            app.NofpointsEditFieldLabel.Layout.Row = 1;
            app.NofpointsEditFieldLabel.Layout.Column = 3;
            app.NofpointsEditFieldLabel.Text = 'N. of points';

            % Create NofpointsEditField
            app.NofpointsEditField = uieditfield(app.GridLayoutModeledCurve, 'numeric');
            app.NofpointsEditField.Limits = [0 Inf];
            app.NofpointsEditField.ValueDisplayFormat = '%.0f';
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

            % Create SetColorsButton
            app.SetColorsButton = uibutton(app.GridLayoutModeledCurve, 'push');
            app.SetColorsButton.ButtonPushedFcn = createCallbackFcn(app, @SetColorsButtonPushed, true);
            app.SetColorsButton.Layout.Row = 1;
            app.SetColorsButton.Layout.Column = 6;
            app.SetColorsButton.Text = 'Set Colors';

            % Create FittedparametersLabel
            app.FittedparametersLabel = uilabel(app.GridLayoutNumbers);
            app.FittedparametersLabel.FontWeight = 'bold';
            app.FittedparametersLabel.Layout.Row = 3;
            app.FittedparametersLabel.Layout.Column = 1;
            app.FittedparametersLabel.Text = 'Fitted parameters';

            % Create HystereticfittingTab
            app.HystereticfittingTab = uitab(app.TabGroup);
            app.HystereticfittingTab.Title = 'Hysteretic fitting ';

            % Create GridLayout2
            app.GridLayout2 = uigridlayout(app.HystereticfittingTab);
            app.GridLayout2.ColumnWidth = {'1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x'};
            app.GridLayout2.RowHeight = {'1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '0.5x', '1.3x'};
            app.GridLayout2.ColumnSpacing = 2.77317164494441;
            app.GridLayout2.RowSpacing = 6.31337694021372;
            app.GridLayout2.Padding = [2.77317164494441 6.31337694021372 2.77317164494441 6.31337694021372];

            % Create AxesM_2
            app.AxesM_2 = uiaxes(app.GridLayout2);
            xlabel(app.AxesM_2, 'H [A/m]')
            ylabel(app.AxesM_2, 'M [A/m]')
            zlabel(app.AxesM_2, 'Z')
            app.AxesM_2.Box = 'on';
            app.AxesM_2.Layout.Row = [2 14];
            app.AxesM_2.Layout.Column = [1 5];

            % Create JilesAthertonmodelrateindependentLabel
            app.JilesAthertonmodelrateindependentLabel = uilabel(app.GridLayout2);
            app.JilesAthertonmodelrateindependentLabel.FontWeight = 'bold';
            app.JilesAthertonmodelrateindependentLabel.Layout.Row = 1;
            app.JilesAthertonmodelrateindependentLabel.Layout.Column = [1 5];
            app.JilesAthertonmodelrateindependentLabel.Text = 'Jiles-Atherton model (rate-independent)';

            % Create ModelparametersLabel
            app.ModelparametersLabel = uilabel(app.GridLayout2);
            app.ModelparametersLabel.FontWeight = 'bold';
            app.ModelparametersLabel.Layout.Row = 2;
            app.ModelparametersLabel.Layout.Column = [6 7];
            app.ModelparametersLabel.Text = 'Model parameters';

            % Create JsTEditFieldLabel_2
            app.JsTEditFieldLabel_2 = uilabel(app.GridLayout2);
            app.JsTEditFieldLabel_2.FontWeight = 'bold';
            app.JsTEditFieldLabel_2.Layout.Row = 3;
            app.JsTEditFieldLabel_2.Layout.Column = 6;
            app.JsTEditFieldLabel_2.Text = 'Ms [A/m]';

            % Create JsField_2
            app.JsField_2 = uieditfield(app.GridLayout2, 'text');
            app.JsField_2.HorizontalAlignment = 'right';
            app.JsField_2.Layout.Row = 3;
            app.JsField_2.Layout.Column = 7;

            % Create JsTEditFieldLabel_3
            app.JsTEditFieldLabel_3 = uilabel(app.GridLayout2);
            app.JsTEditFieldLabel_3.FontWeight = 'bold';
            app.JsTEditFieldLabel_3.Layout.Row = 4;
            app.JsTEditFieldLabel_3.Layout.Column = 6;
            app.JsTEditFieldLabel_3.Text = 'a [A/m]';

            % Create JsField_3
            app.JsField_3 = uieditfield(app.GridLayout2, 'text');
            app.JsField_3.HorizontalAlignment = 'right';
            app.JsField_3.Layout.Row = 4;
            app.JsField_3.Layout.Column = 7;

            % Create JsTEditFieldLabel_4
            app.JsTEditFieldLabel_4 = uilabel(app.GridLayout2);
            app.JsTEditFieldLabel_4.FontWeight = 'bold';
            app.JsTEditFieldLabel_4.Layout.Row = 5;
            app.JsTEditFieldLabel_4.Layout.Column = 6;
            app.JsTEditFieldLabel_4.Text = 'alpha';

            % Create JsField_4
            app.JsField_4 = uieditfield(app.GridLayout2, 'text');
            app.JsField_4.HorizontalAlignment = 'right';
            app.JsField_4.Layout.Row = 5;
            app.JsField_4.Layout.Column = 7;

            % Create JsTEditFieldLabel_5
            app.JsTEditFieldLabel_5 = uilabel(app.GridLayout2);
            app.JsTEditFieldLabel_5.FontWeight = 'bold';
            app.JsTEditFieldLabel_5.Layout.Row = 6;
            app.JsTEditFieldLabel_5.Layout.Column = 6;
            app.JsTEditFieldLabel_5.Text = 'c';

            % Create JsField_5
            app.JsField_5 = uieditfield(app.GridLayout2, 'text');
            app.JsField_5.HorizontalAlignment = 'right';
            app.JsField_5.Layout.Row = 6;
            app.JsField_5.Layout.Column = 7;

            % Create JsTEditFieldLabel_6
            app.JsTEditFieldLabel_6 = uilabel(app.GridLayout2);
            app.JsTEditFieldLabel_6.FontWeight = 'bold';
            app.JsTEditFieldLabel_6.Layout.Row = 7;
            app.JsTEditFieldLabel_6.Layout.Column = 6;
            app.JsTEditFieldLabel_6.Text = 'k [A/m]';

            % Create JsField_6
            app.JsField_6 = uieditfield(app.GridLayout2, 'text');
            app.JsField_6.HorizontalAlignment = 'right';
            app.JsField_6.Layout.Row = 7;
            app.JsField_6.Layout.Column = 7;

            % Create FitButton_2
            app.FitButton_2 = uibutton(app.GridLayout2, 'push');
            app.FitButton_2.ButtonPushedFcn = createCallbackFcn(app, @FitButton_2Pushed, true);
            app.FitButton_2.FontWeight = 'bold';
            app.FitButton_2.FontColor = [0.8667 0.3294 0];
            app.FitButton_2.Layout.Row = 15;
            app.FitButton_2.Layout.Column = 11;
            app.FitButton_2.Text = 'Fit';

            % Create CalculatePlotButton_2
            app.CalculatePlotButton_2 = uibutton(app.GridLayout2, 'push');
            app.CalculatePlotButton_2.ButtonPushedFcn = createCallbackFcn(app, @CalculatePlotButton_2Pushed, true);
            app.CalculatePlotButton_2.WordWrap = 'on';
            app.CalculatePlotButton_2.Layout.Row = 15;
            app.CalculatePlotButton_2.Layout.Column = 10;
            app.CalculatePlotButton_2.Text = 'Calculate & Plot';

            % Create ErrortominimizeDropDownLabel_2
            app.ErrortominimizeDropDownLabel_2 = uilabel(app.GridLayout2);
            app.ErrortominimizeDropDownLabel_2.WordWrap = 'on';
            app.ErrortominimizeDropDownLabel_2.FontWeight = 'bold';
            app.ErrortominimizeDropDownLabel_2.Layout.Row = 15;
            app.ErrortominimizeDropDownLabel_2.Layout.Column = 6;
            app.ErrortominimizeDropDownLabel_2.Text = 'Error to minimize';

            % Create ErrortominimizeDropDown_2
            app.ErrortominimizeDropDown_2 = uidropdown(app.GridLayout2);
            app.ErrortominimizeDropDown_2.Items = {'Diagonal (H, continuous)', 'Vertical', 'Horizontal'};
            app.ErrortominimizeDropDown_2.Layout.Row = 15;
            app.ErrortominimizeDropDown_2.Layout.Column = [7 8];
            app.ErrortominimizeDropDown_2.Value = 'Diagonal (H, continuous)';

            % Create ErrorDisplay_2
            app.ErrorDisplay_2 = uieditfield(app.GridLayout2, 'text');
            app.ErrorDisplay_2.Editable = 'off';
            app.ErrorDisplay_2.Layout.Row = 15;
            app.ErrorDisplay_2.Layout.Column = 9;

            % Create RetrieveseedsButton
            app.RetrieveseedsButton = uibutton(app.GridLayout2, 'push');
            app.RetrieveseedsButton.ButtonPushedFcn = createCallbackFcn(app, @RetrieveseedsButtonPushed, true);
            app.RetrieveseedsButton.Layout.Row = 2;
            app.RetrieveseedsButton.Layout.Column = [11 12];
            app.RetrieveseedsButton.Text = 'Retrieve seeds';

            % Create DrivingfieldLabel
            app.DrivingfieldLabel = uilabel(app.GridLayout2);
            app.DrivingfieldLabel.FontWeight = 'bold';
            app.DrivingfieldLabel.Layout.Row = 9;
            app.DrivingfieldLabel.Layout.Column = [6 11];
            app.DrivingfieldLabel.Text = 'Driving field';

            % Create JsTEditFieldLabel_7
            app.JsTEditFieldLabel_7 = uilabel(app.GridLayout2);
            app.JsTEditFieldLabel_7.FontWeight = 'bold';
            app.JsTEditFieldLabel_7.Layout.Row = 10;
            app.JsTEditFieldLabel_7.Layout.Column = 6;
            app.JsTEditFieldLabel_7.Text = 'Htip [A/m]';

            % Create JsField_7
            app.JsField_7 = uieditfield(app.GridLayout2, 'text');
            app.JsField_7.Editable = 'off';
            app.JsField_7.HorizontalAlignment = 'right';
            app.JsField_7.Layout.Row = 10;
            app.JsField_7.Layout.Column = 7;

            % Create ShowgridCheckBoxM_2
            app.ShowgridCheckBoxM_2 = uicheckbox(app.GridLayout2);
            app.ShowgridCheckBoxM_2.ValueChangedFcn = createCallbackFcn(app, @ShowgridCheckBoxM_2ValueChanged, true);
            app.ShowgridCheckBoxM_2.Text = 'Grid';
            app.ShowgridCheckBoxM_2.Layout.Row = 15;
            app.ShowgridCheckBoxM_2.Layout.Column = 4;
            app.ShowgridCheckBoxM_2.Value = true;

            % Create ResidualplotButtondMdH_2
            app.ResidualplotButtondMdH_2 = uibutton(app.GridLayout2, 'push');
            app.ResidualplotButtondMdH_2.ButtonPushedFcn = createCallbackFcn(app, @ResidualplotButtondMdH_2Pushed, true);
            app.ResidualplotButtondMdH_2.Layout.Row = 15;
            app.ResidualplotButtondMdH_2.Layout.Column = 2;
            app.ResidualplotButtondMdH_2.Text = 'Residuals';

            % Create JsTEditFieldLabel_8
            app.JsTEditFieldLabel_8 = uilabel(app.GridLayout2);
            app.JsTEditFieldLabel_8.FontWeight = 'bold';
            app.JsTEditFieldLabel_8.Layout.Row = 11;
            app.JsTEditFieldLabel_8.Layout.Column = 6;
            app.JsTEditFieldLabel_8.Text = 'Mtip [A/m]';

            % Create JsField_8
            app.JsField_8 = uieditfield(app.GridLayout2, 'text');
            app.JsField_8.Editable = 'off';
            app.JsField_8.HorizontalAlignment = 'right';
            app.JsField_8.Layout.Row = 11;
            app.JsField_8.Layout.Column = 7;

            % Create MsLowerField_2
            app.MsLowerField_2 = uieditfield(app.GridLayout2, 'text');
            app.MsLowerField_2.HorizontalAlignment = 'right';
            app.MsLowerField_2.Layout.Row = 3;
            app.MsLowerField_2.Layout.Column = 8;

            % Create MsUpperField_2
            app.MsUpperField_2 = uieditfield(app.GridLayout2, 'text');
            app.MsUpperField_2.HorizontalAlignment = 'right';
            app.MsUpperField_2.Layout.Row = 3;
            app.MsUpperField_2.Layout.Column = 9;

            % Create aLowerField_2
            app.aLowerField_2 = uieditfield(app.GridLayout2, 'text');
            app.aLowerField_2.HorizontalAlignment = 'right';
            app.aLowerField_2.Layout.Row = 4;
            app.aLowerField_2.Layout.Column = 8;

            % Create aUpperField_2
            app.aUpperField_2 = uieditfield(app.GridLayout2, 'text');
            app.aUpperField_2.HorizontalAlignment = 'right';
            app.aUpperField_2.Layout.Row = 4;
            app.aUpperField_2.Layout.Column = 9;

            % Create alphaLowerField_2
            app.alphaLowerField_2 = uieditfield(app.GridLayout2, 'text');
            app.alphaLowerField_2.HorizontalAlignment = 'right';
            app.alphaLowerField_2.Layout.Row = 5;
            app.alphaLowerField_2.Layout.Column = 8;

            % Create alphaUpperField_2
            app.alphaUpperField_2 = uieditfield(app.GridLayout2, 'text');
            app.alphaUpperField_2.HorizontalAlignment = 'right';
            app.alphaUpperField_2.Layout.Row = 5;
            app.alphaUpperField_2.Layout.Column = 9;

            % Create cLowerField_2
            app.cLowerField_2 = uieditfield(app.GridLayout2, 'text');
            app.cLowerField_2.HorizontalAlignment = 'right';
            app.cLowerField_2.Layout.Row = 6;
            app.cLowerField_2.Layout.Column = 8;

            % Create cUpperField_2
            app.cUpperField_2 = uieditfield(app.GridLayout2, 'text');
            app.cUpperField_2.HorizontalAlignment = 'right';
            app.cUpperField_2.Layout.Row = 6;
            app.cUpperField_2.Layout.Column = 9;

            % Create kLowerField_2
            app.kLowerField_2 = uieditfield(app.GridLayout2, 'text');
            app.kLowerField_2.HorizontalAlignment = 'right';
            app.kLowerField_2.Layout.Row = 7;
            app.kLowerField_2.Layout.Column = 8;

            % Create kUpperField_2
            app.kUpperField_2 = uieditfield(app.GridLayout2, 'text');
            app.kUpperField_2.HorizontalAlignment = 'right';
            app.kUpperField_2.Layout.Row = 7;
            app.kUpperField_2.Layout.Column = 9;

            % Create LowerboundLabel
            app.LowerboundLabel = uilabel(app.GridLayout2);
            app.LowerboundLabel.Layout.Row = 2;
            app.LowerboundLabel.Layout.Column = 8;
            app.LowerboundLabel.Text = 'Lower bound';

            % Create UpperboundLabel
            app.UpperboundLabel = uilabel(app.GridLayout2);
            app.UpperboundLabel.Layout.Row = 2;
            app.UpperboundLabel.Layout.Column = 9;
            app.UpperboundLabel.Text = 'Upper bound';

            % Create FitLabel
            app.FitLabel = uilabel(app.GridLayout2);
            app.FitLabel.Layout.Row = 2;
            app.FitLabel.Layout.Column = 10;
            app.FitLabel.Text = 'Fit';

            % Create CheckBox
            app.CheckBox = uicheckbox(app.GridLayout2);
            app.CheckBox.Text = '';
            app.CheckBox.Layout.Row = 3;
            app.CheckBox.Layout.Column = 10;
            app.CheckBox.Value = true;

            % Create CheckBox_2
            app.CheckBox_2 = uicheckbox(app.GridLayout2);
            app.CheckBox_2.Text = '';
            app.CheckBox_2.Layout.Row = 4;
            app.CheckBox_2.Layout.Column = 10;
            app.CheckBox_2.Value = true;

            % Create CheckBox_3
            app.CheckBox_3 = uicheckbox(app.GridLayout2);
            app.CheckBox_3.Text = '';
            app.CheckBox_3.Layout.Row = 5;
            app.CheckBox_3.Layout.Column = 10;
            app.CheckBox_3.Value = true;

            % Create CheckBox_4
            app.CheckBox_4 = uicheckbox(app.GridLayout2);
            app.CheckBox_4.Text = '';
            app.CheckBox_4.Layout.Row = 6;
            app.CheckBox_4.Layout.Column = 10;
            app.CheckBox_4.Value = true;

            % Create FitkCheckBox
            app.FitkCheckBox = uicheckbox(app.GridLayout2);
            app.FitkCheckBox.Text = '';
            app.FitkCheckBox.Layout.Row = 7;
            app.FitkCheckBox.Layout.Column = 10;
            app.FitkCheckBox.Value = true;

            % Create Label
            app.Label = uilabel(app.GridLayout2);
            app.Label.Layout.Row = 2;
            app.Label.Layout.Column = 12;
            app.Label.Text = '';

            % Create kConstrainedCheckBox_2
            app.kConstrainedCheckBox_2 = uicheckbox(app.GridLayout2);
            app.kConstrainedCheckBox_2.ValueChangedFcn = createCallbackFcn(app, @kConstrainedCheckBox_2ValueChanged, true);
            app.kConstrainedCheckBox_2.Text = 'Constrained by Hc';
            app.kConstrainedCheckBox_2.Layout.Row = 7;
            app.kConstrainedCheckBox_2.Layout.Column = [11 12];
            app.kConstrainedCheckBox_2.Value = true;

            % Create StartingpointDropDown_4Label
            app.StartingpointDropDown_4Label = uilabel(app.GridLayout2);
            app.StartingpointDropDown_4Label.Layout.Row = 9;
            app.StartingpointDropDown_4Label.Layout.Column = 9;
            app.StartingpointDropDown_4Label.Text = 'Starting point';

            % Create StartingpointDropDown_4
            app.StartingpointDropDown_4 = uidropdown(app.GridLayout2);
            app.StartingpointDropDown_4.Items = {'Demagnetized', 'Tip point'};
            app.StartingpointDropDown_4.ValueChangedFcn = createCallbackFcn(app, @StartingpointDropDown_4ValueChanged, true);
            app.StartingpointDropDown_4.Layout.Row = 9;
            app.StartingpointDropDown_4.Layout.Column = [10 11];
            app.StartingpointDropDown_4.Value = 'Demagnetized';

            % Create FittingregionDropDownLabel
            app.FittingregionDropDownLabel = uilabel(app.GridLayout2);
            app.FittingregionDropDownLabel.Layout.Row = 10;
            app.FittingregionDropDownLabel.Layout.Column = 9;
            app.FittingregionDropDownLabel.Text = 'Fitting region';

            % Create FittingregionDropDown
            app.FittingregionDropDown = uidropdown(app.GridLayout2);
            app.FittingregionDropDown.Items = {'Left branch only', 'Entire loop'};
            app.FittingregionDropDown.ValueChangedFcn = createCallbackFcn(app, @FittingregionDropDownValueChanged, true);
            app.FittingregionDropDown.Layout.Row = 10;
            app.FittingregionDropDown.Layout.Column = [10 11];
            app.FittingregionDropDown.Value = 'Entire loop';

            % Create StopcriterionDropDown_5Label
            app.StopcriterionDropDown_5Label = uilabel(app.GridLayout2);
            app.StopcriterionDropDown_5Label.Layout.Row = 11;
            app.StopcriterionDropDown_5Label.Layout.Column = 9;
            app.StopcriterionDropDown_5Label.Text = 'Stop criterion';

            % Create StopcriterionDropDown_5
            app.StopcriterionDropDown_5 = uidropdown(app.GridLayout2);
            app.StopcriterionDropDown_5.Items = {'Fixed repetitions', 'Until convergence'};
            app.StopcriterionDropDown_5.ValueChangedFcn = createCallbackFcn(app, @StopcriterionDropDown_5ValueChanged, true);
            app.StopcriterionDropDown_5.Layout.Row = 11;
            app.StopcriterionDropDown_5.Layout.Column = [10 11];
            app.StopcriterionDropDown_5.Value = 'Fixed repetitions';

            % Create RepetitionsEditField_3Label
            app.RepetitionsEditField_3Label = uilabel(app.GridLayout2);
            app.RepetitionsEditField_3Label.Layout.Row = 12;
            app.RepetitionsEditField_3Label.Layout.Column = 10;
            app.RepetitionsEditField_3Label.Text = 'Repetitions';

            % Create RepetitionsEditField_3
            app.RepetitionsEditField_3 = uieditfield(app.GridLayout2, 'numeric');
            app.RepetitionsEditField_3.Limits = [0 Inf];
            app.RepetitionsEditField_3.RoundFractionalValues = 'on';
            app.RepetitionsEditField_3.ValueChangedFcn = createCallbackFcn(app, @RepetitionsEditField_3ValueChanged, true);
            app.RepetitionsEditField_3.Layout.Row = 13;
            app.RepetitionsEditField_3.Layout.Column = 10;
            app.RepetitionsEditField_3.Value = 1;

            % Create ReltoleranceEditField_3Label
            app.ReltoleranceEditField_3Label = uilabel(app.GridLayout2);
            app.ReltoleranceEditField_3Label.Layout.Row = 12;
            app.ReltoleranceEditField_3Label.Layout.Column = 12;
            app.ReltoleranceEditField_3Label.Text = 'Rel. tolerance';

            % Create ReltoleranceEditField_3
            app.ReltoleranceEditField_3 = uieditfield(app.GridLayout2, 'numeric');
            app.ReltoleranceEditField_3.Limits = [0 Inf];
            app.ReltoleranceEditField_3.ValueDisplayFormat = '%.0e\n';
            app.ReltoleranceEditField_3.ValueChangedFcn = createCallbackFcn(app, @ReltoleranceEditField_3ValueChanged, true);
            app.ReltoleranceEditField_3.Layout.Row = 13;
            app.ReltoleranceEditField_3.Layout.Column = 12;
            app.ReltoleranceEditField_3.Value = 0.001;

            % Create MaxrepetEditFieldLabel
            app.MaxrepetEditFieldLabel = uilabel(app.GridLayout2);
            app.MaxrepetEditFieldLabel.Layout.Row = 12;
            app.MaxrepetEditFieldLabel.Layout.Column = 11;
            app.MaxrepetEditFieldLabel.Text = 'Max. repet.';

            % Create MaxrepetEditField
            app.MaxrepetEditField = uieditfield(app.GridLayout2, 'numeric');
            app.MaxrepetEditField.Limits = [0 Inf];
            app.MaxrepetEditField.RoundFractionalValues = 'on';
            app.MaxrepetEditField.ValueChangedFcn = createCallbackFcn(app, @MaxrepetEditFieldValueChanged, true);
            app.MaxrepetEditField.Layout.Row = 13;
            app.MaxrepetEditField.Layout.Column = 11;
            app.MaxrepetEditField.Value = 1;

            % Create StopfitButton_2
            app.StopfitButton_2 = uibutton(app.GridLayout2, 'push');
            app.StopfitButton_2.ButtonPushedFcn = createCallbackFcn(app, @StopfitButton_2Pushed, true);
            app.StopfitButton_2.Layout.Row = 15;
            app.StopfitButton_2.Layout.Column = 12;
            app.StopfitButton_2.Text = 'Stop fit';

            % Create PlaygroundTab
            app.PlaygroundTab = uitab(app.TabGroup);
            app.PlaygroundTab.Title = 'Playground';

            % Create GridLayout3
            app.GridLayout3 = uigridlayout(app.PlaygroundTab);
            app.GridLayout3.ColumnWidth = {'1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x'};
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

            % Create MajorloopPanel
            app.MajorloopPanel = uipanel(app.GridLayout3);
            app.MajorloopPanel.Title = 'Major loop';
            app.MajorloopPanel.Layout.Row = [2 14];
            app.MajorloopPanel.Layout.Column = [4 8];

            % Create GridLayout4
            app.GridLayout4 = uigridlayout(app.MajorloopPanel);
            app.GridLayout4.ColumnWidth = {'1x', '1x', '1x', '0.5x'};
            app.GridLayout4.RowHeight = {'1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '6x'};
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
            app.ReltoleranceEditField_6.ValueDisplayFormat = '%.0e\n';
            app.ReltoleranceEditField_6.ValueChangedFcn = createCallbackFcn(app, @PlotDropDownValueChanged, true);
            app.ReltoleranceEditField_6.Layout.Row = 7;
            app.ReltoleranceEditField_6.Layout.Column = 3;
            app.ReltoleranceEditField_6.Value = 0.001;

            % Create PlotDropDownLabel
            app.PlotDropDownLabel = uilabel(app.GridLayout4);
            app.PlotDropDownLabel.Layout.Row = 8;
            app.PlotDropDownLabel.Layout.Column = 1;
            app.PlotDropDownLabel.Text = 'Plot';

            % Create PlotDropDown
            app.PlotDropDown = uidropdown(app.GridLayout4);
            app.PlotDropDown.Items = {'Last loop only', 'Full history'};
            app.PlotDropDown.ValueChangedFcn = createCallbackFcn(app, @PlotDropDownValueChanged, true);
            app.PlotDropDown.Layout.Row = 8;
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
            app.HamplitudeAmEditField.ValueChangedFcn = createCallbackFcn(app, @PlotDropDownValueChanged, true);
            app.HamplitudeAmEditField.Layout.Row = 4;
            app.HamplitudeAmEditField.Layout.Column = 3;

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
            app.RepetitionsEditFieldLabel_2.Layout.Column = [2 3];
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
            app.PlotDropDown_2Label.Layout.Row = 8;
            app.PlotDropDown_2Label.Layout.Column = 1;
            app.PlotDropDown_2Label.Text = 'Plot';

            % Create PlotDropDown_2
            app.PlotDropDown_2 = uidropdown(app.GridLayout6);
            app.PlotDropDown_2.Items = {'Last loops only', 'Full history'};
            app.PlotDropDown_2.Layout.Row = 8;
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
            app.ReltoleranceEditField_5Label.Layout.Column = [2 3];
            app.ReltoleranceEditField_5Label.Text = 'Rel. tolerance';

            % Create ReltoleranceEditField_5
            app.ReltoleranceEditField_5 = uieditfield(app.GridLayout6, 'numeric');
            app.ReltoleranceEditField_5.Limits = [0 Inf];
            app.ReltoleranceEditField_5.ValueDisplayFormat = '%.0e\n';
            app.ReltoleranceEditField_5.Layout.Row = 7;
            app.ReltoleranceEditField_5.Layout.Column = [3 4];
            app.ReltoleranceEditField_5.Value = 0.001;

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
            app.HstartAmEditField_3.ValueChangedFcn = createCallbackFcn(app, @HarmonicsValueChanged, true);
            app.HstartAmEditField_3.Layout.Row = 3;
            app.HstartAmEditField_3.Layout.Column = 3;

            % Create StopcriterionDropDown_6Label
            app.StopcriterionDropDown_6Label = uilabel(app.GridLayout7);
            app.StopcriterionDropDown_6Label.Layout.Row = 4;
            app.StopcriterionDropDown_6Label.Layout.Column = 1;
            app.StopcriterionDropDown_6Label.Text = 'Stop criterion';

            % Create StopcriterionDropDown_6
            app.StopcriterionDropDown_6 = uidropdown(app.GridLayout7);
            app.StopcriterionDropDown_6.Items = {'Until convergence', 'Fixed repetitions'};
            app.StopcriterionDropDown_6.ValueChangedFcn = createCallbackFcn(app, @HarmonicsValueChanged, true);
            app.StopcriterionDropDown_6.Layout.Row = 4;
            app.StopcriterionDropDown_6.Layout.Column = [2 3];
            app.StopcriterionDropDown_6.Value = 'Fixed repetitions';

            % Create PeriodsEditFieldLabel
            app.PeriodsEditFieldLabel = uilabel(app.GridLayout7);
            app.PeriodsEditFieldLabel.Layout.Row = 5;
            app.PeriodsEditFieldLabel.Layout.Column = 2;
            app.PeriodsEditFieldLabel.Text = 'Periods';

            % Create PeriodsEditField
            app.PeriodsEditField = uieditfield(app.GridLayout7, 'numeric');
            app.PeriodsEditField.Limits = [0 Inf];
            app.PeriodsEditField.RoundFractionalValues = 'on';
            app.PeriodsEditField.ValueChangedFcn = createCallbackFcn(app, @HarmonicsValueChanged, true);
            app.PeriodsEditField.Layout.Row = 5;
            app.PeriodsEditField.Layout.Column = 3;
            app.PeriodsEditField.Value = 1;

            % Create ReltoleranceEditField_4Label
            app.ReltoleranceEditField_4Label = uilabel(app.GridLayout7);
            app.ReltoleranceEditField_4Label.Layout.Row = 6;
            app.ReltoleranceEditField_4Label.Layout.Column = 2;
            app.ReltoleranceEditField_4Label.Text = 'Rel. tolerance';

            % Create ReltoleranceEditField_4
            app.ReltoleranceEditField_4 = uieditfield(app.GridLayout7, 'numeric');
            app.ReltoleranceEditField_4.Limits = [0 Inf];
            app.ReltoleranceEditField_4.ValueDisplayFormat = '%.0e';
            app.ReltoleranceEditField_4.ValueChangedFcn = createCallbackFcn(app, @HarmonicsValueChanged, true);
            app.ReltoleranceEditField_4.Layout.Row = 6;
            app.ReltoleranceEditField_4.Layout.Column = 3;
            app.ReltoleranceEditField_4.Value = 0.001;

            % Create PlotDropDown_3Label
            app.PlotDropDown_3Label = uilabel(app.GridLayout7);
            app.PlotDropDown_3Label.Layout.Row = 7;
            app.PlotDropDown_3Label.Layout.Column = 1;
            app.PlotDropDown_3Label.Text = 'Plot';

            % Create PlotDropDown_3
            app.PlotDropDown_3 = uidropdown(app.GridLayout7);
            app.PlotDropDown_3.Items = {'Last period only', 'Full history'};
            app.PlotDropDown_3.Layout.Row = 7;
            app.PlotDropDown_3.Layout.Column = [2 3];
            app.PlotDropDown_3.Value = 'Full history';

            % Create UITable2
            app.UITable2 = uitable(app.GridLayout7);
            app.UITable2.ColumnName = {'Order'; 'Amplitude [A/m]'; 'Phase [deg]'};
            app.UITable2.RowName = {};
            app.UITable2.ColumnSortable = [true false false];
            app.UITable2.SelectionType = 'row';
            app.UITable2.ColumnEditable = [true true true];
            app.UITable2.CellEditCallback = createCallbackFcn(app, @HarmonicsTableCellEdit, true);
            app.UITable2.Multiselect = 'off';
            app.UITable2.Layout.Row = [9 10];
            app.UITable2.Layout.Column = [1 4];

            % Create HarmoniccompHtsum_kA_ksinkomegatphi_kLabel
            app.HarmoniccompHtsum_kA_ksinkomegatphi_kLabel = uilabel(app.GridLayout7);
            app.HarmoniccompHtsum_kA_ksinkomegatphi_kLabel.Layout.Row = 8;
            app.HarmoniccompHtsum_kA_ksinkomegatphi_kLabel.Layout.Column = [1 4];
            app.HarmoniccompHtsum_kA_ksinkomegatphi_kLabel.Text = 'Harmonic comp.: H(t) = sum_k[A_k*sin(k*omega*t + phi_k)]';

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
            app.JsTEditFieldLabel_9.FontWeight = 'bold';
            app.JsTEditFieldLabel_9.Layout.Row = 4;
            app.JsTEditFieldLabel_9.Layout.Column = 1;
            app.JsTEditFieldLabel_9.Text = 'Ms [A/m]';

            % Create JsField_9
            app.JsField_9 = uieditfield(app.GridLayout3, 'text');
            app.JsField_9.HorizontalAlignment = 'right';
            app.JsField_9.Layout.Row = 4;
            app.JsField_9.Layout.Column = 2;

            % Create JsTEditFieldLabel_10
            app.JsTEditFieldLabel_10 = uilabel(app.GridLayout3);
            app.JsTEditFieldLabel_10.FontWeight = 'bold';
            app.JsTEditFieldLabel_10.Layout.Row = 5;
            app.JsTEditFieldLabel_10.Layout.Column = 1;
            app.JsTEditFieldLabel_10.Text = 'a [A/m]';

            % Create JsField_10
            app.JsField_10 = uieditfield(app.GridLayout3, 'text');
            app.JsField_10.HorizontalAlignment = 'right';
            app.JsField_10.Layout.Row = 5;
            app.JsField_10.Layout.Column = 2;

            % Create JsTEditFieldLabel_11
            app.JsTEditFieldLabel_11 = uilabel(app.GridLayout3);
            app.JsTEditFieldLabel_11.FontWeight = 'bold';
            app.JsTEditFieldLabel_11.Layout.Row = 6;
            app.JsTEditFieldLabel_11.Layout.Column = 1;
            app.JsTEditFieldLabel_11.Text = 'alpha';

            % Create JsField_11
            app.JsField_11 = uieditfield(app.GridLayout3, 'text');
            app.JsField_11.HorizontalAlignment = 'right';
            app.JsField_11.Layout.Row = 6;
            app.JsField_11.Layout.Column = 2;

            % Create JsTEditFieldLabel_12
            app.JsTEditFieldLabel_12 = uilabel(app.GridLayout3);
            app.JsTEditFieldLabel_12.FontWeight = 'bold';
            app.JsTEditFieldLabel_12.Layout.Row = 7;
            app.JsTEditFieldLabel_12.Layout.Column = 1;
            app.JsTEditFieldLabel_12.Text = 'c';

            % Create JsField_12
            app.JsField_12 = uieditfield(app.GridLayout3, 'text');
            app.JsField_12.HorizontalAlignment = 'right';
            app.JsField_12.Layout.Row = 7;
            app.JsField_12.Layout.Column = 2;

            % Create JsTEditFieldLabel_13
            app.JsTEditFieldLabel_13 = uilabel(app.GridLayout3);
            app.JsTEditFieldLabel_13.FontWeight = 'bold';
            app.JsTEditFieldLabel_13.Layout.Row = 8;
            app.JsTEditFieldLabel_13.Layout.Column = 1;
            app.JsTEditFieldLabel_13.Text = 'k [A/m]';

            % Create JsField_13
            app.JsField_13 = uieditfield(app.GridLayout3, 'text');
            app.JsField_13.HorizontalAlignment = 'right';
            app.JsField_13.Layout.Row = 8;
            app.JsField_13.Layout.Column = 2;

            % Create RetrieveparametersButton
            app.RetrieveparametersButton = uibutton(app.GridLayout3, 'push');
            app.RetrieveparametersButton.ButtonPushedFcn = createCallbackFcn(app, @RetrieveparametersButtonPushed, true);
            app.RetrieveparametersButton.Layout.Row = 2;
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

            % Create MessagesTab
            app.MessagesTab = uitab(app.MessagesTabPanel);
            app.MessagesTab.Title = 'Messages';

            % Create MessagesGridLayout
            app.MessagesGridLayout = uigridlayout(app.MessagesTab);
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