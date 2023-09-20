classdef app < matlab.apps.AppBase

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
        MagnetizationinputdataTab       matlab.ui.container.Tab
        GridLayoutMagnetizationInputData  matlab.ui.container.GridLayout
        GridLayoutInputPlot             matlab.ui.container.GridLayout
        GridLayoutInputPlots            matlab.ui.container.GridLayout
        AxesRawInputData                matlab.ui.control.UIAxes
        AxesProcessedInputData          matlab.ui.control.UIAxes
        GridLayoutInputTipsAndPlotButton  matlab.ui.container.GridLayout
        GridLayoutInputPlotButton       matlab.ui.container.GridLayout
        GridLayoutTips                  matlab.ui.container.GridLayout
        MTipField                       matlab.ui.control.EditField
        MtipAmLabel                     matlab.ui.control.Label
        HTipField                       matlab.ui.control.EditField
        HtipAmLabel                     matlab.ui.control.Label
        GridLayoutInputPlotLog          matlab.ui.container.GridLayout
        logCheckBoxInputPlot            matlab.ui.control.CheckBox
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
        AnhystereticmagnetizationfittingTab  matlab.ui.container.Tab
        AnhystereticmagnetizationfittingTabGridLayout  matlab.ui.container.GridLayout
        GridLayoutNumbers               matlab.ui.container.GridLayout
        FittedparametersLabel           matlab.ui.control.Label
        GridLayoutModeledCurve          matlab.ui.container.GridLayout
        PointSpaceDropDown              matlab.ui.control.DropDown
        NumberofpointsEditField         matlab.ui.control.NumericEditField
        NumberofpointsEditFieldLabel    matlab.ui.control.Label
        NumberofcomponentsSpinner       matlab.ui.control.Spinner
        NumberofcomponentsSpinnerLabel  matlab.ui.control.Label
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
        ShowgridCheckBoxHdMdH           matlab.ui.control.CheckBox
        PlotcomponentsCheckBoxHdMdH     matlab.ui.control.CheckBox
        ResidualplotButtondHdMdH        matlab.ui.control.Button
        logCheckBoxHdMdH                matlab.ui.control.CheckBox
        GridLayoutOptionsdMdH           matlab.ui.container.GridLayout
        ShowgridCheckBoxdMdH            matlab.ui.control.CheckBox
        PlotcomponentsCheckBoxdMdH      matlab.ui.control.CheckBox
        ResidualplotButtondMdH          matlab.ui.control.Button
        logCheckBoxdMdH                 matlab.ui.control.CheckBox
        GridLayoutOptionsM              matlab.ui.container.GridLayout
        SetColorsButton                 matlab.ui.control.Button
        ShowgridCheckBoxM               matlab.ui.control.CheckBox
        PlotcomponentsCheckBoxM         matlab.ui.control.CheckBox
        ResidualplotButtonM             matlab.ui.control.Button
        logCheckBoxM                    matlab.ui.control.CheckBox
        AxesM                           matlab.ui.control.UIAxes
        AxesdMdH                        matlab.ui.control.UIAxes
        AxesHdMdH                       matlab.ui.control.UIAxes
        MagnetizationoutputdataTab      matlab.ui.container.Tab
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
        H_raw
        M_raw
        H
        M
        dMdH
        HdMdH
        Hhat
        Mhat
        Mihat
        dMdHhat
        dMidHhat
        HdMdHhat
        HdMidHhat
        Hcr
        mcr
        Hx
        a
        alphaMs
        Ms
        Js
        murin
        alpha
        dimensionless_alphaMs
        Hk
        density_product
        initial_relative_magnetic_permeability
        number_components
        lb
        ub
        select_fit
        Colors
        ColorDialogApp
        ProjectPath
    end
    
    methods (Access = private)
        
        function plot(app)
            app.plot_M();
            app.plot_dMdH();
            app.plot_HdMdH();

            app.init_parameters_table(false);
            app.init_quantities_table(false);

            offset = (3*app.number_components - 1);
            for i = 1:app.number_components
                app.TableFittedParameters.Data(offset + 1 + (i-1)*2) = {app.format_short(app.Hcr(i))};
                app.TableFittedParameters.Data(offset + 2 + (i-1)*2) = {app.format_short(app.mcr(i))};
            end
            for i = 1:(app.number_components-1)
                app.TableFittedParameters.Data(offset + i + 2*app.number_components) = {app.format_short(app.Hx(i))};
            end
            for i = 1:offset
                app.TableFittedParameters.Data(2*offset + i) = {app.format_short(str2double(app.TableFittedParameters.Data(2*offset + i)))};
                app.TableFittedParameters.Data(3*offset + i) = {app.format_short(str2double(app.TableFittedParameters.Data(3*offset + i)))};
            end
            app.JsField.Value = app.format_short(app.Js);
            app.murinField.Value = app.format_engineering(app.murin);
            e = ErrorCalculator().get_error(log(app.H), app.M, log(app.Hhat), app.Mhat, app.ErrortominimizeDropDown.Value);
            app.ErrorDisplay.Value = app.format_engineering(e);
        end

        function calculate_parameters(app)
            N = app.NumberofpointsEditField.Value;

            utils = Utils();

            app.dMdH = transpose(gradient(app.M(:)) ./ gradient(app.H(:)));

            app.HdMdH = app.H.*app.dMdH;

            [HTip, ~] = utils.find_tip(app.H, app.M);

            magnetic_parameters = MagneticParameters(app.H, app.M, app.Hcr, app.mcr, app.Hx);
            select_a = app.TableParameters.Data{1:app.number_components,5};
            app.a = magnetic_parameters.get_a(select_a);
            app.alphaMs = magnetic_parameters.get_alphaMs(app.a);
            app.Ms = magnetic_parameters.get_Ms(app.a, app.alphaMs);
            app.alpha = magnetic_parameters.get_alpha(app.alphaMs, app.Ms);
            app.dimensionless_alphaMs = magnetic_parameters.get_dimensionless_alphaMs(app.alpha, app.Ms, app.a);
            app.Hk = magnetic_parameters.get_Hk(app.alphaMs, app.a);
            app.Js = magnetic_parameters.get_Js(app.Ms);
            app.density_product = magnetic_parameters.get_density_product(app.Ms, app.a);
            app.initial_relative_magnetic_permeability = magnetic_parameters.get_initial_relative_magnetic_permeability(app.Ms, app.Hk);
            app.murin = magnetic_parameters.get_murin(app.initial_relative_magnetic_permeability);
            if(app.PointSpaceDropDown.Value == "log")
                app.Hhat = logspace(log10(app.H(2)),log10(HTip),N);
            elseif(app.PointSpaceDropDown.Value == "linear")
                app.Hhat = linspace(app.H(2),HTip,N);
            end
            
            [app.Mhat, app.Mihat] = get_Mhat(app.Hhat, app.a, app.alphaMs, app.Ms);
            [app.dMdHhat, app.dMidHhat] = get_dMdHhat(app.Hhat, app.alpha, app.Ms, app.a, app.alphaMs);
            [app.HdMdHhat, app.HdMidHhat] = get_HdMdHhat(app.Hhat, app.dMidHhat);
        end
        
        function fit_parameters(app)
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
                [app.Hcr, app.mcr, app.Hx] = fit(app.H, app.M, cat(2, app.Hcr, app.mcr, app.Hx), select_a, app.ErrortominimizeDropDown.Value, fit_lb, fit_ub, fit_select_fit);
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
            offset = (3*app.number_components - 1);
            for i = 1:app.number_components
                app.Hcr(i) = str2double(app.TableFittedParameters.Data(offset + 1 + (i-1)*2));
                app.mcr(i) = str2double(app.TableFittedParameters.Data(offset + 2 + (i-1)*2));
            end
            for i = 1:(app.number_components-1)
                app.Hx(i) = str2double(app.TableFittedParameters.Data(offset + i + 2*app.number_components));
            end
            if (app.number_components == 1)
                app.Hx = [];
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
            for i = 1:app.number_components
                s = 'Hcr' + string(char(8320 + i));
                row_names(2*i - 1,:) = {convertStringsToChars(s + ' [A/m]')};
                component_values(2*i-1) = 0.01*i;
                s = 'm' + string(char(8320 + i)) + ' (' + s + ')';
                row_names(2*i,:) = {convertStringsToChars(s)};
                component_values(2*i) = 0.5;
                lb_col(2*i-1) = 0;
                lb_col(2*i) = 0.4496;
                ub_col(2*i-1) = 1000000;
                ub_col(2*i) = 1;
            end

            for i = 1:(app.number_components-1)
                s = 'Hx' + string(char(8320 + i)) + ' [A/m]';
                row_names(i + 2*app.number_components,:) = {convertStringsToChars(s)};
                component_values(i + 2*app.number_components) = i*0.015;
                lb_col(i + 2*app.number_components) = 0;
                ub_col(i + 2*app.number_components) = 1000000;
            end
            component_values = arrayfun(@(x) {app.format_short(x)}, component_values);
            lb_col = arrayfun(@(x) {app.format_short(x)}, lb_col);
            ub_col = arrayfun(@(x) {app.format_short(x)}, ub_col);
            app.select_fit = cell(row_count, 1);
            app.select_fit(:) = {true};
            t = table(row_names, component_values, lb_col, ub_col, app.select_fit);
            app.TableFittedParameters.Data = table2cell(t);

            app.init_parameters_table(true);
            app.init_quantities_table(true);
        end

        
        function plot_input(app)
            [HTip, MTip] = Utils().find_tip(app.H, app.M);
            app.MTipField.Value = app.format_short(MTip);
            app.HTipField.Value = app.format_short(HTip);

            cla(app.AxesProcessedInputData, 'reset')
            cla(app.AxesRawInputData, 'reset')
            plotter = Plotter([], [], [], [], [], [], [], [], [], [], [], [], app.Colors, 5);

            if(app.logCheckBoxInputPlot.Value == 0)
                plotter.plot_raw(app.AxesProcessedInputData, app.H, app.M, 'H [A/m]', 'M [A/m]', 'Processed input data');
                plotter.plot_raw(app.AxesRawInputData, app.H_raw, app.M_raw, app.HorizontalaxisfieldDropDown.Value, app.VerticalaxisfieldDropDown.Value, 'Raw input data');
            else
                plotter.plot_raw_log(app.AxesProcessedInputData, app.H, app.M, 'H [A/m]', 'M [A/m]', 'Processed input data');
                plotter.plot_raw_log(app.AxesRawInputData, app.H_raw, app.M_raw, app.HorizontalaxisfieldDropDown.Value, app.VerticalaxisfieldDropDown.Value, 'Raw input data');
            end
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
                    Ms_col(i,:) = {app.format_short(app.Ms(i))};
                    alpha_col(i,:) = {app.format_engineering(app.alpha(i))};
                    a_col(i,:) = {app.format_short(app.a(i))};
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
                    dimensionless_alphaMs_col(i,:) = {app.format_short(app.dimensionless_alphaMs(i))};
                    density_product_col(i,:) = {app.format_short(app.density_product(i))};
                    Hk_col(i,:) = {app.format_short(app.Hk(i))};
                    initial_relative_magnetic_permeability_col(i,:) = {app.format_thousands_only(app.initial_relative_magnetic_permeability(i))};
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
        
        function ret = format_engineering(~, v)
            ret = char(sprintf("%0.4e",v));
        end

        function ret = format_thousands_only(~, v)
            string_value = char(sprintf("%d",round(v)));
            ret = fliplr(regexprep(fliplr(string_value),'\d{3}(?=\d)', '$0,'));
        end
        
        function plot_M(app)
            plotter = Plotter(app.H, app.M, app.dMdH, app.HdMdH, app.Hhat, app.Mhat, app.Mihat, app.dMdHhat, app.dMidHhat, app.HdMdHhat, app.HdMidHhat, app.Hcr, app.Colors);
            cla(app.AxesM,'reset');
            plot_components = app.PlotcomponentsCheckBoxM.Value == 1;
            show_grid = app.ShowgridCheckBoxM.Value == 1;
            if(app.logCheckBoxM.Value == 0)
                plotter.plot_M(app.AxesM, plot_components, show_grid);
            else
                plotter.plot_M_log(app.AxesM, plot_components, show_grid);
            end
        end
        
        function plot_dMdH(app)
            plotter = Plotter(app.H, app.M, app.dMdH, app.HdMdH, app.Hhat, app.Mhat, app.Mihat, app.dMdHhat, app.dMidHhat, app.HdMdHhat, app.HdMidHhat, app.Hcr, app.Colors);
            cla(app.AxesdMdH,'reset');
            plot_components = app.PlotcomponentsCheckBoxdMdH.Value == 1;
            show_grid = app.ShowgridCheckBoxdMdH.Value == 1;
            if(app.logCheckBoxdMdH.Value == 0)
                plotter.plot_dMdH(app.AxesdMdH, plot_components, show_grid);
            else
                plotter.plot_dMdH_log(app.AxesdMdH, plot_components, show_grid);
            end
        end
        
        function plot_HdMdH(app)
            plotter = Plotter(app.H, app.M, app.dMdH, app.HdMdH, app.Hhat, app.Mhat, app.Mihat, app.dMdHhat, app.dMidHhat, app.HdMdHhat, app.HdMidHhat, app.Hcr, app.Colors);
            cla(app.AxesHdMdH,'reset');
            plot_components = app.PlotcomponentsCheckBoxHdMdH.Value == 1;
            show_grid = app.ShowgridCheckBoxHdMdH.Value == 1;
            if(app.logCheckBoxHdMdH.Value == 0)
                plotter.plot_HdMdH(app.AxesHdMdH, plot_components, show_grid);
            else
                plotter.plot_HdMdH_log(app.AxesHdMdH, plot_components, show_grid);
            end
        end
        
        function results = get_time_string(~)
            results = string(datetime(datetime, 'Format', 'yy/MM/dd HH:mm:ss'));
        end
        
        function write_message(app, message)
            msg = sprintf("[%s] %s", app.get_time_string(), message);
            app.MessagesTextArea.Value(end+1) = cellstr(msg);
        end
        
        function import_data(app, path)
            H_unit = app.HorizontalaxisfieldDropDown.Value;
            M_unit = app.VerticalaxisfieldDropDown.Value;
            unit_convertor = UnitConvertor();
            curve_convertor = CurveConvertor();
            [app.H_raw, app.M_raw] = Parser(path).get_data_csv;
            
            [X, Y] = unit_convertor.convert_H_M(app.H_raw, H_unit, app.M_raw, M_unit);
            [app.H, app.M] = curve_convertor.convert_curve(X,Y,app.CurveDropDown.Value);
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
            
            t = table(transpose(app.H(2:end-1)), transpose(residue));
            t.Properties.VariableNames(:) = {'H [A/m]' 'residue'};
                
            path = strcat(app.OutputDatasetPath.Value, '\', file_name);
            writetable(t,path, 'Delimiter', ';');
            app.write_message("Data saved as " + file_name);
        end
        
        function save(app)
            file = fopen(app.ProjectPath,'w');

            s.fitted_parameters_value = app.TableFittedParameters.Data(:,2);
            s.fitted_parameters_lower_bound = app.TableFittedParameters.Data(:,3);
            s.fitted_parameters_upper_bound = app.TableFittedParameters.Data(:,4);
            s.number_components = app.number_components;
            s.select_a = app.TableParameters.Data.(5);
            s.number_points = app.NumberofpointsEditField.Value;
            s.point_space = app.PointSpaceDropDown.Value;
            s.error_type = app.ErrortominimizeDropDown.Value;
            s.input_path = app.InputDatasetPath.Value;
            s.horizontal_axis = app.HorizontalaxisfieldDropDown.Value;
            s.vertical_axis = app.VerticalaxisfieldDropDown.Value;
            s.description = app.DescriptionTextArea.Value;
            s.data_set_path = app.OutputDatasetPath.Value;

            s.magnetization_file_name = app.EditFieldFileNameModeledAnhystereticMagnetization.Value;
            s.parameters_file_name = app.EditFieldFileNameParameters.Value;
            s.magnetization_plots_file_name = app.EditFieldFileNamePlotMagnetization.Value;
            s.suceptibility_plots_file_name = app.EditFieldFileNamePlotSusceptibility.Value;
            s.magnetization_derivative_file_name = app.EditFieldFileNamePlotSemiLogMagDerivative.Value;
            s.magnetization_residual_file_name = app.EditFieldFileNameResiduesMagnetization.Value;
            s.susceptibility_residual_file_name = app.EditFieldFileNameResiduesSusceptibility.Value;
            s.semi_log_derivative_file_name = app.EditFieldFileNameResiduesSemiLogMagDerivative.Value;

            s.log_checkbox = app.logCheckBoxInputPlot.Value;

            s.fitting_log_checkbox = app.logCheckBoxHdMdH.Value;
            s.fitting_show_grid_checkbox = app.ShowgridCheckBoxHdMdH.Value;
            s.fitting_plot_components_checkbox = app.PlotcomponentsCheckBoxHdMdH.Value;
            

            s.model_magnetization_checkbox = app.CheckBoxOutputMagnetizationDataFittedAnhystereticMagnetization.Value;
            s.model_magnetization_components_checkbox = app.OutputSeparateComponentsCheckBox.Value;
            s.fitted_parameters_checkbox = app.ExportFittedparametersCheckBox.Value;
            s.model_parameters_checkbox = app.ExportModelparametersCheckBox.Value;
            s.other_quantities_checkbox = app.ExportOtherquantitiesCheckBox.Value;
            s.errors_checkbox = app.ExportErrorsCheckBox.Value;
            s.magnetization_plots_checkbox = app.CheckBoxExportPlotMagnetization.Value;
            s.susceptibility_plots_checkbox = app.CheckBoxExportPlotSusceptibility.Value;
            s.magnetization_derivatives_checkbox = app.CheckBoxExportPlotSemiLogMagDerivative.Value;

            s.magnetization_residual_checkbox = app.CheckBoxExportResiduesMagnetization.Value;
            s.susceptibility_residual_checkbox = app.CheckBoxExportResiduesSusceptibility.Value;
            s.semi_log_derivative_residual_checkbox = app.CheckBoxExportResiduesSemiLogMagDerivative.Value;

            data = jsonencode(s, PrettyPrint=true);
            fprintf(file, "%s", data);
            fclose(file);
            app.write_message("Project saved at " + app.ProjectPath);
        end
    end
    
    methods (Access = public)
        
        function set_colors_and_plot(app, colors)
            app.Colors = colors;
            update_components(app)
            calculate_parameters(app)
            plot(app)
        end

        function calculate_and_plot(app)
            path = app.InputDatasetPath.Value;
            if path == ""
                return
            end
            app.import_data(path);
            update_components(app)
            calculate_parameters(app)
            app.plot_input();
        end
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            app.ProjectPath = "";

            app.number_components = app.NumberofcomponentsSpinner.Value;

            app.init_components();
            app.TableFittedParameters.ColumnFormat = {[] 'short' 'short' 'short' 'logical'};

            app.init_parameters_table(true);
            for i=1:5
                addStyle(app.TableParameters, uistyle('HorizontalAlignment','right'), "column", i)
            end
            
            app.init_quantities_table(true);
            for i=1:5
                addStyle(app.TableQuantities, uistyle('HorizontalAlignment','right'), "column", i)
            end

            update_components(app)
            
            % Each element from the array represents RGB on scale 0-1 
            app.Colors = [ 0.58 0 0.70; 0.70 0 0; 0 0 0.70; 0 0.70 0; 1 0.50 0];

            addpath(".\minimize")

            app.OutputDatasetPath.Value = strcat(pwd(), '\data');
            
            msg = sprintf("[%s] %s", app.get_time_string(), "MagAnalyst 1.0.0");
            app.MessagesTextArea.Value(end) = cellstr(msg);
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

        % Value changed function: logCheckBoxM
        function logCheckBoxMValueChanged(app, event)
            app.plot_M()
        end

        % Value changed function: logCheckBoxdMdH
        function logCheckBoxdMdHValueChanged(app, event)
            app.plot_dMdH()
        end

        % Value changed function: logCheckBoxHdMdH
        function logCheckBoxHdMdHValueChanged(app, event)
            app.plot_HdMdH()
        end

        % Value changed function: NumberofcomponentsSpinner
        function NumberofcomponentsSpinnerValueChanged(app, event)
            app.number_components = app.NumberofcomponentsSpinner.Value;
            app.init_components();
        end

        % Button pushed function: InputBrowseButton
        function InputBrowseButtonPushed(app, event)
            [file,path] = uigetfile('*.csv','Select dataset file', '.\data');
            if strcat(path, file) == ""
                return
            end

            try
                app.import_data(strcat(path, file));

                app.InputDatasetPath.Value = strcat(path, file);
                update_components(app)
                calculate_parameters(app)
                app.write_message("Imported " + file);
                app.plot_input();
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

        % Callback function: not associated with a component
        function CalculatePlotInputButtonPushed(app, event)
            path = app.InputDatasetPath.Value;
            if path == ""
                return
            end
            app.import_data(path);
            update_components(app)
            calculate_parameters(app)
            app.plot_input();
        end

        % Value changed function: logCheckBoxInputPlot
        function logCheckBoxInputPlotValueChanged(app, event)
            app.plot_input()
        end

        % Button pushed function: ResidualplotButtonM
        function ResidualplotButtonMPushed(app, event)
            error = ErrorCalculator();
            H_log = log(app.H);
            residue = error.residue(H_log, app.M, log(app.Hhat), app.Mhat);
            residue_plotter = ResiduePlotter(app.H(2:end-1), app.M(2:end-1), app.Hhat, app.Mhat, residue, app.logCheckBoxM.Value, "M [A/m]");
            residue_plotter.plot()
        end

        % Button pushed function: ResidualplotButtondMdH
        function ResidualplotButtondMdHPushed(app, event)
            error = ErrorCalculator();
            H_log = log(app.H);
            residue = error.residue(H_log, app.dMdH, log(app.Hhat), app.dMdHhat);
            residue_plotter = ResiduePlotter(app.H(2:end-1), app.dMdH(2:end-1), app.Hhat, app.dMdHhat, residue, app.logCheckBoxdMdH.Value, "∂M/∂H");
            residue_plotter.plot()
        end

        % Button pushed function: ResidualplotButtondHdMdH
        function ResidualplotButtondHdMdHPushed(app, event)
            error = ErrorCalculator();
            H_log = log(app.H);
            residue = error.residue(H_log, app.HdMdH, log(app.Hhat), app.HdMdHhat);
            residue_plotter = ResiduePlotter(app.H(2:end-1), app.HdMdH(2:end-1), app.Hhat, app.HdMdHhat, residue, app.logCheckBoxHdMdH.Value, "∂M/∂(logH) [A/m]");
            residue_plotter.plot()
        end

        % Button pushed function: OutputBrowseButton
        function OutputBrowseButtonPushed(app, event)
            app.OutputDatasetPath.Value = uigetdir(app.OutputDatasetPath.Value,'Select output folder');
        end

        % Button pushed function: ExportdataButton
        function ExportdataButtonPushed(app, event)
            if(app.OutputSeparateComponentsCheckBox.Value == 0)
                t = table(transpose(app.Hhat), transpose(app.Mhat), transpose(app.dMdHhat), transpose(app.HdMdHhat));
                t.Properties.VariableNames(:) = {'H [A/m]' 'M [A/m]' 'dM/dH' 'dM/dlogH [A/m]' };
            elseif(app.OutputSeparateComponentsCheckBox.Value == 1)
                t = table(transpose(app.Hhat), transpose(app.Mhat), array2table(transpose(app.Mihat)), transpose(app.dMdHhat), array2table(transpose(app.dMidHhat)), transpose(app.HdMdHhat), array2table(transpose(app.HdMidHhat)));
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

            %Separate into two functions
            if(app.CheckBoxExperimentalMagnetization.Value == 1)
                t = table(transpose(app.H), transpose(app.M));
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
            end 
        end

        % Value changed function: ShowgridCheckBoxdMdH
        function ShowgridCheckBoxdMdHValueChanged(app, event)
            grid(app.AxesdMdH,"off");
            if(app.ShowgridCheckBoxdMdH.Value == 1)
                grid(app.AxesdMdH,"on");
            end
        end

        % Value changed function: ShowgridCheckBoxHdMdH
        function ShowgridCheckBoxHdMdHValueChanged(app, event)
            grid(app.AxesHdMdH,"off");
            if(app.ShowgridCheckBoxHdMdH.Value == 1)
                grid(app.AxesHdMdH,"on");
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
                error = ErrorCalculator();
                diagonal_error = error.get_error(log(app.H), app.M, log(app.Hhat), app.Mhat, "Diagonal");
                horizontal_error = error.get_error(log(app.H), app.M, log(app.Hhat), app.Mhat, "Horizontal");
                vertical_error = error.get_error(log(app.H), app.M, log(app.Hhat), app.Mhat, "Vertical");
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
          [file,path] = uiputfile('*.txt','Save project', '.\data\project.txt');
          app.ProjectPath = strcat(path, file);
          app.save();
        end

        % Menu selected function: OpenMenu
        function OpenMenuSelected(app, event)
            app.write_message("Opening project project.txt");
            pause(0.01);
            [file,path] = uigetfile('*.txt','Select project', '.\data');
            app.ProjectPath = strcat(path, file);

            data = fileread(app.ProjectPath);
            s = jsondecode(data);

            app.number_components = s.number_components;
            app.init_components();
            app.init_parameters_table(true);
            app.init_quantities_table(true);
            app.NumberofcomponentsSpinner.Value = app.number_components;

            app.TableFittedParameters.Data(:,2) = s.fitted_parameters_value;
            app.TableFittedParameters.Data(:,3) = s.fitted_parameters_lower_bound;
            app.TableFittedParameters.Data(:,4) = s.fitted_parameters_upper_bound;


            app.TableParameters.Data.(5) = cellstr(s.select_a);
            app.TableParameters.Data.(5) = categorical(app.TableParameters.Data.(5), {'high', 'low'}, 'Ordinal', true);
            
            app.NumberofpointsEditField.Value = s.number_points;
            app.PointSpaceDropDown.Value = s.point_space;
            app.ErrortominimizeDropDown.Value = s.error_type;
            app.InputDatasetPath.Value = s.input_path;
            app.HorizontalaxisfieldDropDown.Value = s.horizontal_axis;
            app.VerticalaxisfieldDropDown.Value = s.vertical_axis;
            app.DescriptionTextArea.Value = s.description;
            
            app.OutputDatasetPath.Value = s.data_set_path;
            app.EditFieldFileNameModeledAnhystereticMagnetization.Value = s.magnetization_file_name; 
            app.EditFieldFileNameParameters.Value = s.parameters_file_name;
            app.EditFieldFileNamePlotMagnetization.Value = s.magnetization_plots_file_name;
            app.EditFieldFileNamePlotSusceptibility.Value = s.suceptibility_plots_file_name;
            app.EditFieldFileNamePlotSemiLogMagDerivative.Value = s.magnetization_derivative_file_name;
            app.EditFieldFileNameResiduesMagnetization.Value = s.magnetization_residual_file_name;
            app.EditFieldFileNameResiduesSusceptibility.Value = s.susceptibility_residual_file_name;
            app.EditFieldFileNameResiduesSemiLogMagDerivative.Value = s.semi_log_derivative_file_name;

            app.logCheckBoxInputPlot.Value = s.log_checkbox;
            app.logCheckBoxHdMdH.Value = s.fitting_log_checkbox;
            app.ShowgridCheckBoxHdMdH.Value = s.fitting_show_grid_checkbox;
            app.PlotcomponentsCheckBoxHdMdH.Value = s.fitting_plot_components_checkbox;
            app.CheckBoxOutputMagnetizationDataFittedAnhystereticMagnetization.Value = s.model_magnetization_checkbox;
            app.OutputSeparateComponentsCheckBox.Value = s.model_magnetization_components_checkbox;
            app.ExportFittedparametersCheckBox.Value = s.fitted_parameters_checkbox;
            app.ExportModelparametersCheckBox.Value = s.model_parameters_checkbox;
            app.ExportOtherquantitiesCheckBox.Value = s.other_quantities_checkbox;
            app.ExportErrorsCheckBox.Value = s.errors_checkbox;
            app.CheckBoxExportPlotMagnetization.Value = s.magnetization_plots_checkbox;
            app.CheckBoxExportPlotSusceptibility.Value = s.susceptibility_plots_checkbox;
            app.CheckBoxExportPlotSemiLogMagDerivative.Value = s.magnetization_derivatives_checkbox;

            app.CheckBoxExportResiduesMagnetization.Value = s.magnetization_residual_checkbox;
            app.CheckBoxExportResiduesSusceptibility.Value = s.susceptibility_residual_checkbox;
            app.CheckBoxExportResiduesSemiLogMagDerivative.Value = s.semi_log_derivative_residual_checkbox;

            app.CalculatePlotInputButtonPushed();
            app.CalculatePlotButtonPushed();
            app.write_message("Project was opened successfully");
        end

        % Value changed function: OutputDatasetPath
        function OutputDatasetPathValueChanged(app, event)
           
        end

        % Button pushed function: ExportResiduesButton
        function ExportResiduesButtonPushed(app, event)
            error = ErrorCalculator();
            H_log = log(app.H);

            if (app.CheckBoxExportResiduesMagnetization.Value == 1)
                residue = error.residue(H_log, app.M, log(app.Hhat), app.Mhat);
                file_name = strcat(app.EditFieldFileNameResiduesMagnetization.Value, app.DropDownResiduesMagnetizacionExtension.Value);
                app.export_residual(residue, file_name);
            end

            if(app.CheckBoxExportResiduesSusceptibility.Value == 1)
                residue = error.residue(H_log, app.dMdH, log(app.Hhat), app.dMdHhat);
                file_name = strcat(app.EditFieldFileNameResiduesSusceptibility.Value, app.DropDownResiduesSusceptibilityExtension.Value);
                app.export_residual(residue, file_name);
            end

            if(app.CheckBoxExportResiduesSusceptibility.Value == 1)
                residue = error.residue(H_log, app.HdMdH, log(app.Hhat), app.HdMdHhat);
                file_name = strcat(app.EditFieldFileNameResiduesSemiLogMagDerivative.Value, app.DropDownResiduesSemiLogMagDerivativeExtension.Value);
                app.export_residual(residue, file_name);
            end
        end

        % Menu selected function: SaveMenu
        function SaveMenuSelected(app, event)
            if (app.ProjectPath == "")
                app.SaveasMenuSelected();
            else
                app.save();
            end
        end

        % Value changed function: HorizontalaxisfieldDropDown
        function HorizontalaxisfieldDropDownValueChanged(app, event)
            app.calculate_and_plot();
        end

        % Value changed function: VerticalaxisfieldDropDown
        function VerticalaxisfieldDropDownValueChanged(app, event)
            app.calculate_and_plot();
        end

        % Value changed function: CurveDropDown
        function CurveDropDownValueChanged(app, event)
            app.calculate_and_plot();
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
            app.MagAnalystUIFigure.Position = [100 100 1024 768];
            app.MagAnalystUIFigure.Name = 'MagAnalyst';
            app.MagAnalystUIFigure.Icon = fullfile(pathToMLAPP, 'logo.png');
            app.MagAnalystUIFigure.CloseRequestFcn = createCallbackFcn(app, @MagAnalystUIFigureCloseRequest, true);
            app.MagAnalystUIFigure.WindowState = 'maximized';

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

            % Create MagnetizationinputdataTab
            app.MagnetizationinputdataTab = uitab(app.TabGroup);
            app.MagnetizationinputdataTab.AutoResizeChildren = 'off';
            app.MagnetizationinputdataTab.Title = 'Magnetization input data';

            % Create GridLayoutMagnetizationInputData
            app.GridLayoutMagnetizationInputData = uigridlayout(app.MagnetizationinputdataTab);
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
            app.HorizontalaxisfieldDropDown.Items = {'H [A/m]', 'H [kA/m]', 'H [Oe]', 'H [kOe]', 'Bext [T]', 'Bext [Gauss]', 'Bext [kGauss]'};
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
            app.VerticalaxisfieldDropDown.Items = {'M [A/m]', 'M [kA/m]', 'M [MA/m]', 'M [emu/cm^3]', 'J [T]', 'B [T]', 'B [Gauss]', 'B [kGauss]'};
            app.VerticalaxisfieldDropDown.ValueChangedFcn = createCallbackFcn(app, @VerticalaxisfieldDropDownValueChanged, true);
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

            % Create CurveDropDownLabel
            app.CurveDropDownLabel = uilabel(app.GridLayoutInputCurve);
            app.CurveDropDownLabel.FontWeight = 'bold';
            app.CurveDropDownLabel.Layout.Row = 1;
            app.CurveDropDownLabel.Layout.Column = 1;
            app.CurveDropDownLabel.Text = 'Curve';

            % Create CurveDropDown
            app.CurveDropDown = uidropdown(app.GridLayoutInputCurve);
            app.CurveDropDown.Items = {'Anhysteretic curve', 'Hysteretic loop'};
            app.CurveDropDown.ValueChangedFcn = createCallbackFcn(app, @CurveDropDownValueChanged, true);
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

            % Create GridLayoutInputPlotLog
            app.GridLayoutInputPlotLog = uigridlayout(app.GridLayoutInputPlot);
            app.GridLayoutInputPlotLog.ColumnWidth = {'11x', '1x'};
            app.GridLayoutInputPlotLog.RowHeight = {'1x'};
            app.GridLayoutInputPlotLog.Padding = [0 0 0 0];
            app.GridLayoutInputPlotLog.Layout.Row = 2;
            app.GridLayoutInputPlotLog.Layout.Column = 1;

            % Create logCheckBoxInputPlot
            app.logCheckBoxInputPlot = uicheckbox(app.GridLayoutInputPlotLog);
            app.logCheckBoxInputPlot.ValueChangedFcn = createCallbackFcn(app, @logCheckBoxInputPlotValueChanged, true);
            app.logCheckBoxInputPlot.Text = 'log';
            app.logCheckBoxInputPlot.Layout.Row = 1;
            app.logCheckBoxInputPlot.Layout.Column = 2;

            % Create GridLayoutInputTipsAndPlotButton
            app.GridLayoutInputTipsAndPlotButton = uigridlayout(app.GridLayoutInputPlot);
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

            % Create GridLayoutInputPlotButton
            app.GridLayoutInputPlotButton = uigridlayout(app.GridLayoutInputTipsAndPlotButton);
            app.GridLayoutInputPlotButton.Padding = [0 0 0 0];
            app.GridLayoutInputPlotButton.Layout.Row = 1;
            app.GridLayoutInputPlotButton.Layout.Column = 2;

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

            % Create AnhystereticmagnetizationfittingTab
            app.AnhystereticmagnetizationfittingTab = uitab(app.TabGroup);
            app.AnhystereticmagnetizationfittingTab.AutoResizeChildren = 'off';
            app.AnhystereticmagnetizationfittingTab.Title = 'Anhysteretic magnetization fitting';

            % Create AnhystereticmagnetizationfittingTabGridLayout
            app.AnhystereticmagnetizationfittingTabGridLayout = uigridlayout(app.AnhystereticmagnetizationfittingTab);
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
            app.AxesM.TickDir = 'in';
            app.AxesM.Box = 'on';
            app.AxesM.Layout.Row = 1;
            app.AxesM.Layout.Column = 1;

            % Create GridLayoutOptionsM
            app.GridLayoutOptionsM = uigridlayout(app.GridLayoutAxes);
            app.GridLayoutOptionsM.ColumnWidth = {'2.9x', '2.1x', '3x', '2x', '1x'};
            app.GridLayoutOptionsM.RowHeight = {'1x'};
            app.GridLayoutOptionsM.Padding = [0 0 0 0];
            app.GridLayoutOptionsM.Layout.Row = 2;
            app.GridLayoutOptionsM.Layout.Column = 1;

            % Create logCheckBoxM
            app.logCheckBoxM = uicheckbox(app.GridLayoutOptionsM);
            app.logCheckBoxM.ValueChangedFcn = createCallbackFcn(app, @logCheckBoxMValueChanged, true);
            app.logCheckBoxM.Text = 'log';
            app.logCheckBoxM.Layout.Row = 1;
            app.logCheckBoxM.Layout.Column = 5;
            app.logCheckBoxM.Value = true;

            % Create ResidualplotButtonM
            app.ResidualplotButtonM = uibutton(app.GridLayoutOptionsM, 'push');
            app.ResidualplotButtonM.ButtonPushedFcn = createCallbackFcn(app, @ResidualplotButtonMPushed, true);
            app.ResidualplotButtonM.Layout.Row = 1;
            app.ResidualplotButtonM.Layout.Column = 2;
            app.ResidualplotButtonM.Text = 'Residual plot';

            % Create PlotcomponentsCheckBoxM
            app.PlotcomponentsCheckBoxM = uicheckbox(app.GridLayoutOptionsM);
            app.PlotcomponentsCheckBoxM.ValueChangedFcn = createCallbackFcn(app, @PlotcomponentsCheckBoxMValueChanged, true);
            app.PlotcomponentsCheckBoxM.Text = 'Plot components';
            app.PlotcomponentsCheckBoxM.Layout.Row = 1;
            app.PlotcomponentsCheckBoxM.Layout.Column = 3;
            app.PlotcomponentsCheckBoxM.Value = true;

            % Create ShowgridCheckBoxM
            app.ShowgridCheckBoxM = uicheckbox(app.GridLayoutOptionsM);
            app.ShowgridCheckBoxM.ValueChangedFcn = createCallbackFcn(app, @ShowgridCheckBoxMValueChanged, true);
            app.ShowgridCheckBoxM.Text = 'Show grid';
            app.ShowgridCheckBoxM.Layout.Row = 1;
            app.ShowgridCheckBoxM.Layout.Column = 4;
            app.ShowgridCheckBoxM.Value = true;

            % Create SetColorsButton
            app.SetColorsButton = uibutton(app.GridLayoutOptionsM, 'push');
            app.SetColorsButton.ButtonPushedFcn = createCallbackFcn(app, @SetColorsButtonPushed, true);
            app.SetColorsButton.Layout.Row = 1;
            app.SetColorsButton.Layout.Column = 1;
            app.SetColorsButton.Text = 'Set Colors';

            % Create GridLayoutOptionsdMdH
            app.GridLayoutOptionsdMdH = uigridlayout(app.GridLayoutAxes);
            app.GridLayoutOptionsdMdH.ColumnWidth = {'2.9x', '2.1x', '3x', '2x', '1x'};
            app.GridLayoutOptionsdMdH.RowHeight = {'1x'};
            app.GridLayoutOptionsdMdH.Padding = [0 0 0 0];
            app.GridLayoutOptionsdMdH.Layout.Row = 4;
            app.GridLayoutOptionsdMdH.Layout.Column = 1;

            % Create logCheckBoxdMdH
            app.logCheckBoxdMdH = uicheckbox(app.GridLayoutOptionsdMdH);
            app.logCheckBoxdMdH.ValueChangedFcn = createCallbackFcn(app, @logCheckBoxdMdHValueChanged, true);
            app.logCheckBoxdMdH.Text = 'log';
            app.logCheckBoxdMdH.Layout.Row = 1;
            app.logCheckBoxdMdH.Layout.Column = 5;
            app.logCheckBoxdMdH.Value = true;

            % Create ResidualplotButtondMdH
            app.ResidualplotButtondMdH = uibutton(app.GridLayoutOptionsdMdH, 'push');
            app.ResidualplotButtondMdH.ButtonPushedFcn = createCallbackFcn(app, @ResidualplotButtondMdHPushed, true);
            app.ResidualplotButtondMdH.Layout.Row = 1;
            app.ResidualplotButtondMdH.Layout.Column = 2;
            app.ResidualplotButtondMdH.Text = 'Residual plot';

            % Create PlotcomponentsCheckBoxdMdH
            app.PlotcomponentsCheckBoxdMdH = uicheckbox(app.GridLayoutOptionsdMdH);
            app.PlotcomponentsCheckBoxdMdH.ValueChangedFcn = createCallbackFcn(app, @PlotcomponentsCheckBoxdMdHValueChanged, true);
            app.PlotcomponentsCheckBoxdMdH.Text = 'Plot components';
            app.PlotcomponentsCheckBoxdMdH.Layout.Row = 1;
            app.PlotcomponentsCheckBoxdMdH.Layout.Column = 3;
            app.PlotcomponentsCheckBoxdMdH.Value = true;

            % Create ShowgridCheckBoxdMdH
            app.ShowgridCheckBoxdMdH = uicheckbox(app.GridLayoutOptionsdMdH);
            app.ShowgridCheckBoxdMdH.ValueChangedFcn = createCallbackFcn(app, @ShowgridCheckBoxdMdHValueChanged, true);
            app.ShowgridCheckBoxdMdH.Text = 'Show grid';
            app.ShowgridCheckBoxdMdH.Layout.Row = 1;
            app.ShowgridCheckBoxdMdH.Layout.Column = 4;
            app.ShowgridCheckBoxdMdH.Value = true;

            % Create GridLayoutOptionsHdMdH
            app.GridLayoutOptionsHdMdH = uigridlayout(app.GridLayoutAxes);
            app.GridLayoutOptionsHdMdH.ColumnWidth = {'2.9x', '2.1x', '3x', '2x', '1x'};
            app.GridLayoutOptionsHdMdH.RowHeight = {'1x'};
            app.GridLayoutOptionsHdMdH.Padding = [0 0 0 0];
            app.GridLayoutOptionsHdMdH.Layout.Row = 6;
            app.GridLayoutOptionsHdMdH.Layout.Column = 1;

            % Create logCheckBoxHdMdH
            app.logCheckBoxHdMdH = uicheckbox(app.GridLayoutOptionsHdMdH);
            app.logCheckBoxHdMdH.ValueChangedFcn = createCallbackFcn(app, @logCheckBoxHdMdHValueChanged, true);
            app.logCheckBoxHdMdH.Text = 'log';
            app.logCheckBoxHdMdH.Layout.Row = 1;
            app.logCheckBoxHdMdH.Layout.Column = 5;
            app.logCheckBoxHdMdH.Value = true;

            % Create ResidualplotButtondHdMdH
            app.ResidualplotButtondHdMdH = uibutton(app.GridLayoutOptionsHdMdH, 'push');
            app.ResidualplotButtondHdMdH.ButtonPushedFcn = createCallbackFcn(app, @ResidualplotButtondHdMdHPushed, true);
            app.ResidualplotButtondHdMdH.Layout.Row = 1;
            app.ResidualplotButtondHdMdH.Layout.Column = 2;
            app.ResidualplotButtondHdMdH.Text = 'Residual plot';

            % Create PlotcomponentsCheckBoxHdMdH
            app.PlotcomponentsCheckBoxHdMdH = uicheckbox(app.GridLayoutOptionsHdMdH);
            app.PlotcomponentsCheckBoxHdMdH.ValueChangedFcn = createCallbackFcn(app, @PlotcomponentsCheckBoxHdMdHValueChanged, true);
            app.PlotcomponentsCheckBoxHdMdH.Text = 'Plot components';
            app.PlotcomponentsCheckBoxHdMdH.Layout.Row = 1;
            app.PlotcomponentsCheckBoxHdMdH.Layout.Column = 3;
            app.PlotcomponentsCheckBoxHdMdH.Value = true;

            % Create ShowgridCheckBoxHdMdH
            app.ShowgridCheckBoxHdMdH = uicheckbox(app.GridLayoutOptionsHdMdH);
            app.ShowgridCheckBoxHdMdH.ValueChangedFcn = createCallbackFcn(app, @ShowgridCheckBoxHdMdHValueChanged, true);
            app.ShowgridCheckBoxHdMdH.Text = 'Show grid';
            app.ShowgridCheckBoxHdMdH.Layout.Row = 1;
            app.ShowgridCheckBoxHdMdH.Layout.Column = 4;
            app.ShowgridCheckBoxHdMdH.Value = true;

            % Create GridLayoutNumbers
            app.GridLayoutNumbers = uigridlayout(app.AnhystereticmagnetizationfittingTabGridLayout);
            app.GridLayoutNumbers.ColumnWidth = {'1x'};
            app.GridLayoutNumbers.RowHeight = {'0.2x', '0.2x', '0.2x', '1.8x', '0.2x', '1x', '0.2x', '1x', '0.3x'};
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
            app.GridLayoutButtons.ColumnWidth = {'0.65x', '1.1x', '0.9x', '1.2x', '1.2x'};
            app.GridLayoutButtons.RowHeight = {'1x'};
            app.GridLayoutButtons.Padding = [0 0 0 0];
            app.GridLayoutButtons.Layout.Row = 9;
            app.GridLayoutButtons.Layout.Column = 1;

            % Create FitButton
            app.FitButton = uibutton(app.GridLayoutButtons, 'push');
            app.FitButton.ButtonPushedFcn = createCallbackFcn(app, @FitButtonPushed, true);
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
            app.ErrortominimizeDropDown.Items = {'Diagonal', 'Vertical', 'Horizontal'};
            app.ErrortominimizeDropDown.Layout.Row = 1;
            app.ErrortominimizeDropDown.Layout.Column = 2;
            app.ErrortominimizeDropDown.Value = 'Diagonal';

            % Create ErrorDisplay
            app.ErrorDisplay = uieditfield(app.GridLayoutButtons, 'text');
            app.ErrorDisplay.Editable = 'off';
            app.ErrorDisplay.Layout.Row = 1;
            app.ErrorDisplay.Layout.Column = 3;

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
            app.GridLayoutModeledCurve.ColumnWidth = {'1x', '0.32x', '0.75x', '0.32x', '1x'};
            app.GridLayoutModeledCurve.RowHeight = {'1x'};
            app.GridLayoutModeledCurve.ColumnSpacing = 3;
            app.GridLayoutModeledCurve.Padding = [0 0 0 0];
            app.GridLayoutModeledCurve.Layout.Row = 2;
            app.GridLayoutModeledCurve.Layout.Column = 1;

            % Create NumberofcomponentsSpinnerLabel
            app.NumberofcomponentsSpinnerLabel = uilabel(app.GridLayoutModeledCurve);
            app.NumberofcomponentsSpinnerLabel.Layout.Row = 1;
            app.NumberofcomponentsSpinnerLabel.Layout.Column = 1;
            app.NumberofcomponentsSpinnerLabel.Text = 'Number of components';

            % Create NumberofcomponentsSpinner
            app.NumberofcomponentsSpinner = uispinner(app.GridLayoutModeledCurve);
            app.NumberofcomponentsSpinner.Limits = [1 4];
            app.NumberofcomponentsSpinner.ValueChangedFcn = createCallbackFcn(app, @NumberofcomponentsSpinnerValueChanged, true);
            app.NumberofcomponentsSpinner.Layout.Row = 1;
            app.NumberofcomponentsSpinner.Layout.Column = 2;
            app.NumberofcomponentsSpinner.Value = 1;

            % Create NumberofpointsEditFieldLabel
            app.NumberofpointsEditFieldLabel = uilabel(app.GridLayoutModeledCurve);
            app.NumberofpointsEditFieldLabel.Layout.Row = 1;
            app.NumberofpointsEditFieldLabel.Layout.Column = 3;
            app.NumberofpointsEditFieldLabel.Text = 'Number of points';

            % Create NumberofpointsEditField
            app.NumberofpointsEditField = uieditfield(app.GridLayoutModeledCurve, 'numeric');
            app.NumberofpointsEditField.Limits = [0 Inf];
            app.NumberofpointsEditField.ValueDisplayFormat = '%.0f';
            app.NumberofpointsEditField.Layout.Row = 1;
            app.NumberofpointsEditField.Layout.Column = 4;
            app.NumberofpointsEditField.Value = 100;

            % Create PointSpaceDropDown
            app.PointSpaceDropDown = uidropdown(app.GridLayoutModeledCurve);
            app.PointSpaceDropDown.Items = {'Logarithmically spaced', 'Lineraly spaced'};
            app.PointSpaceDropDown.ItemsData = {'log', 'linear'};
            app.PointSpaceDropDown.Layout.Row = 1;
            app.PointSpaceDropDown.Layout.Column = 5;
            app.PointSpaceDropDown.Value = 'log';

            % Create FittedparametersLabel
            app.FittedparametersLabel = uilabel(app.GridLayoutNumbers);
            app.FittedparametersLabel.FontWeight = 'bold';
            app.FittedparametersLabel.Layout.Row = 3;
            app.FittedparametersLabel.Layout.Column = 1;
            app.FittedparametersLabel.Text = 'Fitted parameters';

            % Create MagnetizationoutputdataTab
            app.MagnetizationoutputdataTab = uitab(app.TabGroup);
            app.MagnetizationoutputdataTab.Title = 'Magnetization output data';

            % Create GridLayoutMagnetizationoutputdata
            app.GridLayoutMagnetizationoutputdata = uigridlayout(app.MagnetizationoutputdataTab);
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
            app.OutputDatasetPath.ValueChangedFcn = createCallbackFcn(app, @OutputDatasetPathValueChanged, true);
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

            % Show the figure after all components are created
            app.MagAnalystUIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = app

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