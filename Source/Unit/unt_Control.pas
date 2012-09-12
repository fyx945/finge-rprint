unit unt_Control;

interface
uses
  Classes, unt_Config, dm_Main,unt_BbsConfig;

Type
  TLang = Byte;
  const
    ENG = 0;        //”¢”Ô
    CHS = 1;        //ºÚÃÂ
    GB5 = 2;        //∑±ÃÂ
    CPY = 3;        //∆¥“Ù

Type
  TUserInfo = record
    UserID: String;
    PWD: String;
    opArea: string;
    opStore: String;
    LoginTime: TDateTime;
  end;

Type
  TControl = Class(TPersistent)    
  private
    FAppPath: String;
    FLanguage: TLang;
    FVersion: String;
    FSQLPath: String;
    procedure setLanguage(const Value: TLang);
  protected
    //----------------------------------------//Effect: ≥ı ºªØ≈‰÷√
    //Author: JackyZhou at 2007-06-20         //Remark:
    procedure InitConfig;

  public
    constructor Create(AppPath: String); virtual;

  published
    property AppPath: String read FAppPath;
    property Language: TLang read FLanguage write setLanguage default ENG;
    property Version: String read FVersion write FVersion;
    property SQLPath: String read FSQLPath write FSQLPath;
  end;

var
  Control : TControl;
  ControlDB: TControlDB;
  Config : TConfig;
  BbsConfig: TBbsConfig;
  CurUser : TUserInfo; 

const
  MAIL_SENDER_NAME = 'Fingerprint';
  MAIL_SENDER_ADD = 'Fingerprint@kwokhang.com';
  MAIL_SWL_SUBJECT = 'Sign Warning Letter';

  ADMIN_USER: string = 'ADMIN';
  ADMIN_PASS: string = 'TESTFINGER';
  SHOP_USER: string = 'SHOP';
  SHOP_PASS: string = 'KHHL';   

implementation

uses
  dm_Local_old;

{ TControl }

constructor TControl.Create(AppPath: String);
begin
  FAppPath := AppPath;
  InitConfig();
  //Language := Config.ShowLang;
  ControlDB := TControlDB.Create;
end;

procedure TControl.InitConfig;
begin
  Config := TConfig.Create(FAppPath + '\Config.ini');
  Config.ReadConfig;
  if Config.ActivateBBS then
  begin  
    BbsConfig := TBbsConfig.Create(Config);
    BbsConfig.ReadConfig;
  end;
  Language := Config.ShowLang;  
end;

procedure TControl.setLanguage(const Value: TLang);
begin
  if (Value < 0) or (Value > 2) then
    FLanguage := 0
  else
    FLanguage := Value;
  dmMain.siLangDispatcher.ActiveLanguage := FLanguage +1;
end;

end.
