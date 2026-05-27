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

; Cascade Menu options
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

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent
