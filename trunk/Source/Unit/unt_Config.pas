unit unt_Config;

interface
uses
  unt_File, unt_DataVar, unt_System,
  IniFiles, SysUtils, Controls, Classes;

Type
  TConfig = class
  private
    FFileName : String;
    FIniFile : TiniFile;
    FAVPort: Integer;
    FLDBTable: string;
    FLDBFile: string;
    FAVHost: string;
    FAVPWD: Integer;
    FSDBBatabase: String;
    FAVNum: Integer;
    FStoreCode: String;
    FSDBPassword: String;
    FAreaCode: String;
    FLDBPWD: string;
    FSDBServer: string;
    FSDBUserName: string;
    FAutoUpload: Byte;
    //FUpdateStaff: TTime;
    FLanguages: TStrings;
    FShowLang: Integer;
    FPowerOffTime: Word;
    FfpType: Integer;
    FmailUsername: String;
    FmailHost: string;
    FmailPassword: String;
    FRecipients: TStrings;
    FCCList: TStrings;
    FSendCount: Integer;
    FMealTime: Word;
    FLoadFingermarkAlways: String;
    FUploadFrequency: Word;
    FLastUploadTime: TDateTime;
    FSwitchSigndetTime: String;
    FSwitchSigndet: boolean;
    FActivateBBS: Boolean;
    FSendWarningLetter: Boolean;
    FExitUpload: Boolean;
    FControlDriver: Boolean;
    FSyncTime: Boolean;
    procedure SetLastUploadTime(const Value: TDateTime);
  public
    constructor Create(Const pFile: String='');

    procedure ReadConfig;

  published
    property fpType: Integer read FfpType write FfpType;
    property AreaCode: String read FAreaCode;
    property StoreCode: String read FStoreCode;
   //property UpdateStaffTiem: TTime read FUpdateStaff;
    property AutoUpload: Byte read FAutoUpload;
    property PowerOffTime: Word read FPowerOffTime;
    property MealTime: Word read FMealTime;
    property UploadFrequency:WORD read FUploadFrequency;
    property LastUploadTime:TDateTime read FLastUploadTime write SetLastUploadTime;
    property SwitchSigndet:boolean read FSwitchSigndet;
    property SwitchSigndetTime:String read FSwitchSigndetTime;

    property MailHost: string read FmailHost;
    property MailUsername: String read FmailUsername;
    property MailPassword: String read FmailPassword;
    property Recipients: TStrings read FRecipients;
    property CCList: TStrings read FCCList;
    property SendCount: Integer read FSendCount;

    property ShowLang: Integer read FShowLang write FShowLang;
    property Languages: TStrings read FLanguages;

    property AVHost: string read FAVHost;
    property AVPort: Integer read FAVPort;
    property AVPassword: Integer read FAVPWD;
    property AVNum: Integer read FAVNum;

    property LDBFile: string read FLDBFile;
    property LDBPassword: string read FLDBPWD;
    property LDBTable: string read FLDBTable;

    property SDBServer: string read FSDBServer;
    property SDBUserName: string read FSDBUserName;
    property SDBPassword: String read FSDBPassword;
    property SDBDatabase: String read FSDBBatabase;

    property LoadFingermarkAlways: String read FLoadFingermarkAlways;

    property ActivateBBS: Boolean read  FActivateBBS;
    property SendWarningLetter: Boolean read FSendWarningLetter;
    property ExitUpload: Boolean read FExitUpload;

    property ControlDriver: Boolean read FControlDriver;
    property SyncTime: Boolean read FSyncTime;
  end;

implementation

{**************************************** TReadConifgFile ****************************************}

constructor TConfig.Create(const pFile: String);
begin
  if pFile = '' then
    FFileName := GetCurrentDir + '\Config.ini'
  else
    FFileName := pFile;
  FIniFile := TIniFile.Create(FFileName);
  KFile.LogWrite(FFileName);
end;

procedure TConfig.ReadConfig;
var
  section, tempStr : String;
  i : integer;
