# CAD for Carpentry

Source for *CAD for Carpentry: Practical SolidCraft and FreeCAD models for
fences, decks, and sheds* — a Quarto book that pairs prose with reproducible
parametric models.

Two tracks: SolidCraft (chapters 1–15) and FreeCAD (chapters 16–24), plus a
command map, troubleshooting guide, glossary, open-source landscape, and FreeCAD
setup appendix.

## Render

```sh
quarto render            # HTML + A4 PDF (Typst) into _book/
quarto render --to html  # quick check, HTML only
```

`.qmd` files are never executed at render time (`execute.enabled: false`); CAD
figures come from saved designs in `designs/`, with outputs in `images/` and
`drawings/`.

## Layout

| Path | Contents |
| --- | --- |
| `index.qmd` | Book landing page |
| `chapters/` | 24 chapters in four parts; `10-opencode.qmd` covers MCP setup |
| `appendices/` | Command map, troubleshooting, glossary, landscape, FreeCAD setup |
| `designs/` | Source designs and headless regeneration scripts |
| `images/`, `drawings/` | Rendered figures and TechDraw exports |
| `AGENTS.md` | Notes for AI agents working in this repo |

`_quarto.yml` is the source of truth for chapter order and formats.
