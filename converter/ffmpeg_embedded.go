//go:build embed_ffmpeg

package converter

import (
	_ "embed"
)

//go:embed ffmpeg.exe
var ffmpegBytes []byte
