# Contributing to ForChange

Thank you for your interest in contributing to **ForChange**! We welcome bug reports, feature suggestions, and pull requests to make this image converter even better.

Please follow these guidelines to ensure a smooth collaboration.

---

## 🛠️ Development Setup

To build and run ForChange locally, you will need:
*   **Go (Golang)**: v1.23 or higher.
*   **Node.js & npm**: Required only for compiling and running the Modern edition (Wails).
*   **Wails CLI**: Install it using `go install github.com/wailsapp/wails/v2/cmd/wails@latest`.

### Running Locally

#### 🏛️ Classic Edition
You can compile and run the classic Win32 application from the root directory:
```bash
# Build the binary
go build -o ForChange.exe

# Run the program
./ForChange.exe
```

#### 🌌 Modern Edition
You can run the modern Wails edition in developer mode with live-reload:
```bash
# Navigate to modern directory
cd modern

# Start Wails dev server (watches frontend and backend modifications)
wails dev
```

---

## 📝 Coding Standards

*   **Go formatting**: Always run `go fmt ./...` before submitting your changes.
*   **Comments**: Keep code comments concise, clean, and in English.
*   **Aesthetics**: When modifying the modern interface, maintain the premium dark/light HSL colors and glassmorphism styling defined in `app.css`.

---

## 🚀 Submitting a Pull Request (PR)

1.  **Fork** the repository and create your branch from `main`:
    ```bash
    git checkout -b feature/your-awesome-feature
    ```
2.  Commit your changes with clean commit messages.
3.  Push your branch to your fork.
4.  Open a **Pull Request** explaining your changes, what you tested, and any relevant context.
5.  Wait for review and approval!
