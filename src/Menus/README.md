# Menus

Standalone logic backing the app's Project menu.

- `MenuUtils.m` — Open / Save / Save as (`OpenMenuSelected`, `SaveMenuSelected`,
  `SaveasMenuSelected` in `app_exported.m` all delegate here) and the "New"
  full-app reset (`new_project`/`reset_app`).
- `ExportDialogUtils.m` — the unified "Export..." dialog: a code-built
  window listing every exportable artifact across all tabs as checkboxes,
  opened from Project ▸ Export....
- `ExportUtils.m` — generic, app-agnostic file-IO writers (CSV/TXT/image)
  used by `ExportDialogUtils.m`.
