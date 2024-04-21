; WinEdt KVicTools for WinEdt 10.3 Inno (Installer) Setup Script
; Prepared by Victor Kozyakin
; =====================================================================
;
; INNO Setup: http://www.innosetup.com
; ---------------------------------------------------------------------
#pragma option -v+
#pragma verboselevel 9

#define AppVersion '10';
#define MinAppVersion '3';
#define Build ReadIni(AddBackslash(SourcePath) +'build', 'Inno Setup', 'Build', '0');
#define Build Str(Int(Build)+1);
#expr WriteIni(AddBackslash(SourcePath) +'build', 'Inno Setup', 'Build', Build);
#define Year GetDateTimeString('yyyy', '', '');
#define BuildInfo AppVersion+'.'+MinAppVersion+'.'+Year+'.'+Build;
#define WinEdtFileVersion '10.3.2018.507';
#define WinEdtName 'WinEdt '+AppVersion;
#define WinEdtTeam 'WinEdt Team';
#define PublisherName 'KVicTools';

[Setup]
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
SolidCompression=true
ShowLanguageDialog=yes
DisableDirPage=true
DisableReadyPage=true
WizardStyle=modern
Compression=lzma2/ultra
InternalCompressLevel=ultra

[Languages]
Name: ru; MessagesFile: compiler:Languages\Russian.isl; LicenseFile: License_ru.rtf; InfoBeforeFile: WinEdt_KVicTools_Readme_ru.rtf

[Messages]
BeveledLabel={#PublisherName}

[Files]
Source: UserData\*.*; DestDir: {userappdata}\{#WinEdtTeam}\{#WinEdtName}; Flags: ignoreversion recursesubdirs


[Run]
Filename: "{code:WinEdtExe}"; Parameters: "-V -E=%b\WinEdt.dnt [Exe('%b\WinShell\Install.edt');]"; Flags: postinstall skipifsilent; Description: "Запуск WinEdt"

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

  if RegQueryStringValue(HKCU, 'Software\{#WinEdtName}', 'Install Root', InstRoot)
		then goto InstRootFound;

  if IsWin64 and RegQueryStringValue(HKCU64, 'Software\{#WinEdtName}', 'Install Root', InstRoot)
		then goto InstRootFound;

  InstRoot:=ExpandConstant('{commonpf}')+'\{#WinEdtTeam}\{#WinEdtName}';
  if FileExists(InstRoot+'\WinEdt.exe') then goto InstRootFound;
   
  InstRoot:=ExpandConstant('{commonpf32}')+'\{#WinEdtTeam}\{#WinEdtName}';
  if FileExists(InstRoot+'\WinEdt.exe') then goto InstRootFound;

  InstRoot:='';
  goto BadWinEdt;

InstRootFound:
	WinEdtExePath:=InstRoot+'\WinEdt.exe';
	If GetVersionNumbersString(WinEdtExePath, Version) then
		begin
			if Version = '{#WinEdtFileVersion}' then
			begin
			Result := True;
			end else goto BadVersion;
		end else goto BadWinEdt;
	goto TotalExit;

BadWinEdt:
   MsgBox(
   'Установка WinEdt {#AppVersion} {#PublisherName} невозможна!'#13#13
   'Информация об оригинальной (английской) версии WinEdt ' +
   'в регистре отсутствует или испорчена!'#13#13
   'Переустановите WinEdt {#AppVersion} в режиме ''Admin installation'''#13
   'после чего возобновите установку WinEdt {#AppVersion} {#PublisherName}', 
   mbCriticalError, MB_OK);
   Result := False;
   goto TotalExit;

BadVersion:
   MsgBox(
   'Установка WinEdt {#AppVersion} {#PublisherName} невозможна!'#13#13
   'Для установки WinEdt {#AppVersion} {#PublisherName} требуется'#13
   'наличие предустановленного оригинального WinEdt'#13
   'версии {#WinEdtFileVersion}, в то время как предустановленный'#13
   'WinEdt имеет версию '+Version+'.'#13#13
   'Установите оригинальный (английский) WinEdt версии'#13
   '{#WinEdtFileVersion} в режиме ''Admin installation'','#13
   'после чего возобновите установку WinEdt {#AppVersion} {#PublisherName}', 
   mbCriticalError, MB_OK);
   Result := False;

TotalExit:
end;

[LangOptions]
LanguageName=Russian
LanguageID=$0419
