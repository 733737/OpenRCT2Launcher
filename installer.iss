#define MyAppName "OpenRCT2 Launcher"
#define MyAppVersion "0.1.0"
#define MyAppPublisher "OpenRCT2"
#define MyAppURL "http://www.github.com/733737/OpenRCT2Launcher"
#define MyAppExeName "OpenRCT2.exe"

#ifdef BUILD64
#define REDIST "vcredist_x64.exe"
#else
#define REDIST "vcredist_x86.exe"
#endif

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{D71D87CE-20E7-4DB6-A0D8-E6DE57051B35}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
DefaultDirName={pf}\{#MyAppName}
DisableProgramGroupPage=yes
OutputDir=.
Compression=lzma
SolidCompression=yes

#ifdef BUILD64
OutputBaseFilename=OpenRCT2Launcher-win
ArchitecturesInstallIn64BitMode=x64
ArchitecturesAllowed=x64
#else
OutputBaseFilename=OpenRCT2Launcher-win-x86

[Code]
function InitializeSetup(): Boolean;
begin
  if ProcessorArchitecture = paX64 then
    Result := SuppressibleMsgBox('It appears that you are installing this 32-bit version on a 64-bit machine.' #13#10 #13#10
                                 'It''s recommended you use the 64-bit version of the launcher instead.' #13#10 #13#10
                                 'Continue Anyways?', mbInformation, MB_YESNO or MB_DEFBUTTON2, 0) = IDYES
  else Result := True;
end;
#endif

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"

[Files]
Source: "build-Windows\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{commonprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#REDIST}"; Parameters: "/passive /norestart"
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

