package converter

import (
	_ "embed"
	"fmt"
	"os"
	"path/filepath"
	"sync"
)

//go:embed ffmpeg.exe
var ffmpegBytes []byte

var (
	extractedPath string
	extractOnce   sync.Once
	extractErr    error
)

// GetFFmpegPath extracts the embedded ffmpeg.exe to local appdata on first call
// and returns the path to the executable.
func GetFFmpegPath() (string, error) {
	extractOnce.Do(func() {
		if len(ffmpegBytes) == 0 {
			extractErr = fmt.Errorf("embedded ffmpeg binary is empty")
			return
		}

		// Use Local AppData for storing the binary, falling back to APPDATA or TempDir
		appData := os.Getenv("LOCALAPPDATA")
		if appData == "" {
			appData = os.Getenv("APPDATA")
		}
		if appData == "" {
			appData = os.TempDir()
		}

		dir := filepath.Join(appData, "ForChange")
		err := os.MkdirAll(dir, 0755)
		if err != nil {
			extractErr = fmt.Errorf("failed to create directory for ffmpeg: %w", err)
			return
		}

		// Use versioned binary so updates are clean
		targetPath := filepath.Join(dir, "ffmpeg_v1.exe")

		// Check if file already exists with same size to avoid redundant writes
		info, err := os.Stat(targetPath)
		if err == nil && info.Size() == int64(len(ffmpegBytes)) {
			extractedPath = targetPath
			return
		}

		// Write the binary to disk
		err = os.WriteFile(targetPath, ffmpegBytes, 0755)
		if err != nil {
			extractErr = fmt.Errorf("failed to extract embedded ffmpeg binary: %w", err)
			return
		}

		extractedPath = targetPath
	})

	return extractedPath, extractErr
}
