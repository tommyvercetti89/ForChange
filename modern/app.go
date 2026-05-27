package main

import (
	"context"
	"forchange/converter"
	"os"
	"path/filepath"
	"strings"

	"github.com/wailsapp/wails/v2/pkg/runtime"
)

// App struct
type App struct {
	ctx          context.Context
	initialFiles []string
}

// NewApp creates a new App struct
func NewApp() *App {
	return &App{}
}

// startup is called when the app starts.
func (a *App) startup(ctx context.Context) {
	a.ctx = ctx
}

// GetInitialFiles returns the file info of initial files passed on CLI launch
func (a *App) GetInitialFiles() []FileInfo {
	var infos []FileInfo
	for _, f := range a.initialFiles {
		info, err := a.GetFileInfo(f)
		if err == nil {
			infos = append(infos, info)
		}
	}
	return infos
}

// FileInfo represents file metadata sent to the frontend
type FileInfo struct {
	Name   string `json:"name"`
	Size   int64  `json:"size"`
	Format string `json:"format"`
	Path   string `json:"path"`
}

// SelectFiles opens a file dialog to choose image files
func (a *App) SelectFiles() ([]FileInfo, error) {
	files, err := runtime.OpenMultipleFilesDialog(a.ctx, runtime.OpenDialogOptions{
		Title: "Select Images to Convert",
		Filters: []runtime.FileFilter{
			{
				DisplayName: "Image Files (*.png;*.jpg;*.jpeg;*.gif;*.bmp;*.tiff;*.webp;*.ico)",
				Pattern:     "*.png;*.jpg;*.jpeg;*.gif;*.bmp;*.tiff;*.webp;*.ico",
			},
			{
				DisplayName: "All Files (*.*)",
				Pattern:     "*.*",
			},
		},
	})
	if err != nil {
		return nil, err
	}

	var infos []FileInfo
	for _, f := range files {
		info, err := a.GetFileInfo(f)
		if err == nil {
			infos = append(infos, info)
		}
	}
	return infos, nil
}

// SelectFolder opens a folder dialog to choose destination directory
func (a *App) SelectFolder() (string, error) {
	folder, err := runtime.OpenDirectoryDialog(a.ctx, runtime.OpenDialogOptions{
		Title: "Select Destination Folder",
	})
	return folder, err
}

// GetFileInfo fetches details of a given file path
func (a *App) GetFileInfo(filePath string) (FileInfo, error) {
	info, err := os.Stat(filePath)
	if err != nil {
		return FileInfo{}, err
	}
	ext := strings.ToLower(filepath.Ext(filePath))
	fmtName := strings.TrimPrefix(ext, ".")
	if fmtName == "" {
		fmtName = "unknown"
	}
	return FileInfo{
		Name:   filepath.Base(filePath),
		Size:   info.Size(),
		Format: strings.ToUpper(fmtName),
		Path:   filePath,
	}, nil
}

// ConvertFile converts a single file to target format with specified options
func (a *App) ConvertFile(filePath string, targetFormat string, qualityOrSize int, useSource bool, destDir string) error {
	var outPath string
	if !useSource {
		ext := "." + strings.ToLower(targetFormat)
		if strings.ToLower(targetFormat) == "jpeg" {
			ext = ".jpg"
		}
		base := filepath.Base(filePath)
		name := strings.TrimSuffix(base, filepath.Ext(base))
		outPath = filepath.Join(destDir, name+ext)
	}
	return converter.ConvertImage(filePath, outPath, targetFormat, qualityOrSize)
}
