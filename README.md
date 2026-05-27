# ⚡ ForChange

<p align="center">
  <strong>A premium, dual-edition image converter for Windows with shell context-menu integrations.</strong>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Platform-Windows-0078d7?style=for-the-badge&logo=windows" alt="Platform">
  <img src="https://img.shields.io/badge/Language-Go-00add8?style=for-the-badge&logo=go" alt="Language">
  <img src="https://img.shields.io/badge/GUI-Wails_v2-00f0ff?style=for-the-badge&logo=wails" alt="Wails">
  <img src="https://img.shields.io/badge/UI-Win32_Walk-7000ff?style=for-the-badge" alt="Walk">
  <img src="https://img.shields.io/badge/License-MIT-emerald?style=for-the-badge" alt="License">
</p>

---

**ForChange** is a highly modular, fast, and lightweight image converter for Windows. It is designed to offer the best of both worlds: a **Classic Win32 Edition** for lovers of native, retro aesthetics (styled exactly like 7-Zip), and a **Modern Edition** built with Wails using sleek web technologies (offering smooth animations and pitch-black dark/light theme switching).

Both editions feature silent right-click context menu shortcuts in Windows Explorer for instant, single-click image conversions without touching your original file.

---

## 🌟 Editions & Key Features

### 🏛️ Classic Win32 Edition
*   **7-Zip Style Native UI**: Ultra-lightweight classic Win32 interface using `github.com/lxn/walk`.
*   **Minimalist & Fast**: Instantly opens with negligible RAM usage.
*   **Integrated Registry Tools**: Automatically registers cascading menu options under Windows Explorer right-click for quick conversion.

### 🌌 Modern Wails Edition
*   **Premium Web GUI**: Sleek modern layout styled with custom glassmorphism components.
*   **Pitch-Black Theme**: A dark mode (`#000000`) featuring glowing indigo/cyan borders and smooth theme transitions.
*   **Light Theme**: Soft, high-contrast white and slate color scheme.
*   **Drag-and-Drop Operations**: Drag image files directly from Explorer into the app interface to load them.
*   **Real-time Batch Badges**: Watch conversion progress dynamically via custom success, pending, and error badges.
*   **CLI Support**: The modern binary (`ForChangeModern.exe`) also supports silent context menu conversions!

---

## 📊 Supported Formats

| Format | Decode / Read | Encode / Write | Notes / Constraints |
| :--- | :---: | :---: | :--- |
| **PNG** | ✅ | ✅ | Standard lossless encoding |
| **JPEG / JPG** | ✅ | ✅ | Quality compression slider (1 - 100) |
| **GIF** | ✅ | ✅ | 256-color palette encoding |
| **BMP** | ✅ | ✅ | Uncompressed bitmap |
| **TIFF / TIF** | ✅ | ✅ | Deflate compression |
| **WEBP** | ✅ | ❌ | Pure Go decoding |
| **ICO** | ✅ | ✅ | Auto-resized maintaining aspect ratio (Max 256x256) |

---

## 🛠️ Installation & Compilation

### Requirements
*   [Go (Golang)](https://go.dev/) 1.23 or higher
*   [Node.js](https://nodejs.org/) & `npm` (Required only for compilation of the Modern edition)
*   [Wails CLI](https://wails.io/docs/gettingstarted/installation) (Required only for compiling the Modern edition)

### Build Steps

1.  Clone the repository:
    ```bash
    git clone https://github.com/tommyvercetti89/ForChange.git
    cd ForChange
    ```

2.  **Build the Classic Edition**:
    ```bash
    # Rebuild resources (manifest and icon)
    rsrc -manifest main.manifest -ico assets/logo.ico -o rsrc.syso
    
    # Build executable in root folder
    go build -o ForChange.exe
    ```

3.  **Build the Modern Edition**:
    ```bash
    # Navigate to modern directory and run wails build
    cd modern
    wails build
    cd ..
    
    # Copy compiled binary to root folder
    Copy-Item -Path "modern\build\bin\ForChangeModern.exe" -Destination ".\ForChangeModern.exe" -Force
    ```

4.  **Create Setup Installers** (Requires Inno Setup installed on Windows):
    ```bash
    # Compile Classic installer
    & "C:\Program Files (x86)\Inno Setup 6\ISCC.exe" setup.iss
    
    # Compile Modern installer
    & "C:\Program Files (x86)\Inno Setup 6\ISCC.exe" setup_modern.iss
    ```

Installers will be generated under the `dist/` folder:
*   `dist/QBSoft_ForChange_Setup.exe` (Classic setup)
*   `dist/QBSoft_ForChangeModern_Setup.exe` (Modern setup)

---

## 💻 Usage

### 🎨 Graphical Mode (GUI)
Run either `ForChange.exe` or `ForChangeModern.exe` without any CLI flags. 
*   **Add Files**: Drag and drop images or click selection buttons.
*   **Destination Settings**: Choose whether to save output files in the same directory as source files, or browse to choose a custom directory.
*   **ICO Size Selector**: When choosing **ICO** as target format, the Quality field dynamically switches to **Size (px)** allowing bounds configuration from `16px` to `256px`.

### 💻 Command-Line Mode (CLI)
Both binaries can run headlessly from Command Prompt, PowerShell, or shortcut commands:

```bash
# Convert image to PNG
./ForChange.exe -i image.jpg -f png

# Convert image to JPG with 90% quality
./ForChange.exe -i image.png -o output.jpg -f jpg -q 90

# Convert image to 128x128 Windows Icon (ICO) using Modern CLI
./ForChangeModern.exe -i image.png -o logo.ico -f ico -q 128
```

#### Available CLI Flags
*   `-i` : Input image path (required).
*   `-o` : Output image path (optional).
*   `-f` : Target format: `png`, `jpg`/`jpeg`, `gif`, `bmp`, `tiff`, `ico`.
*   `-q` : Quality compression (`1-100` for JPEGs) or icon size (`16-256` for ICOs).

---

## 🤝 Collaboration & Credits
This project was developed by **tommyvercetti89** in pair-programming collaboration with **Antigravity**, a powerful agentic AI coding assistant designed by the Google DeepMind team.

---

## ⚖️ License
Distributed under the MIT License. See `LICENSE` for more details.
