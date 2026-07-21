function v = AppVersion()
%APPVERSION Single source of truth for the MagAnalyst version string.
%   Called by MagAnalyst.m (splash screen) and app_exported.m (startup
%   message) so the two never drift apart. Update this value when cutting
%   a release; also update the App Designer "Sharing details" Version
%   field for app.mlapp by hand (that metadata isn't reachable from code).
    v = "2.13";
end
