classdef app_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                        matlab.ui.Figure
        TabGroup                        matlab.ui.container.TabGroup
        MagnetizationinputdataTab       matlab.ui.container.Tab
        GridLayoutMagnetizationInputData  matlab.ui.container.GridLayout
        GridLayoutInputPlot             matlab.ui.container.GridLayout
        GridLayoutInputTips_2           matlab.ui.container.GridLayout
        MTipAmEditField                 matlab.ui.control.NumericEditField
        MTipAmEditFieldLabel            matlab.ui.control.Label
        GridLayoutInputTips             matlab.ui.container.GridLayout
        HTipAmEditField                 matlab.ui.control.NumericEditField
        HTipAmEditFieldLabel            matlab.ui.control.Label
        GridLayoutInputPlotButtons      matlab.ui.container.GridLayout
        GridLayoutLogInput              matlab.ui.container.GridLayout
        logCheckBoxInputPlot            matlab.ui.control.CheckBox
        CalculatePlotInputButton        matlab.ui.control.Button
        AxesInput                       matlab.ui.control.UIAxes
        GridLayoutInput                 matlab.ui.container.GridLayout
        GridLayout2                     matlab.ui.container.GridLayout
        DatasetPath                     matlab.ui.control.EditField
        BrowseButton                    matlab.ui.control.Button
        DatasetpathLabel                matlab.ui.control.Label
        DescriptionLabel                matlab.ui.control.Label
        GridLayout                      matlab.ui.container.GridLayout
        TextArea                        matlab.ui.control.TextArea
        GridLayoutMeasuredField         matlab.ui.container.GridLayout
        MeasuredfieldDropDown           matlab.ui.control.DropDown
        MeasuredfieldDropDownLabel      matlab.ui.control.Label
        GridLayoutInputAppliedField     matlab.ui.container.GridLayout
        AppliedfieldDropDown            matlab.ui.control.DropDown
        AppliedfieldDropDownLabel       matlab.ui.control.Label
        GridLayoutInputCurve            matlab.ui.container.GridLayout
        CurveDropDown                   matlab.ui.control.DropDown
        CurveDropDownLabel              matlab.ui.control.Label
        AnhystereticmagnetizationfittingTab  matlab.ui.container.Tab
        AnhystereticmagnetizationfittingTabGridLayout  matlab.ui.container.GridLayout
        GridLayoutAxes                  matlab.ui.container.GridLayout
        GridLayoutLogHdMdH              matlab.ui.container.GridLayout
        logCheckBoxHdMdH                matlab.ui.control.CheckBox
        GridLayoutLogdMdH               matlab.ui.container.GridLayout
        logCheckBoxdMdH                 matlab.ui.control.CheckBox
        GridLayoutLogM                  matlab.ui.container.GridLayout
        logCheckBoxM                    matlab.ui.control.CheckBox
        AxesHdMdH                       matlab.ui.control.UIAxes
        AxesdMdH                        matlab.ui.control.UIAxes
        AxesM                           matlab.ui.control.UIAxes
        GridLayoutNumbers               matlab.ui.container.GridLayout
        TableQuantities                 matlab.ui.control.Table
        GridLayoutOtherQuantities       matlab.ui.container.GridLayout
        JsformulaLabel                  matlab.ui.control.Label
        OthercalculatedquantitiesLabel  matlab.ui.control.Label
        GridLayoutNumberOfComponents    matlab.ui.container.GridLayout
        NumberofcomponentsSpinner       matlab.ui.control.Spinner
        NumberofcomponentsSpinnerLabel  matlab.ui.control.Label
        FittedparametersLabel           matlab.ui.control.Label
        GridLayoutButtons               matlab.ui.container.GridLayout
        CalculatePlotButton             matlab.ui.control.Button
        FitButton                       matlab.ui.control.Button
        TableParameters                 matlab.ui.control.Table
        ModelretrievedparametersLabel   matlab.ui.control.Label
        TableFittedParameters           matlab.ui.control.Table
    end

    
    properties (Access = private)
        H
        M
        dMdH
        HdMdH
        Hhat
        Mhat
        dMdHhat
        HdMdHhat
        Hcr
        mcr
        a
        alphaMs
        Ms
        alpha
        dimensionless_alphaMs
        Hk
        number_components
    end
    
    methods (Access = private)
        
        function plot(app)
            cla(app.AxesM,'reset');
            cla(app.AxesdMdH,'reset');
            cla(app.AxesHdMdH,'reset');

            plotter = Plotter(app.H, app.M, app.dMdH, app.HdMdH, app.Hhat, app.Mhat, app.dMdHhat, app.HdMdHhat, app.Hcr);
            if(app.logCheckBoxM.Value == 0)
                plotter.plot_M(app.AxesM);
            else
                plotter.plot_M_log(app.AxesM);
            end

            if(app.logCheckBoxdMdH.Value == 0)
                plotter.plot_dMdH(app.AxesdMdH);
            else
                plotter.plot_dMdH_log(app.AxesdMdH);
            end

            if(app.logCheckBoxHdMdH.Value == 0)
                plotter.plot_HdMdH(app.AxesHdMdH);
            else
                plotter.plot_HdMdH_log(app.AxesHdMdH);
            end

            parameters = zeros(app.number_components,3);
            for i = 1:app.number_components
                parameters(i,1) = app.Ms(i);
                parameters(i,2) = app.a(i);
                parameters(i,3) = app.alpha(i);
            end
            t = table(transpose(parameters), 'RowNames', {'Msᵢ'; 'aᵢ'; 'αᵢ'});
            app.TableParameters.Data = t{:,:};
            app.TableParameters.RowName = t.Properties.RowNames;

            quantities = zeros(app.number_components,2);
            for i = 1:app.number_components
                quantities(i,1) = app.dimensionless_alphaMs(i);
                quantities(i,2) = app.Hk(i);
            end
            t = table(transpose(quantities), 'RowNames', {'αᵢ|Msᵢ|/(3aᵢ)'; 'Hk = 3aᵢ - αᵢMsᵢ'});
            app.TableQuantities.Data = t{:,:};
            app.TableQuantities.RowName = t.Properties.RowNames;

            for i = 1:app.number_components
                app.TableFittedParameters.Data(1 + (i-1)*2) = app.Hcr(i);
                app.TableFittedParameters.Data(2 + (i-1)*2) = app.mcr(i);
            end
            for i = 1:(app.number_components-1)
                app.TableFittedParameters.Data(i + 2*app.number_components) = (app.Hcr(i) + app.Hcr(i+1))/2;
            end
        end

        function calculate_parameters(app)
            N = 100;

            utils = Utils();

            app.dMdH = transpose(gradient(app.M(:)) ./ gradient(app.H(:)));

            app.HdMdH = app.H.*app.dMdH;

            [HTip, ~] = utils.find_tip(app.H, app.M);

            magnetic_parameters = MagneticParameters(app.H, app.M, app.Hcr, app.mcr);
            app.a = magnetic_parameters.get_a();
            app.alphaMs = magnetic_parameters.get_alphaMs(app.a);
            app.Ms = magnetic_parameters.get_Ms(app.a, app.alphaMs);
            app.alpha = magnetic_parameters.get_alpha(app.alphaMs, app.Ms);
            app.dimensionless_alphaMs = magnetic_parameters.get_dimensionless_alphaMs(app.alphaMs, app.a);
            app.Hk = magnetic_parameters.get_Hk(app.alphaMs, app.a);

            app.Hhat = logspace(log10(app.H(2)),log10(HTip),N);
            app.Mhat = get_Mhat(app.Hhat, app.a, app.alphaMs, app.Ms);
            app.dMdHhat = get_dMdHhat(app.Hhat, app.alpha, app.Ms, app.a, app.alphaMs);
            app.HdMdHhat = get_HdMdHhat(app.Hhat, app.dMdHhat);
        end
        
        function fit_parameters(app)
            app.calculate_parameters()
            [app.Hcr, app.mcr] = fit(app.H, app.M, cat(2, app.Hcr, app.mcr));
        end
        
        function update_components(app)
            app.Hcr = zeros(1, app.number_components);
            app.mcr = zeros(1, app.number_components);

            for i = 1:app.number_components
                app.Hcr(i) = app.TableFittedParameters.Data(1 + (i-1)*2);
                app.mcr(i) = app.TableFittedParameters.Data(2 + (i-1)*2);
            end
        end
        
        function init_components(app)
            row_count = 3*app.number_components - 1;
            component_values = zeros(row_count,1);
            row_names = cell(row_count, 1);
            for i = 1:app.number_components
                s = 'Hcr' + string(char(8320 + i));
                row_names(2*i - 1,:) = {convertStringsToChars(s)};
                component_values(2*i-1) = 0.01*i;
                s = 'm' + string(char(8320 + i)) + ' (' + s + ')';
                row_names(2*i,:) = {convertStringsToChars(s)};
                component_values(2*i) = 0.5;
            end

            for i = 1:(app.number_components-1)
                s = 'Hₓ' + string(char(8320 + i));
                row_names(i + 2*app.number_components,:) = {convertStringsToChars(s)};
                component_values(i + 2*app.number_components) = 0.01;
            end
            t = table(component_values);
            app.TableFittedParameters.Data = t{:,:};
            app.TableFittedParameters.RowName = row_names;

            parameters = zeros(app.number_components,3);
            t = table(transpose(parameters), 'RowNames', {'Msᵢ'; 'aᵢ'; 'αᵢ'});
            app.TableParameters.Data = t{:,:};
            app.TableParameters.RowName = t.Properties.RowNames;

            quantities = zeros(app.number_components,2);
            t = table(transpose(quantities), 'RowNames', {'αᵢ|Msᵢ|/(3aᵢ)'; 'Hk = 3aᵢ - αᵢMsᵢ'});
            app.TableQuantities.Data = t{:,:};
            app.TableQuantities.RowName = t.Properties.RowNames;
        end

        
        function plot_input(app)
            [HTip, MTip] = Utils().find_tip(app.H, app.M);
            app.MTipAmEditField.Value = MTip;
            app.HTipAmEditField.Value = HTip;

            cla(app.AxesInput, 'reset')
            plotter = Plotter(app.H, app.M, [], [], [], [], [], [], []);
            if(app.logCheckBoxInputPlot.Value == 0)
                plotter.plot_M(app.AxesInput);
            else
                plotter.plot_M_log(app.AxesInput);
            end
        end
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            app.number_components = 2;
            t = table([10; 0.5; 8000; 0.5; 4005], 'RowNames', {'Hcr₁'; 'm₁ (Hcr₁)'; 'Hcr₂'; 'm₂ (Hcr₂)'; 'Hx₁'});
            app.TableFittedParameters.Data = t{:,:};
            app.TableFittedParameters.RowName = t.Properties.RowNames;
            

            parameters = zeros(app.number_components,3);
            t = table(transpose(parameters), 'RowNames', {'Msᵢ'; 'aᵢ'; 'αᵢ'});
            app.TableParameters.Data = t{:,:};
            app.TableParameters.RowName = t.Properties.RowNames;

            quantities = zeros(app.number_components,2);
            t = table(transpose(quantities), 'RowNames', {'αᵢ|Msᵢ|/(3aᵢ)'; 'Hk = 3aᵢ - αᵢMsᵢ'});
            app.TableQuantities.Data = t{:,:};
            app.TableQuantities.RowName = t.Properties.RowNames;
            update_components(app)

            app.JsformulaLabel.Interpreter = 'latex';
            app.JsformulaLabel.Text = '$J_{S}\left[ T \right]=\mu_{0}\sum_{i=1}^{n}M_{Si}$';

            addpath(".\minimize")
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
            update_components(app)
            calculate_parameters(app)
            
            plotter = Plotter(app.H, app.M, app.dMdH, app.HdMdH, app.Hhat, app.Mhat, app.dMdHhat, app.HdMdHhat, app.Hcr);
            cla(app.AxesM,'reset');
            if(app.logCheckBoxM.Value == 0)
                plotter.plot_M(app.AxesM);
            else
                plotter.plot_M_log(app.AxesM);
            end
        end

        % Value changed function: logCheckBoxdMdH
        function logCheckBoxdMdHValueChanged(app, event)
            update_components(app)
            calculate_parameters(app)

            plotter = Plotter(app.H, app.M, app.dMdH, app.HdMdH, app.Hhat, app.Mhat, app.dMdHhat, app.HdMdHhat, app.Hcr);
            cla(app.AxesdMdH,'reset');
            if(app.logCheckBoxdMdH.Value == 0)
                plotter.plot_dMdH(app.AxesdMdH);
            else
                plotter.plot_dMdH_log(app.AxesdMdH);
            end
        end

        % Value changed function: logCheckBoxHdMdH
        function logCheckBoxHdMdHValueChanged(app, event)
            update_components(app)
            calculate_parameters(app)
            
            plotter = Plotter(app.H, app.M, app.dMdH, app.HdMdH, app.Hhat, app.Mhat, app.dMdHhat, app.HdMdHhat, app.Hcr);
            cla(app.AxesHdMdH,'reset');
            if(app.logCheckBoxHdMdH.Value == 0)
                plotter.plot_HdMdH(app.AxesHdMdH);
            else
                plotter.plot_HdMdH_log(app.AxesHdMdH);
            end
        end

        % Value changed function: NumberofcomponentsSpinner
        function NumberofcomponentsSpinnerValueChanged(app, event)
            app.number_components = app.NumberofcomponentsSpinner.Value;
            app.init_components();
        end

        % Button pushed function: BrowseButton
        function BrowseButtonPushed(app, event)
            [file,path] = uigetfile('*.csv','Select dataset file');
            [app.H, app.M] = Parser(strcat(path, file)).get_data_csv;
            app.DatasetPath.Value = strcat(path, file);
        end

        % Value changed function: DatasetPath
        function DatasetPathValueChanged(app, event)
            dataset_path = app.DatasetPath.Value;
            [app.H, app.M] = Parser(dataset_path).get_data_csv;
        end

        % Button pushed function: CalculatePlotInputButton
        function CalculatePlotInputButtonPushed(app, event)
            app.plot_input()
        end

        % Value changed function: logCheckBoxInputPlot
        function logCheckBoxInputPlotValueChanged(app, event)
            app.plot_input()
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 960 540];
            app.UIFigure.Name = 'MATLAB App';

            % Create TabGroup
            app.TabGroup = uitabgroup(app.UIFigure);
            app.TabGroup.AutoResizeChildren = 'off';
            app.TabGroup.Position = [1 1 960 540];

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

            % Create GridLayoutInputCurve
            app.GridLayoutInputCurve = uigridlayout(app.GridLayoutInput);
            app.GridLayoutInputCurve.ColumnWidth = {'1x', '2x'};
            app.GridLayoutInputCurve.RowHeight = {'1x'};
            app.GridLayoutInputCurve.Padding = [0 0 0 0];
            app.GridLayoutInputCurve.Layout.Row = 2;
            app.GridLayoutInputCurve.Layout.Column = 1;

            % Create CurveDropDownLabel
            app.CurveDropDownLabel = uilabel(app.GridLayoutInputCurve);
            app.CurveDropDownLabel.FontWeight = 'bold';
            app.CurveDropDownLabel.Layout.Row = 1;
            app.CurveDropDownLabel.Layout.Column = 1;
            app.CurveDropDownLabel.Text = 'Curve';

            % Create CurveDropDown
            app.CurveDropDown = uidropdown(app.GridLayoutInputCurve);
            app.CurveDropDown.Items = {'Anhysteretic curve'};
            app.CurveDropDown.Layout.Row = 1;
            app.CurveDropDown.Layout.Column = 2;
            app.CurveDropDown.Value = 'Anhysteretic curve';

            % Create GridLayoutInputAppliedField
            app.GridLayoutInputAppliedField = uigridlayout(app.GridLayoutInput);
            app.GridLayoutInputAppliedField.ColumnWidth = {'1x', '2x'};
            app.GridLayoutInputAppliedField.RowHeight = {'1x'};
            app.GridLayoutInputAppliedField.Padding = [0 0 0 0];
            app.GridLayoutInputAppliedField.Layout.Row = 3;
            app.GridLayoutInputAppliedField.Layout.Column = 1;

            % Create AppliedfieldDropDownLabel
            app.AppliedfieldDropDownLabel = uilabel(app.GridLayoutInputAppliedField);
            app.AppliedfieldDropDownLabel.FontWeight = 'bold';
            app.AppliedfieldDropDownLabel.Layout.Row = 1;
            app.AppliedfieldDropDownLabel.Layout.Column = 1;
            app.AppliedfieldDropDownLabel.Text = 'Applied field';

            % Create AppliedfieldDropDown
            app.AppliedfieldDropDown = uidropdown(app.GridLayoutInputAppliedField);
            app.AppliedfieldDropDown.Items = {'H (A/m)'};
            app.AppliedfieldDropDown.Layout.Row = 1;
            app.AppliedfieldDropDown.Layout.Column = 2;
            app.AppliedfieldDropDown.Value = 'H (A/m)';

            % Create GridLayoutMeasuredField
            app.GridLayoutMeasuredField = uigridlayout(app.GridLayoutInput);
            app.GridLayoutMeasuredField.ColumnWidth = {'1x', '2x'};
            app.GridLayoutMeasuredField.RowHeight = {'1x'};
            app.GridLayoutMeasuredField.Padding = [0 0 0 0];
            app.GridLayoutMeasuredField.Layout.Row = 4;
            app.GridLayoutMeasuredField.Layout.Column = 1;

            % Create MeasuredfieldDropDownLabel
            app.MeasuredfieldDropDownLabel = uilabel(app.GridLayoutMeasuredField);
            app.MeasuredfieldDropDownLabel.FontWeight = 'bold';
            app.MeasuredfieldDropDownLabel.Layout.Row = 1;
            app.MeasuredfieldDropDownLabel.Layout.Column = 1;
            app.MeasuredfieldDropDownLabel.Text = 'Measured field';

            % Create MeasuredfieldDropDown
            app.MeasuredfieldDropDown = uidropdown(app.GridLayoutMeasuredField);
            app.MeasuredfieldDropDown.Items = {'M (A/m)'};
            app.MeasuredfieldDropDown.Layout.Row = 1;
            app.MeasuredfieldDropDown.Layout.Column = 2;
            app.MeasuredfieldDropDown.Value = 'M (A/m)';

            % Create GridLayout
            app.GridLayout = uigridlayout(app.GridLayoutInput);
            app.GridLayout.ColumnWidth = {'1x'};
            app.GridLayout.RowHeight = {'1x'};
            app.GridLayout.Padding = [0 0 0 0];
            app.GridLayout.Layout.Row = 6;
            app.GridLayout.Layout.Column = 1;

            % Create TextArea
            app.TextArea = uitextarea(app.GridLayout);
            app.TextArea.Layout.Row = 1;
            app.TextArea.Layout.Column = 1;

            % Create DescriptionLabel
            app.DescriptionLabel = uilabel(app.GridLayoutInput);
            app.DescriptionLabel.FontWeight = 'bold';
            app.DescriptionLabel.Layout.Row = 5;
            app.DescriptionLabel.Layout.Column = 1;
            app.DescriptionLabel.Text = 'Description';

            % Create GridLayout2
            app.GridLayout2 = uigridlayout(app.GridLayoutInput);
            app.GridLayout2.ColumnWidth = {'3x', '4x', '2x'};
            app.GridLayout2.RowHeight = {'1x'};
            app.GridLayout2.Padding = [0 0 0 0];
            app.GridLayout2.Layout.Row = 1;
            app.GridLayout2.Layout.Column = 1;

            % Create DatasetpathLabel
            app.DatasetpathLabel = uilabel(app.GridLayout2);
            app.DatasetpathLabel.FontWeight = 'bold';
            app.DatasetpathLabel.Layout.Row = 1;
            app.DatasetpathLabel.Layout.Column = 1;
            app.DatasetpathLabel.Text = 'Dataset path';

            % Create BrowseButton
            app.BrowseButton = uibutton(app.GridLayout2, 'push');
            app.BrowseButton.ButtonPushedFcn = createCallbackFcn(app, @BrowseButtonPushed, true);
            app.BrowseButton.Layout.Row = 1;
            app.BrowseButton.Layout.Column = 3;
            app.BrowseButton.Text = 'Browse';

            % Create DatasetPath
            app.DatasetPath = uieditfield(app.GridLayout2, 'text');
            app.DatasetPath.ValueChangedFcn = createCallbackFcn(app, @DatasetPathValueChanged, true);
            app.DatasetPath.Layout.Row = 1;
            app.DatasetPath.Layout.Column = 2;

            % Create GridLayoutInputPlot
            app.GridLayoutInputPlot = uigridlayout(app.GridLayoutMagnetizationInputData);
            app.GridLayoutInputPlot.ColumnWidth = {'1x'};
            app.GridLayoutInputPlot.RowHeight = {'20x', '2x', '1x', '1x'};
            app.GridLayoutInputPlot.Padding = [0 10 0 0];
            app.GridLayoutInputPlot.Layout.Row = 1;
            app.GridLayoutInputPlot.Layout.Column = 2;

            % Create AxesInput
            app.AxesInput = uiaxes(app.GridLayoutInputPlot);
            xlabel(app.AxesInput, 'H (A/m)')
            ylabel(app.AxesInput, 'M (A/m)')
            app.AxesInput.Layout.Row = 1;
            app.AxesInput.Layout.Column = 1;

            % Create GridLayoutInputPlotButtons
            app.GridLayoutInputPlotButtons = uigridlayout(app.GridLayoutInputPlot);
            app.GridLayoutInputPlotButtons.ColumnWidth = {'6x', '5x', '1x'};
            app.GridLayoutInputPlotButtons.RowHeight = {'1x'};
            app.GridLayoutInputPlotButtons.Padding = [0 0 0 0];
            app.GridLayoutInputPlotButtons.Layout.Row = 2;
            app.GridLayoutInputPlotButtons.Layout.Column = 1;

            % Create CalculatePlotInputButton
            app.CalculatePlotInputButton = uibutton(app.GridLayoutInputPlotButtons, 'push');
            app.CalculatePlotInputButton.ButtonPushedFcn = createCallbackFcn(app, @CalculatePlotInputButtonPushed, true);
            app.CalculatePlotInputButton.FontWeight = 'bold';
            app.CalculatePlotInputButton.Layout.Row = 1;
            app.CalculatePlotInputButton.Layout.Column = 1;
            app.CalculatePlotInputButton.Text = 'Calculate & Plot';

            % Create GridLayoutLogInput
            app.GridLayoutLogInput = uigridlayout(app.GridLayoutInputPlotButtons);
            app.GridLayoutLogInput.ColumnWidth = {'1x'};
            app.GridLayoutLogInput.Padding = [0 0 0 0];
            app.GridLayoutLogInput.Layout.Row = 1;
            app.GridLayoutLogInput.Layout.Column = 3;

            % Create logCheckBoxInputPlot
            app.logCheckBoxInputPlot = uicheckbox(app.GridLayoutLogInput);
            app.logCheckBoxInputPlot.ValueChangedFcn = createCallbackFcn(app, @logCheckBoxInputPlotValueChanged, true);
            app.logCheckBoxInputPlot.Text = 'log';
            app.logCheckBoxInputPlot.Layout.Row = 1;
            app.logCheckBoxInputPlot.Layout.Column = 1;

            % Create GridLayoutInputTips
            app.GridLayoutInputTips = uigridlayout(app.GridLayoutInputPlot);
            app.GridLayoutInputTips.ColumnWidth = {'0.88x', '1x', '2x'};
            app.GridLayoutInputTips.RowHeight = {'1x'};
            app.GridLayoutInputTips.Padding = [0 0 0 0];
            app.GridLayoutInputTips.Layout.Row = 3;
            app.GridLayoutInputTips.Layout.Column = 1;

            % Create HTipAmEditFieldLabel
            app.HTipAmEditFieldLabel = uilabel(app.GridLayoutInputTips);
            app.HTipAmEditFieldLabel.HorizontalAlignment = 'right';
            app.HTipAmEditFieldLabel.FontWeight = 'bold';
            app.HTipAmEditFieldLabel.Layout.Row = 1;
            app.HTipAmEditFieldLabel.Layout.Column = 1;
            app.HTipAmEditFieldLabel.Text = 'HTip (A/m)';

            % Create HTipAmEditField
            app.HTipAmEditField = uieditfield(app.GridLayoutInputTips, 'numeric');
            app.HTipAmEditField.Editable = 'off';
            app.HTipAmEditField.Layout.Row = 1;
            app.HTipAmEditField.Layout.Column = 2;

            % Create GridLayoutInputTips_2
            app.GridLayoutInputTips_2 = uigridlayout(app.GridLayoutInputPlot);
            app.GridLayoutInputTips_2.ColumnWidth = {'0.88x', '1x', '2x'};
            app.GridLayoutInputTips_2.RowHeight = {'1x'};
            app.GridLayoutInputTips_2.Padding = [0 0 0 0];
            app.GridLayoutInputTips_2.Layout.Row = 4;
            app.GridLayoutInputTips_2.Layout.Column = 1;

            % Create MTipAmEditFieldLabel
            app.MTipAmEditFieldLabel = uilabel(app.GridLayoutInputTips_2);
            app.MTipAmEditFieldLabel.HorizontalAlignment = 'right';
            app.MTipAmEditFieldLabel.FontWeight = 'bold';
            app.MTipAmEditFieldLabel.Layout.Row = 1;
            app.MTipAmEditFieldLabel.Layout.Column = 1;
            app.MTipAmEditFieldLabel.Text = 'MTip (A/m)';

            % Create MTipAmEditField
            app.MTipAmEditField = uieditfield(app.GridLayoutInputTips_2, 'numeric');
            app.MTipAmEditField.Editable = 'off';
            app.MTipAmEditField.Layout.Row = 1;
            app.MTipAmEditField.Layout.Column = 2;

            % Create AnhystereticmagnetizationfittingTab
            app.AnhystereticmagnetizationfittingTab = uitab(app.TabGroup);
            app.AnhystereticmagnetizationfittingTab.AutoResizeChildren = 'off';
            app.AnhystereticmagnetizationfittingTab.Title = 'Anhysteretic magnetization fitting';

            % Create AnhystereticmagnetizationfittingTabGridLayout
            app.AnhystereticmagnetizationfittingTabGridLayout = uigridlayout(app.AnhystereticmagnetizationfittingTab);
            app.AnhystereticmagnetizationfittingTabGridLayout.RowHeight = {'1x'};

            % Create GridLayoutNumbers
            app.GridLayoutNumbers = uigridlayout(app.AnhystereticmagnetizationfittingTabGridLayout);
            app.GridLayoutNumbers.ColumnWidth = {'1x'};
            app.GridLayoutNumbers.RowHeight = {'0.15x', '2x', '0.15x', '0.6x', '0.15x', '0.4x', '0.15x'};
            app.GridLayoutNumbers.RowSpacing = 5;
            app.GridLayoutNumbers.Padding = [10 0 10 0];
            app.GridLayoutNumbers.Layout.Row = 1;
            app.GridLayoutNumbers.Layout.Column = 1;
            app.GridLayoutNumbers.Scrollable = 'on';

            % Create TableFittedParameters
            app.TableFittedParameters = uitable(app.GridLayoutNumbers);
            app.TableFittedParameters.ColumnName = {'Value'};
            app.TableFittedParameters.RowName = {'Hellow'};
            app.TableFittedParameters.ColumnEditable = true;
            app.TableFittedParameters.Layout.Row = 2;
            app.TableFittedParameters.Layout.Column = 1;

            % Create ModelretrievedparametersLabel
            app.ModelretrievedparametersLabel = uilabel(app.GridLayoutNumbers);
            app.ModelretrievedparametersLabel.FontWeight = 'bold';
            app.ModelretrievedparametersLabel.Layout.Row = 3;
            app.ModelretrievedparametersLabel.Layout.Column = 1;
            app.ModelretrievedparametersLabel.Text = 'Model retrieved parameters';

            % Create TableParameters
            app.TableParameters = uitable(app.GridLayoutNumbers);
            app.TableParameters.ColumnName = '';
            app.TableParameters.RowName = {};
            app.TableParameters.Layout.Row = 4;
            app.TableParameters.Layout.Column = 1;

            % Create GridLayoutButtons
            app.GridLayoutButtons = uigridlayout(app.GridLayoutNumbers);
            app.GridLayoutButtons.ColumnWidth = {'1x', '1x', '1x', '1x'};
            app.GridLayoutButtons.RowHeight = {'1x'};
            app.GridLayoutButtons.Padding = [0 0 0 0];
            app.GridLayoutButtons.Layout.Row = 7;
            app.GridLayoutButtons.Layout.Column = 1;

            % Create FitButton
            app.FitButton = uibutton(app.GridLayoutButtons, 'push');
            app.FitButton.ButtonPushedFcn = createCallbackFcn(app, @FitButtonPushed, true);
            app.FitButton.Layout.Row = 1;
            app.FitButton.Layout.Column = 4;
            app.FitButton.Text = 'Fit';

            % Create CalculatePlotButton
            app.CalculatePlotButton = uibutton(app.GridLayoutButtons, 'push');
            app.CalculatePlotButton.ButtonPushedFcn = createCallbackFcn(app, @CalculatePlotButtonPushed, true);
            app.CalculatePlotButton.Layout.Row = 1;
            app.CalculatePlotButton.Layout.Column = 3;
            app.CalculatePlotButton.Text = 'Calculate & Plot';

            % Create GridLayoutNumberOfComponents
            app.GridLayoutNumberOfComponents = uigridlayout(app.GridLayoutNumbers);
            app.GridLayoutNumberOfComponents.ColumnWidth = {'1x', '0.1x'};
            app.GridLayoutNumberOfComponents.RowHeight = {'1x'};
            app.GridLayoutNumberOfComponents.Padding = [0 0 0 0];
            app.GridLayoutNumberOfComponents.Layout.Row = 1;
            app.GridLayoutNumberOfComponents.Layout.Column = 1;

            % Create FittedparametersLabel
            app.FittedparametersLabel = uilabel(app.GridLayoutNumberOfComponents);
            app.FittedparametersLabel.FontWeight = 'bold';
            app.FittedparametersLabel.Layout.Row = 1;
            app.FittedparametersLabel.Layout.Column = 1;
            app.FittedparametersLabel.Text = 'Fitted parameters';

            % Create NumberofcomponentsSpinnerLabel
            app.NumberofcomponentsSpinnerLabel = uilabel(app.GridLayoutNumberOfComponents);
            app.NumberofcomponentsSpinnerLabel.HorizontalAlignment = 'right';
            app.NumberofcomponentsSpinnerLabel.Layout.Row = 1;
            app.NumberofcomponentsSpinnerLabel.Layout.Column = 1;
            app.NumberofcomponentsSpinnerLabel.Text = 'Number of components';

            % Create NumberofcomponentsSpinner
            app.NumberofcomponentsSpinner = uispinner(app.GridLayoutNumberOfComponents);
            app.NumberofcomponentsSpinner.Limits = [1 3];
            app.NumberofcomponentsSpinner.ValueChangedFcn = createCallbackFcn(app, @NumberofcomponentsSpinnerValueChanged, true);
            app.NumberofcomponentsSpinner.Layout.Row = 1;
            app.NumberofcomponentsSpinner.Layout.Column = 2;
            app.NumberofcomponentsSpinner.Value = 2;

            % Create GridLayoutOtherQuantities
            app.GridLayoutOtherQuantities = uigridlayout(app.GridLayoutNumbers);
            app.GridLayoutOtherQuantities.RowHeight = {'1x'};
            app.GridLayoutOtherQuantities.Padding = [0 0 0 0];
            app.GridLayoutOtherQuantities.Layout.Row = 5;
            app.GridLayoutOtherQuantities.Layout.Column = 1;

            % Create OthercalculatedquantitiesLabel
            app.OthercalculatedquantitiesLabel = uilabel(app.GridLayoutOtherQuantities);
            app.OthercalculatedquantitiesLabel.FontWeight = 'bold';
            app.OthercalculatedquantitiesLabel.Layout.Row = 1;
            app.OthercalculatedquantitiesLabel.Layout.Column = 1;
            app.OthercalculatedquantitiesLabel.Text = 'Other calculated quantities';

            % Create JsformulaLabel
            app.JsformulaLabel = uilabel(app.GridLayoutOtherQuantities);
            app.JsformulaLabel.HorizontalAlignment = 'right';
            app.JsformulaLabel.Layout.Row = 1;
            app.JsformulaLabel.Layout.Column = 2;
            app.JsformulaLabel.Text = 'Js formula';

            % Create TableQuantities
            app.TableQuantities = uitable(app.GridLayoutNumbers);
            app.TableQuantities.ColumnName = '';
            app.TableQuantities.RowName = {};
            app.TableQuantities.Layout.Row = 6;
            app.TableQuantities.Layout.Column = 1;

            % Create GridLayoutAxes
            app.GridLayoutAxes = uigridlayout(app.AnhystereticmagnetizationfittingTabGridLayout);
            app.GridLayoutAxes.ColumnWidth = {'1x'};
            app.GridLayoutAxes.RowHeight = {'1x', '0.1x', '1x', '0.1x', '1x', '0.1x'};
            app.GridLayoutAxes.RowSpacing = 0;
            app.GridLayoutAxes.Padding = [0 0 0 0];
            app.GridLayoutAxes.Layout.Row = 1;
            app.GridLayoutAxes.Layout.Column = 2;

            % Create AxesM
            app.AxesM = uiaxes(app.GridLayoutAxes);
            xlabel(app.AxesM, 'H (A/m)')
            ylabel(app.AxesM, 'M (A/m)')
            zlabel(app.AxesM, 'Z')
            app.AxesM.Layout.Row = 1;
            app.AxesM.Layout.Column = 1;

            % Create AxesdMdH
            app.AxesdMdH = uiaxes(app.GridLayoutAxes);
            xlabel(app.AxesdMdH, 'H (A/m)')
            ylabel(app.AxesdMdH, '∂M/∂H')
            zlabel(app.AxesdMdH, 'Z')
            app.AxesdMdH.Layout.Row = 3;
            app.AxesdMdH.Layout.Column = 1;

            % Create AxesHdMdH
            app.AxesHdMdH = uiaxes(app.GridLayoutAxes);
            xlabel(app.AxesHdMdH, 'H (A/m)')
            ylabel(app.AxesHdMdH, 'H ∂M/∂H (A/m)')
            zlabel(app.AxesHdMdH, 'Z')
            app.AxesHdMdH.Layout.Row = 5;
            app.AxesHdMdH.Layout.Column = 1;

            % Create GridLayoutLogM
            app.GridLayoutLogM = uigridlayout(app.GridLayoutAxes);
            app.GridLayoutLogM.ColumnWidth = {'1x', '0.1x'};
            app.GridLayoutLogM.RowHeight = {'1x'};
            app.GridLayoutLogM.Padding = [0 0 0 0];
            app.GridLayoutLogM.Layout.Row = 2;
            app.GridLayoutLogM.Layout.Column = 1;

            % Create logCheckBoxM
            app.logCheckBoxM = uicheckbox(app.GridLayoutLogM);
            app.logCheckBoxM.ValueChangedFcn = createCallbackFcn(app, @logCheckBoxMValueChanged, true);
            app.logCheckBoxM.Text = 'log';
            app.logCheckBoxM.Layout.Row = 1;
            app.logCheckBoxM.Layout.Column = 2;
            app.logCheckBoxM.Value = true;

            % Create GridLayoutLogdMdH
            app.GridLayoutLogdMdH = uigridlayout(app.GridLayoutAxes);
            app.GridLayoutLogdMdH.ColumnWidth = {'1x', '0.1x'};
            app.GridLayoutLogdMdH.RowHeight = {'1x'};
            app.GridLayoutLogdMdH.Padding = [0 0 0 0];
            app.GridLayoutLogdMdH.Layout.Row = 4;
            app.GridLayoutLogdMdH.Layout.Column = 1;

            % Create logCheckBoxdMdH
            app.logCheckBoxdMdH = uicheckbox(app.GridLayoutLogdMdH);
            app.logCheckBoxdMdH.ValueChangedFcn = createCallbackFcn(app, @logCheckBoxdMdHValueChanged, true);
            app.logCheckBoxdMdH.Text = 'log';
            app.logCheckBoxdMdH.Layout.Row = 1;
            app.logCheckBoxdMdH.Layout.Column = 2;
            app.logCheckBoxdMdH.Value = true;

            % Create GridLayoutLogHdMdH
            app.GridLayoutLogHdMdH = uigridlayout(app.GridLayoutAxes);
            app.GridLayoutLogHdMdH.ColumnWidth = {'1x', '0.1x'};
            app.GridLayoutLogHdMdH.RowHeight = {'1x'};
            app.GridLayoutLogHdMdH.Padding = [0 0 0 0];
            app.GridLayoutLogHdMdH.Layout.Row = 6;
            app.GridLayoutLogHdMdH.Layout.Column = 1;

            % Create logCheckBoxHdMdH
            app.logCheckBoxHdMdH = uicheckbox(app.GridLayoutLogHdMdH);
            app.logCheckBoxHdMdH.ValueChangedFcn = createCallbackFcn(app, @logCheckBoxHdMdHValueChanged, true);
            app.logCheckBoxHdMdH.Text = 'log';
            app.logCheckBoxHdMdH.Layout.Row = 1;
            app.logCheckBoxHdMdH.Layout.Column = 2;
            app.logCheckBoxHdMdH.Value = true;

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = app_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end