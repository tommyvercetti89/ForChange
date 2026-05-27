package converter

import (
	"fmt"
	"image"
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

	// Create output file
	outFile, err := os.Create(outputPath)
	if err != nil {
		return fmt.Errorf("failed to create output file: %w", err)
	}
	defer outFile.Close()

	// Encode to the desired target format
	switch targetFormat {
	case "png":
		err = png.Encode(outFile, img)
	case "jpeg", "jpg":
		err = jpeg.Encode(outFile, img, &jpeg.Options{Quality: qualityOrSize})
	case "gif":
		err = gif.Encode(outFile, img, &gif.Options{NumColors: 256})
	case "bmp":
		err = bmp.Encode(outFile, img)
	case "tiff", "tif":
		err = tiff.Encode(outFile, img, &tiff.Options{Compression: tiff.Deflate})
	case "ico":
		// Ensure icon size is between 16 and 256. Default to 256 if not specified or invalid.
		sz := qualityOrSize
		if sz < 16 || sz > 256 {
			sz = 256
		}
		bounds := img.Bounds()
		width := bounds.Dx()
		height := bounds.Dy()
		if width != sz || height != sz {
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

			scaledImg := image.NewRGBA(image.Rect(0, 0, newW, newH))
			draw.BiLinear.Scale(scaledImg, scaledImg.Bounds(), img, bounds, draw.Over, nil)
			img = scaledImg
		}
		err = ico.Encode(outFile, img)
	default:
		return fmt.Errorf("unsupported output format: %s", targetFormat)
	}

	if err != nil {
		return fmt.Errorf("failed to encode to %s: %w", targetFormat, err)
	}

	return nil
}
