<p align="center">
  <img src="assets/logo.png" alt="ForChange Logo" width="120" height="120">
</p>

<h1 align="center">ForChange</h1>

<p align="center">
  <strong>A premium, dual-edition media converter for Windows — images, video & audio — with shell context-menu integration.</strong>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Platform-Windows-0078d7?style=for-the-badge&logo=windows" alt="Platform">
  <img src="https://img.shields.io/badge/Language-Go-00add8?style=for-the-badge&logo=go" alt="Language">
  <img src="https://img.shields.io/badge/GUI-Wails_v2-00f0ff?style=for-the-badge&logo=wails" alt="Wails">
  <img src="https://img.shields.io/badge/UI-Win32_Walk-7000ff?style=for-the-badge" alt="Walk">
  <img src="https://img.shields.io/badge/License-MIT-emerald?style=for-the-badge" alt="License">
</p>

---

**ForChange** is a highly modular, fast, and lightweight **image, video & audio converter** for Windows. It offers the best of both worlds: a **Classic Win32 Edition** styled after native Windows applications (7-Zip aesthetic), and a **Modern Edition** built with Wails featuring a sleek dark/light UI with smooth animations.

Both editions register **cascading right-click context menus** directly into Windows Explorer for instant, single-click conversions — for image, video, and audio files alike.

---

## 🌟 Editions & Key Features

### 🏛️ Classic Win32 Edition (`ForChange.exe`)
- **7-Zip Style Native UI** — Ultra-lightweight Win32 interface using `github.com/lxn/walk`
- **Minimalist & Fast** — Instant startup with negligible RAM usage
- **Full Media Support** — Convert images, video files, and audio files from a single interface
- **Integrated Context Menu** — Cascading shell menu auto-registered for images, video, and audio on installation

### 🌌 Modern Wails Edition (`ForChangeModern.exe`)
- **Premium Web GUI** — Sleek modern layout with custom glassmorphism components
- **Pitch-Black Dark Mode** — `#000000` background with glowing indigo/cyan borders and smooth theme transitions
- **Light Theme** — Soft, high-contrast white and slate color scheme
- **Drag-and-Drop** — Drop media files directly from Explorer into the app
- **Real-time Batch Badges** — Live conversion progress with success, pending, and error badges
- **Full CLI Support** — Also supports silent context-menu conversions headlessly

---

## 📊 Supported Formats

### 🖼️ Image Formats

| Format | Read | Write | Notes |
| :--- | :---: | :---: | :--- |
| **PNG** | ✅ | ✅ | Standard lossless encoding |
| **JPEG / JPG** | ✅ | ✅ | Quality slider (1–100) |
| **GIF** | ✅ | ✅ | 256-color palette encoding |
| **BMP** | ✅ | ✅ | Uncompressed bitmap |
| **TIFF / TIF** | ✅ | ✅ | Deflate compression |
| **WEBP** | ✅ | ❌ | Decode only (pure Go) |
| **ICO** | ✅ | ✅ | Auto-resized, max 256×256 px |

### 🎬 Video Formats

| Format | Read | Write | Notes |
| :--- | :---: | :---: | :--- |
| **MP4** | ✅ | ✅ | H.264, widely compatible |
| **MKV** | ✅ | ✅ | Matroska container |
| **AVI** | ✅ | ✅ | Legacy format support |
| **MOV** | ✅ | ✅ | Apple QuickTime |
| **WEBM** | ✅ | ✅ | VP8/VP9, web-optimized |
| **GIF** (from video) | ✅ | ✅ | Animated GIF extraction |
| **MP3** (from video) | ✅ | ✅ | Extract audio from video |

### 🔊 Audio Formats

| Format | Read | Write | Notes |
| :--- | :---: | :---: | :--- |
| **MP3** | ✅ | ✅ | Lossy, universal playback |
| **WAV** | ✅ | ✅ | Uncompressed PCM |
| **M4A** | ✅ | ✅ | AAC in MPEG-4 container |
| **FLAC** | ✅ | ✅ | Lossless audio |
| **AAC** | ✅ | ✅ | Advanced Audio Coding |
| **OGG** | ✅ | ✅ | Vorbis codec |

---

## 🖱️ Right-Click Context Menu Integration

One of ForChange's standout features is its deep Windows Explorer integration. After installation, **right-clicking any supported file** shows a **"ForChange Converter"** submenu with one-click conversion options — no need to open the app manually.

### How it works

The installer registers shell entries under `Software\Classes\SystemFileAssociations` in the Windows Registry — the correct, non-destructive approach that **does not interfere with existing file associations** set by other applications (e.g. VLC, Windows Media Player).

### Context menu coverage

| File Type | Extensions | Submenu Options |
| :--- | :--- | :--- |
| **Image** | All image files | Convert to PNG, JPG, BMP, GIF, ICO, Convert with GUI... |
| **Video** | `.mp4` `.mkv` `.avi` `.mov` `.webm` | Convert to MP4, WEBM, MKV, MP3 (Audio), GIF, Convert with GUI... |
| **Audio** | All audio files | Convert to MP3, WAV, M4A, FLAC, Convert with GUI... |

