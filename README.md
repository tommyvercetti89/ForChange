# ForChange

<p align="center">
  <strong>A high-performance, professional-grade Win32 native image converter for Windows.</strong>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Platform-Windows-0078d7?style=flat-square" alt="Platform">
  <img src="https://img.shields.io/badge/Language-Go-00add8?style=flat-square" alt="Language">
  <img src="https://img.shields.io/badge/License-MIT-green?style=flat-square" alt="License">
</p>

---

**ForChange** is a fast, lightweight, and native Windows image converter. It features a classic Win32 graphical user interface designed to look and feel **exactly like 7-Zip**, alongside a fully functional command-line interface (CLI) for terminal usage and batch automation.

---

## 🌟 Key Features

-   **7-Zip Style Native UI**: Sleek, lightweight classic Windows design with a TableView grid, toolbar controls, and status logging.
-   **Dual Mode Execution**: Launches as a native GUI when double-clicked, or runs directly inside your terminal when flags are provided.
-   **Wide Format Support**: 
    -   **Decode/Read**: PNG, JPEG/JPG, GIF, BMP, TIFF, and WEBP.
    -   **Encode/Write**: PNG, JPEG/JPG, GIF, BMP, and TIFF.
-   **Asynchronous Processing**: Image encoding runs in background threads, keeping the GUI smooth, responsive, and crash-free.
-   **No External Dependencies**: Built entirely in pure Go (CGO disabled). Does not require MinGW/GCC or any external C libraries to compile or run on Windows.

---

## 💻 Installation & Compilation

### Requirements
*   [Go (Golang)](https://go.dev/) 1.16 or higher

### Build Steps
1.  Clone the repository:
    ```bash
    git clone https://github.com/tommyvercetti89/Downloader.git
    ```
2.  Navigate to the directory and build the executable:
    ```bash
    go build -ldflags="-H windowsgui" -o ForChange.exe
    ```
    *(Note: Using `-ldflags="-H windowsgui"` compiles the binary as a GUI application, preventing the CMD window from opening when double-clicked).*

---

## 🛠️ Usage

### 🎨 Graphical Mode (GUI)
Simply run `ForChange.exe` without any arguments. 
*   **Add**: Click `➕ Add` to choose images to convert.
*   **Remove / Clear**: Manage the files in the list.
*   **Format & Quality**: Choose the target format from the dropdown menu and set the compression quality (1-100).
*   **Convert**: Click `⚡ Convert All` to process the entire queue asynchronously.

### 💻 Command-Line Mode (CLI)
Run `ForChange.exe` with flags from command prompt or PowerShell:

```bash
# Convert PNG to JPEG with 85% quality
./ForChange.exe -i input.png -o output.jpg -f jpg -q 85

# Convert BMP to PNG (default output path will be input.png)
./ForChange.exe -i input.bmp -f png
```

#### Available Flags
*   `-i` : Input image file path (required).
*   `-o` : Output image file path (optional).
*   `-f` : Target image format (`png`, `jpg`, `gif`, `bmp`, `tiff`, `ico`).
*   `-q` : JPEG compression quality (`1` to `100`, default is `80`) or icon size (`16` to `256`, `ico`).

---

## 🤝 Collaboration & Credits
This project was developed by **tommyvercetti89** in pair-programming collaboration with **Antigravity**, a powerful agentic AI coding assistant designed by the Google DeepMind team.

---

## ⚖️ License
Distributed under the MIT License. See `LICENSE` for more information.
