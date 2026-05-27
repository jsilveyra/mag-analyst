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
        GridLayoutTips                  matlab.ui.container.GridLayout
        MTipField                       matlab.ui.control.EditField
        MtipAmLabel                     matlab.ui.control.Label
        HTipField                       matlab.ui.control.EditField
        HtipAmLabel                     matlab.ui.control.Label
        GridLayoutInputPlots            matlab.ui.container.GridLayout
        AxesRawInputData                matlab.ui.control.UIAxes
        AxesProcessedInputData          matlab.ui.control.UIAxes
        GridLayoutInputAxisScale        matlab.ui.container.GridLayout
        InputNumberofPointsEditField    matlab.ui.control.NumericEditField
        InputApplyPointsButton          matlab.ui.control.Button
        AxisscaleLabel                  matlab.ui.control.Label
        InputNumberofPointsLabel        matlab.ui.control.Label
        InputAxisScaleDropDown          matlab.ui.control.DropDown
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
        NofcomponentsSpinner            matlab.ui.control.Spinner
        NofcomponentsSpinnerLabel       matlab.ui.control.Label
        ModeledcurveLabel               matlab.ui.control.Label
        TableQuantities                 matlab.ui.control.Table
        GridLayoutOtherQuantities       matlab.ui.container.GridLayout
        murinLabel                      matlab.ui.control.Label
        murinField                      matlab.ui.control.EditField
        JsField                         matlab.ui.control.EditField
        JsTEditFieldLabel               matlab.ui.control.Label
        OthercalculatedquantitiesLabel  matlab.ui.control.Label
        GridLayoutButtons               matlab.ui.container.GridLayout
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
        ShowgridCheckBoxM_4             matlab.ui.control.CheckBox
        ShowgridCheckBoxM_3             matlab.ui.control.CheckBox
        DrivingfieldLabel_2             matlab.ui.control.Label
        RetrieveparametersButton        matlab.ui.control.Button
        CalculatePlotButton_3           matlab.ui.control.Button
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
        AxesM_4                         matlab.ui.control.UIAxes
        AxesM_3                         matlab.ui.control.UIAxes
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
    end

    
    properties (Access = private)
        AppRoot string                % MOD: root folder of the app
        H_raw
        M_raw
        imported_curve_type string = ""
        data_curve
        modeled_curve
        Hcr
        mcr
        Hx
        magnetic_parameters
        number_components
        lb
        ub
        select_fit
        Colors
        ColorDialogApp
        ProjectPath
        fitted_parameter_values
        component_row_types
    end
    
    methods (Access = private)
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
            app.plot_M();
            app.plot_dMdH();
            app.plot_HdMdH();

            app.init_parameters_table(false);
            app.init_quantities_table(false);
            
            app.sync_fitted_parameter_values_from_components();
            app.refresh_table_value_display();
            offset = (3*app.number_components - 1);
            
            for i = 1:offset
                app.TableFittedParameters.Data(2*offset + i) = {app.format_short(str2double(app.TableFittedParameters.Data(2*offset + i)))};
                app.TableFittedParameters.Data(3*offset + i) = {app.format_short(str2double(app.TableFittedParameters.Data(3*offset + i)))};
            end
            app.JsField.Value = app.format_short(app.magnetic_parameters.Js);
            app.murinField.Value = app.format_engineering(app.magnetic_parameters.murin);

            
            utils = Utils();

            [HTip, ~] = utils.find_tip(app.data_curve.H, app.data_curve.M);

            select_a = app.TableParameters.Data{1:app.number_components,5};
            app.magnetic_parameters = MagneticParameters(app.data_curve, app.Hcr, app.mcr, app.Hx, select_a);


            error_type = string(app.ErrortominimizeDropDown.Value);
            if (error_type == "Diagonal (H, sampled)")
                error_calculator = DiagonalErrorCalculator(app.data_curve, app.modeled_curve, false, false);
            elseif (error_type == "Diagonal (H, continuous)")
                error_calculator = DiagonalErrorCalculator(app.data_curve, app.modeled_curve, false, true);
            elseif (error_type == "Diagonal (logH, sampled)") || (error_type == "Diagonal (sampled)")
                error_calculator = DiagonalErrorCalculator(app.data_curve, app.modeled_curve, true, false);
            elseif (error_type == "Diagonal (logH, continuous)") || (error_type == "Diagonal") || (error_type == "Diagonal (continuous)")
                error_calculator = DiagonalErrorCalculator(app.data_curve, app.modeled_curve, true, true);
            elseif (error_type == "Vertical")
                error_calculator = VerticalErrorCalculator(app.data_curve, app.modeled_curve);
            elseif (error_type == "Horizontal")
                error_calculator = HorizontalErrorCalculator(app.data_curve, app.modeled_curve);
            else
                app.write_message("Unknown error type: " + error_type);
                return;
            end

            e = error_calculator.get_error();
            app.ErrorDisplay.Value = app.format_engineering(e);
        end

        function calculate_parameters(app)
            % Guard: no data yet
            if ~isobject(app.data_curve) || ~isprop(app.data_curve, 'H') || isempty(app.data_curve.H)
                return;
            end
        
            N = max(2, round(app.NofpointsEditField.Value));
        
            H = app.data_curve.H(:).';
            M = app.data_curve.M(:).';
        
            % Work only with positive H for log spacing
            Hpos = H(H > 0);
            if numel(Hpos) < 2
                app.write_message("Not enough positive H points to build modeled curve.");
                return;
            end
        
            % Robust HTip default + safe tip detection
            HTip = max(Hpos);
            try
                [HTip_tmp, ~] = Utils().find_tip(H, M);
                if ~isempty(HTip_tmp) && isfinite(HTip_tmp) && (HTip_tmp > 0)
                    HTip = HTip_tmp;
                end
            catch
                % keep fallback HTip
            end
        
            Hstart = Hpos(1);
            if HTip <= Hstart
                HTip = max(Hpos);
            end
        
            select_a = app.TableParameters.Data{1:app.number_components,5};
            app.magnetic_parameters = MagneticParameters(app.data_curve, app.Hcr, app.mcr, app.Hx, select_a);
        
            point_space = string(app.PointSpaceDropDown.Value);
            if (point_space == "log") || (point_space == "Logarithmically spaced")
                Hhat = logspace(log10(Hstart), log10(HTip), N-1);
            else
                Hhat = linspace(Hstart, HTip, N-1);
            end
        
            Hhat = [0, Hhat];
            app.modeled_curve = ModeledAnhystereticCurve(Hhat, app.magnetic_parameters);
        end

        function fit_parameters(app)
            N = app.NofpointsEditField.Value;
            app.calculate_parameters()
            select_a = app.TableParameters.Data{1:app.number_components,5};
            fit_lb = zeros(app.number_components*3 - 1, 1);
            fit_ub = zeros(app.number_components*3 - 1, 1);
            fit_select_fit = cell(app.number_components*3 - 1, 1);
            for i=1:app.number_components
                fit_lb(i) = app.lb(2*i - 1);
                fit_lb(i + app.number_components) = app.lb(2*i);
                fit_ub(i) = app.ub(2*i - 1);
                fit_ub(i + app.number_components) = app.ub(2*i);
                fit_select_fit(i) = app.select_fit(2*i - 1);
                fit_select_fit(i + app.number_components) = app.select_fit(2*i);
            end
            for i=1:(app.number_components-1)
                fit_lb(i + 2*app.number_components) = app.lb(2*app.number_components + i);
                fit_ub(i + 2*app.number_components) = app.ub(2*app.number_components + i);
                fit_select_fit(i + 2*app.number_components) = app.select_fit(2*app.number_components + i);
            end
            
            app.write_message("Fitting started");
            pause(0.01);
            tic
            try
                [app.Hcr, app.mcr, app.Hx] = fit(app.data_curve, cat(2, app.Hcr, app.mcr, app.Hx), N, select_a, app.ErrortominimizeDropDown.Value, fit_lb, fit_ub, fit_select_fit);
                t = sprintf("%0.2f", toc);
                app.write_message("Fitting finished after " + t + " s");
            catch e
                t = sprintf("%0.2f", toc);
                app.write_message("Fitting failed after " + t + " s: " + e.message);
            end
        end
        
        function update_components(app)
            app.Hcr = zeros(1, app.number_components);
            app.mcr = zeros(1, app.number_components);
            app.Hx = zeros(1, max(app.number_components - 1, 0));
            offset = (3*app.number_components - 1);
            if offset > 0 && numel(app.fitted_parameter_values) >= offset && numel(app.component_row_types) >= offset
                hcr_index = 1;
                mcr_index = 1;
                hx_index = 1;
                for row = 1:offset
                    value = app.fitted_parameter_values(row);
                    switch app.component_row_types(row)
                        case "Hcr"
                            app.Hcr(hcr_index) = value;
                            hcr_index = hcr_index + 1;
                        case "m"
                            app.mcr(mcr_index) = value;
                            mcr_index = mcr_index + 1;
                        case "Hx"
                            app.Hx(hx_index) = value;
                            hx_index = hx_index + 1;
                    end
                end
            end
            app.lb = zeros(1, offset);
            app.ub = zeros(1, offset);
            app.select_fit = cell(1, offset);
            for i = 1:offset
                app.lb(i) = str2double(app.TableFittedParameters.Data(2*offset + i));
                app.ub(i) = str2double(app.TableFittedParameters.Data(3*offset + i));
                app.select_fit(i) = app.TableFittedParameters.Data(4*offset + i);
            end
        end
        
        function init_components(app)
            row_count = 3*app.number_components - 1;
            component_values = zeros(row_count, 1);
            lb_col = zeros(row_count, 1);
            ub_col = zeros(row_count, 1);
            row_names = cell(row_count, 1);
            row_types = strings(row_count, 1);
            for i = 1:app.number_components
                s = 'Hcr' + string(char(8320 + i));
                row_names(2*i - 1,:) = {convertStringsToChars(s + ' [A/m]')};
                component_values(2*i-1) = 0.01*i;
                row_types(2*i-1) = "Hcr";
                s = 'm' + string(char(8320 + i)) + ' (' + s + ')';
                row_names(2*i,:) = {convertStringsToChars(s)};
                component_values(2*i) = 0.521657107787896;
                row_types(2*i) = "m";
                lb_col(2*i-1) = 0;
                lb_col(2*i) = 0.4496;
                ub_col(2*i-1) = 1000000;
                ub_col(2*i) = 1;
            end

            for i = 1:(app.number_components-1)
                row_index = i + 2*app.number_components;
                s = 'Hx' + string(char(8320 + i)) + ' [A/m]';
                row_names(row_index,:) = {convertStringsToChars(s)};
                component_values(row_index) = i*0.015;
                row_types(row_index) = "Hx";
                lb_col(row_index) = 0;
                ub_col(row_index) = 1000000;
            end
            app.component_row_types = row_types;
            app.fitted_parameter_values = component_values;
            component_values = num2cell(component_values);
            lb_col = arrayfun(@(x) {app.format_short(x)}, lb_col);
            ub_col = arrayfun(@(x) {app.format_short(x)}, ub_col);
            app.select_fit = cell(row_count, 1);
            app.select_fit(:) = {true};
            t = table(row_names, component_values, lb_col, ub_col, app.select_fit);
            app.TableFittedParameters.Data = table2cell(t);
            app.refresh_table_value_display();

            app.init_parameters_table(true);
            app.init_quantities_table(true);
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
            parameters_col = cell(app.number_components, 1);
            for i = 1:app.number_components
                s = string(i);
                parameters_col(i,:) = {convertStringsToChars(s)};
            end

            Ms_col = cell(app.number_components, 1);
            alpha_col = cell(app.number_components, 1);
            a_col = cell(app.number_components, 1);

            select_a_col = cell(app.number_components, 1);
            for i = 1:app.number_components
                select_a_col(i,:) = {'low'};
            end
   
            if ~default_values
                select_a_col = app.TableParameters.Data{:,5};

                for i = 1:app.number_components
                    Ms_col(i,:) = {app.format_short(app.magnetic_parameters.Ms(i))};
                    alpha_col(i,:) = {app.format_engineering(app.magnetic_parameters.alpha(i))};
                    a_col(i,:) = {app.format_short(app.magnetic_parameters.a(i))};
                end
            end

            t = table(parameters_col, Ms_col, alpha_col, a_col, select_a_col);
            t.(5) = categorical(t.(5), {'high', 'low'}, 'Ordinal', true);

            app.TableParameters.Data = t;  
        end

        function init_quantities_table(app, default_values)
            parameters_col = cell(app.number_components, 1);
            for i = 1:app.number_components
                s = string(i);
                parameters_col(i,:) = {convertStringsToChars(s)};
            end

            dimensionless_alphaMs_col = cell(app.number_components, 1);
            density_product_col = cell(app.number_components, 1);
            Hk_col = cell(app.number_components, 1);
            initial_relative_magnetic_permeability_col = cell(app.number_components, 1);

            if ~default_values
                for i = 1:app.number_components
                    dimensionless_alphaMs_col(i,:) = {app.format_short(app.magnetic_parameters.dimensionless_alphaMs(i))};
                    density_product_col(i,:) = {app.format_short(app.magnetic_parameters.density_product(i))};
                    Hk_col(i,:) = {app.format_short(app.magnetic_parameters.Hk(i))};
