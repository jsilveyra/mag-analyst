# Menus

Standalone logic backing the app's Project menu.

- `MenuUtils.m` — Open / Save / Save as (`OpenMenuSelected`, `SaveMenuSelected`,
  `SaveasMenuSelected` in `app_exported.m` all delegate here) and the "New"
  full-app reset (`new_project`/`reset_app`).
- `ExportDialogUtils.m` — the unified "Export..." dialog (replaces the
  deprecated Output-data tab, which is detached from the TabGroup at startup
  rather than deleted, since `MenuUtils.save`/`open_project` still read its
  `OutputDatasetPath` and per-item fields).
- `ExportUtils.m` — generic, app-agnostic file-IO writers (CSV/TXT/image)
  used by `ExportDialogUtils.m`.
