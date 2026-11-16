# Licensing

Everything in this repository is licensed under the GNU General Public License,
version 2 only (`GPL-2.0-only`). The full text is in [`LICENSE`](LICENSE), a
byte-for-byte copy of the upstream Hangprinter project's `LICENSE`.

## Why GPL-2.0-only

This is a build of Torbjørn Ludvigsen's [Hangprinter](https://hangprinter.org/)
v4, and [`config.g`](config.g) is a modified copy of the upstream
`firmware/RepRapFirmware/Duet3/config.g`. The upstream repository is licensed
GPL-2.0 and has been since its first commit; its
[FAQ](https://hangprinter.org/FAQ/) says "Hangprinter (the repo) is under
GPLv2". Upstream states no "or later" option, so files derived from it stay
under version 2 only.

This differs from the FAST
[licensing policy](https://github.com/uwo-fast/.github/blob/main/LICENSING.md)
(`GPL-3.0-or-later` with `CERN-OHL-S-2.0` for hardware), because GPL-2.0-only
cannot be combined with either. The upstream licence takes precedence here.

## What is FAST's

`config.g` notes in its header what FAST changed and when. The rest of the file,
including most of its comments, is upstream's.

The CAD linked from the [README](README.md) is in Onshape, outside this
repository, and this licence does not cover it. It also contains third-party
vendor models.
