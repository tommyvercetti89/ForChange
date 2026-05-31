; Inno Setup Script for QBSoft ForChange Image Converter
#define MyAppName "ForChange"
#define MyAppVersion "1.0"
#define MyAppPublisher "QBSoft"
#define MyAppExeName "ForChange.exe"

[Setup]
AppId={{E5C3B61E-786C-4965-9831-29E2C68A5EFE}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
DefaultDirName={autopf}\{#MyAppPublisher}\{#MyAppName}
DefaultGroupName={#MyAppPublisher}\{#MyAppName}
AllowNoIcons=yes
LicenseFile=LICENSE
OutputDir=dist
OutputBaseFilename=QBSoft_ForChange_Setup
Compression=lzma2/ultra64
SolidCompression=yes
WizardStyle=modern
SetupIconFile=assets\logo.ico
ChangesAssociations=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "ForChange.exe"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Registry]
; Windows Explorer Context Menu integration for image files
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\image\shell\ForChange"; ValueType: string; ValueName: "MUIVerb"; ValueData: "ForChange Converter"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\image\shell\ForChange"; ValueType: string; ValueName: "SubCommands"; ValueData: ""; Flags: uninsdeletekey

; Cascade Menu options for Images
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\image\shell\ForChange\shell\ConvertPNG"; ValueType: string; ValueData: "Convert to PNG"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\image\shell\ForChange\shell\ConvertPNG\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f png"; Flags: uninsdeletekey

Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\image\shell\ForChange\shell\ConvertJPG"; ValueType: string; ValueData: "Convert to JPG"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\image\shell\ForChange\shell\ConvertJPG\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f jpg"; Flags: uninsdeletekey

Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\image\shell\ForChange\shell\ConvertBMP"; ValueType: string; ValueData: "Convert to BMP"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\image\shell\ForChange\shell\ConvertBMP\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f bmp"; Flags: uninsdeletekey

Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\image\shell\ForChange\shell\ConvertGIF"; ValueType: string; ValueData: "Convert to GIF"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\image\shell\ForChange\shell\ConvertGIF\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f gif"; Flags: uninsdeletekey

Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\image\shell\ForChange\shell\ConvertICO"; ValueType: string; ValueData: "Convert to ICO"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\image\shell\ForChange\shell\ConvertICO\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f ico -q 256"; Flags: uninsdeletekey

Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\image\shell\ForChange\shell\ConvertGUI"; ValueType: string; ValueData: "Convert with GUI..."; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\image\shell\ForChange\shell\ConvertGUI\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" ""%1"""; Flags: uninsdeletekey

; Windows Explorer Context Menu integration for video files (via SystemFileAssociations\video - PerceivedType based)
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\video\shell\ForChange"; ValueType: string; ValueName: "MUIVerb"; ValueData: "ForChange Converter"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\video\shell\ForChange"; ValueType: string; ValueName: "SubCommands"; ValueData: ""; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\video\shell\ForChange\shell\ConvertMP4"; ValueType: string; ValueData: "Convert to MP4"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\video\shell\ForChange\shell\ConvertMP4\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f mp4"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\video\shell\ForChange\shell\ConvertWEBM"; ValueType: string; ValueData: "Convert to WEBM"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\video\shell\ForChange\shell\ConvertWEBM\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f webm"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\video\shell\ForChange\shell\ConvertMKV"; ValueType: string; ValueData: "Convert to MKV"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\video\shell\ForChange\shell\ConvertMKV\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f mkv"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\video\shell\ForChange\shell\ConvertMP3_Video"; ValueType: string; ValueData: "Convert to MP3 (Audio)"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\video\shell\ForChange\shell\ConvertMP3_Video\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f mp3"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\video\shell\ForChange\shell\ConvertGIF_Video"; ValueType: string; ValueData: "Convert to GIF"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\video\shell\ForChange\shell\ConvertGIF_Video\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f gif_video"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\video\shell\ForChange\shell\ConvertGUI"; ValueType: string; ValueData: "Convert with GUI..."; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\video\shell\ForChange\shell\ConvertGUI\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" ""%1"""; Flags: uninsdeletekey

; Per-extension context menu (SystemFileAssociations\.ext) - most reliable approach
; .mp4
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mp4\shell\ForChange"; ValueType: string; ValueName: "MUIVerb"; ValueData: "ForChange Converter"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mp4\shell\ForChange"; ValueType: string; ValueName: "SubCommands"; ValueData: ""; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mp4\shell\ForChange\shell\ConvertMP4"; ValueType: string; ValueData: "Convert to MP4"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mp4\shell\ForChange\shell\ConvertMP4\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f mp4"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mp4\shell\ForChange\shell\ConvertWEBM"; ValueType: string; ValueData: "Convert to WEBM"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mp4\shell\ForChange\shell\ConvertWEBM\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f webm"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mp4\shell\ForChange\shell\ConvertMKV"; ValueType: string; ValueData: "Convert to MKV"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mp4\shell\ForChange\shell\ConvertMKV\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f mkv"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mp4\shell\ForChange\shell\ConvertMP3_Video"; ValueType: string; ValueData: "Convert to MP3 (Audio)"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mp4\shell\ForChange\shell\ConvertMP3_Video\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f mp3"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mp4\shell\ForChange\shell\ConvertGIF_Video"; ValueType: string; ValueData: "Convert to GIF"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mp4\shell\ForChange\shell\ConvertGIF_Video\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f gif_video"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mp4\shell\ForChange\shell\ConvertGUI"; ValueType: string; ValueData: "Convert with GUI..."; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mp4\shell\ForChange\shell\ConvertGUI\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" ""%1"""; Flags: uninsdeletekey
; .mkv
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mkv\shell\ForChange"; ValueType: string; ValueName: "MUIVerb"; ValueData: "ForChange Converter"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mkv\shell\ForChange"; ValueType: string; ValueName: "SubCommands"; ValueData: ""; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mkv\shell\ForChange\shell\ConvertMP4"; ValueType: string; ValueData: "Convert to MP4"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mkv\shell\ForChange\shell\ConvertMP4\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f mp4"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mkv\shell\ForChange\shell\ConvertWEBM"; ValueType: string; ValueData: "Convert to WEBM"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mkv\shell\ForChange\shell\ConvertWEBM\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f webm"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mkv\shell\ForChange\shell\ConvertMKV"; ValueType: string; ValueData: "Convert to MKV"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mkv\shell\ForChange\shell\ConvertMKV\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f mkv"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mkv\shell\ForChange\shell\ConvertMP3_Video"; ValueType: string; ValueData: "Convert to MP3 (Audio)"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mkv\shell\ForChange\shell\ConvertMP3_Video\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f mp3"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mkv\shell\ForChange\shell\ConvertGIF_Video"; ValueType: string; ValueData: "Convert to GIF"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mkv\shell\ForChange\shell\ConvertGIF_Video\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f gif_video"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mkv\shell\ForChange\shell\ConvertGUI"; ValueType: string; ValueData: "Convert with GUI..."; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mkv\shell\ForChange\shell\ConvertGUI\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" ""%1"""; Flags: uninsdeletekey
; .avi
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.avi\shell\ForChange"; ValueType: string; ValueName: "MUIVerb"; ValueData: "ForChange Converter"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.avi\shell\ForChange"; ValueType: string; ValueName: "SubCommands"; ValueData: ""; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.avi\shell\ForChange\shell\ConvertMP4"; ValueType: string; ValueData: "Convert to MP4"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.avi\shell\ForChange\shell\ConvertMP4\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f mp4"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.avi\shell\ForChange\shell\ConvertWEBM"; ValueType: string; ValueData: "Convert to WEBM"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.avi\shell\ForChange\shell\ConvertWEBM\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f webm"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.avi\shell\ForChange\shell\ConvertMKV"; ValueType: string; ValueData: "Convert to MKV"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.avi\shell\ForChange\shell\ConvertMKV\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f mkv"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.avi\shell\ForChange\shell\ConvertMP3_Video"; ValueType: string; ValueData: "Convert to MP3 (Audio)"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.avi\shell\ForChange\shell\ConvertMP3_Video\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f mp3"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.avi\shell\ForChange\shell\ConvertGIF_Video"; ValueType: string; ValueData: "Convert to GIF"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.avi\shell\ForChange\shell\ConvertGIF_Video\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f gif_video"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.avi\shell\ForChange\shell\ConvertGUI"; ValueType: string; ValueData: "Convert with GUI..."; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.avi\shell\ForChange\shell\ConvertGUI\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" ""%1"""; Flags: uninsdeletekey
; .mov
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mov\shell\ForChange"; ValueType: string; ValueName: "MUIVerb"; ValueData: "ForChange Converter"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mov\shell\ForChange"; ValueType: string; ValueName: "SubCommands"; ValueData: ""; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mov\shell\ForChange\shell\ConvertMP4"; ValueType: string; ValueData: "Convert to MP4"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mov\shell\ForChange\shell\ConvertMP4\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f mp4"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mov\shell\ForChange\shell\ConvertWEBM"; ValueType: string; ValueData: "Convert to WEBM"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mov\shell\ForChange\shell\ConvertWEBM\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f webm"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mov\shell\ForChange\shell\ConvertMKV"; ValueType: string; ValueData: "Convert to MKV"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mov\shell\ForChange\shell\ConvertMKV\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f mkv"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mov\shell\ForChange\shell\ConvertMP3_Video"; ValueType: string; ValueData: "Convert to MP3 (Audio)"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mov\shell\ForChange\shell\ConvertMP3_Video\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f mp3"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mov\shell\ForChange\shell\ConvertGIF_Video"; ValueType: string; ValueData: "Convert to GIF"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mov\shell\ForChange\shell\ConvertGIF_Video\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f gif_video"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mov\shell\ForChange\shell\ConvertGUI"; ValueType: string; ValueData: "Convert with GUI..."; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mov\shell\ForChange\shell\ConvertGUI\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" ""%1"""; Flags: uninsdeletekey
; .webm
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.webm\shell\ForChange"; ValueType: string; ValueName: "MUIVerb"; ValueData: "ForChange Converter"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.webm\shell\ForChange"; ValueType: string; ValueName: "SubCommands"; ValueData: ""; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.webm\shell\ForChange\shell\ConvertMP4"; ValueType: string; ValueData: "Convert to MP4"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.webm\shell\ForChange\shell\ConvertMP4\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f mp4"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.webm\shell\ForChange\shell\ConvertWEBM"; ValueType: string; ValueData: "Convert to WEBM"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.webm\shell\ForChange\shell\ConvertWEBM\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f webm"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.webm\shell\ForChange\shell\ConvertMKV"; ValueType: string; ValueData: "Convert to MKV"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.webm\shell\ForChange\shell\ConvertMKV\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f mkv"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.webm\shell\ForChange\shell\ConvertMP3_Video"; ValueType: string; ValueData: "Convert to MP3 (Audio)"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.webm\shell\ForChange\shell\ConvertMP3_Video\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f mp3"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.webm\shell\ForChange\shell\ConvertGIF_Video"; ValueType: string; ValueData: "Convert to GIF"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.webm\shell\ForChange\shell\ConvertGIF_Video\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f gif_video"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.webm\shell\ForChange\shell\ConvertGUI"; ValueType: string; ValueData: "Convert with GUI..."; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.webm\shell\ForChange\shell\ConvertGUI\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" ""%1"""; Flags: uninsdeletekey

; Windows Explorer Context Menu integration for audio files
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\audio\shell\ForChange"; ValueType: string; ValueName: "MUIVerb"; ValueData: "ForChange Converter"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\audio\shell\ForChange"; ValueType: string; ValueName: "SubCommands"; ValueData: ""; Flags: uninsdeletekey

; Audio Cascade Menu options
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\audio\shell\ForChange\shell\ConvertMP3"; ValueType: string; ValueData: "Convert to MP3"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\audio\shell\ForChange\shell\ConvertMP3\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f mp3"; Flags: uninsdeletekey

Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\audio\shell\ForChange\shell\ConvertWAV"; ValueType: string; ValueData: "Convert to WAV"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\audio\shell\ForChange\shell\ConvertWAV\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f wav"; Flags: uninsdeletekey

Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\audio\shell\ForChange\shell\ConvertM4A"; ValueType: string; ValueData: "Convert to M4A"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\audio\shell\ForChange\shell\ConvertM4A\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f m4a"; Flags: uninsdeletekey

Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\audio\shell\ForChange\shell\ConvertFLAC"; ValueType: string; ValueData: "Convert to FLAC"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\audio\shell\ForChange\shell\ConvertFLAC\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f flac"; Flags: uninsdeletekey

Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\audio\shell\ForChange\shell\ConvertGUI"; ValueType: string; ValueData: "Convert with GUI..."; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\audio\shell\ForChange\shell\ConvertGUI\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" ""%1"""; Flags: uninsdeletekey

; Register perceived types to ensure video/audio explorer associations work
Root: HKA; Subkey: "Software\Classes\.mp4"; ValueType: string; ValueName: "PerceivedType"; ValueData: "video"; Flags: uninsdeletevalue
Root: HKA; Subkey: "Software\Classes\.mkv"; ValueType: string; ValueName: "PerceivedType"; ValueData: "video"; Flags: uninsdeletevalue
Root: HKA; Subkey: "Software\Classes\.avi"; ValueType: string; ValueName: "PerceivedType"; ValueData: "video"; Flags: uninsdeletevalue
Root: HKA; Subkey: "Software\Classes\.mov"; ValueType: string; ValueName: "PerceivedType"; ValueData: "video"; Flags: uninsdeletevalue
Root: HKA; Subkey: "Software\Classes\.webm"; ValueType: string; ValueName: "PerceivedType"; ValueData: "video"; Flags: uninsdeletevalue
Root: HKA; Subkey: "Software\Classes\.mp3"; ValueType: string; ValueName: "PerceivedType"; ValueData: "audio"; Flags: uninsdeletevalue
Root: HKA; Subkey: "Software\Classes\.wav"; ValueType: string; ValueName: "PerceivedType"; ValueData: "audio"; Flags: uninsdeletevalue
Root: HKA; Subkey: "Software\Classes\.m4a"; ValueType: string; ValueName: "PerceivedType"; ValueData: "audio"; Flags: uninsdeletevalue
Root: HKA; Subkey: "Software\Classes\.flac"; ValueType: string; ValueName: "PerceivedType"; ValueData: "audio"; Flags: uninsdeletevalue
Root: HKA; Subkey: "Software\Classes\.aac"; ValueType: string; ValueName: "PerceivedType"; ValueData: "audio"; Flags: uninsdeletevalue
Root: HKA; Subkey: "Software\Classes\.ogg"; ValueType: string; ValueName: "PerceivedType"; ValueData: "audio"; Flags: uninsdeletevalue



[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent
