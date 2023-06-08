classdef colorDialog < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure           matlab.ui.Figure
        GridLayout         matlab.ui.container.GridLayout
        SetColorsLabel     matlab.ui.control.Label
        GridLayoutButtons  matlab.ui.container.GridLayout
        ColorTotal         matlab.ui.container.GridLayout
        ColorComponent1    matlab.ui.container.GridLayout
        ColorComponent2    matlab.ui.container.GridLayout
        ColorComponent3    matlab.ui.container.GridLayout
        ColorComponent4    matlab.ui.container.GridLayout
        Component4Button   matlab.ui.control.Button
        Component3Button   matlab.ui.control.Button
        Component2Button   matlab.ui.control.Button
        Component1Button   matlab.ui.control.Button
        TotalButton        matlab.ui.control.Button
    end


    properties (Access = private)
        MainApp
        Colors
    end
    
    methods (Access = private)
        
        function set_color(app, i)
            c = uisetcolor;
            app.Colors(i,:) = c;
            
            app.MainApp.set_colors_and_plot(app.Colors);
        end
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app, main_app, colors, number_components)
            app.MainApp = main_app;
            app.Colors = colors;
            color_samples = [app.ColorTotal; app.ColorComponent1; app.ColorComponent2; app.ColorComponent3; app.ColorComponent4];
            buttons = [app.TotalButton; app.Component1Button; app.Component2Button; app.Component3Button; app.Component4Button];
            for i = 1:number_components+1
                buttons(i).Visible = true;
                buttons(i).Enable = true;
                color_samples(i).Visible = true;
                color_samples(i).BackgroundColor = app.Colors(i,:);
            end
        end

        % Button pushed function: TotalButton
        function TotalButtonPushed(app, event)
            app.set_color(1);
            app.ColorTotal.BackgroundColor = app.Colors(1,:);
        end

        % Button pushed function: Component1Button
        function Component1ButtonPushed(app, event)
            app.set_color(2);
            app.ColorComponent1.BackgroundColor = app.Colors(2,:);
        end

        % Button pushed function: Component2Button
        function Component2ButtonPushed(app, event)
            app.set_color(3);
            app.ColorComponent2.BackgroundColor = app.Colors(3,:);
        end

        % Button pushed function: Component3Button
        function Component3ButtonPushed(app, event)
            app.set_color(4);
            app.ColorComponent3.BackgroundColor = app.Colors(4,:);
        end

        % Button pushed function: Component4Button
        function Component4ButtonPushed(app, event)
            app.set_color(5);
            app.ColorComponent4.BackgroundColor = app.Colors(5,:);
        end

        % Close request function: UIFigure
        function UIFigureCloseRequest(app, event)
            app.MainApp.SetColorsButton.Enable = 'on';

            delete(app)
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 250 219];
            app.UIFigure.Name = 'MATLAB App';
            app.UIFigure.CloseRequestFcn = createCallbackFcn(app, @UIFigureCloseRequest, true);

            % Create GridLayout
            app.GridLayout = uigridlayout(app.UIFigure);
            app.GridLayout.ColumnWidth = {'1x'};
            app.GridLayout.RowHeight = {'1x', '10x'};

            % Create GridLayoutButtons
            app.GridLayoutButtons = uigridlayout(app.GridLayout);
            app.GridLayoutButtons.RowHeight = {'1x', '1x', '1x', '1x', '1x'};
            app.GridLayoutButtons.Padding = [5 5 5 5];
            app.GridLayoutButtons.Layout.Row = 2;
            app.GridLayoutButtons.Layout.Column = 1;
            app.GridLayoutButtons.BackgroundColor = [0.902 0.902 0.902];

            % Create TotalButton
            app.TotalButton = uibutton(app.GridLayoutButtons, 'push');
            app.TotalButton.ButtonPushedFcn = createCallbackFcn(app, @TotalButtonPushed, true);
            app.TotalButton.Enable = 'off';
            app.TotalButton.Visible = 'off';
            app.TotalButton.Layout.Row = 1;
            app.TotalButton.Layout.Column = 1;
            app.TotalButton.Text = 'Total';

            % Create Component1Button
            app.Component1Button = uibutton(app.GridLayoutButtons, 'push');
            app.Component1Button.ButtonPushedFcn = createCallbackFcn(app, @Component1ButtonPushed, true);
            app.Component1Button.Enable = 'off';
            app.Component1Button.Visible = 'off';
            app.Component1Button.Layout.Row = 2;
            app.Component1Button.Layout.Column = 1;
            app.Component1Button.Text = 'Component 1';

            % Create Component2Button
            app.Component2Button = uibutton(app.GridLayoutButtons, 'push');
            app.Component2Button.ButtonPushedFcn = createCallbackFcn(app, @Component2ButtonPushed, true);
            app.Component2Button.Enable = 'off';
            app.Component2Button.Visible = 'off';
            app.Component2Button.Layout.Row = 3;
            app.Component2Button.Layout.Column = 1;
            app.Component2Button.Text = 'Component 2';

            % Create Component3Button
            app.Component3Button = uibutton(app.GridLayoutButtons, 'push');
            app.Component3Button.ButtonPushedFcn = createCallbackFcn(app, @Component3ButtonPushed, true);
            app.Component3Button.Enable = 'off';
            app.Component3Button.Visible = 'off';
            app.Component3Button.Layout.Row = 4;
            app.Component3Button.Layout.Column = 1;
            app.Component3Button.Text = 'Component 3';

            % Create Component4Button
            app.Component4Button = uibutton(app.GridLayoutButtons, 'push');
            app.Component4Button.ButtonPushedFcn = createCallbackFcn(app, @Component4ButtonPushed, true);
            app.Component4Button.Enable = 'off';
            app.Component4Button.Visible = 'off';
            app.Component4Button.Layout.Row = 5;
            app.Component4Button.Layout.Column = 1;
            app.Component4Button.Text = 'Component 4';

            % Create ColorComponent4
            app.ColorComponent4 = uigridlayout(app.GridLayoutButtons);
            app.ColorComponent4.ColumnWidth = {'1x'};
            app.ColorComponent4.RowHeight = {'1x'};
            app.ColorComponent4.Padding = [0 0 0 0];
            app.ColorComponent4.Visible = 'off';
            app.ColorComponent4.Layout.Row = 5;
            app.ColorComponent4.Layout.Column = 2;

            % Create ColorComponent3
            app.ColorComponent3 = uigridlayout(app.GridLayoutButtons);
            app.ColorComponent3.ColumnWidth = {'1x'};
            app.ColorComponent3.RowHeight = {'1x'};
            app.ColorComponent3.Padding = [0 0 0 0];
            app.ColorComponent3.Visible = 'off';
            app.ColorComponent3.Layout.Row = 4;
            app.ColorComponent3.Layout.Column = 2;

            % Create ColorComponent2
            app.ColorComponent2 = uigridlayout(app.GridLayoutButtons);
            app.ColorComponent2.ColumnWidth = {'1x'};
            app.ColorComponent2.RowHeight = {'1x'};
            app.ColorComponent2.Padding = [0 0 0 0];
            app.ColorComponent2.Visible = 'off';
            app.ColorComponent2.Layout.Row = 3;
            app.ColorComponent2.Layout.Column = 2;

            % Create ColorComponent1
            app.ColorComponent1 = uigridlayout(app.GridLayoutButtons);
            app.ColorComponent1.ColumnWidth = {'1x'};
            app.ColorComponent1.RowHeight = {'1x'};
            app.ColorComponent1.Padding = [0 0 0 0];
            app.ColorComponent1.Visible = 'off';
            app.ColorComponent1.Layout.Row = 2;
            app.ColorComponent1.Layout.Column = 2;

            % Create ColorTotal
            app.ColorTotal = uigridlayout(app.GridLayoutButtons);
            app.ColorTotal.ColumnWidth = {'1x'};
            app.ColorTotal.RowHeight = {'1x'};
            app.ColorTotal.Padding = [0 0 0 0];
            app.ColorTotal.Visible = 'off';
            app.ColorTotal.Layout.Row = 1;
            app.ColorTotal.Layout.Column = 2;

            % Create SetColorsLabel
            app.SetColorsLabel = uilabel(app.GridLayout);
            app.SetColorsLabel.HorizontalAlignment = 'center';
            app.SetColorsLabel.FontWeight = 'bold';
            app.SetColorsLabel.Layout.Row = 1;
            app.SetColorsLabel.Layout.Column = 1;
            app.SetColorsLabel.Text = 'Set Colors';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = colorDialog(varargin)

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @(app)startupFcn(app, varargin{:}))

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