; TeXLive KVicTools Inno (Installer) Setup Script
; Made by Victor Kozyakin
; =====================================================================
;
; INNO Setup: http://www.innosetup.com
; ---------------------------------------------------------------------
#pragma option -v+
#pragma verboselevel 9

#define Build ReadIni(AddBackslash(SourcePath) +'build', 'Inno Setup', 'Build', '0');
#define Build Str(Int(Build)+1);
#expr WriteIni(AddBackslash(SourcePath) +'build', 'Inno Setup', 'Build', Build);
#define Year GetDateTimeString('yyyy', '', '');
#define BuildInfo Year+'.'+Build;
#define PublisherName 'KVicTools';

[Setup]
PrivilegesRequired=admin
AppName=TeX Live {#PublisherName}
AppVerName=TeX Live {#PublisherName}
AppPublisher=Victor Kozyakin
AppPublisherURL=http://www.iitp.ru/ru/users/46.htm
DefaultDirName={code:TEXMFLOCAL}
DefaultGroupName=TeX Live
LicenseFile=License_ru.rtf
InfoBeforeFile=TeXLive_KVicTools_Readme_ru.rtf
AllowNoIcons=true
DirExistsWarning=no
UninstallDisplayName=TeX Live {#PublisherName}
Uninstallable=true
OutputDir=.
DisableDirPage=true
OutputBaseFilename=setup-TeXLive-{#PublisherName}
SolidCompression=true
AppVersion={#BuildInfo}
AppCopyright=Copyright © {#Year} by Victor Kozyakin
VersionInfoCopyright=Copyright © {#Year} by Victor Kozyakin
VersionInfoVersion={#BuildInfo}
VersionInfoTextVersion={#BuildInfo}
ShowLanguageDialog=yes
UsePreviousAppDir=false
UninstallLogMode=overwrite
ChangesEnvironment=yes
WizardStyle=modern
Compression=lzma2/ultra
InternalCompressLevel=ultra

[Languages]
Name: ru; MessagesFile: compiler:Languages\Russian.isl; LicenseFile: License_ru.rtf; InfoBeforeFile: TeXLive_KVicTools_Readme_ru.rtf

[Messages]
BeveledLabel={#PublisherName}

[Tasks]

[InstallDelete]

[Files]
Source: "fwdrefs\texmf-local\*.*"; DestDir: "{code:TEXMFLOCAL}"; Flags: recursesubdirs overwritereadonly ignoreversion; Components: default
Source: "utfcyrbib\texmf-local\*.*"; DestDir: "{code:TEXMFLOCAL}"; Flags: recursesubdirs overwritereadonly ignoreversion; Components: default
Source: "gost705bib\texmf-local\*.*"; DestDir: "{code:TEXMFLOCAL}"; Flags: recursesubdirs overwritereadonly ignoreversion; Components: default
Source: "ruenhyph\texmf-local\*.*"; DestDir: "{code:TEXMFLOCAL}"; Flags: recursesubdirs overwritereadonly ignoreversion; Components: default
Source: "rudicthunspell\texmf-config\*.*"; DestDir: "{code:TEXMFCONFIG}"; Flags: recursesubdirs overwritereadonly ignoreversion; Components: default rudicthunspell
Source: "User_home_dir\*.*"; DestDir: "{%USERPROFILE}"; Flags: recursesubdirs overwritereadonly ignoreversion; Components: default

[Registry]

[Icons]

[UninstallDelete]

[Run]
Filename: "{code:TEXMFMAIN}\..\bin\win32\mktexlsr.exe"; Flags: skipifdoesntexist runascurrentuser; StatusMsg: "Обновление базы данных файлов TeX Live..."; Components: default
Filename: "{code:TEXMFMAIN}\..\bin\win32\updmap-sys.exe"; Flags: skipifdoesntexist runascurrentuser; StatusMsg: "Обновление map-файлов"; Components: default
Filename: "{code:TEXMFMAIN}\..\bin\win32\fmtutil-sys.exe"; Parameters: "--byhyphen language.dat"; Flags: skipifdoesntexist runascurrentuser; StatusMsg: "Обновление форматных файлов"

[UninstallRun]
Filename: "{code:TEXMFMAIN}\..\bin\win32\mktexlsr.exe"; Flags: skipifdoesntexist runascurrentuser; StatusMsg: "Обновление базы данных файлов TeX Live..."; RunOnceId: "texlive_kvic"; Components: default
Filename: "{code:TEXMFMAIN}\..\bin\win32\updmap-sys.exe"; Parameters: "--syncwithtrees"; Flags: skipifdoesntexist runascurrentuser; StatusMsg: "Обновление map-файлов"; RunOnceId: "texlive_kvic"; Components: default
Filename: "{code:TEXMFMAIN}\..\bin\win32\updmap-sys.exe"; Flags: skipifdoesntexist runascurrentuser; StatusMsg: "Обновление map-файлов"; RunOnceId: "texlive_kvic"; Components: default
Filename: "{code:TEXMFMAIN}\..\bin\win32\fmtutil-sys.exe"; Parameters: "--byhyphen language.dat"; Flags: skipifdoesntexist runascurrentuser; StatusMsg: "Обновление форматных файлов"; RunOnceId: "texlive_kvic"

[Code]
var
  TmpFileName: string;
  DESTMAIN, DESTLOCAL, DESTCONFIG, TLYEAR: AnsiString;
  ResultCode: integer;

function TEXMFMAIN(Param: String): String;
begin
  Result := DESTMAIN;
end;

function TEXMFLOCAL(Param: String): String;
begin
  Result := DESTLOCAL;
end;

function TEXMFCONFIG(Param: String): String;
begin
  Result := DESTCONFIG;
end;

function TLVERSION(Param: String): String;
begin
  Result := TLYEAR;
end;

function InitializeSetup(): Boolean;

begin

    TmpFileName := ExpandConstant('{tmp}') + '\tl16kv.txt';
    Exec('cmd.exe', '/C kpsewhich -var-value=TEXMFMAIN > "' + TmpFileName + '"', '', SW_HIDE,
      ewWaitUntilTerminated, ResultCode);
    if LoadStringFromFile(TmpFileName, DESTMAIN) then DESTMAIN := Trim(DESTMAIN);
    DeleteFile(TmpFileName);

    TmpFileName := ExpandConstant('{tmp}') + '\tl16kv.txt';
    Exec('cmd.exe', '/C kpsewhich -var-value=TEXMFLOCAL > "' + TmpFileName + '"', '', SW_HIDE,
      ewWaitUntilTerminated, ResultCode);
    if LoadStringFromFile(TmpFileName, DESTLOCAL) then DESTLOCAL := Trim(DESTLOCAL);
    DeleteFile(TmpFileName);

    TmpFileName := ExpandConstant('{tmp}') + '\tl16kv.txt';
    Exec('cmd.exe', '/C kpsewhich -var-value=TEXMFCONFIG > "' + TmpFileName + '"', '', SW_HIDE,
      ewWaitUntilTerminated, ResultCode);
    if LoadStringFromFile(TmpFileName, DESTCONFIG) then DESTCONFIG := Trim(DESTCONFIG);
    DeleteFile(TmpFileName);

    TLYEAR := ExtractFileName(RemoveBackslashUnlessRoot(ExtractFilePath(DESTMAIN)));

//    MsgBox(
//   'VERSION = '+TLYEAR+#13#13+
//   'DESTMAIN = '+DESTMAIN+#13#13+
//   'DESTLOCAL = '+DESTLOCAL+#13#13+
//   'DESTCONFIG = '+DESTCONFIG+#13#13,mbInformation, MB_OK);

    Result := True;
    if (DESTMAIN='') or (DESTLOCAL='') or (DESTCONFIG='') = True then
    begin
    MsgBox(
   'Установка TeX Live {#PublisherName} невозможна!'#13#13
   'Одна из переменых TEXMFMAIN, TEXMFLOCAL или TEXMFCONFIG системы TeX Live не определена или испорчена!'#13#13
   'Переустановите TeX Live после чего возобновите'#13
   'установку TeX Live {#PublisherName}', mbCriticalError, MB_OK);
   Result := False;
   end;

end;

[LangOptions]
LanguageName=Russian
LanguageID=$0419

[Components]
Name: "default"; Description: "Установка и конфигурация поддержки русского языка"; Types: custom compact full; Flags: fixed
Name: "rudicthunspell"; Description: "Русские и англо-русские словари для Hunspell"; Types: custom full
