; WinEdt KVicTools for WinEdt 11.0 Inno (Installer) Setup Script
; Prepared by Victor Kozyakin
; =====================================================================
;
; INNO Setup: http://www.innosetup.com
; ---------------------------------------------------------------------
#pragma option -v+
#pragma verboselevel 9

#define AppVersion '11';
#define MinAppVersion '0';
#define Build ReadIni(AddBackslash(SourcePath) +'build', 'Inno Setup', 'Build', '0');
#define Build Str(Int(Build)+1);
#expr WriteIni(AddBackslash(SourcePath) +'build', 'Inno Setup', 'Build', Build);
#define Year GetDateTimeString('yyyy', '', '');
#define BuildInfo AppVersion+'.'+MinAppVersion+'.'+Year+'.'+Build;
#define WinEdtFileVersion '11.0.2022.524';
#define WinEdtName 'WinEdt '+AppVersion;
#define WinEdtTeam 'WinEdt Team';
#define PublisherName 'KVicTools';

[Setup]
AppName={#WinEdtName} {#PublisherName}
AppVerName={#WinEdtName} {#PublisherName}
AppPublisher=Victor Kozyakin
AppPublisherURL=http://www.iitp.ru/ru/users/46.htm
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
AppVersion={#BuildInfo}
AppCopyright=Copyright � {#Year} by Victor Kozyakin
VersionInfoCopyright=Copyright � {#Year} by Victor Kozyakin
ShowLanguageDialog=yes
DisableDirPage=true
DisableReadyPage=true
VersionInfoVersion={#BuildInfo}
VersionInfoTextVersion={#BuildInfo}
PrivilegesRequired=none
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
Filename: "{code:WinEdtExe}"; Parameters: "-V -E=%b\WinEdt.dnt"; Flags: postinstall skipifsilent; Description: "������ WinEdt"

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
   '��������� WinEdt {#AppVersion} {#PublisherName} ����������!'#13#13
   '���������� �� ������������ (����������) ������ WinEdt'#13
   '� �������� ����������� ��� ���������!'#13#13
   '�������������� WinEdt {#AppVersion} ����� ���� �����������'#13
   '��������� WinEdt {#AppVersion} {#PublisherName}', mbCriticalError, MB_OK);
   Result := False;
   goto TotalExit;

BadVersion:
   MsgBox(
   '��������� WinEdt {#AppVersion} {#PublisherName} ����������!'#13#13
   '��� ��������� WinEdt {#AppVersion} {#PublisherName} ���������'#13
   '������� ������������������ ������������� WinEdt'#13
   '������ {#WinEdtFileVersion}, � �� ����� ��� �����������������'#13
   'WinEdt ����� ������ '+Version+'.'#13#13
   '���������� ������������ (����������) WinEdt ������'#13
   '{#WinEdtFileVersion}, ����� ���� ����������� ���������'#13
   'WinEdt {#AppVersion} {#PublisherName}', mbCriticalError, MB_OK);
   Result := False;

TotalExit:
end;

[LangOptions]
LanguageName=Russian
LanguageID=$0419