%                     initial_relative_magnetic_permeability_col(i,:) = {app.format_thousands_only(app.magnetic_parameters.initial_relative_magnetic_permeability(i))};
                    initial_relative_magnetic_permeability_col(i,:) = {app.format_short(app.magnetic_parameters.initial_relative_magnetic_permeability(i))};
                end
            end

            t = table(parameters_col, dimensionless_alphaMs_col, density_product_col, Hk_col, initial_relative_magnetic_permeability_col);
            app.TableQuantities.Data = t;
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
            row_count = size(app.TableFittedParameters.Data, 1);
            if row_count == 0 || isempty(app.component_row_types) || isempty(app.fitted_parameter_values)
                return;
            end
            valid_rows = min([row_count, numel(app.component_row_types), numel(app.fitted_parameter_values)]);
            for row = 1:valid_rows
                app.TableFittedParameters.Data(row, 2) = {app.format_value_for_display(row, app.fitted_parameter_values(row))};
            end
        end

        function sync_fitted_parameter_values_from_components(app)
            row_count = 3*app.number_components - 1;
            if row_count <= 0 || isempty(app.component_row_types)
                return;
            end
            values = zeros(row_count, 1);
            idx = 1;
            for i = 1:app.number_components
                values(idx) = app.Hcr(i);
                values(idx + 1) = app.mcr(i);
                idx = idx + 2;
            end
            for i = 1:(app.number_components - 1)
                values(idx) = app.Hx(i);
                idx = idx + 1;
            end
            app.fitted_parameter_values = values;
        end

        function ret = format_value_for_display(app, row, value)
            if row < 1 || row > numel(app.component_row_types)
                ret = char(sprintf("%g", value));
                return;
            end
            row_type = app.component_row_types(row);
            switch row_type
                case "m"
                    ret = app.format_m_display(value);
                otherwise
                    ret = app.format_short(value);
            end
        end

        function ret = format_value_for_edit(app, row)
            if row < 1 || row > numel(app.fitted_parameter_values)
                ret = "";
                return;
            end
            ret = char(sprintf("%.16g", app.fitted_parameter_values(row)));
        end

        function ret = format_m_display(~, value)
            ret = char(sprintf("%.2g", value));
        end

        function tf = is_m_row(app, row)
            tf = false;
            if row < 1 || row > numel(app.component_row_types)
                return;
            end
            tf = app.component_row_types(row) == "m";
        end

        function ret = format_thousands_only(~, v)
            string_value = char(sprintf("%d",round(v)));
            ret = fliplr(regexprep(fliplr(string_value),'\d{3}(?=\d)', '$0,'));
        end

        function plot_M(app)
            hcr_values = [];
            if app.ShowhcrCheckBoxM.Value == 1
                hcr_values = app.Hcr;
            end
            plotter = Plotter(app.data_curve, app.modeled_curve, hcr_values, app.Colors);
            cla(app.AxesM,'reset');
            plot_components = app.PlotcomponentsCheckBoxM.Value == 1;
            show_grid = app.ShowgridCheckBoxM.Value == 1;
            axis_scale = string(app.AxisScaleDropDownM.Value);
            if app.axis_scale_has_x(axis_scale)
                plotter.plot_M_log(app.AxesM, plot_components, show_grid);
            else
                plotter.plot_M(app.AxesM, plot_components, show_grid);
            end
            app.apply_axis_scale(app.AxesM, axis_scale);
        end

        function plot_dMdH(app)
            hcr_values = [];
            if app.ShowhcrCheckBoxdMdH.Value == 1
                hcr_values = app.Hcr;
            end
            plotter = Plotter(app.data_curve, app.modeled_curve, hcr_values, app.Colors);
            cla(app.AxesdMdH,'reset');
            plot_components = app.PlotcomponentsCheckBoxdMdH.Value == 1;
            show_grid = app.ShowgridCheckBoxdMdH.Value == 1;
            axis_scale = string(app.AxisScaleDropDowndMdH.Value);
            if app.axis_scale_has_x(axis_scale)
                plotter.plot_dMdH_log(app.AxesdMdH, plot_components, show_grid);
            else
                plotter.plot_dMdH(app.AxesdMdH, plot_components, show_grid);
            end
            app.apply_axis_scale(app.AxesdMdH, axis_scale);
        end
        
        function plot_HdMdH(app)
            hcr_values = [];
            if app.ShowhcrCheckBoxHdMdH.Value == 1
                hcr_values = app.Hcr;
            end
            plotter = Plotter(app.data_curve, app.modeled_curve, hcr_values, app.Colors);
            cla(app.AxesHdMdH,'reset');
            plot_components = app.PlotcomponentsCheckBoxHdMdH.Value == 1;
            show_grid = app.ShowgridCheckBoxHdMdH.Value == 1;
            axis_scale = string(app.AxisScaleDropDownHdMdH.Value);
            if app.axis_scale_has_x(axis_scale)
                plotter.plot_HdMdH_log(app.AxesHdMdH, plot_components, show_grid);
            else
                plotter.plot_HdMdH(app.AxesHdMdH, plot_components, show_grid);
            end
            app.apply_axis_scale(app.AxesHdMdH, axis_scale);
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

        function plot_hysteretic_tab_data(app)
            ax = app.AxesM_2;
            cla(ax, 'reset');
            hold(ax, 'on');

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

            [params, has_params] = app.get_ja_params_from_tab();
            [Htip, Mtip, has_tip] = app.get_ja_tip_from_tab_or_data();
            if has_params && has_tip
                try
                    opts = odeset('RelTol', 1e-7, 'AbsTol', 1e-6);
                    [Hsim, Msim] = solveJA_fromTip(Htip, Mtip, params, opts);
                    plot(ax, Hsim, Msim, 'r-', 'LineWidth', 1.2, 'DisplayName', 'JA simulated');
                catch ME
                    app.write_message("Warning: JA simulation could not be plotted (" + string(ME.message) + ").");
                end
            end

            xline(ax, 0, 'k-', 'LineWidth', 1.2);
            yline(ax, 0, 'k-', 'LineWidth', 1.2);
            hx0 = xline(ax, 0, 'k-', 'LineWidth', 1.2);
            hy0 = yline(ax, 0, 'k-', 'LineWidth', 1.2);
            hx0.Annotation.LegendInformation.IconDisplayStyle = 'off';
            hy0.Annotation.LegendInformation.IconDisplayStyle = 'off';
            if app.ShowgridCheckBoxM_2.Value == 1
                grid(ax, 'on');
            else
                grid(ax, 'off');
            end
            xlabel(ax, 'H [A/m]');
            ylabel(ax, 'M [A/m]');
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

            if any(~isfinite([Ms, a, alpha, c, k])) || a == 0
                return;
            end

            params = struct('Ms', Ms, 'a', a, 'alpha', alpha, 'k', k, 'c', c);
            ok = true;
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
            has_seeds = false;
            ms_seed = "";
            a_seed = "";
            alpha_seed = "";

            if isempty(app.TableParameters.Data) || height(app.TableParameters.Data) < 1
                return;
            end

            ms_raw = string(app.TableParameters.Data{1,2});
            alpha_raw = string(app.TableParameters.Data{1,3});
            a_raw = string(app.TableParameters.Data{1,4});

            if strlength(ms_raw) == 0 || strlength(alpha_raw) == 0 || strlength(a_raw) == 0
                return;
            end

            ms_num = str2double(replace(ms_raw, ",", ""));
            a_num = str2double(replace(a_raw, ",", ""));
            alpha_num = str2double(replace(alpha_raw, ",", ""));
            if isnan(ms_num) || isnan(a_num) || isnan(alpha_num)
                return;
            end

            ms_seed = ms_raw;
            a_seed = a_raw;
            alpha_seed = alpha_raw;
            has_seeds = true;
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
                    Sx = range(Hleft) / 2;
                    Sy = range(Mleft) / 2;
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
        
            fit_timer = tic;
            try
                fit_result = JAFitter.fit( ...
                    params_seed, mask, bounds, Hleft, Mleft, Htip, Mtip, error_type, ...
                    @(p) app.estimateK_fromCoercivePoint(Hleft, Mleft, p.Ms, p.a, p.alpha, p.c), ...
                    @(errType, hL, mL, hHat, mHat) app.compute_ja_left_branch_error_core(errType, hL, mL, hHat, mHat));
        
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
                app.write_message("Fitting finished after " + app.format_short(t) + " s");
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

        function ret = subscript_to_number(~, str)
            chars = char(str);
            for i = 1:length(chars)
                if chars(i) >= 8272
                    chars(i) = 48 + chars(i) - '₀'; 
                end
            end
            ret = string(chars);
        end

        function export_residual(app, residue, file_name)
            t = table(transpose(app.data_curve.H), transpose(residue));
            t.Properties.VariableNames(:) = {'H [A/m]' 'residue'};

            path = fullfile(app.OutputDatasetPath.Value, file_name);
            writetable(t,path, 'Delimiter', ';');
            app.write_message("Data saved as " + file_name);
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
        
        function set_colors_and_plot(app, colors)
            app.Colors = colors;
            if ~isobject(app.data_curve) || ~isprop(app.data_curve, 'H') || isempty(app.data_curve.H)
                app.write_message("Colors updated. Import data before recalculating.");
                return;
            end
            update_components(app)
            calculate_parameters(app)
            plot(app)
        end

        function a = calculate_and_plot(app)
            path = app.InputDatasetPath.Value;
            if isfile(path)
                app.import_data(path);
                update_components(app)
                calculate_parameters(app)
                app.plot_input();
                a = 0;
            else
                app.write_message(path + " was not found, please browse the dataseth path again");
                a = -1;
            end
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
            import_src();
        
            app.ProjectPath = "";
            app.number_components = app.NofcomponentsSpinner.Value;
        
            app.init_components();
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

        % Value changed function: NofcomponentsSpinner
        function NofcomponentsSpinnerValueChanged(app, event)
            app.number_components = app.NofcomponentsSpinner.Value;
            app.init_components();
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
            [app.H, app.M] = Parser(dataset_path).get_data_csv;
            update_components(app)
            calculate_parameters(app)
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
            app.init_parameters_table(true);
            app.init_quantities_table(true);
            app.NofcomponentsSpinner.Value = app.number_components;

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

        % Value changed function: InputAxisScaleDropDown
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
            else
                app.write_message(path + " was not found, please browse the dataseth path again");
            end
        end

        % Value changed function: ShowgridCheckBoxM_2
        function ShowgridCheckBoxM_2ValueChanged(app, event)
            if app.ShowgridCheckBoxM_2.Value == 1
                grid(app.AxesM_2, 'on');
            else
                grid(app.AxesM_2, 'off');
            end
            
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
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Get the file path for locating images
            pathToMLAPP = fileparts(mfilename('fullpath'));

            % Create MagAnalystUIFigure and hide until all components are created
            app.MagAnalystUIFigure = uifigure('Visible', 'off');
            app.MagAnalystUIFigure.Color = [0.96078431372549 0.96078431372549 0.96078431372549];
            app.MagAnalystUIFigure.Position = [100 100 1044 768];
            app.MagAnalystUIFigure.Name = 'MagAnalyst';
            app.MagAnalystUIFigure.Icon = fullfile(pathToMLAPP, 'assets', 'logo.png');
            app.MagAnalystUIFigure.CloseRequestFcn = createCallbackFcn(app, @MagAnalystUIFigureCloseRequest, true);

            % Create ProjectMenu
            app.ProjectMenu = uimenu(app.MagAnalystUIFigure);
            app.ProjectMenu.ForegroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ProjectMenu.Text = 'Project';

            % Create OpenMenu
            app.OpenMenu = uimenu(app.ProjectMenu);
            app.OpenMenu.MenuSelectedFcn = createCallbackFcn(app, @OpenMenuSelected, true);
            app.OpenMenu.ForegroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.OpenMenu.Separator = 'on';
            app.OpenMenu.Accelerator = 'O';
            app.OpenMenu.Text = 'Open...';

            % Create SaveMenu
            app.SaveMenu = uimenu(app.ProjectMenu);
            app.SaveMenu.MenuSelectedFcn = createCallbackFcn(app, @SaveMenuSelected, true);
            app.SaveMenu.ForegroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.SaveMenu.Accelerator = 'S';
            app.SaveMenu.Text = 'Save';

            % Create SaveasMenu
            app.SaveasMenu = uimenu(app.ProjectMenu);
            app.SaveasMenu.MenuSelectedFcn = createCallbackFcn(app, @SaveasMenuSelected, true);
            app.SaveasMenu.ForegroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.SaveasMenu.Separator = 'on';
            app.SaveasMenu.Text = 'Save as...';

            % Create AppGridLayout
            app.AppGridLayout = uigridlayout(app.MagAnalystUIFigure);
            app.AppGridLayout.ColumnWidth = {'1x'};
            app.AppGridLayout.RowHeight = {'3x', '1x'};
            app.AppGridLayout.RowSpacing = 0;
            app.AppGridLayout.Padding = [0 0 0 0];
            app.AppGridLayout.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];

            % Create TabGroup
            app.TabGroup = uitabgroup(app.AppGridLayout);
            app.TabGroup.AutoResizeChildren = 'off';
            app.TabGroup.Layout.Row = 1;
            app.TabGroup.Layout.Column = 1;

            % Create InputdataTab
            app.InputdataTab = uitab(app.TabGroup);
            app.InputdataTab.AutoResizeChildren = 'off';
            app.InputdataTab.Title = 'Input data';
            app.InputdataTab.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
            app.InputdataTab.ForegroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];

            % Create GridLayoutMagnetizationInputData
            app.GridLayoutMagnetizationInputData = uigridlayout(app.InputdataTab);
            app.GridLayoutMagnetizationInputData.ColumnWidth = {'1x', '2x'};
            app.GridLayoutMagnetizationInputData.RowHeight = {'1x'};
            app.GridLayoutMagnetizationInputData.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];

            % Create GridLayoutInput
            app.GridLayoutInput = uigridlayout(app.GridLayoutMagnetizationInputData);
            app.GridLayoutInput.ColumnWidth = {'1x'};
            app.GridLayoutInput.RowHeight = {'1x', '1x', '1x', '1x', '1x', '10x'};
            app.GridLayoutInput.Layout.Row = 1;
            app.GridLayoutInput.Layout.Column = 1;
            app.GridLayoutInput.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];

            % Create GridLayoutInputHorizontalAxis
            app.GridLayoutInputHorizontalAxis = uigridlayout(app.GridLayoutInput);
            app.GridLayoutInputHorizontalAxis.ColumnWidth = {'1x', '1.4x'};
            app.GridLayoutInputHorizontalAxis.RowHeight = {'1x'};
            app.GridLayoutInputHorizontalAxis.Padding = [0 0 0 0];
            app.GridLayoutInputHorizontalAxis.Layout.Row = 2;
            app.GridLayoutInputHorizontalAxis.Layout.Column = 1;
            app.GridLayoutInputHorizontalAxis.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];

            % Create HorizontalaxisfieldDropDownLabel
            app.HorizontalaxisfieldDropDownLabel = uilabel(app.GridLayoutInputHorizontalAxis);
            app.HorizontalaxisfieldDropDownLabel.FontWeight = 'bold';
            app.HorizontalaxisfieldDropDownLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.HorizontalaxisfieldDropDownLabel.Layout.Row = 1;
            app.HorizontalaxisfieldDropDownLabel.Layout.Column = 1;
            app.HorizontalaxisfieldDropDownLabel.Text = 'Horizontal axis field';

            % Create HorizontalaxisfieldDropDown
            app.HorizontalaxisfieldDropDown = uidropdown(app.GridLayoutInputHorizontalAxis);
            app.HorizontalaxisfieldDropDown.Items = {'H [A/m]', 'H [kA/m]', 'H [Oe]', 'H [kOe]', 'Bext [T]', 'Bext [G]', 'Bext [kG]'};
            app.HorizontalaxisfieldDropDown.ValueChangedFcn = createCallbackFcn(app, @HorizontalaxisfieldDropDownValueChanged, true);
            app.HorizontalaxisfieldDropDown.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.HorizontalaxisfieldDropDown.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
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
            app.GridLayoutInputVerticalAxis.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];

            % Create VerticalaxisfieldDropDownLabel
            app.VerticalaxisfieldDropDownLabel = uilabel(app.GridLayoutInputVerticalAxis);
            app.VerticalaxisfieldDropDownLabel.FontWeight = 'bold';
            app.VerticalaxisfieldDropDownLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.VerticalaxisfieldDropDownLabel.Layout.Row = 1;
            app.VerticalaxisfieldDropDownLabel.Layout.Column = 1;
            app.VerticalaxisfieldDropDownLabel.Text = 'Vertical axis field';

            % Create VerticalaxisfieldDropDown
            app.VerticalaxisfieldDropDown = uidropdown(app.GridLayoutInputVerticalAxis);
            app.VerticalaxisfieldDropDown.Items = {'M [A/m]', 'M [kA/m]', 'M [MA/m]', 'M [emu/cm^3]', 'J [T]', 'B [T]', 'B [G]', 'B [kG]'};
            app.VerticalaxisfieldDropDown.ValueChangedFcn = createCallbackFcn(app, @VerticalaxisfieldDropDownValueChanged, true);
            app.VerticalaxisfieldDropDown.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.VerticalaxisfieldDropDown.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
            app.VerticalaxisfieldDropDown.Layout.Row = 1;
            app.VerticalaxisfieldDropDown.Layout.Column = 2;
            app.VerticalaxisfieldDropDown.Value = 'M [A/m]';

            % Create GridLayoutInputCurve
            app.GridLayoutInputCurve = uigridlayout(app.GridLayoutInput);
            app.GridLayoutInputCurve.ColumnWidth = {'1x', '1.4x'};
            app.GridLayoutInputCurve.RowHeight = {'1x'};
            app.GridLayoutInputCurve.Padding = [0 0 0 0];
            app.GridLayoutInputCurve.Layout.Row = 4;
            app.GridLayoutInputCurve.Layout.Column = 1;
            app.GridLayoutInputCurve.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];

            % Create CurveDropDownLabel
            app.CurveDropDownLabel = uilabel(app.GridLayoutInputCurve);
            app.CurveDropDownLabel.FontWeight = 'bold';
            app.CurveDropDownLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.CurveDropDownLabel.Layout.Row = 1;
            app.CurveDropDownLabel.Layout.Column = 1;
            app.CurveDropDownLabel.Text = 'Curve';

            % Create CurveDropDown
            app.CurveDropDown = uidropdown(app.GridLayoutInputCurve);
            app.CurveDropDown.Items = {'Anhysteretic curve', 'Hysteresis loop'};
            app.CurveDropDown.ValueChangedFcn = createCallbackFcn(app, @CurveDropDownValueChanged, true);
            app.CurveDropDown.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.CurveDropDown.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
            app.CurveDropDown.Layout.Row = 1;
            app.CurveDropDown.Layout.Column = 2;
            app.CurveDropDown.Value = 'Anhysteretic curve';

            % Create GridLayout
            app.GridLayout = uigridlayout(app.GridLayoutInput);
            app.GridLayout.ColumnWidth = {'1x'};
            app.GridLayout.RowHeight = {'1x'};
            app.GridLayout.Padding = [0 0 0 0];
            app.GridLayout.Layout.Row = 6;
            app.GridLayout.Layout.Column = 1;
            app.GridLayout.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];

            % Create DescriptionTextArea
            app.DescriptionTextArea = uitextarea(app.GridLayout);
            app.DescriptionTextArea.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.DescriptionTextArea.Layout.Row = 1;
            app.DescriptionTextArea.Layout.Column = 1;

            % Create DescriptionLabel
            app.DescriptionLabel = uilabel(app.GridLayoutInput);
            app.DescriptionLabel.FontWeight = 'bold';
            app.DescriptionLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
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
            app.GridLayoutDatasetPath.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];

            % Create InputDatasetpathLabel
            app.InputDatasetpathLabel = uilabel(app.GridLayoutDatasetPath);
            app.InputDatasetpathLabel.FontWeight = 'bold';
            app.InputDatasetpathLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.InputDatasetpathLabel.Layout.Row = 1;
            app.InputDatasetpathLabel.Layout.Column = 1;
            app.InputDatasetpathLabel.Text = 'Dataset path';

            % Create InputBrowseButton
            app.InputBrowseButton = uibutton(app.GridLayoutDatasetPath, 'push');
            app.InputBrowseButton.ButtonPushedFcn = createCallbackFcn(app, @InputBrowseButtonPushed, true);
            app.InputBrowseButton.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
            app.InputBrowseButton.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.InputBrowseButton.Layout.Row = 1;
            app.InputBrowseButton.Layout.Column = 3;
            app.InputBrowseButton.Text = 'Browse';

            % Create InputDatasetPath
            app.InputDatasetPath = uieditfield(app.GridLayoutDatasetPath, 'text');
            app.InputDatasetPath.ValueChangedFcn = createCallbackFcn(app, @InputDatasetPathValueChanged, true);
            app.InputDatasetPath.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
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
            app.GridLayoutInputPlot.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];

            % Create GridLayoutInputAxisScale
            app.GridLayoutInputAxisScale = uigridlayout(app.GridLayoutInputPlot);
            app.GridLayoutInputAxisScale.ColumnWidth = {'0.7x', '0.3x', '0.5x', '1x', '0.5x'};
            app.GridLayoutInputAxisScale.RowHeight = {'3x'};
            app.GridLayoutInputAxisScale.Padding = [0 0 0 0];
            app.GridLayoutInputAxisScale.Layout.Row = 2;
            app.GridLayoutInputAxisScale.Layout.Column = 1;
            app.GridLayoutInputAxisScale.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];

            % Create InputAxisScaleDropDown
            app.InputAxisScaleDropDown = uidropdown(app.GridLayoutInputAxisScale);
            app.InputAxisScaleDropDown.Items = {'linear', 'semilog-x', 'semilog-y', 'log-log'};
            app.InputAxisScaleDropDown.ValueChangedFcn = createCallbackFcn(app, @InputAxisScaleDropDownValueChanged2, true);
            app.InputAxisScaleDropDown.Tag = 'InputAxisScaleDropDown';
            app.InputAxisScaleDropDown.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.InputAxisScaleDropDown.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
            app.InputAxisScaleDropDown.Layout.Row = 1;
            app.InputAxisScaleDropDown.Layout.Column = 5;
            app.InputAxisScaleDropDown.Value = 'linear';

            % Create InputNumberofPointsLabel
            app.InputNumberofPointsLabel = uilabel(app.GridLayoutInputAxisScale);
            app.InputNumberofPointsLabel.HorizontalAlignment = 'right';
            app.InputNumberofPointsLabel.FontWeight = 'bold';
            app.InputNumberofPointsLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.InputNumberofPointsLabel.Layout.Row = 1;
            app.InputNumberofPointsLabel.Layout.Column = 1;
            app.InputNumberofPointsLabel.Text = 'Number of points';

            % Create AxisscaleLabel
            app.AxisscaleLabel = uilabel(app.GridLayoutInputAxisScale);
            app.AxisscaleLabel.HorizontalAlignment = 'right';
            app.AxisscaleLabel.FontWeight = 'bold';
            app.AxisscaleLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.AxisscaleLabel.Layout.Row = 1;
            app.AxisscaleLabel.Layout.Column = 4;
            app.AxisscaleLabel.Text = 'Axis scale';

            % Create InputApplyPointsButton
            app.InputApplyPointsButton = uibutton(app.GridLayoutInputAxisScale, 'push');
            app.InputApplyPointsButton.ButtonPushedFcn = createCallbackFcn(app, @InputApplyPointsButtonPushed, true);
            app.InputApplyPointsButton.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
            app.InputApplyPointsButton.FontWeight = 'bold';
            app.InputApplyPointsButton.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.InputApplyPointsButton.Layout.Row = 1;
            app.InputApplyPointsButton.Layout.Column = 3;
            app.InputApplyPointsButton.Text = 'Apply';

            % Create InputNumberofPointsEditField
            app.InputNumberofPointsEditField = uieditfield(app.GridLayoutInputAxisScale, 'numeric');
            app.InputNumberofPointsEditField.Limits = [2 Inf];
            app.InputNumberofPointsEditField.RoundFractionalValues = 'on';
            app.InputNumberofPointsEditField.ValueDisplayFormat = '%.0f';
            app.InputNumberofPointsEditField.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.InputNumberofPointsEditField.Layout.Row = 1;
            app.InputNumberofPointsEditField.Layout.Column = 2;
            app.InputNumberofPointsEditField.Value = 50;

            % Create GridLayoutInputPlots
            app.GridLayoutInputPlots = uigridlayout(app.GridLayoutInputPlot);
            app.GridLayoutInputPlots.RowHeight = {'1x'};
            app.GridLayoutInputPlots.Layout.Row = 1;
            app.GridLayoutInputPlots.Layout.Column = 1;
            app.GridLayoutInputPlots.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];

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
            app.GridLayoutInputTipsAndPlotButton.RowHeight = {'1x'};
            app.GridLayoutInputTipsAndPlotButton.Padding = [0 0 0 0];
            app.GridLayoutInputTipsAndPlotButton.Layout.Row = 3;
            app.GridLayoutInputTipsAndPlotButton.Layout.Column = 1;
            app.GridLayoutInputTipsAndPlotButton.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];

            % Create GridLayoutTips
            app.GridLayoutTips = uigridlayout(app.GridLayoutInputTipsAndPlotButton);
            app.GridLayoutTips.ColumnWidth = {'0.5x', '1x'};
            app.GridLayoutTips.RowHeight = {'0.2x', '1x', '1x'};
            app.GridLayoutTips.Padding = [0 0 0 0];
            app.GridLayoutTips.Layout.Row = 1;
            app.GridLayoutTips.Layout.Column = 1;
            app.GridLayoutTips.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];

            % Create HtipAmLabel
            app.HtipAmLabel = uilabel(app.GridLayoutTips);
            app.HtipAmLabel.HorizontalAlignment = 'right';
            app.HtipAmLabel.FontWeight = 'bold';
            app.HtipAmLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.HtipAmLabel.Layout.Row = 2;
            app.HtipAmLabel.Layout.Column = 1;
            app.HtipAmLabel.Text = 'Htip [A/m]';

            % Create HTipField
            app.HTipField = uieditfield(app.GridLayoutTips, 'text');
            app.HTipField.Editable = 'off';
            app.HTipField.HorizontalAlignment = 'right';
            app.HTipField.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.HTipField.Layout.Row = 2;
            app.HTipField.Layout.Column = 2;

            % Create MtipAmLabel
            app.MtipAmLabel = uilabel(app.GridLayoutTips);
            app.MtipAmLabel.HorizontalAlignment = 'right';
            app.MtipAmLabel.FontWeight = 'bold';
            app.MtipAmLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.MtipAmLabel.Layout.Row = 3;
            app.MtipAmLabel.Layout.Column = 1;
            app.MtipAmLabel.Text = 'Mtip [A/m]';

            % Create MTipField
            app.MTipField = uieditfield(app.GridLayoutTips, 'text');
            app.MTipField.Editable = 'off';
            app.MTipField.HorizontalAlignment = 'right';
            app.MTipField.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.MTipField.Layout.Row = 3;
            app.MTipField.Layout.Column = 2;

            % Create AnhystereticfittingTab
            app.AnhystereticfittingTab = uitab(app.TabGroup);
            app.AnhystereticfittingTab.AutoResizeChildren = 'off';
            app.AnhystereticfittingTab.Title = 'Anhysteretic fitting';
            app.AnhystereticfittingTab.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
            app.AnhystereticfittingTab.ForegroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];

            % Create AnhystereticmagnetizationfittingTabGridLayout
            app.AnhystereticmagnetizationfittingTabGridLayout = uigridlayout(app.AnhystereticfittingTab);
            app.AnhystereticmagnetizationfittingTabGridLayout.RowHeight = {'1x'};
            app.AnhystereticmagnetizationfittingTabGridLayout.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];

            % Create GridLayoutAxes
            app.GridLayoutAxes = uigridlayout(app.AnhystereticmagnetizationfittingTabGridLayout);
            app.GridLayoutAxes.ColumnWidth = {'1x'};
            app.GridLayoutAxes.RowHeight = {'1x', '0.15x', '1x', '0.15x', '1x', '0.15x'};
            app.GridLayoutAxes.RowSpacing = 3;
            app.GridLayoutAxes.Padding = [0 0 0 0];
            app.GridLayoutAxes.Layout.Row = 1;
            app.GridLayoutAxes.Layout.Column = 1;
            app.GridLayoutAxes.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];

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
            app.AxesM.TickDir = 'in';
            app.AxesM.Layout.Row = 1;
            app.AxesM.Layout.Column = 1;

            % Create GridLayoutOptionsM
            app.GridLayoutOptionsM = uigridlayout(app.GridLayoutAxes);
            app.GridLayoutOptionsM.ColumnWidth = {'2.9x', '2.1x', '3x', '2x', '2x', '1x', '1.3x'};
            app.GridLayoutOptionsM.RowHeight = {'1x'};
            app.GridLayoutOptionsM.Padding = [0 0 0 0];
            app.GridLayoutOptionsM.Layout.Row = 2;
            app.GridLayoutOptionsM.Layout.Column = 1;
            app.GridLayoutOptionsM.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];

            % Create ResidualplotButtonM
            app.ResidualplotButtonM = uibutton(app.GridLayoutOptionsM, 'push');
            app.ResidualplotButtonM.ButtonPushedFcn = createCallbackFcn(app, @ResidualplotButtonMPushed, true);
            app.ResidualplotButtonM.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
            app.ResidualplotButtonM.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ResidualplotButtonM.Layout.Row = 1;
            app.ResidualplotButtonM.Layout.Column = 2;
            app.ResidualplotButtonM.Text = 'Residuals';

            % Create PlotcomponentsCheckBoxM
            app.PlotcomponentsCheckBoxM = uicheckbox(app.GridLayoutOptionsM);
            app.PlotcomponentsCheckBoxM.ValueChangedFcn = createCallbackFcn(app, @PlotcomponentsCheckBoxMValueChanged, true);
            app.PlotcomponentsCheckBoxM.Text = 'Plot comp.';
            app.PlotcomponentsCheckBoxM.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.PlotcomponentsCheckBoxM.Layout.Row = 1;
            app.PlotcomponentsCheckBoxM.Layout.Column = 3;
            app.PlotcomponentsCheckBoxM.Value = true;

            % Create ShowgridCheckBoxM
            app.ShowgridCheckBoxM = uicheckbox(app.GridLayoutOptionsM);
            app.ShowgridCheckBoxM.ValueChangedFcn = createCallbackFcn(app, @ShowgridCheckBoxMValueChanged, true);
            app.ShowgridCheckBoxM.Text = 'Grid';
            app.ShowgridCheckBoxM.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ShowgridCheckBoxM.Layout.Row = 1;
            app.ShowgridCheckBoxM.Layout.Column = 4;
            app.ShowgridCheckBoxM.Value = true;

            % Create AxisScaleDropDownM
            app.AxisScaleDropDownM = uidropdown(app.GridLayoutOptionsM);
            app.AxisScaleDropDownM.Items = {'linear', 'semilog-x', 'semilog-y', 'log-log'};
            app.AxisScaleDropDownM.ValueChangedFcn = createCallbackFcn(app, @AxisScaleDropDownMValueChanged, true);
            app.AxisScaleDropDownM.Tag = 'InputAxisScaleDropDown';
            app.AxisScaleDropDownM.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.AxisScaleDropDownM.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
            app.AxisScaleDropDownM.Layout.Row = 1;
            app.AxisScaleDropDownM.Layout.Column = [6 7];
            app.AxisScaleDropDownM.Value = 'semilog-x';

            % Create ShowhcrCheckBoxM
            app.ShowhcrCheckBoxM = uicheckbox(app.GridLayoutOptionsM);
            app.ShowhcrCheckBoxM.ValueChangedFcn = createCallbackFcn(app, @ShowhcrCheckBoxMValueChanged, true);
            app.ShowhcrCheckBoxM.Text = 'Hcr,i';
            app.ShowhcrCheckBoxM.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
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
            app.GridLayoutOptionsdMdH.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];

            % Create ResidualplotButtondMdH
            app.ResidualplotButtondMdH = uibutton(app.GridLayoutOptionsdMdH, 'push');
            app.ResidualplotButtondMdH.ButtonPushedFcn = createCallbackFcn(app, @ResidualplotButtondMdHPushed, true);
            app.ResidualplotButtondMdH.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
            app.ResidualplotButtondMdH.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ResidualplotButtondMdH.Layout.Row = 1;
            app.ResidualplotButtondMdH.Layout.Column = 2;
            app.ResidualplotButtondMdH.Text = 'Residuals';

            % Create PlotcomponentsCheckBoxdMdH
            app.PlotcomponentsCheckBoxdMdH = uicheckbox(app.GridLayoutOptionsdMdH);
            app.PlotcomponentsCheckBoxdMdH.ValueChangedFcn = createCallbackFcn(app, @PlotcomponentsCheckBoxdMdHValueChanged, true);
            app.PlotcomponentsCheckBoxdMdH.Text = 'Plot comp.';
            app.PlotcomponentsCheckBoxdMdH.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.PlotcomponentsCheckBoxdMdH.Layout.Row = 1;
            app.PlotcomponentsCheckBoxdMdH.Layout.Column = 3;
            app.PlotcomponentsCheckBoxdMdH.Value = true;

            % Create ShowgridCheckBoxdMdH
            app.ShowgridCheckBoxdMdH = uicheckbox(app.GridLayoutOptionsdMdH);
            app.ShowgridCheckBoxdMdH.ValueChangedFcn = createCallbackFcn(app, @ShowgridCheckBoxdMdHValueChanged, true);
            app.ShowgridCheckBoxdMdH.Text = 'Grid';
            app.ShowgridCheckBoxdMdH.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ShowgridCheckBoxdMdH.Layout.Row = 1;
            app.ShowgridCheckBoxdMdH.Layout.Column = 4;
            app.ShowgridCheckBoxdMdH.Value = true;

            % Create AxisScaleDropDowndMdH
            app.AxisScaleDropDowndMdH = uidropdown(app.GridLayoutOptionsdMdH);
            app.AxisScaleDropDowndMdH.Items = {'linear', 'semilog-x', 'semilog-y', 'log-log'};
            app.AxisScaleDropDowndMdH.ValueChangedFcn = createCallbackFcn(app, @AxisScaleDropDowndMdHValueChanged, true);
            app.AxisScaleDropDowndMdH.Tag = 'InputAxisScaleDropDown';
            app.AxisScaleDropDowndMdH.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.AxisScaleDropDowndMdH.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
            app.AxisScaleDropDowndMdH.Layout.Row = 1;
            app.AxisScaleDropDowndMdH.Layout.Column = [6 7];
            app.AxisScaleDropDowndMdH.Value = 'semilog-x';

            % Create ShowhcrCheckBoxdMdH
            app.ShowhcrCheckBoxdMdH = uicheckbox(app.GridLayoutOptionsdMdH);
            app.ShowhcrCheckBoxdMdH.ValueChangedFcn = createCallbackFcn(app, @ShowhcrCheckBoxdMdHValueChanged, true);
            app.ShowhcrCheckBoxdMdH.Text = 'Hcr,i';
            app.ShowhcrCheckBoxdMdH.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
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
            app.GridLayoutOptionsHdMdH.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];

            % Create ResidualplotButtondHdMdH
            app.ResidualplotButtondHdMdH = uibutton(app.GridLayoutOptionsHdMdH, 'push');
            app.ResidualplotButtondHdMdH.ButtonPushedFcn = createCallbackFcn(app, @ResidualplotButtondHdMdHPushed, true);
            app.ResidualplotButtondHdMdH.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
            app.ResidualplotButtondHdMdH.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ResidualplotButtondHdMdH.Layout.Row = 1;
            app.ResidualplotButtondHdMdH.Layout.Column = 2;
            app.ResidualplotButtondHdMdH.Text = 'Residuals';

            % Create PlotcomponentsCheckBoxHdMdH
            app.PlotcomponentsCheckBoxHdMdH = uicheckbox(app.GridLayoutOptionsHdMdH);
            app.PlotcomponentsCheckBoxHdMdH.ValueChangedFcn = createCallbackFcn(app, @PlotcomponentsCheckBoxHdMdHValueChanged, true);
            app.PlotcomponentsCheckBoxHdMdH.Text = 'Plot comp.';
            app.PlotcomponentsCheckBoxHdMdH.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.PlotcomponentsCheckBoxHdMdH.Layout.Row = 1;
            app.PlotcomponentsCheckBoxHdMdH.Layout.Column = 3;
            app.PlotcomponentsCheckBoxHdMdH.Value = true;

            % Create ShowgridCheckBoxHdMdH
            app.ShowgridCheckBoxHdMdH = uicheckbox(app.GridLayoutOptionsHdMdH);
            app.ShowgridCheckBoxHdMdH.ValueChangedFcn = createCallbackFcn(app, @ShowgridCheckBoxHdMdHValueChanged, true);
            app.ShowgridCheckBoxHdMdH.Text = 'Grid';
            app.ShowgridCheckBoxHdMdH.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ShowgridCheckBoxHdMdH.Layout.Row = 1;
            app.ShowgridCheckBoxHdMdH.Layout.Column = 4;
            app.ShowgridCheckBoxHdMdH.Value = true;

            % Create AxisScaleDropDownHdMdH
            app.AxisScaleDropDownHdMdH = uidropdown(app.GridLayoutOptionsHdMdH);
            app.AxisScaleDropDownHdMdH.Items = {'linear', 'semilog-x', 'semilog-y', 'log-log'};
            app.AxisScaleDropDownHdMdH.ValueChangedFcn = createCallbackFcn(app, @AxisScaleDropDownHdMdHValueChanged, true);
            app.AxisScaleDropDownHdMdH.Tag = 'InputAxisScaleDropDown';
            app.AxisScaleDropDownHdMdH.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.AxisScaleDropDownHdMdH.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
            app.AxisScaleDropDownHdMdH.Layout.Row = 1;
            app.AxisScaleDropDownHdMdH.Layout.Column = [6 7];
            app.AxisScaleDropDownHdMdH.Value = 'semilog-x';

            % Create ShowhcrCheckBoxHdMdH
            app.ShowhcrCheckBoxHdMdH = uicheckbox(app.GridLayoutOptionsHdMdH);
            app.ShowhcrCheckBoxHdMdH.ValueChangedFcn = createCallbackFcn(app, @ShowhcrCheckBoxHdMdHValueChanged, true);
            app.ShowhcrCheckBoxHdMdH.Text = 'Hcr,i';
            app.ShowhcrCheckBoxHdMdH.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ShowhcrCheckBoxHdMdH.Layout.Row = 1;
            app.ShowhcrCheckBoxHdMdH.Layout.Column = 5;
            app.ShowhcrCheckBoxHdMdH.Value = true;

            % Create GridLayoutNumbers
            app.GridLayoutNumbers = uigridlayout(app.AnhystereticmagnetizationfittingTabGridLayout);
            app.GridLayoutNumbers.ColumnWidth = {'1x'};
            app.GridLayoutNumbers.RowHeight = {'0.2x', '0.2x', '0.2x', '1.8x', '0.2x', '1x', '0.2x', '1x', '0.3x'};
            app.GridLayoutNumbers.RowSpacing = 5;
            app.GridLayoutNumbers.Padding = [10 0 10 0];
            app.GridLayoutNumbers.Layout.Row = 1;
            app.GridLayoutNumbers.Layout.Column = 2;
            app.GridLayoutNumbers.Scrollable = 'on';
            app.GridLayoutNumbers.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];

            % Create TableFittedParameters
            app.TableFittedParameters = uitable(app.GridLayoutNumbers);
            app.TableFittedParameters.BackgroundColor = [1 1 1;0.96078431372549 0.96078431372549 0.96078431372549];
            app.TableFittedParameters.ColumnName = {'Parameter'; 'Value'; 'Lower bound'; 'Upper bound'; 'Fit'};
            app.TableFittedParameters.RowName = {};
            app.TableFittedParameters.ColumnEditable = [false true true true true];
            app.TableFittedParameters.CellEditCallback = createCallbackFcn(app, @TableFittedParametersCellEdit, true);
            app.TableFittedParameters.CellSelectionCallback = createCallbackFcn(app, @TableFittedParametersCellSelection, true);
            app.TableFittedParameters.ForegroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.TableFittedParameters.Layout.Row = 4;
            app.TableFittedParameters.Layout.Column = 1;

            % Create ModelretrievedparametersLabel
            app.ModelretrievedparametersLabel = uilabel(app.GridLayoutNumbers);
            app.ModelretrievedparametersLabel.FontWeight = 'bold';
            app.ModelretrievedparametersLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ModelretrievedparametersLabel.Layout.Row = 5;
            app.ModelretrievedparametersLabel.Layout.Column = 1;
            app.ModelretrievedparametersLabel.Text = 'Model retrieved parameters';

            % Create TableParameters
            app.TableParameters = uitable(app.GridLayoutNumbers);
            app.TableParameters.BackgroundColor = [1 1 1;0.96078431372549 0.96078431372549 0.96078431372549];
            app.TableParameters.ColumnName = {'Component'; 'Msᵢ [A/m]'; 'αᵢ'; 'aᵢ [A/m]'; 'Select aᵢ'};
            app.TableParameters.RowName = {};
            app.TableParameters.ColumnEditable = [false false false false true];
            app.TableParameters.ForegroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.TableParameters.Layout.Row = 6;
            app.TableParameters.Layout.Column = 1;

            % Create GridLayoutButtons
            app.GridLayoutButtons = uigridlayout(app.GridLayoutNumbers);
            app.GridLayoutButtons.ColumnWidth = {'0.65x', '1.1x', '0.9x', '1.2x', '1.2x'};
            app.GridLayoutButtons.RowHeight = {'1x'};
            app.GridLayoutButtons.Padding = [0 0 0 0];
            app.GridLayoutButtons.Layout.Row = 9;
            app.GridLayoutButtons.Layout.Column = 1;
            app.GridLayoutButtons.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];

            % Create FitButton
            app.FitButton = uibutton(app.GridLayoutButtons, 'push');
            app.FitButton.ButtonPushedFcn = createCallbackFcn(app, @FitButtonPushed, true);
            app.FitButton.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
            app.FitButton.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.FitButton.Layout.Row = 1;
            app.FitButton.Layout.Column = 5;
            app.FitButton.Text = 'Fit';

            % Create CalculatePlotButton
            app.CalculatePlotButton = uibutton(app.GridLayoutButtons, 'push');
            app.CalculatePlotButton.ButtonPushedFcn = createCallbackFcn(app, @CalculatePlotButtonPushed, true);
            app.CalculatePlotButton.WordWrap = 'on';
            app.CalculatePlotButton.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
            app.CalculatePlotButton.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.CalculatePlotButton.Layout.Row = 1;
            app.CalculatePlotButton.Layout.Column = 4;
            app.CalculatePlotButton.Text = 'Calculate & Plot';

            % Create ErrortominimizeDropDownLabel
            app.ErrortominimizeDropDownLabel = uilabel(app.GridLayoutButtons);
            app.ErrortominimizeDropDownLabel.WordWrap = 'on';
            app.ErrortominimizeDropDownLabel.FontWeight = 'bold';
            app.ErrortominimizeDropDownLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ErrortominimizeDropDownLabel.Layout.Row = 1;
            app.ErrortominimizeDropDownLabel.Layout.Column = 1;
            app.ErrortominimizeDropDownLabel.Text = 'Error to minimize';

            % Create ErrortominimizeDropDown
            app.ErrortominimizeDropDown = uidropdown(app.GridLayoutButtons);
            app.ErrortominimizeDropDown.Items = {'Diagonal (H, sampled)', 'Diagonal (H, continuous)', 'Diagonal (logH, sampled)', 'Diagonal (logH, continuous)', 'Vertical', 'Horizontal'};
            app.ErrortominimizeDropDown.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ErrortominimizeDropDown.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
            app.ErrortominimizeDropDown.Layout.Row = 1;
            app.ErrortominimizeDropDown.Layout.Column = 2;
            app.ErrortominimizeDropDown.Value = 'Diagonal (logH, continuous)';

            % Create ErrorDisplay
            app.ErrorDisplay = uieditfield(app.GridLayoutButtons, 'text');
            app.ErrorDisplay.Editable = 'off';
            app.ErrorDisplay.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ErrorDisplay.Layout.Row = 1;
            app.ErrorDisplay.Layout.Column = 3;

            % Create GridLayoutOtherQuantities
            app.GridLayoutOtherQuantities = uigridlayout(app.GridLayoutNumbers);
            app.GridLayoutOtherQuantities.ColumnWidth = {'1.8x', '0.4x', '1x', '0.4x', '1x'};
            app.GridLayoutOtherQuantities.RowHeight = {'1x'};
            app.GridLayoutOtherQuantities.Padding = [0 0 0 0];
            app.GridLayoutOtherQuantities.Layout.Row = 7;
            app.GridLayoutOtherQuantities.Layout.Column = 1;
            app.GridLayoutOtherQuantities.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];

            % Create OthercalculatedquantitiesLabel
            app.OthercalculatedquantitiesLabel = uilabel(app.GridLayoutOtherQuantities);
            app.OthercalculatedquantitiesLabel.FontWeight = 'bold';
            app.OthercalculatedquantitiesLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.OthercalculatedquantitiesLabel.Layout.Row = 1;
            app.OthercalculatedquantitiesLabel.Layout.Column = 1;
            app.OthercalculatedquantitiesLabel.Text = 'Other calculated quantities';

            % Create JsTEditFieldLabel
            app.JsTEditFieldLabel = uilabel(app.GridLayoutOtherQuantities);
            app.JsTEditFieldLabel.HorizontalAlignment = 'right';
            app.JsTEditFieldLabel.FontWeight = 'bold';
            app.JsTEditFieldLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.JsTEditFieldLabel.Layout.Row = 1;
            app.JsTEditFieldLabel.Layout.Column = 4;
            app.JsTEditFieldLabel.Text = 'Js [T]';

            % Create JsField
            app.JsField = uieditfield(app.GridLayoutOtherQuantities, 'text');
            app.JsField.Editable = 'off';
            app.JsField.HorizontalAlignment = 'right';
            app.JsField.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.JsField.Layout.Row = 1;
            app.JsField.Layout.Column = 5;

            % Create murinField
            app.murinField = uieditfield(app.GridLayoutOtherQuantities, 'text');
            app.murinField.Editable = 'off';
            app.murinField.HorizontalAlignment = 'right';
            app.murinField.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.murinField.Layout.Row = 1;
            app.murinField.Layout.Column = 3;

            % Create murinLabel
            app.murinLabel = uilabel(app.GridLayoutOtherQuantities);
            app.murinLabel.HorizontalAlignment = 'right';
            app.murinLabel.FontWeight = 'bold';
            app.murinLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.murinLabel.Layout.Row = 1;
            app.murinLabel.Layout.Column = 2;
            app.murinLabel.Text = 'μrᵢₙ';

            % Create TableQuantities
            app.TableQuantities = uitable(app.GridLayoutNumbers);
            app.TableQuantities.BackgroundColor = [1 1 1;0.96078431372549 0.96078431372549 0.96078431372549];
            app.TableQuantities.ColumnName = {'Component'; 'αᵢ⏐Msᵢ⏐/(3aᵢ)'; 'NᵢkвT [J/m³]'; 'Hkᵢ [A/m]'; 'μrᵢₙ ᵢ'};
            app.TableQuantities.RowName = {};
            app.TableQuantities.ForegroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.TableQuantities.Layout.Row = 8;
            app.TableQuantities.Layout.Column = 1;

            % Create ModeledcurveLabel
            app.ModeledcurveLabel = uilabel(app.GridLayoutNumbers);
            app.ModeledcurveLabel.FontWeight = 'bold';
            app.ModeledcurveLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ModeledcurveLabel.Layout.Row = 1;
            app.ModeledcurveLabel.Layout.Column = 1;
            app.ModeledcurveLabel.Text = 'Modeled curve';

            % Create GridLayoutModeledCurve
            app.GridLayoutModeledCurve = uigridlayout(app.GridLayoutNumbers);
            app.GridLayoutModeledCurve.ColumnWidth = {'1x', '0.32x', '0.75x', '0.32x', '1x', '0.6x'};
            app.GridLayoutModeledCurve.RowHeight = {'1x'};
            app.GridLayoutModeledCurve.ColumnSpacing = 3;
            app.GridLayoutModeledCurve.Padding = [0 0 0 0];
            app.GridLayoutModeledCurve.Layout.Row = 2;
            app.GridLayoutModeledCurve.Layout.Column = 1;
            app.GridLayoutModeledCurve.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];

            % Create NofcomponentsSpinnerLabel
            app.NofcomponentsSpinnerLabel = uilabel(app.GridLayoutModeledCurve);
            app.NofcomponentsSpinnerLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.NofcomponentsSpinnerLabel.Layout.Row = 1;
            app.NofcomponentsSpinnerLabel.Layout.Column = 1;
            app.NofcomponentsSpinnerLabel.Text = 'N. of components';

            % Create NofcomponentsSpinner
            app.NofcomponentsSpinner = uispinner(app.GridLayoutModeledCurve);
            app.NofcomponentsSpinner.Limits = [1 4];
            app.NofcomponentsSpinner.ValueChangedFcn = createCallbackFcn(app, @NofcomponentsSpinnerValueChanged, true);
            app.NofcomponentsSpinner.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.NofcomponentsSpinner.Layout.Row = 1;
            app.NofcomponentsSpinner.Layout.Column = 2;
            app.NofcomponentsSpinner.Value = 1;

            % Create NofpointsEditFieldLabel
            app.NofpointsEditFieldLabel = uilabel(app.GridLayoutModeledCurve);
            app.NofpointsEditFieldLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.NofpointsEditFieldLabel.Layout.Row = 1;
            app.NofpointsEditFieldLabel.Layout.Column = 3;
            app.NofpointsEditFieldLabel.Text = 'N. of points';

            % Create NofpointsEditField
            app.NofpointsEditField = uieditfield(app.GridLayoutModeledCurve, 'numeric');
            app.NofpointsEditField.Limits = [0 Inf];
            app.NofpointsEditField.ValueDisplayFormat = '%.0f';
            app.NofpointsEditField.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.NofpointsEditField.Layout.Row = 1;
            app.NofpointsEditField.Layout.Column = 4;
            app.NofpointsEditField.Value = 100;

            % Create PointSpaceDropDown
            app.PointSpaceDropDown = uidropdown(app.GridLayoutModeledCurve);
            app.PointSpaceDropDown.Items = {'Logarithmically spaced', 'Lineraly spaced'};
            app.PointSpaceDropDown.ItemsData = {'log', 'linear'};
            app.PointSpaceDropDown.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.PointSpaceDropDown.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
            app.PointSpaceDropDown.Layout.Row = 1;
            app.PointSpaceDropDown.Layout.Column = 5;
            app.PointSpaceDropDown.Value = 'log';

            % Create SetColorsButton
            app.SetColorsButton = uibutton(app.GridLayoutModeledCurve, 'push');
            app.SetColorsButton.ButtonPushedFcn = createCallbackFcn(app, @SetColorsButtonPushed, true);
            app.SetColorsButton.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
            app.SetColorsButton.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.SetColorsButton.Layout.Row = 1;
            app.SetColorsButton.Layout.Column = 6;
            app.SetColorsButton.Text = 'Set Colors';

            % Create FittedparametersLabel
            app.FittedparametersLabel = uilabel(app.GridLayoutNumbers);
            app.FittedparametersLabel.FontWeight = 'bold';
            app.FittedparametersLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.FittedparametersLabel.Layout.Row = 3;
            app.FittedparametersLabel.Layout.Column = 1;
            app.FittedparametersLabel.Text = 'Fitted parameters';

            % Create HystereticfittingTab
            app.HystereticfittingTab = uitab(app.TabGroup);
            app.HystereticfittingTab.Title = 'Hysteretic fitting ';
            app.HystereticfittingTab.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
            app.HystereticfittingTab.ForegroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];

            % Create GridLayout2
            app.GridLayout2 = uigridlayout(app.HystereticfittingTab);
            app.GridLayout2.ColumnWidth = {39.01, 65, 114.01, 61.99, 188.99, 61.99, '1x', '1x', '1x', '0.2x', '1x', '1x'};
            app.GridLayout2.RowHeight = {25, 21.99, 21.99, 21.99, 21.99, 21.99, 21.99, '1x', 21.99, 21.99, '1x', '8.56x', 28.99};
            app.GridLayout2.ColumnSpacing = 2.77317164494441;
            app.GridLayout2.RowSpacing = 6.31337694021372;
            app.GridLayout2.Padding = [2.77317164494441 6.31337694021372 2.77317164494441 6.31337694021372];
            app.GridLayout2.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];

            % Create AxesM_2
            app.AxesM_2 = uiaxes(app.GridLayout2);
            xlabel(app.AxesM_2, 'H [A/m]')
            ylabel(app.AxesM_2, 'M [A/m]')
            zlabel(app.AxesM_2, 'Z')
            app.AxesM_2.Box = 'on';
            app.AxesM_2.TickDir = 'in';
            app.AxesM_2.Layout.Row = [2 12];
            app.AxesM_2.Layout.Column = [1 5];

            % Create JilesAthertonmodelrateindependentLabel
            app.JilesAthertonmodelrateindependentLabel = uilabel(app.GridLayout2);
            app.JilesAthertonmodelrateindependentLabel.FontWeight = 'bold';
            app.JilesAthertonmodelrateindependentLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.JilesAthertonmodelrateindependentLabel.Layout.Row = 1;
            app.JilesAthertonmodelrateindependentLabel.Layout.Column = [1 11];
            app.JilesAthertonmodelrateindependentLabel.Text = 'Jiles-Atherton model (rate-independent)';

            % Create ModelparametersLabel
            app.ModelparametersLabel = uilabel(app.GridLayout2);
            app.ModelparametersLabel.FontWeight = 'bold';
            app.ModelparametersLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ModelparametersLabel.Layout.Row = 2;
            app.ModelparametersLabel.Layout.Column = [6 7];
            app.ModelparametersLabel.Text = 'Model parameters';

            % Create JsTEditFieldLabel_2
            app.JsTEditFieldLabel_2 = uilabel(app.GridLayout2);
            app.JsTEditFieldLabel_2.FontWeight = 'bold';
            app.JsTEditFieldLabel_2.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.JsTEditFieldLabel_2.Layout.Row = 3;
            app.JsTEditFieldLabel_2.Layout.Column = 6;
            app.JsTEditFieldLabel_2.Text = 'Ms [A/m]';

            % Create JsField_2
            app.JsField_2 = uieditfield(app.GridLayout2, 'text');
            app.JsField_2.HorizontalAlignment = 'right';
            app.JsField_2.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.JsField_2.Layout.Row = 3;
            app.JsField_2.Layout.Column = 7;

            % Create JsTEditFieldLabel_3
            app.JsTEditFieldLabel_3 = uilabel(app.GridLayout2);
            app.JsTEditFieldLabel_3.FontWeight = 'bold';
            app.JsTEditFieldLabel_3.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.JsTEditFieldLabel_3.Layout.Row = 4;
            app.JsTEditFieldLabel_3.Layout.Column = 6;
            app.JsTEditFieldLabel_3.Text = 'a [A/m]';

            % Create JsField_3
            app.JsField_3 = uieditfield(app.GridLayout2, 'text');
            app.JsField_3.HorizontalAlignment = 'right';
            app.JsField_3.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.JsField_3.Layout.Row = 4;
            app.JsField_3.Layout.Column = 7;

            % Create JsTEditFieldLabel_4
            app.JsTEditFieldLabel_4 = uilabel(app.GridLayout2);
            app.JsTEditFieldLabel_4.FontWeight = 'bold';
            app.JsTEditFieldLabel_4.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.JsTEditFieldLabel_4.Layout.Row = 5;
            app.JsTEditFieldLabel_4.Layout.Column = 6;
            app.JsTEditFieldLabel_4.Text = 'alpha';

            % Create JsField_4
            app.JsField_4 = uieditfield(app.GridLayout2, 'text');
            app.JsField_4.HorizontalAlignment = 'right';
            app.JsField_4.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.JsField_4.Layout.Row = 5;
            app.JsField_4.Layout.Column = 7;

            % Create JsTEditFieldLabel_5
            app.JsTEditFieldLabel_5 = uilabel(app.GridLayout2);
            app.JsTEditFieldLabel_5.FontWeight = 'bold';
            app.JsTEditFieldLabel_5.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.JsTEditFieldLabel_5.Layout.Row = 6;
            app.JsTEditFieldLabel_5.Layout.Column = 6;
            app.JsTEditFieldLabel_5.Text = 'c';

            % Create JsField_5
            app.JsField_5 = uieditfield(app.GridLayout2, 'text');
            app.JsField_5.HorizontalAlignment = 'right';
            app.JsField_5.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.JsField_5.Layout.Row = 6;
            app.JsField_5.Layout.Column = 7;

            % Create JsTEditFieldLabel_6
            app.JsTEditFieldLabel_6 = uilabel(app.GridLayout2);
            app.JsTEditFieldLabel_6.FontWeight = 'bold';
            app.JsTEditFieldLabel_6.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.JsTEditFieldLabel_6.Layout.Row = 7;
            app.JsTEditFieldLabel_6.Layout.Column = 6;
            app.JsTEditFieldLabel_6.Text = 'k [A/m]';

            % Create JsField_6
            app.JsField_6 = uieditfield(app.GridLayout2, 'text');
            app.JsField_6.HorizontalAlignment = 'right';
            app.JsField_6.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.JsField_6.Layout.Row = 7;
            app.JsField_6.Layout.Column = 7;

            % Create FitButton_2
            app.FitButton_2 = uibutton(app.GridLayout2, 'push');
            app.FitButton_2.ButtonPushedFcn = createCallbackFcn(app, @FitButton_2Pushed, true);
            app.FitButton_2.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
            app.FitButton_2.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.FitButton_2.Layout.Row = 13;
            app.FitButton_2.Layout.Column = 12;
            app.FitButton_2.Text = 'Fit';

            % Create CalculatePlotButton_2
            app.CalculatePlotButton_2 = uibutton(app.GridLayout2, 'push');
            app.CalculatePlotButton_2.ButtonPushedFcn = createCallbackFcn(app, @CalculatePlotButton_2Pushed, true);
            app.CalculatePlotButton_2.WordWrap = 'on';
            app.CalculatePlotButton_2.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
            app.CalculatePlotButton_2.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.CalculatePlotButton_2.Layout.Row = 13;
            app.CalculatePlotButton_2.Layout.Column = 11;
            app.CalculatePlotButton_2.Text = 'Calculate & Plot';

            % Create ErrortominimizeDropDownLabel_2
            app.ErrortominimizeDropDownLabel_2 = uilabel(app.GridLayout2);
            app.ErrortominimizeDropDownLabel_2.WordWrap = 'on';
            app.ErrortominimizeDropDownLabel_2.FontWeight = 'bold';
            app.ErrortominimizeDropDownLabel_2.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ErrortominimizeDropDownLabel_2.Layout.Row = 13;
            app.ErrortominimizeDropDownLabel_2.Layout.Column = 6;
            app.ErrortominimizeDropDownLabel_2.Text = 'Error to minimize';

            % Create ErrortominimizeDropDown_2
            app.ErrortominimizeDropDown_2 = uidropdown(app.GridLayout2);
            app.ErrortominimizeDropDown_2.Items = {'Diagonal (H, continuous)', 'Vertical', 'Horizontal'};
            app.ErrortominimizeDropDown_2.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ErrortominimizeDropDown_2.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
            app.ErrortominimizeDropDown_2.Layout.Row = 13;
            app.ErrortominimizeDropDown_2.Layout.Column = [7 8];
            app.ErrortominimizeDropDown_2.Value = 'Diagonal (H, continuous)';

            % Create ErrorDisplay_2
            app.ErrorDisplay_2 = uieditfield(app.GridLayout2, 'text');
            app.ErrorDisplay_2.Editable = 'off';
            app.ErrorDisplay_2.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ErrorDisplay_2.Layout.Row = 13;
            app.ErrorDisplay_2.Layout.Column = 9;

            % Create RetrieveseedsButton
            app.RetrieveseedsButton = uibutton(app.GridLayout2, 'push');
            app.RetrieveseedsButton.ButtonPushedFcn = createCallbackFcn(app, @RetrieveseedsButtonPushed, true);
            app.RetrieveseedsButton.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
            app.RetrieveseedsButton.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.RetrieveseedsButton.Layout.Row = 2;
            app.RetrieveseedsButton.Layout.Column = 11;
            app.RetrieveseedsButton.Text = 'Retrieve seeds';

            % Create DrivingfieldLabel
            app.DrivingfieldLabel = uilabel(app.GridLayout2);
            app.DrivingfieldLabel.FontWeight = 'bold';
            app.DrivingfieldLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.DrivingfieldLabel.Layout.Row = 9;
            app.DrivingfieldLabel.Layout.Column = [6 11];
            app.DrivingfieldLabel.Text = 'Driving field';

            % Create JsTEditFieldLabel_7
            app.JsTEditFieldLabel_7 = uilabel(app.GridLayout2);
            app.JsTEditFieldLabel_7.FontWeight = 'bold';
            app.JsTEditFieldLabel_7.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.JsTEditFieldLabel_7.Layout.Row = 10;
            app.JsTEditFieldLabel_7.Layout.Column = 6;
            app.JsTEditFieldLabel_7.Text = 'Htip [A/m]';

            % Create JsField_7
            app.JsField_7 = uieditfield(app.GridLayout2, 'text');
            app.JsField_7.Editable = 'off';
            app.JsField_7.HorizontalAlignment = 'right';
            app.JsField_7.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.JsField_7.Layout.Row = 10;
            app.JsField_7.Layout.Column = 8;

            % Create ShowgridCheckBoxM_2
            app.ShowgridCheckBoxM_2 = uicheckbox(app.GridLayout2);
            app.ShowgridCheckBoxM_2.ValueChangedFcn = createCallbackFcn(app, @ShowgridCheckBoxM_2ValueChanged, true);
            app.ShowgridCheckBoxM_2.Text = 'Grid';
            app.ShowgridCheckBoxM_2.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ShowgridCheckBoxM_2.Layout.Row = 13;
            app.ShowgridCheckBoxM_2.Layout.Column = 4;
            app.ShowgridCheckBoxM_2.Value = true;

            % Create ResidualplotButtondMdH_2
            app.ResidualplotButtondMdH_2 = uibutton(app.GridLayout2, 'push');
            app.ResidualplotButtondMdH_2.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
            app.ResidualplotButtondMdH_2.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ResidualplotButtondMdH_2.Layout.Row = 13;
            app.ResidualplotButtondMdH_2.Layout.Column = 2;
            app.ResidualplotButtondMdH_2.Text = 'Residuals';

            % Create JsTEditFieldLabel_8
            app.JsTEditFieldLabel_8 = uilabel(app.GridLayout2);
            app.JsTEditFieldLabel_8.FontWeight = 'bold';
            app.JsTEditFieldLabel_8.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.JsTEditFieldLabel_8.Layout.Row = 11;
            app.JsTEditFieldLabel_8.Layout.Column = 6;
            app.JsTEditFieldLabel_8.Text = 'Mtip [A/m]';

            % Create JsField_8
            app.JsField_8 = uieditfield(app.GridLayout2, 'text');
            app.JsField_8.Editable = 'off';
            app.JsField_8.HorizontalAlignment = 'right';
            app.JsField_8.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.JsField_8.Layout.Row = 11;
            app.JsField_8.Layout.Column = 8;

            % Create MsLowerField_2
            app.MsLowerField_2 = uieditfield(app.GridLayout2, 'text');
            app.MsLowerField_2.HorizontalAlignment = 'right';
            app.MsLowerField_2.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.MsLowerField_2.Layout.Row = 3;
            app.MsLowerField_2.Layout.Column = 8;

            % Create MsUpperField_2
            app.MsUpperField_2 = uieditfield(app.GridLayout2, 'text');
            app.MsUpperField_2.HorizontalAlignment = 'right';
            app.MsUpperField_2.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.MsUpperField_2.Layout.Row = 3;
            app.MsUpperField_2.Layout.Column = 9;

            % Create aLowerField_2
            app.aLowerField_2 = uieditfield(app.GridLayout2, 'text');
            app.aLowerField_2.HorizontalAlignment = 'right';
            app.aLowerField_2.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.aLowerField_2.Layout.Row = 4;
            app.aLowerField_2.Layout.Column = 8;

            % Create aUpperField_2
            app.aUpperField_2 = uieditfield(app.GridLayout2, 'text');
            app.aUpperField_2.HorizontalAlignment = 'right';
            app.aUpperField_2.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.aUpperField_2.Layout.Row = 4;
            app.aUpperField_2.Layout.Column = 9;

            % Create alphaLowerField_2
            app.alphaLowerField_2 = uieditfield(app.GridLayout2, 'text');
            app.alphaLowerField_2.HorizontalAlignment = 'right';
            app.alphaLowerField_2.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.alphaLowerField_2.Layout.Row = 5;
            app.alphaLowerField_2.Layout.Column = 8;

            % Create alphaUpperField_2
            app.alphaUpperField_2 = uieditfield(app.GridLayout2, 'text');
            app.alphaUpperField_2.HorizontalAlignment = 'right';
            app.alphaUpperField_2.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.alphaUpperField_2.Layout.Row = 5;
            app.alphaUpperField_2.Layout.Column = 9;

            % Create cLowerField_2
            app.cLowerField_2 = uieditfield(app.GridLayout2, 'text');
            app.cLowerField_2.HorizontalAlignment = 'right';
            app.cLowerField_2.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.cLowerField_2.Layout.Row = 6;
            app.cLowerField_2.Layout.Column = 8;

            % Create cUpperField_2
            app.cUpperField_2 = uieditfield(app.GridLayout2, 'text');
            app.cUpperField_2.HorizontalAlignment = 'right';
            app.cUpperField_2.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.cUpperField_2.Layout.Row = 6;
            app.cUpperField_2.Layout.Column = 9;

            % Create kLowerField_2
            app.kLowerField_2 = uieditfield(app.GridLayout2, 'text');
            app.kLowerField_2.HorizontalAlignment = 'right';
            app.kLowerField_2.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.kLowerField_2.Layout.Row = 7;
            app.kLowerField_2.Layout.Column = 8;

            % Create kUpperField_2
            app.kUpperField_2 = uieditfield(app.GridLayout2, 'text');
            app.kUpperField_2.HorizontalAlignment = 'right';
            app.kUpperField_2.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.kUpperField_2.Layout.Row = 7;
            app.kUpperField_2.Layout.Column = 9;

            % Create LowerboundLabel
            app.LowerboundLabel = uilabel(app.GridLayout2);
            app.LowerboundLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.LowerboundLabel.Layout.Row = 2;
            app.LowerboundLabel.Layout.Column = 8;
            app.LowerboundLabel.Text = 'Lower bound';

            % Create UpperboundLabel
            app.UpperboundLabel = uilabel(app.GridLayout2);
            app.UpperboundLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.UpperboundLabel.Layout.Row = 2;
            app.UpperboundLabel.Layout.Column = 9;
            app.UpperboundLabel.Text = 'Upper bound';

            % Create FitLabel
            app.FitLabel = uilabel(app.GridLayout2);
            app.FitLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.FitLabel.Layout.Row = 2;
            app.FitLabel.Layout.Column = 10;
            app.FitLabel.Text = 'Fit';

            % Create CheckBox
            app.CheckBox = uicheckbox(app.GridLayout2);
            app.CheckBox.Text = '';
            app.CheckBox.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.CheckBox.Layout.Row = 3;
            app.CheckBox.Layout.Column = 10;
            app.CheckBox.Value = true;

            % Create CheckBox_2
            app.CheckBox_2 = uicheckbox(app.GridLayout2);
            app.CheckBox_2.Text = '';
            app.CheckBox_2.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.CheckBox_2.Layout.Row = 4;
            app.CheckBox_2.Layout.Column = 10;
            app.CheckBox_2.Value = true;

            % Create CheckBox_3
            app.CheckBox_3 = uicheckbox(app.GridLayout2);
            app.CheckBox_3.Text = '';
            app.CheckBox_3.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.CheckBox_3.Layout.Row = 5;
            app.CheckBox_3.Layout.Column = 10;
            app.CheckBox_3.Value = true;

            % Create CheckBox_4
            app.CheckBox_4 = uicheckbox(app.GridLayout2);
            app.CheckBox_4.Text = '';
            app.CheckBox_4.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.CheckBox_4.Layout.Row = 6;
            app.CheckBox_4.Layout.Column = 10;
            app.CheckBox_4.Value = true;

            % Create FitkCheckBox
            app.FitkCheckBox = uicheckbox(app.GridLayout2);
            app.FitkCheckBox.Text = '';
            app.FitkCheckBox.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.FitkCheckBox.Layout.Row = 7;
            app.FitkCheckBox.Layout.Column = 10;
            app.FitkCheckBox.Value = true;

            % Create Label
            app.Label = uilabel(app.GridLayout2);
            app.Label.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.Label.Layout.Row = 2;
            app.Label.Layout.Column = 12;
            app.Label.Text = '';

            % Create kConstrainedCheckBox_2
            app.kConstrainedCheckBox_2 = uicheckbox(app.GridLayout2);
            app.kConstrainedCheckBox_2.ValueChangedFcn = createCallbackFcn(app, @kConstrainedCheckBox_2ValueChanged, true);
            app.kConstrainedCheckBox_2.Text = 'Constrained by Hc';
            app.kConstrainedCheckBox_2.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.kConstrainedCheckBox_2.Layout.Row = 7;
            app.kConstrainedCheckBox_2.Layout.Column = [11 12];
            app.kConstrainedCheckBox_2.Value = true;

            % Create PlaygroundTab
            app.PlaygroundTab = uitab(app.TabGroup);
            app.PlaygroundTab.Title = 'Playground';

            % Create AxesM_3
            app.AxesM_3 = uiaxes(app.PlaygroundTab);
            xlabel(app.AxesM_3, 'H [A/m]')
            ylabel(app.AxesM_3, 'M [A/m]')
            zlabel(app.AxesM_3, 'Z')
            app.AxesM_3.Box = 'on';
            app.AxesM_3.TickDir = 'in';
            app.AxesM_3.Position = [8 40 480 472];

            % Create AxesM_4
            app.AxesM_4 = uiaxes(app.PlaygroundTab);
            xlabel(app.AxesM_4, 'index')
            ylabel(app.AxesM_4, 'H (index) [A/m]')
            zlabel(app.AxesM_4, 'Z')
            app.AxesM_4.Box = 'on';
            app.AxesM_4.TickDir = 'in';
            app.AxesM_4.Position = [505 41 480 179];

            % Create JilesAthertonmodelrateindependentLabel_2
            app.JilesAthertonmodelrateindependentLabel_2 = uilabel(app.PlaygroundTab);
            app.JilesAthertonmodelrateindependentLabel_2.FontWeight = 'bold';
            app.JilesAthertonmodelrateindependentLabel_2.Position = [8 518 942 25];
            app.JilesAthertonmodelrateindependentLabel_2.Text = 'Jiles-Atherton model (rate-independent)';

            % Create ModelparametersLabel_2
            app.ModelparametersLabel_2 = uilabel(app.PlaygroundTab);
            app.ModelparametersLabel_2.FontWeight = 'bold';
            app.ModelparametersLabel_2.Position = [491 489 156 22];
            app.ModelparametersLabel_2.Text = 'Model parameters';

            % Create JsTEditFieldLabel_9
            app.JsTEditFieldLabel_9 = uilabel(app.PlaygroundTab);
            app.JsTEditFieldLabel_9.FontWeight = 'bold';
            app.JsTEditFieldLabel_9.Position = [491 461 62 22];
            app.JsTEditFieldLabel_9.Text = 'Ms [A/m]';

            % Create JsField_9
            app.JsField_9 = uieditfield(app.PlaygroundTab, 'text');
            app.JsField_9.HorizontalAlignment = 'right';
            app.JsField_9.Position = [555 461 91 22];

            % Create JsTEditFieldLabel_10
            app.JsTEditFieldLabel_10 = uilabel(app.PlaygroundTab);
            app.JsTEditFieldLabel_10.FontWeight = 'bold';
            app.JsTEditFieldLabel_10.Position = [491 433 62 22];
            app.JsTEditFieldLabel_10.Text = 'a [A/m]';

            % Create JsField_10
            app.JsField_10 = uieditfield(app.PlaygroundTab, 'text');
            app.JsField_10.HorizontalAlignment = 'right';
            app.JsField_10.Position = [555 433 91 22];

            % Create JsTEditFieldLabel_11
            app.JsTEditFieldLabel_11 = uilabel(app.PlaygroundTab);
            app.JsTEditFieldLabel_11.FontWeight = 'bold';
            app.JsTEditFieldLabel_11.Position = [491 404 62 22];
            app.JsTEditFieldLabel_11.Text = 'alpha';

            % Create JsField_11
            app.JsField_11 = uieditfield(app.PlaygroundTab, 'text');
            app.JsField_11.HorizontalAlignment = 'right';
            app.JsField_11.Position = [555 404 91 22];

            % Create JsTEditFieldLabel_12
            app.JsTEditFieldLabel_12 = uilabel(app.PlaygroundTab);
            app.JsTEditFieldLabel_12.FontWeight = 'bold';
            app.JsTEditFieldLabel_12.Position = [491 376 62 22];
            app.JsTEditFieldLabel_12.Text = 'c';

            % Create JsField_12
            app.JsField_12 = uieditfield(app.PlaygroundTab, 'text');
            app.JsField_12.HorizontalAlignment = 'right';
            app.JsField_12.Position = [555 376 91 22];

            % Create JsTEditFieldLabel_13
            app.JsTEditFieldLabel_13 = uilabel(app.PlaygroundTab);
            app.JsTEditFieldLabel_13.FontWeight = 'bold';
            app.JsTEditFieldLabel_13.Position = [491 348 62 22];
            app.JsTEditFieldLabel_13.Text = 'k [A/m]';

            % Create JsField_13
            app.JsField_13 = uieditfield(app.PlaygroundTab, 'text');
            app.JsField_13.HorizontalAlignment = 'right';
            app.JsField_13.Position = [555 348 91 22];

            % Create CalculatePlotButton_3
            app.CalculatePlotButton_3 = uibutton(app.PlaygroundTab, 'push');
            app.CalculatePlotButton_3.WordWrap = 'on';
            app.CalculatePlotButton_3.Position = [859 4 91 29];
            app.CalculatePlotButton_3.Text = 'Calculate & Plot';

            % Create RetrieveparametersButton
            app.RetrieveparametersButton = uibutton(app.PlaygroundTab, 'push');
            app.RetrieveparametersButton.Position = [613 490 124 23];
            app.RetrieveparametersButton.Text = 'Retrieve parameters';

            % Create DrivingfieldLabel_2
            app.DrivingfieldLabel_2 = uilabel(app.PlaygroundTab);
            app.DrivingfieldLabel_2.FontWeight = 'bold';
            app.DrivingfieldLabel_2.Position = [491 291 459 22];
            app.DrivingfieldLabel_2.Text = 'Driving field';

            % Create ShowgridCheckBoxM_3
            app.ShowgridCheckBoxM_3 = uicheckbox(app.PlaygroundTab);
            app.ShowgridCheckBoxM_3.Text = 'Grid';
            app.ShowgridCheckBoxM_3.Position = [234 4 62 29];
            app.ShowgridCheckBoxM_3.Value = true;

            % Create ShowgridCheckBoxM_4
            app.ShowgridCheckBoxM_4 = uicheckbox(app.PlaygroundTab);
            app.ShowgridCheckBoxM_4.Text = 'Data curve';
            app.ShowgridCheckBoxM_4.Position = [408 4 80 29];
            app.ShowgridCheckBoxM_4.Value = true;

            % Create OutputdataTab
            app.OutputdataTab = uitab(app.TabGroup);
            app.OutputdataTab.Title = 'Output data';
            app.OutputdataTab.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
            app.OutputdataTab.ForegroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];

            % Create GridLayoutMagnetizationoutputdata
            app.GridLayoutMagnetizationoutputdata = uigridlayout(app.OutputdataTab);
            app.GridLayoutMagnetizationoutputdata.ColumnWidth = {'1x'};
            app.GridLayoutMagnetizationoutputdata.RowHeight = {'1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x'};
            app.GridLayoutMagnetizationoutputdata.RowSpacing = 5;
            app.GridLayoutMagnetizationoutputdata.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];

            % Create GridLayoutOutputDatasetPath
            app.GridLayoutOutputDatasetPath = uigridlayout(app.GridLayoutMagnetizationoutputdata);
            app.GridLayoutOutputDatasetPath.ColumnWidth = {'1.1x', '3x', '1x'};
            app.GridLayoutOutputDatasetPath.RowHeight = {'1x'};
            app.GridLayoutOutputDatasetPath.Padding = [0 0 0 0];
            app.GridLayoutOutputDatasetPath.Layout.Row = 1;
            app.GridLayoutOutputDatasetPath.Layout.Column = 1;
            app.GridLayoutOutputDatasetPath.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];

            % Create OutputDatasetpathLabel
            app.OutputDatasetpathLabel = uilabel(app.GridLayoutOutputDatasetPath);
            app.OutputDatasetpathLabel.FontWeight = 'bold';
            app.OutputDatasetpathLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.OutputDatasetpathLabel.Layout.Row = 1;
            app.OutputDatasetpathLabel.Layout.Column = 1;
            app.OutputDatasetpathLabel.Text = 'Dataset path';

            % Create OutputDatasetPath
            app.OutputDatasetPath = uieditfield(app.GridLayoutOutputDatasetPath, 'text');
            app.OutputDatasetPath.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.OutputDatasetPath.Layout.Row = 1;
            app.OutputDatasetPath.Layout.Column = 2;

            % Create OutputBrowseButton
            app.OutputBrowseButton = uibutton(app.GridLayoutOutputDatasetPath, 'push');
            app.OutputBrowseButton.ButtonPushedFcn = createCallbackFcn(app, @OutputBrowseButtonPushed, true);
            app.OutputBrowseButton.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
            app.OutputBrowseButton.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.OutputBrowseButton.Layout.Row = 1;
            app.OutputBrowseButton.Layout.Column = 3;
            app.OutputBrowseButton.Text = 'Browse';

            % Create MagnetizationdataLabel
            app.MagnetizationdataLabel = uilabel(app.GridLayoutMagnetizationoutputdata);
            app.MagnetizationdataLabel.FontWeight = 'bold';
            app.MagnetizationdataLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
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
            app.GridLayoutMagnetizationDataFittedAnhystereticMagnetization.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];

            % Create CheckBoxOutputMagnetizationDataFittedAnhystereticMagnetization
            app.CheckBoxOutputMagnetizationDataFittedAnhystereticMagnetization = uicheckbox(app.GridLayoutMagnetizationDataFittedAnhystereticMagnetization);
            app.CheckBoxOutputMagnetizationDataFittedAnhystereticMagnetization.Text = '';
            app.CheckBoxOutputMagnetizationDataFittedAnhystereticMagnetization.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.CheckBoxOutputMagnetizationDataFittedAnhystereticMagnetization.Layout.Row = 1;
            app.CheckBoxOutputMagnetizationDataFittedAnhystereticMagnetization.Layout.Column = 2;
            app.CheckBoxOutputMagnetizationDataFittedAnhystereticMagnetization.Value = true;

            % Create ModeledanhystereticmagnetizationLabel
            app.ModeledanhystereticmagnetizationLabel = uilabel(app.GridLayoutMagnetizationDataFittedAnhystereticMagnetization);
            app.ModeledanhystereticmagnetizationLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ModeledanhystereticmagnetizationLabel.Layout.Row = 1;
            app.ModeledanhystereticmagnetizationLabel.Layout.Column = 1;
            app.ModeledanhystereticmagnetizationLabel.Text = 'Modeled anhysteretic magnetization';

            % Create EditFieldFileNameModeledAnhystereticMagnetization
            app.EditFieldFileNameModeledAnhystereticMagnetization = uieditfield(app.GridLayoutMagnetizationDataFittedAnhystereticMagnetization, 'text');
            app.EditFieldFileNameModeledAnhystereticMagnetization.HorizontalAlignment = 'right';
            app.EditFieldFileNameModeledAnhystereticMagnetization.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.EditFieldFileNameModeledAnhystereticMagnetization.Layout.Row = 1;
            app.EditFieldFileNameModeledAnhystereticMagnetization.Layout.Column = 3;
            app.EditFieldFileNameModeledAnhystereticMagnetization.Value = 'modeled_anhysteretic_magnetization';

            % Create DropDownOutputModeledAnhystereticMagnetizationExtension
            app.DropDownOutputModeledAnhystereticMagnetizationExtension = uidropdown(app.GridLayoutMagnetizationDataFittedAnhystereticMagnetization);
            app.DropDownOutputModeledAnhystereticMagnetizationExtension.Items = {'.csv'};
            app.DropDownOutputModeledAnhystereticMagnetizationExtension.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.DropDownOutputModeledAnhystereticMagnetizationExtension.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
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
            app.GridLayoutExportData.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];

            % Create ExportdataButton
            app.ExportdataButton = uibutton(app.GridLayoutExportData, 'push');
            app.ExportdataButton.ButtonPushedFcn = createCallbackFcn(app, @ExportdataButtonPushed, true);
            app.ExportdataButton.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
            app.ExportdataButton.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ExportdataButton.Layout.Row = 1;
            app.ExportdataButton.Layout.Column = 4;
            app.ExportdataButton.Text = 'Export data';

            % Create OutputSeparateComponentsCheckBox
            app.OutputSeparateComponentsCheckBox = uicheckbox(app.GridLayoutExportData);
            app.OutputSeparateComponentsCheckBox.Text = '';
            app.OutputSeparateComponentsCheckBox.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.OutputSeparateComponentsCheckBox.Layout.Row = 1;
            app.OutputSeparateComponentsCheckBox.Layout.Column = 2;
            app.OutputSeparateComponentsCheckBox.Value = true;

            % Create ModeledanhystereticmagnetizationcomponentsLabel
            app.ModeledanhystereticmagnetizationcomponentsLabel = uilabel(app.GridLayoutExportData);
            app.ModeledanhystereticmagnetizationcomponentsLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ModeledanhystereticmagnetizationcomponentsLabel.Layout.Row = 1;
            app.ModeledanhystereticmagnetizationcomponentsLabel.Layout.Column = 1;
            app.ModeledanhystereticmagnetizationcomponentsLabel.Text = 'Modeled anhysteretic magnetization components';

            % Create ParametersLabel
            app.ParametersLabel = uilabel(app.GridLayoutMagnetizationoutputdata);
            app.ParametersLabel.FontWeight = 'bold';
            app.ParametersLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
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
            app.GridLayoutExportParametersFile.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];

            % Create EditFieldFileNameParameters
            app.EditFieldFileNameParameters = uieditfield(app.GridLayoutExportParametersFile, 'text');
            app.EditFieldFileNameParameters.HorizontalAlignment = 'right';
            app.EditFieldFileNameParameters.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.EditFieldFileNameParameters.Layout.Row = 1;
            app.EditFieldFileNameParameters.Layout.Column = 3;
            app.EditFieldFileNameParameters.Value = 'parameters';

            % Create DropDownOutputParametersExtension
            app.DropDownOutputParametersExtension = uidropdown(app.GridLayoutExportParametersFile);
            app.DropDownOutputParametersExtension.Items = {'.txt'};
            app.DropDownOutputParametersExtension.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.DropDownOutputParametersExtension.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
            app.DropDownOutputParametersExtension.Layout.Row = 1;
            app.DropDownOutputParametersExtension.Layout.Column = 4;
            app.DropDownOutputParametersExtension.Value = '.txt';

            % Create ExportFittedparametersCheckBox
            app.ExportFittedparametersCheckBox = uicheckbox(app.GridLayoutExportParametersFile);
            app.ExportFittedparametersCheckBox.Text = 'Fitted parameters';
            app.ExportFittedparametersCheckBox.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ExportFittedparametersCheckBox.Layout.Row = 1;
            app.ExportFittedparametersCheckBox.Layout.Column = 1;
            app.ExportFittedparametersCheckBox.Value = true;

            % Create ExportModelparametersCheckBox
            app.ExportModelparametersCheckBox = uicheckbox(app.GridLayoutExportParametersFile);
            app.ExportModelparametersCheckBox.Text = 'Model parameters';
            app.ExportModelparametersCheckBox.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
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
            app.GridLayoutExportParametersButton.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];

            % Create ExportParametersButton
            app.ExportParametersButton = uibutton(app.GridLayoutExportParametersButton, 'push');
            app.ExportParametersButton.ButtonPushedFcn = createCallbackFcn(app, @ExportParametersButtonPushed, true);
            app.ExportParametersButton.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
            app.ExportParametersButton.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ExportParametersButton.Layout.Row = 1;
            app.ExportParametersButton.Layout.Column = 4;
            app.ExportParametersButton.Text = 'Export data';

            % Create ExportOtherquantitiesCheckBox
            app.ExportOtherquantitiesCheckBox = uicheckbox(app.GridLayoutExportParametersButton);
            app.ExportOtherquantitiesCheckBox.Text = 'Other quantities';
            app.ExportOtherquantitiesCheckBox.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ExportOtherquantitiesCheckBox.Layout.Row = 1;
            app.ExportOtherquantitiesCheckBox.Layout.Column = 1;
            app.ExportOtherquantitiesCheckBox.Value = true;

            % Create ExportErrorsCheckBox
            app.ExportErrorsCheckBox = uicheckbox(app.GridLayoutExportParametersButton);
            app.ExportErrorsCheckBox.Text = 'Errors';
            app.ExportErrorsCheckBox.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ExportErrorsCheckBox.Layout.Row = 1;
            app.ExportErrorsCheckBox.Layout.Column = 2;
            app.ExportErrorsCheckBox.Value = true;

            % Create PlotsLabel
            app.PlotsLabel = uilabel(app.GridLayoutMagnetizationoutputdata);
            app.PlotsLabel.FontWeight = 'bold';
            app.PlotsLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
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
            app.GridLayoutExportPlotMagnetization.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];

            % Create MagnetizationPlotExportLabel
            app.MagnetizationPlotExportLabel = uilabel(app.GridLayoutExportPlotMagnetization);
            app.MagnetizationPlotExportLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.MagnetizationPlotExportLabel.Layout.Row = 1;
            app.MagnetizationPlotExportLabel.Layout.Column = 1;
            app.MagnetizationPlotExportLabel.Text = 'Magnetization';

            % Create CheckBoxExportPlotMagnetization
            app.CheckBoxExportPlotMagnetization = uicheckbox(app.GridLayoutExportPlotMagnetization);
            app.CheckBoxExportPlotMagnetization.Text = '';
            app.CheckBoxExportPlotMagnetization.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.CheckBoxExportPlotMagnetization.Layout.Row = 1;
            app.CheckBoxExportPlotMagnetization.Layout.Column = 2;
            app.CheckBoxExportPlotMagnetization.Value = true;

            % Create EditFieldFileNamePlotMagnetization
            app.EditFieldFileNamePlotMagnetization = uieditfield(app.GridLayoutExportPlotMagnetization, 'text');
            app.EditFieldFileNamePlotMagnetization.HorizontalAlignment = 'right';
            app.EditFieldFileNamePlotMagnetization.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.EditFieldFileNamePlotMagnetization.Layout.Row = 1;
            app.EditFieldFileNamePlotMagnetization.Layout.Column = 3;
            app.EditFieldFileNamePlotMagnetization.Value = 'M';

            % Create DropDownPlotMagnetizacionExtension
            app.DropDownPlotMagnetizacionExtension = uidropdown(app.GridLayoutExportPlotMagnetization);
            app.DropDownPlotMagnetizacionExtension.Items = {'.png'};
            app.DropDownPlotMagnetizacionExtension.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.DropDownPlotMagnetizacionExtension.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
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
            app.GridLayoutExportPlotSusceptibility.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];

            % Create SusceptibilityPlotExportLabel
            app.SusceptibilityPlotExportLabel = uilabel(app.GridLayoutExportPlotSusceptibility);
            app.SusceptibilityPlotExportLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.SusceptibilityPlotExportLabel.Layout.Row = 1;
            app.SusceptibilityPlotExportLabel.Layout.Column = 1;
            app.SusceptibilityPlotExportLabel.Text = 'Susceptibility';

            % Create CheckBoxExportPlotSusceptibility
            app.CheckBoxExportPlotSusceptibility = uicheckbox(app.GridLayoutExportPlotSusceptibility);
            app.CheckBoxExportPlotSusceptibility.Text = '';
            app.CheckBoxExportPlotSusceptibility.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.CheckBoxExportPlotSusceptibility.Layout.Row = 1;
            app.CheckBoxExportPlotSusceptibility.Layout.Column = 2;
            app.CheckBoxExportPlotSusceptibility.Value = true;

            % Create EditFieldFileNamePlotSusceptibility
            app.EditFieldFileNamePlotSusceptibility = uieditfield(app.GridLayoutExportPlotSusceptibility, 'text');
            app.EditFieldFileNamePlotSusceptibility.HorizontalAlignment = 'right';
            app.EditFieldFileNamePlotSusceptibility.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.EditFieldFileNamePlotSusceptibility.Layout.Row = 1;
            app.EditFieldFileNamePlotSusceptibility.Layout.Column = 3;
            app.EditFieldFileNamePlotSusceptibility.Value = 'dMdH';

            % Create DropDownPlotSusceptibilityExtension
            app.DropDownPlotSusceptibilityExtension = uidropdown(app.GridLayoutExportPlotSusceptibility);
            app.DropDownPlotSusceptibilityExtension.Items = {'.png'};
            app.DropDownPlotSusceptibilityExtension.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.DropDownPlotSusceptibilityExtension.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
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
            app.GridLayoutExportPlotSemiLogMagDerivative.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];

            % Create SemilogmagnetizationderivativePlotExportLabel
            app.SemilogmagnetizationderivativePlotExportLabel = uilabel(app.GridLayoutExportPlotSemiLogMagDerivative);
            app.SemilogmagnetizationderivativePlotExportLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.SemilogmagnetizationderivativePlotExportLabel.Layout.Row = 1;
            app.SemilogmagnetizationderivativePlotExportLabel.Layout.Column = 1;
            app.SemilogmagnetizationderivativePlotExportLabel.Text = 'Semi-log magnetization derivative';

            % Create CheckBoxExportPlotSemiLogMagDerivative
            app.CheckBoxExportPlotSemiLogMagDerivative = uicheckbox(app.GridLayoutExportPlotSemiLogMagDerivative);
            app.CheckBoxExportPlotSemiLogMagDerivative.Text = '';
            app.CheckBoxExportPlotSemiLogMagDerivative.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.CheckBoxExportPlotSemiLogMagDerivative.Layout.Row = 1;
            app.CheckBoxExportPlotSemiLogMagDerivative.Layout.Column = 2;
            app.CheckBoxExportPlotSemiLogMagDerivative.Value = true;

            % Create EditFieldFileNamePlotSemiLogMagDerivative
            app.EditFieldFileNamePlotSemiLogMagDerivative = uieditfield(app.GridLayoutExportPlotSemiLogMagDerivative, 'text');
            app.EditFieldFileNamePlotSemiLogMagDerivative.HorizontalAlignment = 'right';
            app.EditFieldFileNamePlotSemiLogMagDerivative.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.EditFieldFileNamePlotSemiLogMagDerivative.Layout.Row = 1;
            app.EditFieldFileNamePlotSemiLogMagDerivative.Layout.Column = 3;
            app.EditFieldFileNamePlotSemiLogMagDerivative.Value = 'dMdlnH';

            % Create DropDownPlotSemiLogMagDerivativeExtension
            app.DropDownPlotSemiLogMagDerivativeExtension = uidropdown(app.GridLayoutExportPlotSemiLogMagDerivative);
            app.DropDownPlotSemiLogMagDerivativeExtension.Items = {'.png'};
            app.DropDownPlotSemiLogMagDerivativeExtension.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.DropDownPlotSemiLogMagDerivativeExtension.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
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
            app.GridLayoutExportPlotsButton.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];

            % Create ExportPlotsButton
            app.ExportPlotsButton = uibutton(app.GridLayoutExportPlotsButton, 'push');
            app.ExportPlotsButton.ButtonPushedFcn = createCallbackFcn(app, @ExportPlotsButtonPushed, true);
            app.ExportPlotsButton.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
            app.ExportPlotsButton.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
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
            app.GridLayoutExportResiduesMagnetization.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];

            % Create MagnetizationExportResiduesLabel
            app.MagnetizationExportResiduesLabel = uilabel(app.GridLayoutExportResiduesMagnetization);
            app.MagnetizationExportResiduesLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.MagnetizationExportResiduesLabel.Layout.Row = 1;
            app.MagnetizationExportResiduesLabel.Layout.Column = 1;
            app.MagnetizationExportResiduesLabel.Text = 'Magnetization';

            % Create CheckBoxExportResiduesMagnetization
            app.CheckBoxExportResiduesMagnetization = uicheckbox(app.GridLayoutExportResiduesMagnetization);
            app.CheckBoxExportResiduesMagnetization.Text = '';
            app.CheckBoxExportResiduesMagnetization.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.CheckBoxExportResiduesMagnetization.Layout.Row = 1;
            app.CheckBoxExportResiduesMagnetization.Layout.Column = 2;
            app.CheckBoxExportResiduesMagnetization.Value = true;

            % Create EditFieldFileNameResiduesMagnetization
            app.EditFieldFileNameResiduesMagnetization = uieditfield(app.GridLayoutExportResiduesMagnetization, 'text');
            app.EditFieldFileNameResiduesMagnetization.HorizontalAlignment = 'right';
            app.EditFieldFileNameResiduesMagnetization.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.EditFieldFileNameResiduesMagnetization.Layout.Row = 1;
            app.EditFieldFileNameResiduesMagnetization.Layout.Column = 3;
            app.EditFieldFileNameResiduesMagnetization.Value = 'residual_M';

            % Create DropDownResiduesMagnetizacionExtension
            app.DropDownResiduesMagnetizacionExtension = uidropdown(app.GridLayoutExportResiduesMagnetization);
            app.DropDownResiduesMagnetizacionExtension.Items = {'.csv'};
            app.DropDownResiduesMagnetizacionExtension.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.DropDownResiduesMagnetizacionExtension.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
            app.DropDownResiduesMagnetizacionExtension.Layout.Row = 1;
            app.DropDownResiduesMagnetizacionExtension.Layout.Column = 4;
            app.DropDownResiduesMagnetizacionExtension.Value = '.csv';

            % Create ResidualplotsdataLabel
            app.ResidualplotsdataLabel = uilabel(app.GridLayoutMagnetizationoutputdata);
            app.ResidualplotsdataLabel.FontWeight = 'bold';
            app.ResidualplotsdataLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
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
            app.GridLayoutExportResiduesSusceptibility.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];

            % Create SusceptibilityResiduesExportLabel
            app.SusceptibilityResiduesExportLabel = uilabel(app.GridLayoutExportResiduesSusceptibility);
            app.SusceptibilityResiduesExportLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.SusceptibilityResiduesExportLabel.Layout.Row = 1;
            app.SusceptibilityResiduesExportLabel.Layout.Column = 1;
            app.SusceptibilityResiduesExportLabel.Text = 'Susceptibility';

            % Create CheckBoxExportResiduesSusceptibility
            app.CheckBoxExportResiduesSusceptibility = uicheckbox(app.GridLayoutExportResiduesSusceptibility);
            app.CheckBoxExportResiduesSusceptibility.Text = '';
            app.CheckBoxExportResiduesSusceptibility.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.CheckBoxExportResiduesSusceptibility.Layout.Row = 1;
            app.CheckBoxExportResiduesSusceptibility.Layout.Column = 2;
            app.CheckBoxExportResiduesSusceptibility.Value = true;

            % Create EditFieldFileNameResiduesSusceptibility
            app.EditFieldFileNameResiduesSusceptibility = uieditfield(app.GridLayoutExportResiduesSusceptibility, 'text');
            app.EditFieldFileNameResiduesSusceptibility.HorizontalAlignment = 'right';
            app.EditFieldFileNameResiduesSusceptibility.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.EditFieldFileNameResiduesSusceptibility.Layout.Row = 1;
            app.EditFieldFileNameResiduesSusceptibility.Layout.Column = 3;
            app.EditFieldFileNameResiduesSusceptibility.Value = 'residual_dMdH';

            % Create DropDownResiduesSusceptibilityExtension
            app.DropDownResiduesSusceptibilityExtension = uidropdown(app.GridLayoutExportResiduesSusceptibility);
            app.DropDownResiduesSusceptibilityExtension.Items = {'.csv'};
            app.DropDownResiduesSusceptibilityExtension.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.DropDownResiduesSusceptibilityExtension.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
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
            app.GridLayoutExportResiduesSemiLogMagDerivative.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];

            % Create SemilogmagnetizationderivativeResiduesExportLabel
            app.SemilogmagnetizationderivativeResiduesExportLabel = uilabel(app.GridLayoutExportResiduesSemiLogMagDerivative);
            app.SemilogmagnetizationderivativeResiduesExportLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.SemilogmagnetizationderivativeResiduesExportLabel.Layout.Row = 1;
            app.SemilogmagnetizationderivativeResiduesExportLabel.Layout.Column = 1;
            app.SemilogmagnetizationderivativeResiduesExportLabel.Text = 'Semi-log magnetization derivative';

            % Create CheckBoxExportResiduesSemiLogMagDerivative
            app.CheckBoxExportResiduesSemiLogMagDerivative = uicheckbox(app.GridLayoutExportResiduesSemiLogMagDerivative);
            app.CheckBoxExportResiduesSemiLogMagDerivative.Text = '';
            app.CheckBoxExportResiduesSemiLogMagDerivative.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.CheckBoxExportResiduesSemiLogMagDerivative.Layout.Row = 1;
            app.CheckBoxExportResiduesSemiLogMagDerivative.Layout.Column = 2;
            app.CheckBoxExportResiduesSemiLogMagDerivative.Value = true;

            % Create EditFieldFileNameResiduesSemiLogMagDerivative
            app.EditFieldFileNameResiduesSemiLogMagDerivative = uieditfield(app.GridLayoutExportResiduesSemiLogMagDerivative, 'text');
            app.EditFieldFileNameResiduesSemiLogMagDerivative.HorizontalAlignment = 'right';
            app.EditFieldFileNameResiduesSemiLogMagDerivative.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.EditFieldFileNameResiduesSemiLogMagDerivative.Layout.Row = 1;
            app.EditFieldFileNameResiduesSemiLogMagDerivative.Layout.Column = 3;
            app.EditFieldFileNameResiduesSemiLogMagDerivative.Value = 'residual_dMdlnH';

            % Create DropDownResiduesSemiLogMagDerivativeExtension
            app.DropDownResiduesSemiLogMagDerivativeExtension = uidropdown(app.GridLayoutExportResiduesSemiLogMagDerivative);
            app.DropDownResiduesSemiLogMagDerivativeExtension.Items = {'.csv'};
            app.DropDownResiduesSemiLogMagDerivativeExtension.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.DropDownResiduesSemiLogMagDerivativeExtension.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
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
            app.GridLayoutExportResiduesButton.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];

            % Create ExportResiduesButton
            app.ExportResiduesButton = uibutton(app.GridLayoutExportResiduesButton, 'push');
            app.ExportResiduesButton.ButtonPushedFcn = createCallbackFcn(app, @ExportResiduesButtonPushed, true);
            app.ExportResiduesButton.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
            app.ExportResiduesButton.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
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
            app.GridLayoutExperimentalMagnetizationData.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];

            % Create CheckBoxExperimentalMagnetization
            app.CheckBoxExperimentalMagnetization = uicheckbox(app.GridLayoutExperimentalMagnetizationData);
            app.CheckBoxExperimentalMagnetization.Text = '';
            app.CheckBoxExperimentalMagnetization.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.CheckBoxExperimentalMagnetization.Layout.Row = 1;
            app.CheckBoxExperimentalMagnetization.Layout.Column = 2;
            app.CheckBoxExperimentalMagnetization.Value = true;

            % Create ExperimentalanhystereticmagnetizationLabel
            app.ExperimentalanhystereticmagnetizationLabel = uilabel(app.GridLayoutExperimentalMagnetizationData);
            app.ExperimentalanhystereticmagnetizationLabel.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.ExperimentalanhystereticmagnetizationLabel.Layout.Row = 1;
            app.ExperimentalanhystereticmagnetizationLabel.Layout.Column = 1;
            app.ExperimentalanhystereticmagnetizationLabel.Text = 'Experimental anhysteretic magnetization';

            % Create EditFieldFileNameExperimentalMagnetizationData
            app.EditFieldFileNameExperimentalMagnetizationData = uieditfield(app.GridLayoutExperimentalMagnetizationData, 'text');
            app.EditFieldFileNameExperimentalMagnetizationData.HorizontalAlignment = 'right';
            app.EditFieldFileNameExperimentalMagnetizationData.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.EditFieldFileNameExperimentalMagnetizationData.Layout.Row = 1;
            app.EditFieldFileNameExperimentalMagnetizationData.Layout.Column = 3;
            app.EditFieldFileNameExperimentalMagnetizationData.Value = 'experimental_anhysteretic_magnetization';

            % Create DropDownOutputExperimentalMagnetizationData
            app.DropDownOutputExperimentalMagnetizationData = uidropdown(app.GridLayoutExperimentalMagnetizationData);
            app.DropDownOutputExperimentalMagnetizationData.Items = {'.csv'};
            app.DropDownOutputExperimentalMagnetizationData.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.DropDownOutputExperimentalMagnetizationData.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
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
            app.MessagesTab.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];
            app.MessagesTab.ForegroundColor = [0.129411764705882 0.129411764705882 0.129411764705882];

            % Create MessagesGridLayout
            app.MessagesGridLayout = uigridlayout(app.MessagesTab);
            app.MessagesGridLayout.ColumnWidth = {'1x'};
            app.MessagesGridLayout.RowHeight = {'1x'};
            app.MessagesGridLayout.BackgroundColor = [0.96078431372549 0.96078431372549 0.96078431372549];

            % Create MessagesTextArea
            app.MessagesTextArea = uitextarea(app.MessagesGridLayout);
            app.MessagesTextArea.Editable = 'off';
            app.MessagesTextArea.FontColor = [0.129411764705882 0.129411764705882 0.129411764705882];
            app.MessagesTextArea.Layout.Row = 1;
            app.MessagesTextArea.Layout.Column = 1;

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