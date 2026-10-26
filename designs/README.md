# Designs and figures

Keep the source model for each chapter here, next to the figures and drawings it
produces. A chapter should never contain a picture that cannot be regenerated
from a saved design.

## Naming

Use the chapter number and a short part name.

SolidCraft:

- `11-fence-panel.solidcraft` — a saved design container
- `11-fence-panel.json` — a command script or plain JSON design
- `12-deck-frame.solidcraft`
- `13-shed-roof.solidcraft`

FreeCAD:

- `20-fence.FCStd` — a FreeCAD document
- `20-fence.py` — a macro or headless build script
- `21-deck.FCStd`
- `22-shed.FCStd`
- `20-fence.step` — a neutral export

Put exported figures in `images/` and drawing sheets in `drawings/` with the
same prefix, for example `images/20-fence-iso.png` and
`drawings/20-fence.pdf`.

## Regenerating a SolidCraft figure

A command script is a JSON array of `{command, params}` objects:

```json
[
  {"command": "solid.box", "params": {"length": 90, "width": 90, "height": 2400}}
]
```

Build it without opening the app:

```bash
solidcraft-cli run designs/11-fence-panel.json --results
```

Render a figure:

```bash
solidcraft-cli snapshot designs/11-fence-panel.json \
  --out images/11-fence-panel-iso.png --width 1200 --height 800
```

For a view saved in the design, pass `--view <name>`. For a section, pass
`--section` with a plane or coordinate; see `solidcraft-cli --help`.

## Regenerating a FreeCAD figure

FreeCAD documents are binary `.FCStd` files. Keep the document and, where
possible, a Python macro or script that rebuilds the important parts.

Run a script headlessly:

```bash
flatpak run --command=freecadcmd org.freecad.FreeCAD designs/20-fence.py
```

A native installation usually provides `freecadcmd` directly. Export figures
from the GUI, or from the script with FreeCAD's export API. TechDraw pages are
exported to `drawings/` as PDF, SVG, or DXF.

## What to keep

- the design, document, or command script;
- the macro or Python script if the model was built by code;
- the final PNG or drawing used in the book;
- a one-line note in the chapter saying how the figure was made.

Do not keep temporary renders, autosaves, or screenshots of error dialogs.
