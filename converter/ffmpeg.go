package converter

import (
	"fmt"
	"os"
	"os/exec"
	"path/filepath"
	"sync"
)

var (
	extractedPath string
	extractOnce   sync.Once
	extractErr    error
)

// GetFFmpegPath locates or extracts an FFmpeg binary.
// Discovery order:
// 1. Portable application directory (next to the running executable)
// 2. System PATH (e.g. C:\ffmpeg\bin\ffmpeg.exe)
// 3. LocalAppData cached/extracted binary (%LOCALAPPDATA%\ForChange\ffmpeg_v1.exe)
// 4. Embedded binary (if compiled with -tags embed_ffmpeg)
func GetFFmpegPath() (string, error) {
	extractOnce.Do(func() {
		// 1. Check if ffmpeg.exe is in the same directory as the running executable
		if exePath, err := os.Executable(); err == nil {
			appDir := filepath.Dir(exePath)
			localFFmpeg := filepath.Join(appDir, "ffmpeg.exe")
			if info, err := os.Stat(localFFmpeg); err == nil && !info.IsDir() {
				extractedPath = localFFmpeg
				return
			}
		}

		// 2. Check if ffmpeg is available in system PATH
		if sysPath, err := exec.LookPath("ffmpeg"); err == nil {
			extractedPath = sysPath
			return
		}
		if sysPath, err := exec.LookPath("ffmpeg.exe"); err == nil {
			extractedPath = sysPath
			return
		}

		// 3. Check LocalAppData for a previously extracted binary
		appData := os.Getenv("LOCALAPPDATA")
		if appData == "" {
			appData = os.Getenv("APPDATA")
		}
		if appData == "" {
			appData = os.TempDir()
		}
		targetDir := filepath.Join(appData, "ForChange")
		targetPath := filepath.Join(targetDir, "ffmpeg_v1.exe")

		if info, err := os.Stat(targetPath); err == nil && !info.IsDir() && info.Size() > 0 {
			extractedPath = targetPath
			return
		}

		// 4. If embedded binary is present, extract it to LocalAppData
		if len(ffmpegBytes) > 0 {
			err := os.MkdirAll(targetDir, 0755)
			if err != nil {
				extractErr = fmt.Errorf("failed to create directory for ffmpeg: %w", err)
				return
			}
			err = os.WriteFile(targetPath, ffmpegBytes, 0755)
			if err != nil {
				extractErr = fmt.Errorf("failed to extract embedded ffmpeg binary: %w", err)
				return
			}
			extractedPath = targetPath
			return
		}

		extractErr = fmt.Errorf("FFmpeg binary not found. Please install FFmpeg and add it to your PATH, or place ffmpeg.exe next to the application")
	})

	return extractedPath, extractErr
}
