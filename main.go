package main

import (
	"flag"
	"fmt"
	"os"
	"syscall"

	"forchange/cli"
	"forchange/gui"
)

func main() {
	// Parse command-line flags
	input := flag.String("i", "", "Path to the input media file")
	output := flag.String("o", "", "Path to the output media file (optional)")
	format := flag.String("f", "", "Target format (png, jpg/jpeg, gif, bmp, tiff, ico, mp4, mkv, avi, mov, webm, gif_video, mp3, wav, aac, flac, ogg, m4a)")
	quality := flag.Int("q", 80, "Encoding quality (1-100) or icon size (16-256, ico)")

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

	// Fallback to GUI mode
	hideConsole()

	initialFiles := flag.Args()
	gui.Run(initialFiles)
}

// hideConsole dynamically hides the cmd window on Windows
func hideConsole() {
	kernel32 := syscall.NewLazyDLL("kernel32.dll")
	user32 := syscall.NewLazyDLL("user32.dll")

	procGetConsole := kernel32.NewProc("GetConsoleWindow")
	procShowWindow := user32.NewProc("ShowWindow")

	hwnd, _, _ := procGetConsole.Call()
	if hwnd != 0 {
		procShowWindow.Call(hwnd, 0) // SW_HIDE = 0
	}
}
