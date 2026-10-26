# Figures

Final PNGs referenced by the chapters live here. Each one should be
regenerable from a design in `../designs/`.

Naming follows the chapter prefix:

- `11-fence-panel-iso.png` — SolidCraft fence
- `12-deck-frame-plan.png` — SolidCraft deck
- `13-shed-roof-section.png` — SolidCraft shed
- `20-fence-iso.png` — FreeCAD fence
- `21-deck-plan.png` — FreeCAD deck
- `22-shed-plan.png` — FreeCAD/BIM shed

TechDraw exports go in `../drawings/`, not here.

Use a relative path from the chapter:

```markdown
![Fence panel: isometric view](../images/11-fence-panel-iso.png){#fig-fence-iso}
```

Use a caption, refer to the figure with `@fig-...`, and include a dimension or
scale note when the image is used as a construction reference. Do not edit a
PNG by hand; regenerate it from the design.
