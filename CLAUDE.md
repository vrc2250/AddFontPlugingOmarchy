# AddFontPlugingOmarchy

Building an **Omarchy plugin** ("Font Installer") that installs user-level fonts and
refreshes the fontconfig cache. Motivated by the **PDF-SIDES-PRO** app, which ships
special fonts and needs an easier install path.

## ⏱️ Resume here (read this first each session)

**On session start, greet the user with a one-line status recap.** Repo is live at
https://github.com/vrc2250/AddFontPlugingOmarchy (branch `EZ-OM-FONT`). The agreed next
step is **verifying the QML front-end on a real Omarchy 3 / Quickshell shell** — offer that.

### Status (2026-09-22): scaffold complete, bash CLI verified working
All files live in `io.github.vrc2250.font-installer/`.

- ✅ `manifest.json` — kinds `["menu","service"]`, Style category
- ✅ `font-installer` (bash, executable) — the single source of truth. Commands:
  `install`, `install-dir`, `list`, `remove`, `refresh`, `help`. Smoke-tested end-to-end.
- ⚠️ `Service.qml` — Quickshell singleton that shells out to bash. **UNTESTED** (no runtime here).
- ⚠️ `Menu.qml` — minimal UI (path field + buttons). **UNTESTED**.
- ✅ `README.md`, `LICENSE` (MIT)

### Next steps
1. **`git init` + first commit** (this workspace is not yet a git repo). ← expected next action
2. Verify QML on a real Omarchy 3 / Quickshell install (`StdioCollector`/`Process` API; `menu` manifest block).
3. Optional: real file picker in `Menu.qml`.
4. Optional: auto-detect PDF-SIDES-PRO's bundled font folder.
5. Before publishing: set `id`/`author`/`homepage` in `manifest.json` to a real GitHub namespace.

## Architecture notes
Omarchy 3 plugins are **Quickshell/QML**, run unsandboxed as the user. Recommended pattern
(from `om-custom-font`): thin QML → shell out via Quickshell `Process` → bash does the real work.
Fonts install per-user to `~/.local/share/fonts/font-installer/` (no sudo). Formats: ttf/otf/ttc/otc.

## Standalone CLI usage
```sh
cd io.github.vrc2250.font-installer
./font-installer install-dir /path/to/PDF-SIDES-PRO/fonts
./font-installer list
```
