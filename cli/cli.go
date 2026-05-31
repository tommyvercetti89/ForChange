package cli

import (
	"fmt"
	"forchange/converter"
)

// Run executes the conversion in CLI mode and prints status output.
func Run(inputPath, outputPath, targetFormat string, quality int) error {
	fmt.Println("ForChange Media Converter v1.0")
	fmt.Printf("Processing: %s to %s (quality: %d)\n", inputPath, targetFormat, quality)

	err := converter.Convert(inputPath, outputPath, targetFormat, quality, "")
	if err != nil {
		return fmt.Errorf("conversion failed: %w", err)
	}

	fmt.Println("Conversion completed successfully.")
	return nil
}
