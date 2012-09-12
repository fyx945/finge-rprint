unit unt_BbsConfig;

interface
uses
  unt_File, unt_DataVar, unt_System,
  IniFiles, SysUtils, Controls, Classes,unt_Config;

Type
  TBbsConfig = class
  private
    FConfig: TConfig;
    FFileName : String;
    FIniFile : TiniFile;

    FAreaCode: String;
    FStoreCode: String;

    FBbsDBServer: string;
    FBbsDBUserName: string;
    FBbsDBPassword: String;
    FBbsDBBatabase: String;

    FBltIntranetSite:String;
    FBltInternetSite:String;
    FBltShowAmount:Integer;
    FBltFreshTime:Integer;
  public
    constructor Create(AConfig:TConfig);

    procedure ReadConfig;

  published
    property AreaCode: String read FAreaCode;
    property StoreCode: String read FStoreCode;

    property DbServer: string read FBbsDBServer;
    property DbUserName: string read FBbsDBUserName;
    property DbPassword: String read FBbsDBPassword;
    property DbDatabase: String read FBbsDBBatabase;

    property BltIntranetSite: String read FBltIntranetSite;
    property BltInternetSite: String read FBltInternetSite;
    property BltShowAmount: Integer read FBltShowAmount;
    property BltFreshTime:Integer read FBltFreshTime;
  end;

implementation

{**************************************** TReadConifgFile ****************************************}

constructor TBbsConfig.Create(AConfig:TConfig);
begin
  FConfig := AConfig;
  FFileName := GetCurrentDir + '\BbsConfig.ini';
  FIniFile := TIniFile.Create(FFileName);
  KFile.LogWrite(FFileName);
end;

procedure TBbsConfig.ReadConfig;
var
  section, tempStr : String;
  i : integer;
begin
  if FConfig <> nil then
  begin
    FAreaCode := FConfig.AreaCode;
    FStoreCode := FConfig.StoreCode;
  end;    

  section := 'BBS_DB';
  FBbsDBServer := FIniFile.ReadString(section, 'Server', '');
  FBbsDBUsername := FIniFile.ReadString(section, 'UserName', '');
  FBbsDBPassword := KString.DecryptStr(FIniFile.ReadString(section, 'Password', ''));
  FBbsDBBatabase := FIniFile.ReadString(section, 'Database', '');

  section := 'Bulletin';
  FBltIntranetSite := FIniFile.ReadString(section, 'IntranetSite', '');
  FBltInternetSite := FIniFile.ReadString(section, 'InternetSite', '');
  FBltShowAmount :=  FIniFile.ReadInteger(section, 'ShowAmount', -1);
  FBltFreshTime :=  FIniFile.ReadInteger(section, 'FreshTime', 5);
end;

end.
