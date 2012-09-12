program FingerManage;

uses
  Forms,
  fmMain in 'Form\fmMain.pas' {frm_FmMain},
  frm_FingerData in 'Form\frm_FingerData.pas' {frmFingerData},
  frm_FingerEnroll in 'Form\frm_FingerEnroll.pas' {frmFingerEnroll},
  unt_Finger in 'Unit\unt_Finger.pas',
  unt_Staff in 'Unit\unt_Staff.pas',
  dm_Local_old in 'DM\dm_Local_old.pas' {dmLocal_old: TDataModule},
  dm_Server in 'DM\dm_Server.pas' {dmServer: TDataModule},
  dm_Update in 'DM\dm_Update.pas' {dmUpdate: TDataModule},
  unt_Control in 'Unit\unt_Control.pas',
  dm_Finger in 'DM\dm_Finger.pas' {dmFinger: TDataModule},
  unt_Biokey in 'Unit\unt_Biokey.pas',
  kuControlDevice in 'Unit\kuControlDevice.pas',
  SetupAPI in 'Unit\SetupAPI.pas',
  unt_Config in 'Unit\unt_Config.pas',
  frm_User in 'Form\frm_User.pas' {frmUser},
  dm_Main in 'DM\dm_Main.pas' {dmMain: TDataModule},
  dm_Local in 'DM\dm_Local.pas' {dmLocal: TDataModule},
  unt_Update in 'Unit\unt_Update.pas',
  unt_User in 'Unit\unt_User.pas',
  fre_Store in 'Form\fre_Store.pas' {freStroe: TFrame},
  UnCoServlet in '..\DelphiCommon\UnCoServlet.pas',
  UnicodeFile in '..\DelphiCommon\UnicodeFile.pas',
  unt_Accounting in '..\DelphiCommon\unt_Accounting.pas',
  unt_Database in '..\DelphiCommon\unt_Database.pas',
  unt_DataVar in '..\DelphiCommon\unt_DataVar.pas',
  unt_File in '..\DelphiCommon\unt_File.pas',
  unt_KH_Utils in '..\DelphiCommon\unt_KH_Utils.pas',
  unt_Message in '..\DelphiCommon\unt_Message.pas',
  unt_System in '..\DelphiCommon\unt_System.pas',
  unt_XML in '..\DelphiCommon\unt_XML.pas',
  unt_BbsConfig in 'Unit\unt_BbsConfig.pas',
  unt_bulletinUtils in 'Unit\unt_bulletinUtils.pas',
  frm_ExpSigndet in 'Form\frm_ExpSigndet.pas' {FormExpSigndet},
  frm_UpdateData in 'Form\frm_UpdateData.pas' {FormUpdateData},
  unt_domain in 'Unit\unt_domain.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  KFile := TKFile.Create;
  Application.CreateForm(TdmMain, dmMain);
  Application.CreateForm(TdmLocal_old, dmLocal_old);
  Application.CreateForm(Tfrm_FmMain, frm_FmMain);
  Application.CreateForm(TdmFinger, dmFinger);
  Application.CreateForm(TdmLocal, dmLocal);
  Application.CreateForm(TdmUpdate, dmUpdate);
  Application.CreateForm(TdmServer, dmServer);
  Application.Run;
end.
