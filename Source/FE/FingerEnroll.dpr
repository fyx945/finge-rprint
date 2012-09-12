program FingerEnroll;

uses
  Forms,
  peMain in 'peMain.pas' {frmBiiokey},
  unt_Config in 'unit\unt_Config.pas',
  dm_Local in 'dm\dm_Local.pas' {dmLocal: TDataModule},
  unt_Biokey in 'unit\unt_Biokey.pas',
  dm_Server in 'dm\dm_Server.pas' {dmServer: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Fingerprint Enroll';
  Application.CreateForm(TdmLocal, dmLocal);
  Application.CreateForm(TdmServer, dmServer);
  Application.CreateForm(TfrmBiiokey, frmBiiokey);
  Application.Run;
end.