> **Technical note:** Video extensions each receive **two** registry entries for maximum compatibility:
> - `SystemFileAssociations\video\shell\` — PerceivedType-based, catches all video files generically
> - `SystemFileAssociations\.mp4\shell\` (per-extension) — direct extension binding, guaranteed to appear regardless of which app owns the `.mp4` association

---

## 🛠️ Installation & Compilation

### Requirements
- [Go (Golang)](https://go.dev/) 1.23 or higher
- [Node.js](https://nodejs.org/) & `npm` *(Modern edition only)*
- [Wails CLI](https://wails.io/docs/gettingstarted/installation) *(Modern edition only)*
- [Inno Setup 6](https://jrsoftware.org/isinfo.php) *(for building installers)*

### Build Steps

1. **Clone the repository:**
   ```bash
   git clone https://github.com/tommyvercetti89/ForChange.git
   cd ForChange
   ```

2. **Build the Classic Edition:**
   ```bash
   # Rebuild resources (manifest and icon)
   rsrc -manifest main.manifest -ico assets/logo.ico -o rsrc.syso

   # Build executable
   go build -ldflags="-s -w -H windowsgui" -o ForChange.exe .
   ```

3. **Build the Modern Edition:**
   ```bash
   cd modern
   wails build -platform windows/amd64 -o ForChangeModern.exe
   cd ..

   # Copy binary to root folder
   Copy-Item "modern\build\bin\ForChangeModern.exe" -Destination "ForChangeModern.exe" -Force
   ```

4. **Create Installers** *(requires Inno Setup 6)*:
   ```bash
   # Classic installer
   & "C:\Program Files (x86)\Inno Setup 6\ISCC.exe" setup.iss

   # Modern installer
   & "C:\Program Files (x86)\Inno Setup 6\ISCC.exe" setup_modern.iss
   ```

   Output installers will be placed in the `dist/` folder:
   - `dist/QBSoft_ForChange_Setup.exe`
   - `dist/QBSoft_ForChangeModern_Setup.exe`

---

## 💻 Usage

### 🎨 Graphical Mode (GUI)
Run `ForChange.exe` or `ForChangeModern.exe` without any flags to launch the GUI.

- **Add Files** — Drag & drop or use the file picker
- **Destination** — Save next to source file or choose a custom output directory
- **ICO Size** — When targeting ICO format, the Quality field switches to a Size selector (16–256 px)

### 💻 Command-Line Mode (CLI)
Both binaries support headless CLI usage:

```bash
# Convert image to PNG
ForChange.exe -i photo.jpg -f png

# Convert image to JPG at 90% quality
ForChange.exe -i photo.png -o output.jpg -f jpg -q 90

# Convert image to 128px Windows icon
ForChange.exe -i logo.png -o logo.ico -f ico -q 128

# Convert video to MP4
ForChange.exe -i video.mkv -f mp4

# Convert video to WEBM
ForChange.exe -i video.mp4 -f webm

# Extract audio from video as MP3
ForChange.exe -i video.mp4 -f mp3

# Convert audio to FLAC
ForChange.exe -i music.mp3 -f flac

# Convert audio to WAV
ForChange.exe -i podcast.m4a -f wav
```

#### Available CLI Flags

| Flag | Description | Required |
| :--- | :--- | :---: |
| `-i` | Input file path | ✅ |
| `-o` | Output file path | ❌ |
| `-f` | Target format (see tables above) | ✅ |
| `-q` | Quality `1–100` (JPEG) or size `16–256` (ICO) | ❌ |

---

## 📁 Project Structure

```
ForChange/
├── main.go                  # Entry point — CLI flag routing & GUI fallback
├── cli/
│   └── cli.go               # Headless conversion logic
├── converter/
│   ├── converter.go         # Image conversion engine
│   ├── media.go             # Video & audio conversion (FFmpeg wrapper)
│   └── ffmpeg_embed.go      # Embedded FFmpeg binary
├── gui/
│   └── gui.go               # Classic Win32 GUI (Walk)
├── modern/
│   ├── main.go              # Wails app entry point
│   ├── app.go               # Go backend bindings
│   └── frontend/            # Web UI (HTML/CSS/JS)
├── assets/                  # Icons and images
├── setup.iss                # Inno Setup script — Classic edition
├── setup_modern.iss         # Inno Setup script — Modern edition
└── dist/                    # Generated installers (git-ignored)
```

---

## 📋 Changelog

### Latest Changes
- **Video context menu fixed** — Right-clicking `.mp4`, `.mkv`, `.avi`, `.mov`, `.webm` files now correctly shows the **ForChange Converter** submenu in Windows Explorer. Previously used `.ext\shell\` registry path which is overridden by other apps; now uses the correct `SystemFileAssociations\.ext\shell\` approach.
- **Full video format support** — MP4, MKV, AVI, MOV, WEBM conversion added via embedded FFmpeg
- **Audio extraction from video** — Convert any video file directly to MP3
- **Animated GIF from video** — Extract and convert video clips to animated GIF
- **Audio conversion** — MP3 ↔ WAV ↔ M4A ↔ FLAC ↔ AAC ↔ OGG

---

## 🤝 Collaboration & Credits
This project was developed by **tommyvercetti89** in pair-programming collaboration with **Antigravity**, a powerful agentic AI coding assistant designed by the Google DeepMind team.

---

## ⚖️ License
Distributed under the MIT License. See `LICENSE` for more details.
