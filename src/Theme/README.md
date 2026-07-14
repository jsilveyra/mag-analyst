# Theme

The app's visual-theme system (colors/fonts/line widths). All logic lives in
`ThemeUtils.m` (a static class, same pattern as `PlaygroundUtils`/
`AnhystereticUtils`): `theme_palette()` is the single tweak point for every
color/font knob, `apply_theme(app)` runs the runtime passes that apply them.

`app_exported.m` only needs one delegator line at the end of `startupFcn`:
`ThemeUtils.apply_theme(app);` — per the "keep Code View thin" rule,
no theme logic is written directly into `app.mlapp`.

Shared by every tab (not tab-specific), which is why it lives in its own
`src/Theme/` folder rather than a per-tab `Utils.m`.
