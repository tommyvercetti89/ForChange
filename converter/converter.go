package converter

import (
	"fmt"
	"image"
	"image/color"
	"image/gif"
	"image/jpeg"
	"image/png"
	"os"
	"path/filepath"
	"strings"

	"github.com/sergeymakinen/go-ico"
	"golang.org/x/image/bmp"
	"golang.org/x/image/draw"
	"golang.org/x/image/tiff"
	_ "golang.org/x/image/webp" // Webp decoding support
)

// ConvertImage decodes the input file and encodes it to the target format.
func ConvertImage(inputPath, outputPath, targetFormat string, qualityOrSize int) error {
	// Open input file
	inFile, err := os.Open(inputPath)
	if err != nil {
		return fmt.Errorf("failed to open input file: %w", err)
	}
	defer inFile.Close()

	// Decode image automatically based on registered decoders
	img, _, err := image.Decode(inFile)
	if err != nil {
		return fmt.Errorf("failed to decode image: %w", err)
	}

	targetFormat = strings.ToLower(targetFormat)

	// Generate default output path if not specified
	if outputPath == "" {
		ext := "." + targetFormat
		if targetFormat == "jpeg" {
			ext = ".jpg"
		}
		dir := filepath.Dir(inputPath)
		base := filepath.Base(inputPath)
		name := strings.TrimSuffix(base, filepath.Ext(base))
		outputPath = filepath.Join(dir, name+ext)
	}

	// Prevent overwriting the original file directly
	if filepath.Clean(outputPath) == filepath.Clean(inputPath) {
		dir := filepath.Dir(inputPath)
		base := filepath.Base(inputPath)
		ext := filepath.Ext(inputPath)
		name := strings.TrimSuffix(base, ext)
		outputPath = filepath.Join(dir, name+"_converted"+ext)
	}

	// Create output file
	outFile, err := os.Create(outputPath)
	if err != nil {
		return fmt.Errorf("failed to create output file: %w", err)
	}
	success := false
	defer func() {
		_ = outFile.Close()
		if !success {
			_ = os.Remove(outputPath)
		}
	}()

	// Encode to the desired target format
	switch targetFormat {
	case "png":
		enc := png.Encoder{CompressionLevel: png.BestCompression}
		err = enc.Encode(outFile, img)
	case "jpeg", "jpg":
		q := qualityOrSize
		if q < 1 {
			q = 80
		} else if q > 100 {
			q = 100
		}
		// Composite over a clean white background if the image has transparent areas to prevent ugly black backgrounds
		bounds := img.Bounds()
		opaqueImg := image.NewRGBA(bounds)
		draw.Draw(opaqueImg, bounds, &image.Uniform{C: color.White}, image.Point{}, draw.Src)
		draw.Draw(opaqueImg, bounds, img, bounds.Min, draw.Over)
		err = jpeg.Encode(outFile, opaqueImg, &jpeg.Options{Quality: q})
	case "gif":
		err = gif.Encode(outFile, img, &gif.Options{NumColors: 256})
	case "bmp":
		err = bmp.Encode(outFile, img)
	case "tiff", "tif":
		err = tiff.Encode(outFile, img, &tiff.Options{Compression: tiff.Deflate})
	case "ico":
		bounds := img.Bounds()
		width := bounds.Dx()
		height := bounds.Dy()
		if width <= 0 || height <= 0 {
			return fmt.Errorf("invalid image dimensions for ICO: %dx%d", width, height)
		}

		// Ensure icon size is between 16 and 256. Default to 256 if not specified or invalid.
		sz := qualityOrSize
		if sz < 16 || sz > 256 {
			sz = 256
		}

		// Calculate scaled dimensions preserving aspect ratio
		var newW, newH int
		if width > height {
			newW = sz
			newH = (height * sz) / width
		} else {
			newH = sz
			newW = (width * sz) / height
		}
		if newW < 1 {
			newW = 1
		}
		if newH < 1 {
			newH = 1
		}

		// Windows icons should be placed on a square canvas (sz x sz) with transparent padding
		canvas := image.NewRGBA(image.Rect(0, 0, sz, sz))
		offsetX := (sz - newW) / 2
		offsetY := (sz - newH) / 2
		targetRect := image.Rect(offsetX, offsetY, offsetX+newW, offsetY+newH)

		// High-fidelity Catmull-Rom resampling for crisp icon downscaling
		draw.CatmullRom.Scale(canvas, targetRect, img, bounds, draw.Over, nil)
		err = ico.Encode(outFile, canvas)
	default:
		return fmt.Errorf("unsupported output format: %s", targetFormat)
	}

	if err != nil {
		return fmt.Errorf("failed to encode to %s: %w", targetFormat, err)
	}

	if err := outFile.Close(); err != nil {
		return fmt.Errorf("failed to finalize output file: %w", err)
	}

	success = true
	return nil
}

// Convert is the main entry point that determines the input file type and routes the task
// to either ConvertImage (for standard image conversions) or ConvertMedia (for video/audio/GIF conversions via FFmpeg).
func Convert(inputPath, outputPath, targetFormat string, qualityOrSize int, resolution string) error {
	inputPathType := GetFileType(inputPath)
	targetFormatClean := strings.ToLower(strings.TrimSpace(targetFormat))

	// Normalize format strings
	if targetFormatClean == "jpeg" {
		targetFormatClean = "jpg"
	}
	if targetFormatClean == "gif (image)" {
		targetFormatClean = "gif"
	}
	if targetFormatClean == "gif (video)" || targetFormatClean == "gif_video" {
		targetFormatClean = "gif_video"
	}

	// Determine if target format is a media (video/audio) format
	isMediaTarget := false
	isVideoTarget := false
	switch targetFormatClean {
	case "mp4", "mkv", "avi", "mov", "webm", "gif_video":
		isMediaTarget = true
		isVideoTarget = true
	case "mp3", "wav", "aac", "flac", "ogg", "m4a":
		isMediaTarget = true
	}

	// Validate media/image compatibility
	if inputPathType == "audio" && !isMediaTarget {
		return fmt.Errorf("cannot convert audio to an image format (%s)", targetFormatClean)
	}
	if inputPathType == "audio" && isVideoTarget {
		return fmt.Errorf("cannot convert audio to a video format (%s)", targetFormatClean)
	}
	if inputPathType == "image" && isMediaTarget && targetFormatClean != "gif_video" {
		return fmt.Errorf("cannot convert image to a video/audio format (%s)", targetFormatClean)
	}

	// Route based on type
	if isMediaTarget || inputPathType == "video" || inputPathType == "audio" {
		return ConvertMedia(inputPath, outputPath, targetFormatClean, qualityOrSize, resolution)
	}

	// Fallback to pure-Go image conversion
	return ConvertImage(inputPath, outputPath, targetFormatClean, qualityOrSize)
}

