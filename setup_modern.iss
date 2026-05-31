; Inno Setup Script for QBSoft ForChange Modern Image Converter
#define MyAppName "ForChange Modern"
#define MyAppVersion "1.0"
#define MyAppPublisher "QBSoft"
#define MyAppExeName "ForChangeModern.exe"

[Setup]
AppId={{D3F9B62E-896C-4A65-9831-29E2C68A5EFD}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
DefaultDirName={autopf}\{#MyAppPublisher}\{#MyAppName}
DefaultGroupName={#MyAppPublisher}\{#MyAppName}
AllowNoIcons=yes
LicenseFile=LICENSE
OutputDir=dist
OutputBaseFilename=QBSoft_ForChangeModern_Setup
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
Source: "ForChangeModern.exe"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Registry]
; Windows Explorer Context Menu integration for image files
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\image\shell\ForChangeModern"; ValueType: string; ValueName: "MUIVerb"; ValueData: "ForChange Modern"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\image\shell\ForChangeModern"; ValueType: string; ValueName: "SubCommands"; ValueData: ""; Flags: uninsdeletekey

; Cascade Menu options for Images
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\image\shell\ForChangeModern\shell\ConvertPNG"; ValueType: string; ValueData: "Convert to PNG"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\image\shell\ForChangeModern\shell\ConvertPNG\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f png"; Flags: uninsdeletekey

Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\image\shell\ForChangeModern\shell\ConvertJPG"; ValueType: string; ValueData: "Convert to JPG"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\image\shell\ForChangeModern\shell\ConvertJPG\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f jpg"; Flags: uninsdeletekey

Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\image\shell\ForChangeModern\shell\ConvertBMP"; ValueType: string; ValueData: "Convert to BMP"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\image\shell\ForChangeModern\shell\ConvertBMP\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f bmp"; Flags: uninsdeletekey

Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\image\shell\ForChangeModern\shell\ConvertGIF"; ValueType: string; ValueData: "Convert to GIF"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\image\shell\ForChangeModern\shell\ConvertGIF\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f gif"; Flags: uninsdeletekey

Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\image\shell\ForChangeModern\shell\ConvertICO"; ValueType: string; ValueData: "Convert to ICO"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\image\shell\ForChangeModern\shell\ConvertICO\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f ico -q 256"; Flags: uninsdeletekey

Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\image\shell\ForChangeModern\shell\ConvertGUI"; ValueType: string; ValueData: "Convert with GUI..."; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\image\shell\ForChangeModern\shell\ConvertGUI\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" ""%1"""; Flags: uninsdeletekey

; Windows Explorer Context Menu integration for video files (via SystemFileAssociations\video - PerceivedType based)
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\video\shell\ForChangeModern"; ValueType: string; ValueName: "MUIVerb"; ValueData: "ForChange Modern"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\video\shell\ForChangeModern"; ValueType: string; ValueName: "SubCommands"; ValueData: ""; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\video\shell\ForChangeModern\shell\ConvertMP4"; ValueType: string; ValueData: "Convert to MP4"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\video\shell\ForChangeModern\shell\ConvertMP4\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f mp4"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\video\shell\ForChangeModern\shell\ConvertWEBM"; ValueType: string; ValueData: "Convert to WEBM"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\video\shell\ForChangeModern\shell\ConvertWEBM\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f webm"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\video\shell\ForChangeModern\shell\ConvertMKV"; ValueType: string; ValueData: "Convert to MKV"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\video\shell\ForChangeModern\shell\ConvertMKV\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f mkv"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\video\shell\ForChangeModern\shell\ConvertMP3_Video"; ValueType: string; ValueData: "Convert to MP3 (Audio)"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\video\shell\ForChangeModern\shell\ConvertMP3_Video\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f mp3"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\video\shell\ForChangeModern\shell\ConvertGIF_Video"; ValueType: string; ValueData: "Convert to GIF"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\video\shell\ForChangeModern\shell\ConvertGIF_Video\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f gif_video"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\video\shell\ForChangeModern\shell\ConvertGUI"; ValueType: string; ValueData: "Convert with GUI..."; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\video\shell\ForChangeModern\shell\ConvertGUI\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" ""%1"""; Flags: uninsdeletekey

; Per-extension context menu (SystemFileAssociations\.ext) - most reliable approach
; .mp4
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mp4\shell\ForChangeModern"; ValueType: string; ValueName: "MUIVerb"; ValueData: "ForChange Modern"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mp4\shell\ForChangeModern"; ValueType: string; ValueName: "SubCommands"; ValueData: ""; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mp4\shell\ForChangeModern\shell\ConvertMP4"; ValueType: string; ValueData: "Convert to MP4"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mp4\shell\ForChangeModern\shell\ConvertMP4\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f mp4"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mp4\shell\ForChangeModern\shell\ConvertWEBM"; ValueType: string; ValueData: "Convert to WEBM"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mp4\shell\ForChangeModern\shell\ConvertWEBM\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f webm"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mp4\shell\ForChangeModern\shell\ConvertMKV"; ValueType: string; ValueData: "Convert to MKV"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mp4\shell\ForChangeModern\shell\ConvertMKV\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f mkv"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mp4\shell\ForChangeModern\shell\ConvertMP3_Video"; ValueType: string; ValueData: "Convert to MP3 (Audio)"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mp4\shell\ForChangeModern\shell\ConvertMP3_Video\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f mp3"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mp4\shell\ForChangeModern\shell\ConvertGIF_Video"; ValueType: string; ValueData: "Convert to GIF"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mp4\shell\ForChangeModern\shell\ConvertGIF_Video\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f gif_video"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mp4\shell\ForChangeModern\shell\ConvertGUI"; ValueType: string; ValueData: "Convert with GUI..."; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mp4\shell\ForChangeModern\shell\ConvertGUI\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" ""%1"""; Flags: uninsdeletekey
; .mkv
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mkv\shell\ForChangeModern"; ValueType: string; ValueName: "MUIVerb"; ValueData: "ForChange Modern"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mkv\shell\ForChangeModern"; ValueType: string; ValueName: "SubCommands"; ValueData: ""; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mkv\shell\ForChangeModern\shell\ConvertMP4"; ValueType: string; ValueData: "Convert to MP4"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mkv\shell\ForChangeModern\shell\ConvertMP4\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f mp4"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mkv\shell\ForChangeModern\shell\ConvertWEBM"; ValueType: string; ValueData: "Convert to WEBM"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mkv\shell\ForChangeModern\shell\ConvertWEBM\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f webm"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mkv\shell\ForChangeModern\shell\ConvertMKV"; ValueType: string; ValueData: "Convert to MKV"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mkv\shell\ForChangeModern\shell\ConvertMKV\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f mkv"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mkv\shell\ForChangeModern\shell\ConvertMP3_Video"; ValueType: string; ValueData: "Convert to MP3 (Audio)"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mkv\shell\ForChangeModern\shell\ConvertMP3_Video\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f mp3"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mkv\shell\ForChangeModern\shell\ConvertGIF_Video"; ValueType: string; ValueData: "Convert to GIF"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mkv\shell\ForChangeModern\shell\ConvertGIF_Video\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f gif_video"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mkv\shell\ForChangeModern\shell\ConvertGUI"; ValueType: string; ValueData: "Convert with GUI..."; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mkv\shell\ForChangeModern\shell\ConvertGUI\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" ""%1"""; Flags: uninsdeletekey
; .avi
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.avi\shell\ForChangeModern"; ValueType: string; ValueName: "MUIVerb"; ValueData: "ForChange Modern"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.avi\shell\ForChangeModern"; ValueType: string; ValueName: "SubCommands"; ValueData: ""; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.avi\shell\ForChangeModern\shell\ConvertMP4"; ValueType: string; ValueData: "Convert to MP4"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.avi\shell\ForChangeModern\shell\ConvertMP4\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f mp4"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.avi\shell\ForChangeModern\shell\ConvertWEBM"; ValueType: string; ValueData: "Convert to WEBM"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.avi\shell\ForChangeModern\shell\ConvertWEBM\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f webm"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.avi\shell\ForChangeModern\shell\ConvertMKV"; ValueType: string; ValueData: "Convert to MKV"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.avi\shell\ForChangeModern\shell\ConvertMKV\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f mkv"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.avi\shell\ForChangeModern\shell\ConvertMP3_Video"; ValueType: string; ValueData: "Convert to MP3 (Audio)"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.avi\shell\ForChangeModern\shell\ConvertMP3_Video\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f mp3"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.avi\shell\ForChangeModern\shell\ConvertGIF_Video"; ValueType: string; ValueData: "Convert to GIF"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.avi\shell\ForChangeModern\shell\ConvertGIF_Video\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f gif_video"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.avi\shell\ForChangeModern\shell\ConvertGUI"; ValueType: string; ValueData: "Convert with GUI..."; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.avi\shell\ForChangeModern\shell\ConvertGUI\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" ""%1"""; Flags: uninsdeletekey
; .mov
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mov\shell\ForChangeModern"; ValueType: string; ValueName: "MUIVerb"; ValueData: "ForChange Modern"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mov\shell\ForChangeModern"; ValueType: string; ValueName: "SubCommands"; ValueData: ""; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mov\shell\ForChangeModern\shell\ConvertMP4"; ValueType: string; ValueData: "Convert to MP4"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mov\shell\ForChangeModern\shell\ConvertMP4\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f mp4"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mov\shell\ForChangeModern\shell\ConvertWEBM"; ValueType: string; ValueData: "Convert to WEBM"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mov\shell\ForChangeModern\shell\ConvertWEBM\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f webm"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mov\shell\ForChangeModern\shell\ConvertMKV"; ValueType: string; ValueData: "Convert to MKV"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mov\shell\ForChangeModern\shell\ConvertMKV\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f mkv"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mov\shell\ForChangeModern\shell\ConvertMP3_Video"; ValueType: string; ValueData: "Convert to MP3 (Audio)"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mov\shell\ForChangeModern\shell\ConvertMP3_Video\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f mp3"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mov\shell\ForChangeModern\shell\ConvertGIF_Video"; ValueType: string; ValueData: "Convert to GIF"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mov\shell\ForChangeModern\shell\ConvertGIF_Video\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f gif_video"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mov\shell\ForChangeModern\shell\ConvertGUI"; ValueType: string; ValueData: "Convert with GUI..."; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.mov\shell\ForChangeModern\shell\ConvertGUI\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" ""%1"""; Flags: uninsdeletekey
; .webm
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.webm\shell\ForChangeModern"; ValueType: string; ValueName: "MUIVerb"; ValueData: "ForChange Modern"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.webm\shell\ForChangeModern"; ValueType: string; ValueName: "SubCommands"; ValueData: ""; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.webm\shell\ForChangeModern\shell\ConvertMP4"; ValueType: string; ValueData: "Convert to MP4"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.webm\shell\ForChangeModern\shell\ConvertMP4\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f mp4"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.webm\shell\ForChangeModern\shell\ConvertWEBM"; ValueType: string; ValueData: "Convert to WEBM"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.webm\shell\ForChangeModern\shell\ConvertWEBM\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f webm"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.webm\shell\ForChangeModern\shell\ConvertMKV"; ValueType: string; ValueData: "Convert to MKV"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.webm\shell\ForChangeModern\shell\ConvertMKV\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f mkv"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.webm\shell\ForChangeModern\shell\ConvertMP3_Video"; ValueType: string; ValueData: "Convert to MP3 (Audio)"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.webm\shell\ForChangeModern\shell\ConvertMP3_Video\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f mp3"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.webm\shell\ForChangeModern\shell\ConvertGIF_Video"; ValueType: string; ValueData: "Convert to GIF"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.webm\shell\ForChangeModern\shell\ConvertGIF_Video\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f gif_video"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.webm\shell\ForChangeModern\shell\ConvertGUI"; ValueType: string; ValueData: "Convert with GUI..."; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\.webm\shell\ForChangeModern\shell\ConvertGUI\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" ""%1"""; Flags: uninsdeletekey

; Windows Explorer Context Menu integration for audio files
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\audio\shell\ForChangeModern"; ValueType: string; ValueName: "MUIVerb"; ValueData: "ForChange Modern"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\audio\shell\ForChangeModern"; ValueType: string; ValueName: "SubCommands"; ValueData: ""; Flags: uninsdeletekey

; Audio Cascade Menu options
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\audio\shell\ForChangeModern\shell\ConvertMP3"; ValueType: string; ValueData: "Convert to MP3"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\audio\shell\ForChangeModern\shell\ConvertMP3\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f mp3"; Flags: uninsdeletekey

Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\audio\shell\ForChangeModern\shell\ConvertWAV"; ValueType: string; ValueData: "Convert to WAV"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\audio\shell\ForChangeModern\shell\ConvertWAV\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f wav"; Flags: uninsdeletekey

Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\audio\shell\ForChangeModern\shell\ConvertM4A"; ValueType: string; ValueData: "Convert to M4A"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\audio\shell\ForChangeModern\shell\ConvertM4A\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f m4a"; Flags: uninsdeletekey

Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\audio\shell\ForChangeModern\shell\ConvertFLAC"; ValueType: string; ValueData: "Convert to FLAC"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\audio\shell\ForChangeModern\shell\ConvertFLAC\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f flac"; Flags: uninsdeletekey

Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\audio\shell\ForChangeModern\shell\ConvertGUI"; ValueType: string; ValueData: "Convert with GUI..."; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\SystemFileAssociations\audio\shell\ForChangeModern\shell\ConvertGUI\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" ""%1"""; Flags: uninsdeletekey

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

; Per-extension context menu for .mp4 files
Root: HKA; Subkey: "Software\Classes\.mp4\shell\ForChangeModern"; ValueType: string; ValueName: "MUIVerb"; ValueData: "ForChange Modern"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.mp4\shell\ForChangeModern"; ValueType: string; ValueName: "SubCommands"; ValueData: ""; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.mp4\shell\ForChangeModern\shell\ConvertMP4"; ValueType: string; ValueData: "Convert to MP4"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.mp4\shell\ForChangeModern\shell\ConvertMP4\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f mp4"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.mp4\shell\ForChangeModern\shell\ConvertWEBM"; ValueType: string; ValueData: "Convert to WEBM"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.mp4\shell\ForChangeModern\shell\ConvertWEBM\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f webm"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.mp4\shell\ForChangeModern\shell\ConvertMKV"; ValueType: string; ValueData: "Convert to MKV"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.mp4\shell\ForChangeModern\shell\ConvertMKV\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f mkv"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.mp4\shell\ForChangeModern\shell\ConvertMP3_Video"; ValueType: string; ValueData: "Convert to MP3 (Audio)"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.mp4\shell\ForChangeModern\shell\ConvertMP3_Video\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f mp3"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.mp4\shell\ForChangeModern\shell\ConvertGIF_Video"; ValueType: string; ValueData: "Convert to GIF"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.mp4\shell\ForChangeModern\shell\ConvertGIF_Video\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f gif_video"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.mp4\shell\ForChangeModern\shell\ConvertGUI"; ValueType: string; ValueData: "Convert with GUI..."; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.mp4\shell\ForChangeModern\shell\ConvertGUI\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" ""%1"""; Flags: uninsdeletekey

; Per-extension context menu for .mkv files
Root: HKA; Subkey: "Software\Classes\.mkv\shell\ForChangeModern"; ValueType: string; ValueName: "MUIVerb"; ValueData: "ForChange Modern"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.mkv\shell\ForChangeModern"; ValueType: string; ValueName: "SubCommands"; ValueData: ""; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.mkv\shell\ForChangeModern\shell\ConvertMP4"; ValueType: string; ValueData: "Convert to MP4"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.mkv\shell\ForChangeModern\shell\ConvertMP4\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f mp4"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.mkv\shell\ForChangeModern\shell\ConvertWEBM"; ValueType: string; ValueData: "Convert to WEBM"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.mkv\shell\ForChangeModern\shell\ConvertWEBM\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f webm"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.mkv\shell\ForChangeModern\shell\ConvertMKV"; ValueType: string; ValueData: "Convert to MKV"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.mkv\shell\ForChangeModern\shell\ConvertMKV\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f mkv"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.mkv\shell\ForChangeModern\shell\ConvertMP3_Video"; ValueType: string; ValueData: "Convert to MP3 (Audio)"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.mkv\shell\ForChangeModern\shell\ConvertMP3_Video\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f mp3"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.mkv\shell\ForChangeModern\shell\ConvertGIF_Video"; ValueType: string; ValueData: "Convert to GIF"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.mkv\shell\ForChangeModern\shell\ConvertGIF_Video\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f gif_video"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.mkv\shell\ForChangeModern\shell\ConvertGUI"; ValueType: string; ValueData: "Convert with GUI..."; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.mkv\shell\ForChangeModern\shell\ConvertGUI\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" ""%1"""; Flags: uninsdeletekey

; Per-extension context menu for .avi files
Root: HKA; Subkey: "Software\Classes\.avi\shell\ForChangeModern"; ValueType: string; ValueName: "MUIVerb"; ValueData: "ForChange Modern"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.avi\shell\ForChangeModern"; ValueType: string; ValueName: "SubCommands"; ValueData: ""; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.avi\shell\ForChangeModern\shell\ConvertMP4"; ValueType: string; ValueData: "Convert to MP4"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.avi\shell\ForChangeModern\shell\ConvertMP4\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f mp4"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.avi\shell\ForChangeModern\shell\ConvertWEBM"; ValueType: string; ValueData: "Convert to WEBM"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.avi\shell\ForChangeModern\shell\ConvertWEBM\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f webm"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.avi\shell\ForChangeModern\shell\ConvertMKV"; ValueType: string; ValueData: "Convert to MKV"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.avi\shell\ForChangeModern\shell\ConvertMKV\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f mkv"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.avi\shell\ForChangeModern\shell\ConvertMP3_Video"; ValueType: string; ValueData: "Convert to MP3 (Audio)"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.avi\shell\ForChangeModern\shell\ConvertMP3_Video\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f mp3"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.avi\shell\ForChangeModern\shell\ConvertGIF_Video"; ValueType: string; ValueData: "Convert to GIF"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.avi\shell\ForChangeModern\shell\ConvertGIF_Video\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f gif_video"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.avi\shell\ForChangeModern\shell\ConvertGUI"; ValueType: string; ValueData: "Convert with GUI..."; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.avi\shell\ForChangeModern\shell\ConvertGUI\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" ""%1"""; Flags: uninsdeletekey

; Per-extension context menu for .mov files
Root: HKA; Subkey: "Software\Classes\.mov\shell\ForChangeModern"; ValueType: string; ValueName: "MUIVerb"; ValueData: "ForChange Modern"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.mov\shell\ForChangeModern"; ValueType: string; ValueName: "SubCommands"; ValueData: ""; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.mov\shell\ForChangeModern\shell\ConvertMP4"; ValueType: string; ValueData: "Convert to MP4"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.mov\shell\ForChangeModern\shell\ConvertMP4\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f mp4"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.mov\shell\ForChangeModern\shell\ConvertWEBM"; ValueType: string; ValueData: "Convert to WEBM"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.mov\shell\ForChangeModern\shell\ConvertWEBM\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f webm"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.mov\shell\ForChangeModern\shell\ConvertMKV"; ValueType: string; ValueData: "Convert to MKV"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.mov\shell\ForChangeModern\shell\ConvertMKV\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f mkv"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.mov\shell\ForChangeModern\shell\ConvertMP3_Video"; ValueType: string; ValueData: "Convert to MP3 (Audio)"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.mov\shell\ForChangeModern\shell\ConvertMP3_Video\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f mp3"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.mov\shell\ForChangeModern\shell\ConvertGIF_Video"; ValueType: string; ValueData: "Convert to GIF"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.mov\shell\ForChangeModern\shell\ConvertGIF_Video\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f gif_video"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.mov\shell\ForChangeModern\shell\ConvertGUI"; ValueType: string; ValueData: "Convert with GUI..."; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.mov\shell\ForChangeModern\shell\ConvertGUI\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" ""%1"""; Flags: uninsdeletekey

; Per-extension context menu for .webm files
Root: HKA; Subkey: "Software\Classes\.webm\shell\ForChangeModern"; ValueType: string; ValueName: "MUIVerb"; ValueData: "ForChange Modern"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.webm\shell\ForChangeModern"; ValueType: string; ValueName: "SubCommands"; ValueData: ""; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.webm\shell\ForChangeModern\shell\ConvertMP4"; ValueType: string; ValueData: "Convert to MP4"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.webm\shell\ForChangeModern\shell\ConvertMP4\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f mp4"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.webm\shell\ForChangeModern\shell\ConvertWEBM"; ValueType: string; ValueData: "Convert to WEBM"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.webm\shell\ForChangeModern\shell\ConvertWEBM\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f webm"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.webm\shell\ForChangeModern\shell\ConvertMKV"; ValueType: string; ValueData: "Convert to MKV"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.webm\shell\ForChangeModern\shell\ConvertMKV\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f mkv"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.webm\shell\ForChangeModern\shell\ConvertMP3_Video"; ValueType: string; ValueData: "Convert to MP3 (Audio)"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.webm\shell\ForChangeModern\shell\ConvertMP3_Video\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f mp3"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.webm\shell\ForChangeModern\shell\ConvertGIF_Video"; ValueType: string; ValueData: "Convert to GIF"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.webm\shell\ForChangeModern\shell\ConvertGIF_Video\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" -i ""%1"" -f gif_video"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.webm\shell\ForChangeModern\shell\ConvertGUI"; ValueType: string; ValueData: "Convert with GUI..."; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\.webm\shell\ForChangeModern\shell\ConvertGUI\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" ""%1"""; Flags: uninsdeletekey

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent
