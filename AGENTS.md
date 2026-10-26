# AGENTS.md — AI CAD book

A Quarto book for carpentry and exterior construction, built around SolidCraft
and FreeCAD. It is prose plus reproducible models and figures, not an
application. The book is scaffolded: an unnumbered introduction, 24 numbered
chapter outlines in four parts, five appendices, and places for designs,
figures, and drawings.

## Book structure and build

- `_quarto.yml` is the source of truth for chapter order, parts, appendices,
  formats, and output. A chapter file not listed there will not render.
- Prose lives in `index.qmd`, `chapters/00-introduction.qmd` (deliberately
  unnumbered and outside a `part:`), `chapters/01-...` through `24-...`, and
  `appendices/a-...` through `e-...`. Keep book-wide settings in `_quarto.yml`,
  not repeated per chapter.
- The book has two tracks: SolidCraft chapters 1–15 and FreeCAD chapters 16–24.
  Part IV starts at `chapters/16-freecad-tour.qmd`; do not merge the tracks
  without restructuring `_quarto.yml` and the index.
- `chapters/10-opencode.qmd` documents OpenCode V2 MCP setup. Verify commands
  and config shape against <https://opencode.ai/v2/docs/> before editing it;
  SolidCraft's own `mcp setup` currently writes an older `mcp.<name>` shape.
- `chapters/23-freecad-opencode.qmd` documents the FreeCAD MCP workflow; the
  install details are in `appendices/e-freecad-setup.qmd`.
- `appendices/d-open-source-landscape.qmd` compares SolidCraft with FreeCAD and
  Bonsai. Verify their current capabilities before changing those claims.
- The numbered chapter files are intentionally outlines; many carry `TODO`
  callouts. The introduction is written prose. Fill the outlines in; do not
  reorder chapters without updating `_quarto.yml` and the index.
- `designs/README.md` defines naming and headless regeneration. Keep each
  chapter's source design/script in `designs/`, final PNGs in `images/`, and
  TechDraw exports in `drawings/`.
- Render from the repo root with `quarto render` (HTML plus A4 Typst PDF).
  Quick check: `quarto render --to html`; PDF only: `quarto render --to typst`.
  A `--to` render leaves only that format in `_book`; run the full command when
  both outputs are needed. Focused chapter check:
  `quarto render chapters/<file>.qmd`.
- Output goes to `_book/`; never edit it as source. Quarto 1.10.19 and Typst
  are installed.
- The book is published at <https://shigesong.github.io/cad-for-carpentry/>.
  This repo is private and a free GitHub account cannot serve Pages from a
  private repo, so the site is built from a second public repo,
  `shigesong/cad-for-carpentry`, containing only rendered HTML. Run
  `scripts/publish-site.sh` (renders HTML into `_site/`, force-syncs that into
  a clone of the pages repo, commits, pushes) after committing source changes.
  Do not add the pages repo as a submodule or commit `_site/`.
- There is no package manifest, test suite, linter, or CI. Do not add a
  Node/Python/R toolchain or invent build steps for the book.

## SolidCraft

- Installed binaries: `/usr/bin/solidcraft` (GUI) and `/usr/bin/solidcraft-cli`.
- OpenCode's global MCP entry runs `solidcraft-cli mcp --connect 127.0.0.1:27878`.
  Every `tools.solidcraft.*` call fails with "no SolidCraft app is listening"
  until the app runs. Start `solidcraft --control 27878` (or ask the user to)
  before modeling; the next call connects.
- The MCP tools operate on one live design, not on a file path. Use `new_design`
  or `open` first, and `save` to persist. `batch` builds a whole part in one
  call; `inspect_design`, `measure`, and `body_topology` verify it.
- `screenshot({path: "..."})` writes a PNG directly, so book figures can come
  from the live design.
- Read the bundled skill before serious modeling:
  `skill_reference({skill: "solidcraft-modeling"})` (also `-checking`,
  `-editing`, `-mechanisms`). Use `list_commands` / `describe_command` for
  command ids and parameter schemas instead of relying on memory or older docs.
- Units are millimetres and degrees in expressions (radians internally), Z is up.

## FreeCAD

- Installed as a Flatpak: `flatpak run org.freecad.FreeCAD` (1.1.4). Headless:
  `flatpak run --command=freecadcmd org.freecad.FreeCAD <script.py>`.
- The FreeCAD MCP addon is a separate community component. FreeCAD must be open
  with its RPC server on `127.0.0.1:9875`; the book's OpenCode connection
  launches `uvx freecad-mcp` (not configured in this repo by default). Setup and
  troubleshooting are in Appendix E.
- The addon uses FreeCAD's bundled Python; the `freecad-mcp` package needs
  Python 3.12+ via `uv`. Do not install the package into FreeCAD's Python.
- FreeCAD documents are binary `.FCStd` files. Keep the document plus a Python
  macro/script where reproducibility matters.
- FreeCAD's feature tree is not SolidCraft's timeline. Prefer datum planes and
  named sketches over references to generated faces.

## Reproducible figures

- Headless path that does not need the app:
  `solidcraft-cli run <script.json> --results` builds a design and reports
  errors; `solidcraft-cli snapshot <script.json> --out fig.png` renders it.
  Both are verified working here.
- A command script is JSON: `[{"command": "solid.box", "params": {...}}]`.
  `solidcraft-cli script <design.solidcraft> --out script.json` extracts one
  from a saved design.
- Keep the design/script for each chapter in `designs/`, final figures in
  `images/`, and TechDraw/PDF exports in `drawings/`, so every figure can be
  regenerated. Commit sources and final outputs, not temporary renders.
- Every CAD figure must come from a saved design. Do not substitute stock or
  generated images for a model, and do not present a screenshot as a design
  that was never built.

## Archive rules

- This folder is not a git repo, and the parent `/home/shige/project` is not
  one either. Do not initialize git or commit unless asked, and never run
  archive-wide installs/builds.
- Quote paths: they contain spaces and Unicode punctuation. Do not edit
  generated or tool state such as `_book/`, `.quarto/`, or `.obsidian/`.
