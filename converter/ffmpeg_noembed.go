//go:build !embed_ffmpeg

package converter

// ffmpegBytes is nil when building without embedded ffmpeg binary.
var ffmpegBytes []byte
