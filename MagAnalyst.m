function app = MagAnalyst()
%MAGANALYST  Launch the MagAnalyst app behind a loading splash.
%
%   MagAnalyst() opens a single splash window (logo + version + an
%   animated progress bar), builds the app, then closes the splash and
%   shows the app.
%
%   The first launch after starting MATLAB is slow because MATLAB has to
%   warm up the App Designer / uifigure graphics framework (a one-time,
%   per-session cost) and then build the large multi-tab UI. This is the
%   same warm-up that makes App Designer itself show a splash the first
%   time it opens. Later launches in the same MATLAB session are faster.
%
%   The progress bar is a CSS animation rendered inside a uihtml
%   component, so it keeps moving during the (blocking) app construction.

    version = AppVersion();

    % --- Theme: pick logo + colours from the OS light/dark setting ---
    if isDarkMode()
        logoName   = "logo_dark_maganalyst.png";
        figBG      = [0.15 0.15 0.15];
        textColor  = [0.90 0.90 0.90];
        htmlBG     = "#262626";
        trackColor = "#404040";
    else
        logoName   = "logo_light_maganalyst.png";
        figBG      = [1.00 1.00 1.00];
        textColor  = [0.15 0.15 0.15];
        htmlBG     = "#ffffff";
        trackColor = "#e0e0e0";
    end
    accent = "#f15a29";   % orange from the logo

    % --- Splash figure: single window, centred on screen ---
    scr = get(groot, 'ScreenSize');
    w = 480; h = 300;
    pos = [(scr(3) - w) / 2, (scr(4) - h) / 2, w, h];

    % 'Icon' replaces the generic MATLAB icon that would otherwise show in
    % the window's title bar (top-left corner) with the app's own mark --
    % same asset the main app window uses (app_exported.m, MagAnalystUIFigure.Icon).
    iconFile = fullfile(fileparts(mfilename('fullpath')), 'assets', 'logo.png');

    splash = uifigure( ...
        'Name', 'MagAnalyst', ...
        'Icon', iconFile, ...
        'Position', pos, ...
        'Resize', 'off', ...
        'Color', figBG);

    % Always tear the splash down, even if construction errors out.
    cleaner = onCleanup(@() delete(splash));

    % Logo (skip gracefully if the asset is missing).
    logoFile = fullfile(fileparts(mfilename('fullpath')), 'assets', logoName);
    if isfile(logoFile)
        uiimage(splash, ...
            'ImageSource', logoFile, ...
            'BackgroundColor', figBG, ...
            'ScaleMethod', 'fit', ...
            'Position', [60, 175, 360, 100]);
    end

    % Release version note.
    uilabel(splash, ...
        'Text', "MagAnalyst " + version, ...
        'HorizontalAlignment', 'center', ...
        'FontSize', 15, 'FontWeight', 'bold', 'FontColor', textColor, ...
        'Position', [0, 140, w, 26]);

    uilabel(splash, ...
        'Text', 'Loading, please wait…', ...
        'HorizontalAlignment', 'center', ...
        'FontSize', 11, 'FontColor', textColor, ...
        'Position', [0, 116, w, 20]);

    % Indeterminate progress bar (CSS animation via uihtml).
    uihtml(splash, ...
        'Position', [40, 60, w - 80, 30], ...
        'HTMLSource', progressBarHTML(htmlBG, trackColor, accent));

    drawnow;   % paint the splash before the heavy work begins

    % --- Build the app (the slow part) ---
    app = app_exported();

    % --- Tear down splash ---
    clear cleaner;   % triggers delete(splash)

    if nargout == 0
        clear app;
    end
end


function tf = isDarkMode()
%ISDARKMODE  True if the OS is set to dark mode, false otherwise.
%   Supports Windows, macOS, and GNOME-based Linux. Defaults to light
%   mode (false) on any other platform or if the setting can't be read.
    tf = false;
    try
        if ispc
            % Windows: AppsUseLightTheme = 0 means dark mode.
            val = winqueryreg('HKEY_CURRENT_USER', ...
                'Software\Microsoft\Windows\CurrentVersion\Themes\Personalize', ...
                'AppsUseLightTheme');
            tf = (val == 0);

        elseif ismac
            % macOS: the key exists (value "Dark") only in dark mode.
            [status, out] = system('defaults read -g AppleInterfaceStyle 2>/dev/null');
            tf = (status == 0) && contains(lower(strtrim(out)), 'dark');

        elseif isunix
            % Linux (GNOME): prefer color-scheme, fall back to gtk-theme.
            [status, out] = system( ...
                'gsettings get org.gnome.desktop.interface color-scheme 2>/dev/null');
            if status == 0 && contains(lower(out), 'dark')
                tf = true;
            else
                [status2, out2] = system( ...
                    'gsettings get org.gnome.desktop.interface gtk-theme 2>/dev/null');
                tf = (status2 == 0) && contains(lower(out2), 'dark');
            end
        end
    catch
        tf = false;   % default to light mode if the setting can't be read
    end
end


function html = progressBarHTML(bg, track, accent)
%PROGRESSBARHTML  Inline HTML/CSS for an indeterminate progress bar.
    html = [ ...
        '<!DOCTYPE html><html><head><style>', ...
        'html,body{margin:0;height:100%;overflow:hidden;background:${BG};}', ...
        '.track{position:absolute;top:50%;left:0;width:100%;height:8px;', ...
        'transform:translateY(-50%);background:${TRACK};border-radius:4px;', ...
        'overflow:hidden;}', ...
        '.bar{position:absolute;height:100%;width:35%;border-radius:4px;', ...
        'background:${ACCENT};animation:slide 1.3s ease-in-out infinite;}', ...
        '@keyframes slide{0%{left:-35%;}100%{left:100%;}}', ...
        '</style></head><body>', ...
        '<div class="track"><div class="bar"></div></div>', ...
        '</body></html>'];
    html = strrep(html, '${BG}',     char(bg));
    html = strrep(html, '${TRACK}',  char(track));
    html = strrep(html, '${ACCENT}', char(accent));
end
