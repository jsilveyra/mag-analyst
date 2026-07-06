# Menus

Reserved for standalone scripts backing the app's menu bar (Project > Open /
Save / Save as, and future Export dialog).

As of 2026-07-06, this logic still lives inline in `app_old_exported.m`
(`OpenMenuSelected`, `SaveMenuSelected`, `SaveasMenuSelected`, `save`,
`default_data_folder`, `safe_getfile`/`safe_putfile`/`safe_getdir`) — it
hasn't been extracted into standalone files yet. See CLAUDE.md for the
extraction plan.
