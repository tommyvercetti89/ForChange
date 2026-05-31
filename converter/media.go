package converter

import (
	"fmt"
	"os/exec"
	"path/filepath"
	"strings"
	"syscall"
)

// GetFileType determines the type of media file based on its extension.
func GetFileType(path string) string {
	ext := strings.ToLower(filepath.Ext(path))
	switch ext {
	case ".png", ".jpg", ".jpeg", ".gif", ".bmp", ".tiff", ".tif", ".webp", ".ico":
		return "image"
	case ".mp4", ".mkv", ".avi", ".mov", ".webm", ".flv", ".wmv", ".m4v", ".3gp":
		return "video"
	case ".mp3", ".wav", ".aac", ".flac", ".ogg", ".m4a", ".wma", ".opus":
		return "audio"
	default:
		return "unknown"
	}
}

// ConvertMedia converts video/audio files using the embedded ffmpeg.
func ConvertMedia(inputPath, outputPath, targetFormat string, quality int, resolution string) error {
	ffmpegPath, err := GetFFmpegPath()
	if err != nil {
		return fmt.Errorf("failed to obtain FFmpeg binary: %w", err)
	}

	targetFormat = strings.ToLower(targetFormat)

	// Auto-generate output path if empty
	if outputPath == "" {
		ext := "." + targetFormat
		// Match GIF output extension
		if targetFormat == "gif_video" || targetFormat == "gif" {
			ext = ".gif"
		}
		dir := filepath.Dir(inputPath)
		base := filepath.Base(inputPath)
		name := strings.TrimSuffix(base, filepath.Ext(base))
		outputPath = filepath.Join(dir, name+ext)
	}

	// Prepare ffmpeg arguments
	args := []string{"-y", "-i", inputPath}

	// Determine if target is audio
	isAudioTarget := false
	switch targetFormat {
	case "mp3", "wav", "aac", "flac", "ogg", "m4a":
		isAudioTarget = true
	}

	if isAudioTarget {
		// Map quality (1-100) to audio bitrate
		bitrate := "192k"
		if quality >= 90 {
			bitrate = "320k"
		} else if quality >= 70 {
			bitrate = "256k"
		} else if quality >= 50 {
			bitrate = "192k"
		} else if quality >= 30 {
			bitrate = "128k"
		} else {
			bitrate = "96k"
		}

		switch targetFormat {
		case "mp3":
			args = append(args, "-c:a", "libmp3lame", "-b:a", bitrate)
		case "wav":
			args = append(args, "-c:a", "pcm_s16le") // WAV is lossless
		case "aac", "m4a":
			args = append(args, "-c:a", "aac", "-b:a", bitrate)
		case "flac":
			args = append(args, "-c:a", "flac") // FLAC is lossless
		case "ogg":
			args = append(args, "-c:a", "libvorbis", "-b:a", bitrate)
		}
	} else {
		// Video targets (mp4, mkv, avi, mov, webm, gif_video)
		// Map quality (1-100) to CRF (51 - 0)
		crf := 51 - (quality * 51 / 100)
		if crf < 0 {
			crf = 0
		} else if crf > 51 {
			crf = 51
		}

		// Add resolution scaling if requested
		var scaleFilter string
		switch strings.ToLower(resolution) {
		case "1080p":
			scaleFilter = "scale=-2:1080"
		case "720p":
			scaleFilter = "scale=-2:720"
		case "480p":
			scaleFilter = "scale=-2:480"
		case "360p":
			scaleFilter = "scale=-2:360"
		}

		switch targetFormat {
		case "gif", "gif_video":
			// Video to high-quality animated GIF
			fps := 15
			width := 480
			if quality >= 80 {
				width = 640
				fps = 20
			} else if quality < 40 {
				width = 320
				fps = 10
			}
			filter := fmt.Sprintf("fps=%d,scale=%d:-1:flags=lanczos", fps, width)
			if scaleFilter != "" {
				filter = fmt.Sprintf("fps=%d,%s:flags=lanczos", fps, scaleFilter)
			}
			// Single-pass high quality palette generation filter graph
			filterGraph := fmt.Sprintf("%s,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse", filter)
			args = append(args, "-vf", filterGraph)
		case "mp4":
			args = append(args, "-c:v", "libx264", "-crf", fmt.Sprintf("%d", crf), "-pix_fmt", "yuv420p", "-c:a", "aac", "-b:a", "128k")
			if scaleFilter != "" {
				args = append(args, "-vf", scaleFilter)
			}
		case "webm":
			args = append(args, "-c:v", "libvpx-vp9", "-crf", fmt.Sprintf("%d", crf), "-b:v", "0", "-c:a", "libopus")
			if scaleFilter != "" {
				args = append(args, "-vf", scaleFilter)
			}
		case "mkv":
			args = append(args, "-c:v", "libx264", "-crf", fmt.Sprintf("%d", crf), "-c:a", "aac", "-b:a", "128k")
			if scaleFilter != "" {
				args = append(args, "-vf", scaleFilter)
			}
		case "mov":
			args = append(args, "-c:v", "libx264", "-crf", fmt.Sprintf("%d", crf), "-c:a", "aac", "-b:a", "128k")
			if scaleFilter != "" {
				args = append(args, "-vf", scaleFilter)
			}
		case "avi":
			args = append(args, "-c:v", "mpeg4", "-q:v", fmt.Sprintf("%d", (crf/2)+1), "-c:a", "libmp3lame", "-b:a", "128k")
			if scaleFilter != "" {
				args = append(args, "-vf", scaleFilter)
			}
		default:
			return fmt.Errorf("unsupported video target format: %s", targetFormat)
		}
	}

	args = append(args, outputPath)

	cmd := exec.Command(ffmpegPath, args...)
	// Ensure the CLI window is hidden on Windows
	cmd.SysProcAttr = &syscall.SysProcAttr{
		HideWindow: true,
	}

	output, err := cmd.CombinedOutput()
	if err != nil {
		return fmt.Errorf("FFmpeg error: %v, details: %s", err, string(output))
	}

	return nil
}