begin
  section := 'System';
  FfpType := FIniFile.ReadInteger(section, 'fpType', 2);
  FAreaCode := FIniFile.ReadString(section, 'AreaCode', '');
  FStoreCode := FIniFile.ReadString(section, 'StoreCode', '');
  FAutoUpload := FIniFile.ReadInteger(section, 'AutoUpload', 10);
  FExitUpload := FIniFile.ReadBool(section, 'ExitUpload', True);
  ShowLang := FIniFile.ReadInteger(section, 'Def_Language', 255);
  if ShowLang = 255 then
  begin
    tempStr := KSys.GetLocaleILanguage;
    if tempStr = '0804' then
      ShowLang := 1
    else
    begin
      if tempStr = '0404' then
        ShowLang := 2
      else
        ShowLang := 0;
    end;
  end;
  FPowerOffTime := FIniFile.ReadInteger(section, 'PowerOffTime', 1800);
  FMealTime := FIniFile.ReadInteger(section, 'MealTime', 10);
  FUploadFrequency := FIniFile.ReadInteger(section, 'UploadFrequency', 3600);
  FLastUploadTime := 0;
  FSwitchSigndet := FIniFile.ReadBool(section, 'SwitchSigndet', false);
  FSwitchSigndetTime := FIniFile.ReadString(section, 'SwitchSigndetTime', '');
  FSendWarningLetter := FIniFile.ReadBool(section, 'SendWarningLetter', false);
  FControlDriver := FIniFile.ReadBool(section, 'ControlDriver', False);
  FSyncTime := FIniFile.ReadBool(section, 'SyncTime', False);
  FActivateBBS :=  FIniFile.ReadBool('Bulletin', 'Activate', False);


  section := 'EMail';
  if FIniFile.SectionExists(section) then
  begin        
    FMailHost := FIniFile.ReadString(section, 'Host', '');
    FmailUsername := FIniFile.ReadString(section, 'Username', '');
    FMailPassword := KString.DecryptStr(FIniFile.ReadString(section, 'Password', ''));
    FRecipients := KString.DisasStr( KString.DecryptStr(FIniFile.ReadString(section, 'Recipients', '')), ';');
    FCCList := KString.DisasStr( KString.DecryptStr(FIniFile.ReadString(section, 'CCList', '')), ';');
    FSendCount := FIniFile.ReadInteger(section, 'SendCount', 0);
    if FSendCount < 0 then
      FSendCount := 0;
  end;

  section := 'Languages';
  FLanguages := TStringList.Create;
  FIniFile.ReadSectionValues(section, Languages);
  for i := 0 to Languages.Count-1 do
  begin
    FLanguages.ValueFromIndex[i] := FIniFile.ReadString(section, Languages.Names[i],'');
  end;

  section := 'Fingerprint';
  if FIniFile.SectionExists(section) then
  begin
    FAVHost := FIniFile.ReadString(section, 'Host', '');
    FAVPort := FIniFile.ReadInteger(section, 'Port', 5010);
    FAVNum := FIniFile.ReadInteger(section, 'ID', 1);
    tempStr := FIniFile.ReadString(section, 'PWD', '');
    FAVPWD := StrToIntDef(KString.DecryptStr(tempStr), 0);
  end;

  section := 'DBLocal';
  if FIniFile.SectionExists(section) then
  begin
    FLDBFile := FIniFile.ReadString(section, 'File', '');
    tempStr := FIniFile.ReadString(section, 'PWD', '');
    if tempStr = '' then
      FLDBPWD := ''
    else
      FLDBPWD := KString.DecryptStr(tempStr);
    FLDBTable := FIniFile.ReadString(section, 'Table', '');
  end
  else
  begin
    FLDBFile := 'Data\FPData.mdb';
    FLDBPWD := '';
    FLDBTable := 'SIGNDET';
  end;

  section := 'DBServer';
  if FIniFile.SectionExists(section) then
  begin
    FSDBServer := FIniFile.ReadString(section, 'Server', '');
    FSDBUsername := FIniFile.ReadString(section, 'UserName', '');
    FSDBPassword := KString.DecryptStr(FIniFile.ReadString(section, 'Password', ''));
    FSDBBatabase := FIniFile.ReadString(section, 'Database', '');
  end
  else
  begin

  end;

  section := 'Staff';
  if FIniFile.SectionExists(section) then
  begin
    FLoadFingermarkAlways := FIniFile.ReadString(section, 'LoadFingermarkAlways', '');
  end;
end;

procedure TConfig.SetLastUploadTime(const Value: TDateTime);
begin
  FLastUploadTime := Value;
end;

end.
