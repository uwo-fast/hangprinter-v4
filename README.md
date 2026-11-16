# FAST's Hangprinter v4

FAST's build of the [Hangprinter](https://hangprinter.org/) v4, the open-source
cable-driven RepRap 3D printer by Torbjørn Ludvigsen. The print head hangs from
cables anchored to the room, so the build volume is set by the room rather than
a frame. This is not the official Hangprinter v4; the upstream project is at
<https://gitlab.com/tobben/hangprinter>.

## The build

The machine follows the upstream [v4 documentation](https://hangprinter.org/doc/v4/).
It differs from the standard build in:

- an effector triangle of 2040 aluminium extrusion instead of wooden beams
- a Mean Well SE-1000-24 power supply
- a Duet 3 Toolboard 1LC on the effector, over CAN, so extruders can be swapped
- an E3D Hemera extruder with a Revo hotend

Ravneet Rattan started the build in summer 2022. After it was taken down in late
2023, Jahangir (Janik) Abdullayev, Ravneet and Troy Leishman rehung and upgraded
it; it printed again on 5 June 2024, and Janik maintains it. Build photos, notes
and videos are on the [Appropedia page](https://www.appropedia.org/FAST's_Hangprinter_v4).
The CAD for the FAST parts is in
[Onshape](https://cad.onshape.com/documents/8ef2171b7d467a0be2c57f48), outside this
repository.

## Contents

- [`config.g`](config.g): the RepRapFirmware configuration for the machine's Duet 3
  board, modified from upstream's `firmware/RepRapFirmware/Duet3/config.g`. Its
  header lists what changed.

The anchor positions (`M669`), spool values and flex-compensation values in
`config.g` come from this machine's calibration in June 2024. Another build needs
its own: calibrate as the upstream documentation describes before using them.

## Related work

R. S. Rattan, N. Nauta, A. Romani, J. M. Pearce, "Hangprinter for large scale
additive manufacturing using fused particle fabrication with recycled plastic and
continuous feeding", *HardwareX* 13 (2023) e00401,
[doi:10.1016/j.ohx.2023.e00401](https://doi.org/10.1016/j.ohx.2023.e00401). It
describes FAST's hybrid of Hangprinter v3 and v4 with NEMA 23 steppers and a
recycled-plastic pellet extruder; its design files are on
[OSF](https://doi.org/10.17605/OSF.IO/NDWS6).

## Licence

GPL-2.0-only, to match the upstream Hangprinter project. See
[LICENSING.md](LICENSING.md).

## Contact

Maintained by the [FAST research group](https://uwo-fast.github.io/). For questions
about this machine, contact [Janik](https://www.appropedia.org/User:Janik).
