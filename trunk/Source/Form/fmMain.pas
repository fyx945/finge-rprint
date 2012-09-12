unit fmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzGroupBar, ActnList, RzEdit, StdCtrls, Mask, RzTabs, RzButton, RzStatus, ExtCtrls,
  RzPanel, siComp, OleCtrls, ZKFPEngXControl_TLB;

type
  Tfrm_FmMain = class(TForm)
    RzGroupBar1: TRzGroupBar;
    grp_System: TRzGroup;
    grp_Finger: TRzGroup;
    RzGroup3: TRzGroup;
    RzStatusBar1: TRzStatusBar;
    RzStatusPane1: TRzStatusPane;
    sp_Message: TRzStatusPane;
    pnl_Module: TRzPanel;
    tc_Login: TRzTabControl;
    Label1: TLabel;
    Label2: TLabel;
    edt_User: TRzEdit;
    btn_Login: TRzButton;
    siLang: TsiLang;
    edt_Pass: TRzEdit;
    RzGroup1: TRzGroup;
    grp_Data: TRzGroup;
    RzVersionInfo1: TRzVersionInfo;
    RzVersionInfoStatus1: TRzVersionInfoStatus;
    procedure ShowTagModule(Sender: TObject);         //Effect: 根据其Tag值，显示功能模块
    procedure FormCreate(Sender: TObject);
    procedure btn_LoginClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure edt_PassKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
	protected
    //----------------------------------------//Effect: 登录系统
    //Author: JackyZhou at 2008-02-27         //Remark:
    procedure DoLogin(UserID : String);

    //----------------------------------------//Effect: 销定/解销系统
    //Author: JackyZhou at 2008-02-27         //Remark:
    procedure LockSystem(Lock: Boolean);

    //Author: JackyZhou at 2008-02-27             //Effect: 打开功能窗口
    procedure ShowModuleForm(FormClass: TFormClass; var mForm: TForm);    

  public
    //----------------------------------------//Effect: 验证用户登录
    //Author: JackyZhou at 2008-02-27         //Remark:
    procedure ValidLogin(UserID, Password: String);
  end;

var
  frm_FmMain: Tfrm_FmMain;

implementation

uses
  unt_Control, dm_Main, dm_Local_old, 
  frm_User, frm_FingerEnroll, frm_FingerData, frm_ExpSigndet, frm_UpdateData;

{$R *.dfm}
//======================================== Events ========================================//
procedure Tfrm_FmMain.ShowTagModule(Sender: TObject);
var
  sTag: Byte;
begin
  sTag := TRzGroupItem(Sender).Tag;
  case sTag of
    11: ;
    12: ShowModuleForm(TfrmUser, TForm(frmUser)) ;
    13: Close;
    21: ShowModuleForm(TfrmFingerEnroll, TForm(frmFingerEnroll)) ;
    22: ShowModuleForm(TfrmFingerData, TForm(frmFingerData)) ;
    31: Control.Language := ENG;
    32: Control.Language := CHS;
    33: Control.Language := GB5;
    41: ShowModuleForm(TFormExpSigndet, TForm(FormExpSigndet));//导出打卡数据
    42: ShowModuleForm(TFormUpdateData, TForm(FormUpdateData));//更新基础数据
  end;
  if (sTag = 31) or (sTag = 32) or (sTag = 33) then
  begin
    if (Assigned(frmFingerEnroll)) and( frmFingerEnroll.Showing ) then
    begin
      frmFingerEnroll.ChangeLanguage();
    end;
    if (Assigned(frmFingerData)) and( frmFingerData.Showing ) then
    begin
      frmFingerData.ChangeLanguage();
    end;       
  end;
  
end;

procedure Tfrm_FmMain.FormCreate(Sender: TObject);
begin
  ControlDB.Local_OpenDatabase;
  ControlDB.Server_OpenDatabase;
end;

procedure Tfrm_FmMain.FormShow(Sender: TObject);
begin
  LockSystem(True);
  edt_User.SetFocus;
end;

procedure Tfrm_FmMain.FormResize(Sender: TObject);
begin
	with tc_Login do
  begin
		Left := Round( ( pnl_Module.Width - Width ) / 2 ) ;
		Top := Round( ( pnl_Module.Height - height ) / 3 ) ;
	end;
end;

procedure Tfrm_FmMain.btn_LoginClick(Sender: TObject);
var
  user, pass: String;
begin
  user := UpperCase(edt_User.Text);
  pass := UpperCase(edt_Pass.Text);
  ValidLogin(user, pass);
end;

//======================================== Protected ========================================//
procedure Tfrm_FmMain.DoLogin(UserID: String);
begin
  tc_Login.Visible := false;
  CurUser.UserID := UserID;
  CurUser.LoginTime := now();
  LockSystem(False);
end;

procedure Tfrm_FmMain.edt_PassKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    btn_Login.Click;
end;

procedure Tfrm_FmMain.LockSystem(Lock: Boolean);
begin
  grp_System.Enabled := not(Lock);
  grp_System.Opened := not(Lock);
  grp_Finger.Enabled := not(Lock);
  grp_Finger.Opened := not(Lock);
  grp_Data.Enabled := not(Lock);
  grp_Data.Opened := not(Lock);
end;

procedure Tfrm_FmMain.ShowModuleForm(FormClass: TFormClass; var mForm: TForm);
begin
	sp_Message.Caption := 'Loading Module...';
	Screen.Cursor := crHourGlass;
	try
		if Not Assigned(mForm) then
    begin
			mForm := FormClass.Create(Self);
    end
		else
			ShowWindow(mForm.Handle, SW_RESTORE);
    mForm.BorderStyle := bsNone;
    mForm.WindowState := wsMaximized;
    mForm.Parent := pnl_Module;
		mForm.Show;                
		//cForm.BringToFront;
	finally
		Screen.Cursor := crDefault;
		sp_Message.Caption := '';
	end;
end;

//======================================== public ========================================//
procedure Tfrm_FmMain.ValidLogin(UserID, Password: String);
begin
  if (UserID <> '') and (Password <> '')  then
  begin
    if (UserID = ADMIN_USER) and (Password = ADMIN_PASS) then
    begin
      DoLogin(UserID);
    end
    else
    begin
      if (UserID = SHOP_USER) and (Password = SHOP_PASS) then
        DoLogin(UserID)
      else
        Application.MessageBox('用户不存在或密码错误', '系统提示', 0);
        //Application.MessageBox(PChar(siLang.GetText('FM03')), PChar(siLang.GetText('FM01')), 0);
    end;
  end
  else
  begin
    Application.MessageBox('请输入用户与密码', '系统提示', 0);
    //Application.MessageBox(PChar(siLang.GetText('FM02')), PChar(siLang.GetText('FM01')), 0);
  end;
end;


end.
