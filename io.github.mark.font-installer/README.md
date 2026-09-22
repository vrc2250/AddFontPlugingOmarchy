# Font Installer — Omarchy plugin

Install `.ttf` / `.otf` / `.ttc` fonts (a single file or a whole folder) into your
**user** font directory and refresh the fontconfig cache — no root required.

Built because apps like **PDF-SIDES-PRO** ship special fonts and dropping them in
by hand + remembering `fc-cache` is tedious.

## How it works

Omarchy 3 plugins are Quickshell/QML components. This plugin follows the
recommended split:

- **`font-installer`** (bash) — the single source of truth; does the copy + cache.
- **`Service.qml`** — headless singleton that shells out to the bash script.
- **`Menu.qml`** — minimal summoned UI (path field + install buttons).
- **`manifest.json`** — plugin metadata (`kinds: ["menu", "service"]`).

Fonts install per-user to:

```
${XDG_DATA_HOME:-$HOME/.local/share}/fonts/font-installer/
```

## Install (as an Omarchy plugin)

```sh
omarchy plugin add https://github.com/<you>/font-installer.git --enable
omarchy restart shell
```

Then summon the **Font Installer** menu (it registers under the *Style* category).

> Update the `id`, `author`, and `homepage` in `manifest.json` to your own
> namespace (e.g. `io.github.<youruser>.font-installer`) before publishing.

## Use as a plain CLI (no Omarchy needed)

The bash script is fully standalone:

```sh
./font-installer install ~/Downloads/MyFont.ttf
./font-installer install ./fonts/*.otf
./font-installer install-dir ./PDF-SIDES-PRO/fonts
./font-installer list
./font-installer remove MyFont
./font-installer refresh
./font-installer help
```

Verify a font is visible to the system afterward:

```sh
fc-list | grep -i myfont
```

## Notes / caveats

- **User-level only.** Truly system-wide install (`/usr/share/fonts`) needs
  `sudo`; per-user fonts are picked up everywhere without it.
- Supported formats: `.ttf`, `.otf`, `.ttc`, `.otc`.
- The QML targets Omarchy 3 (Quickshell). Verify QML imports/APIs against your
  installed Quickshell version — the bash script is version-independent.

## License

MIT — see [LICENSE](LICENSE).
