package main

import (
	"embed"
	"flag"
	"fmt"
	"os"

	"forchange/cli"

	"github.com/wailsapp/wails/v2"
	"github.com/wailsapp/wails/v2/pkg/options"
	"github.com/wailsapp/wails/v2/pkg/options/assetserver"
)

//go:embed all:frontend/dist
var assets embed.FS

func main() {
	// Parse command-line flags for CLI/Context menu support
	input := flag.String("i", "", "Path to the input image file")
	output := flag.String("o", "", "Path to the output image file (optional)")
	format := flag.String("f", "", "Target image format (png, jpg/jpeg, gif, bmp, tiff, ico)")
	quality := flag.Int("q", 80, "Encoding quality (1-100, jpeg/jpg) or icon size (16-256, ico)")

	flag.Parse()

	// Direct to CLI mode if input parameter is provided
	if *input != "" {
		if *format == "" {
			fmt.Println("Error: Target format (-f) is required in CLI mode.")
			flag.Usage()
			os.Exit(1)
		}
		err := cli.Run(*input, *output, *format, *quality)
		if err != nil {
			fmt.Fprintf(os.Stderr, "Error: %v\n", err)
			os.Exit(1)
		}
		return
	}

	// Create an instance of the app structure
	app := NewApp()

	// Store non-flag arguments as initial files to preload
	if flag.NArg() > 0 {
		app.initialFiles = flag.Args()
	}

	// Create application with options
	err := wails.Run(&options.App{
		Title:         "ForChange Modern",
		Width:         720,
		Height:        560,
		MinWidth:      720,
		MinHeight:     560,
		DisableResize: false,
		AssetServer: &assetserver.Options{
			Assets: assets,
		},
		BackgroundColour: &options.RGBA{R: 0, G: 0, B: 0, A: 1},
		OnStartup:        app.startup,
		Bind: []interface{}{
			app,
		},
	})

	if err != nil {
		println("Error:", err.Error())
	}
}
