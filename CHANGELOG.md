# Changelog

All notable changes to the **ForChange** project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [1.0.0] - 2026-05-27

### Added
- **Initial Release** containing two separate graphical user interface editions:
  - **Classic Win32 GUI** (`ForChange.exe`): Styled exactly like 7-Zip, fast and lightweight.
  - **Modern Wails GUI** (`ForChangeModern.exe`): Built using HTML/CSS/JS, featuring Pitch-Black and Light themes, drag-and-drop file preloading, and real-time conversion badges.
- **Silent Explorer Integration**: Cascade context menu registry setup in Windows Explorer for converting files with a single click.
- **Multiple Image Decoder/Encoder Support**: Compatible with PNG, JPEG/JPG, GIF, BMP, and TIFF. WebP is fully supported for decoding.
- **Dynamic ICO Size Controls**: Automative resize scaling maintaining aspect ratio for Windows `.ico` generation.
- **Dual-Mode execution**: Full CLI command-line support for automation and batch scripts.
