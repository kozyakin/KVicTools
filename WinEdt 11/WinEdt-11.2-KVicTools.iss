; WinEdt KVicTools for WinEdt 11.2 Inno (Installer) Setup Script
; Prepared by Victor Kozyakin
; =====================================================================
;
; INNO Setup: http://www.innosetup.com
; ---------------------------------------------------------------------
#pragma option -v+
#pragma verboselevel 9

#define AppVersion '11';
#define MinAppVersion '2';
#define AppFullVersion AppVersion+'.'+MinAppVersion
#define Build ReadIni(AddBackslash(SourcePath) +'build', 'Inno Setup', 'Build', '0');
#define Build Str(Int(Build)+1);
#expr WriteIni(AddBackslash(SourcePath) +'build', 'Inno Setup', 'Build', Build);
#define Year GetDateTimeString('yyyy', '', '');
#define BuildInfo AppFullVersion+'.'+Year+'.'+Build;
#define WinEdtName 'WinEdt '+AppVersion;
#define WinEdtTeam 'WinEdt Team';
#define PublisherName 'KVicTools';

[Setup]
ArchitecturesAllowed=x64
ArchitecturesInstallIn64BitMode=x64
PrivilegesRequired=lowest
AppName={#WinEdtName} {#PublisherName}
AppPublisher=Victor Kozyakin
AppPublisherURL=http://www.iitp.ru/ru/users/46.htm
AppVersion={#BuildInfo}
AppCopyright=Copyright © {#Year} by Victor Kozyakin
VersionInfoVersion={#BuildInfo}
DefaultDirName={userappdata}\{#WinEdtTeam}\{#WinEdtName}
DefaultGroupName={#WinEdtName}
LicenseFile=License_ru.rtf
InfoBeforeFile=WinEdt_KVicTools_Readme_ru.rtf
AllowNoIcons=true
DirExistsWarning=no
Uninstallable=false
OutputDir=.
OutputBaseFilename=setup-WinEdt-{#AppVersion}.{#MinAppVersion}-{#PublisherName}
ShowLanguageDialog=yes
DisableDirPage=true
DisableReadyPage=true
WizardStyle=modern
Compression=lzma2
SolidCompression=yes

[Languages]
Name: ru; MessagesFile: compiler:Languages\Russian.isl; LicenseFile: License_ru.rtf; InfoBeforeFile: WinEdt_KVicTools_Readme_ru.rtf

[Messages]
BeveledLabel={#PublisherName}

[Files]
Source: UserData\*.*; DestDir: {userappdata}\{#WinEdtTeam}\{#WinEdtName}; Flags: ignoreversion recursesubdirs


[Run]
Filename: "{code:WinEdtExe}"; Parameters: "-V -E=%b\WinEdt.dnt"; Flags: postinstall skipifsilent; Description: "Запуск WinEdt"

[Code]
var
  InstRoot, Version, WinEdtExePath: String;

function WinEdtExe(Param: String): String;
begin
  Result := WinEdtExePath;
end;

function InstRootPath(Param: String): String;
begin
  Result := InstRoot;
end;

function InitializeSetup(): Boolean;

label TotalExit, BadWinEdt, BadVersion, InstRootFound;

begin

  if RegQueryStringValue(HKLM64, 'Software\Microsoft\Windows\CurrentVersion\Uninstall\{#WinEdtName}', 'InstallLocation', InstRoot)
		then goto InstRootFound;

  InstRoot:='';
  goto BadWinEdt;

InstRootFound:
	WinEdtExePath:=InstRoot+'\WinEdt.exe';
	If RegQueryStringValue(HKLM64, 'Software\Microsoft\Windows\CurrentVersion\Uninstall\{#WinEdtName}', 'DisplayVersion', Version)
    then
		begin
			if Version = '{#AppFullVersion}' then
			begin
			Result := True;
			end else goto BadVersion;
		end else goto BadWinEdt;
	goto TotalExit;

BadWinEdt:
   MsgBox(
   'Установка WinEdt {#AppFullVersion} {#PublisherName} невозможна!'#13#13
   'Информация об оригинальной (английской) версии WinEdt ' +
   'в регистре отсутствует или испорчена!'#13#13
   'Переустановите WinEdt {#AppVersion} в режиме ''Admin installation'''#13
   'после чего возобновите установку WinEdt {#AppVersion} {#PublisherName}', 
   mbCriticalError, MB_OK);
   Result := False;
   goto TotalExit;

BadVersion:
   MsgBox(
   'Установка WinEdt {#AppFullVersion} {#PublisherName} невозможна!'#13#13
   'Для установки WinEdt {#AppFullVersion} {#PublisherName} требуется наличие'#13
   'предустановленного оригинального WinEdt версии {#AppFullVersion},'#13
   'в то время как предустановленный WinEdt имеет версию '+Version+'.'#13#13
   'Установите оригинальный (английский) WinEdt версии'#13
   '{#AppFullVersion} в режиме ''Admin installation'', после чего возобновите'#13
   'установку WinEdt {#AppFullVersion} {#PublisherName}', 
   mbCriticalError, MB_OK);
   Result := False;

TotalExit:
end;

[LangOptions]
LanguageName=Russian
LanguageID=$0419
