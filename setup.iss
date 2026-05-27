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

; Cascade Menu options
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

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent
