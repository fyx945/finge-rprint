{***************************************************************************************************
Project Name: ָ�ƴ�ϵͳ
Code Name: Pingerprint
Author��JackyZhou
Version: 1.2.3
Data: 2006-03-01 to 2007-01-23
Remark: �ɡ�ǩ����ϵͳ(TimeBook)���ݱ������
        1.1.9 (060921): �޸ġ�SendEMail����Server��¼���ʼ�ʱ��
        1.2.3 (070123): ��������������ļ�;
***************************************************************************************************}
program Fingerprint;

uses
  Forms,
  Windows,
  fpMain in 'Form\fpMain.pas' {frmFingerprint},
  unt_Config in 'Unit\unt_Config.pas',
  unt_Biokey in 'Unit\unt_Biokey.pas',
  dm_Local_old in 'DM\dm_Local_old.pas' {dmLocal_old: TDataModule},
  dm_Server in 'DM\dm_Server.pas' {dmServer: TDataModule},
  dm_Update in 'DM\dm_Update.pas' {dmUpdate: TDataModule},
  unt_Update in 'Unit\unt_Update.pas',
  unt_Sign in 'Unit\unt_Sign.pas',
  unt_SendEmail in 'Unit\unt_SendEmail.pas',
  unt_Control in 'Unit\unt_Control.pas',
  kuControlDevice in 'Unit\kuControlDevice.pas',
  SetupAPI in 'Unit\SetupAPI.pas',
  UnCoServlet in '..\DelphiCommon\UnCoServlet.pas',
  unt_Accounting in '..\DelphiCommon\unt_Accounting.pas',
  unt_Database in '..\DelphiCommon\unt_Database.pas',
  unt_DataVar in '..\DelphiCommon\unt_DataVar.pas',
  unt_File in '..\DelphiCommon\unt_File.pas',
  unt_KH_Utils in '..\DelphiCommon\unt_KH_Utils.pas',
  unt_Message in '..\DelphiCommon\unt_Message.pas',
  unt_System in '..\DelphiCommon\unt_System.pas',
  unt_XML in '..\DelphiCommon\unt_XML.pas',
  dm_Main in 'DM\dm_Main.pas' {dmMain: TDataModule},
  dm_Local in 'DM\dm_Local.pas' {dmLocal: TDataModule},
  UnicodeFile in '..\DelphiCommon\UnicodeFile.pas',
  unt_bulletinUtils in 'Unit\unt_bulletinUtils.pas',
  unt_BbsConfig in 'Unit\unt_BbsConfig.pas',
  unt_domain in 'Unit\unt_domain.pas',
  khProgressFrom in 'Form\khProgressFrom.pas' {ProgressForm};

{$R *.res}
var
  handle:DWORD;

begin
  handle := CreateMutex(nil, false, 'Fingerprint');
  if GetLastError = ERROR_ALREADY_EXISTS then
  begin
    SetForegroundWindow(handle);
    //SendMessage(HWND_BROADCAST, RegisterWindowMessage('Fingerprint'), 0, 0);
    Halt(0);
  end;
  KFile := TKFile.Create();
  Application.Initialize;
  Application.CreateForm(TdmMain, dmMain);
  Application.CreateForm(TdmServer, dmServer);
  Application.CreateForm(TdmLocal_old, dmLocal_old);
  Application.CreateForm(TfrmFingerprint, frmFingerprint);
  Application.CreateForm(TdmUpdate, dmUpdate);
  Application.CreateForm(TdmLocal, dmLocal);
  Application.Run;
end.
