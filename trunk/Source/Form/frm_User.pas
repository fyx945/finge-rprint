unit frm_User;

interface

uses
  unt_Control, unt_User,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, StrUtils,
  Dialogs, StdCtrls, RzCmboBx, RzPanel, ExtCtrls, RzButton, Mask, RzEdit, RzTabs, fre_Store,
  OleCtrls, ZKFPEngXControl_TLB, siComp;

type
  TfrmUser = class(TForm)
    RzPageControl1: TRzPageControl;
    TabSheet1: TRzTabSheet;
    Label3: TLabel;
    Label4: TLabel;
    edt_User: TRzEdit;
    btn_Confirm: TRzButton;
    edt_Password: TRzEdit;
    edt_ConfirmPwd: TRzEdit;
    Label5: TLabel;
    RzPageControl2: TRzPageControl;
    TabSheet2: TRzTabSheet;
    btn_Enroll: TRzButton;
    RzButton2: TRzButton;
    mem_FingerLog: TRzMemo;
    freStroe: TfreStroe;
    ZKEngine: TZKFPEngX;
    siLang: TsiLang;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure freStroecb_StoreCodeChange(Sender: TObject);
    procedure btn_ConfirmClick(Sender: TObject);
    procedure ZKEngineEnroll(ASender: TObject; ActionResult: WordBool; ATemplate: OleVariant);
    procedure btn_EnrollClick(Sender: TObject);
    procedure ZKEngineFeatureInfo(ASender: TObject; AQuality: Integer);
  private
    FUser: TUser;
    FOpUser: TUserInfo;
	protected
    //----------------------------------------//Effect: 显示用户信息
    //Author: JackyZhou at 2008-03-08         //Remark:
    procedure InitOpUser();
  public
    //----------------------------------------//Effect: 显示用户信息
    //Author: JackyZhou at 2008-03-08         //Remark:
    procedure ShowUserInfo(UserID: String);

    //----------------------------------------//Effect: 新增/重置用户
    //Author: JackyZhou at 2008-03-08         //Remark:
    procedure ConfirmUser(UserID, Pwd: String);
    procedure EnrollUser(UserID, FMD: String);

  end;

var
  frmUser: TfrmUser;

implementation
uses
  unt_Finger, unt_Biokey, dm_Main;

var
  Biokey: TBiokey;

{$R *.dfm}
//======================================== protected ========================================//
procedure TfrmUser.InitOpUser;
begin
  FOpUser.UserID := '';
  FOpUser.PWD := '';
  FOpUser.opArea := '';
  FOpUser.opStore := '';
end;

//======================================== public ========================================//
procedure TfrmUser.ShowUserInfo(UserID: String);
begin
  FOpUser := FUser.GetUserInfo(UserID);
  if FOpUser.UserID <> UserID then
  begin
    edt_Password.Text := FOpUser.PWD;
  end;
end;


procedure TfrmUser.ConfirmUser(UserID, Pwd: String);
begin
  if FOpUser.UserID <> UserID then
  begin
    FUser.AddUser_Pwd(UserID, Pwd, freStroe.AreaCode, freStroe.StoreCode);
  end
  else
  begin
    FUser.ResetPwd(UserID, Pwd);
  end;
end;

procedure TfrmUser.EnrollUser(UserID, FMD: String);
begin
  if FOpUser.UserID <> UserID then
  begin
    FUser.AddUser_FMD(UserID, FMD, freStroe.AreaCode, freStroe.StoreCode);
  end
  else
  begin
    FUser.ResetFMD(UserID, FMD);
  end;
end;

//======================================== Event ========================================//
procedure TfrmUser.FormCreate(Sender: TObject);
begin
  BioKey := TBiokey.Create(Self, ZKEngine);
end;

procedure TfrmUser.FormShow(Sender: TObject);
begin
  freStroe.ShowAreaMas();
end;

procedure TfrmUser.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmUser.FormDestroy(Sender: TObject);
begin
  frmUser := nil;
end;

procedure TfrmUser.freStroecb_StoreCodeChange(Sender: TObject);
var
  StoreCode: String;
  iPos: Integer;
begin
  StoreCode := TRzComboBox(Sender).Text;
  iPos := Pos('-', StoreCode);
  StoreCode := LeftStr(StoreCode, iPos -1);

  InitOpUser();
  edt_User.Text := StoreCode;
  ShowUserInfo( StoreCode );
end;

procedure TfrmUser.btn_ConfirmClick(Sender: TObject);
var
  UserID, Pwd: string;
begin
  if edt_Password.Text = edt_ConfirmPwd.Text then
  begin  
    UserID := UpperCase(edt_User.Text);
    Pwd := UpperCase(edt_Password.Text);
    ConfirmUser(UserID, Pwd);
  end;                     
end;

procedure TfrmUser.ZKEngineFeatureInfo(ASender: TObject; AQuality: Integer);
var
  enIndex: Integer;
begin
  enIndex := Biokey.FeatureInfo(AQuality);
  if enIndex > 1 then
  begin
    mem_FingerLog.Lines.Add( Format(siLang.GetText('ENROLL_FEATURE'),  [enIndex] ) );
  end;
end;

procedure TfrmUser.btn_EnrollClick(Sender: TObject);
begin      
  try
    if Biokey.OpenFP then
    begin
      Biokey.StartEnroll();
      mem_FingerLog.Lines.Add( siLang.GetText('ENROLL_PUT') );
    end
    else
    begin
      mem_FingerLog.Lines.Add( siLang.GetText('URU_CANNOT_OPEN') );
    end;
  except
    Raise ERangeError.CreateFmt( siLang.GetText('URU_OPEN_EXCEPT'), []);
  end;
end;

procedure TfrmUser.ZKEngineEnroll(ASender: TObject; ActionResult: WordBool; ATemplate: OleVariant);
var
  UserID: String;
  fmData : String;
begin
  UserID := edt_User.Text;
  if ActionResult then
  begin
    fmData := ZKEngine.EncodeTemplate1(ATemplate);
    EnrollUser(UserID, fmData);
    mem_FingerLog.Lines.Add( siLang.GetText('ENROLL_SUCCEED') );
  end
  else
  begin
    mem_FingerLog.Lines.Add( siLang.GetText('ENROLL_FAIL') );
  end;
end;


end.
