unit frm_UpdateData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, siComp, DB, unt_File;

type
  TFormUpdateData = class(TForm)
    pnlHeaderButtons: TPanel;
    pnlContent: TPanel;
    btnStart: TButton;
    pbTotal: TProgressBar;
    lblTotal: TLabel;
    slngUpdateData: TsiLang;
    btnDownloadStaff: TButton;
    sp_Update: TLabel;
    procedure btnStartClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnDownloadStaffClick(Sender: TObject);
  private
    { Private declarations }
    FTotal:Integer;
    FCurr:Integer;
    function DownloadStaff: Integer;
    procedure ConfigDB;
  public
    { Public declarations }
    procedure updateProgress(var total,curr:integer);
  end;

var
  FormUpdateData: TFormUpdateData;

implementation

uses
  dm_Update,dm_Main, dm_Local_old, dm_Server, unt_Control;

{$R *.dfm}

procedure TFormUpdateData.FormCreate(Sender: TObject);
begin
  // 
end;

procedure TFormUpdateData.btnDownloadStaffClick(Sender: TObject);
begin
  ConfigDB;
  if not dmServer.MyC_Server.Connected then
    dmServer.OpenDatabase;
  
    try
      DownloadStaff;
    except
    end;
end;

procedure TFormUpdateData.ConfigDB;
begin
  dmLocal_old.DBFile := Config.LDBFile;
  dmLocal_old.DBPWD := Config.LDBPassword;
  dmLocal_old.AreaCode := Config.AreaCode;
  dmLocal_old.StoreCode := Config.StoreCode;
  dmLocal_old.Language := Config.ShowLang;
  dmLocal_old.OpenDatabase();

  dmServer.ServerIP := Config.SDBServer;
  dmServer.UserName := Config.SDBUserName;
  dmServer.Password := Config.SDBPassword;
  dmServer.Database := Config.SDBDatabase;
  //
  if dmServer.OpenDatabase then
  begin
    dmServer.AreaCode := Config.AreaCode;
    dmServer.StoreCode := Config.StoreCode;
    dmServer.MailHost := Config.MailHost;
    dmServer.MailUsername := Config.MailUsername;
    dmServer.MailPassword := Config.MailPassword;
    dmServer.Recipients := Config.Recipients;
    dmServer.CCList := Config.CCList;
  end;
  //dmServer.InitIdMsg;
  {
  dmLocal_old.siLang.LangDispatcher := siLangDispatcher;
  dmServer.siLang.LangDispatcher := siLangDispatcher;
  }
end;


procedure TFormUpdateData.btnStartClick(Sender: TObject);
begin
  pbTotal.Max := 99;
  pbTotal.Step := 1;
  pbTotal.Position := 0;
  FTotal := 0;
  btnStart.Enabled := False;
  try
    dmUpdate.DownloadAreamas(Self.updateProgress);
    dmUpdate.DownloadStoremas(Self.updateProgress);
    dmUpdate.DownloadDeptmas(Self.updateProgress);

    ShowMessage('Complete');
    pbTotal.Position := 0;
  finally
    btnStart.Enabled := True;
  end;
end;

procedure TFormUpdateData.updateProgress(var total, curr: integer);
begin
  if total = 0 then
  begin
    FTotal := FTotal + 33;
    Exit;
  end;
  FCurr := Round(curr / total * 33);
  pbTotal.Position := FTotal + FCurr;
  if(total = curr) then
  begin
    FTotal := FTotal + FCurr;
  end;
end;

function TFormUpdateData.DownloadStaff: Integer;
var
  sCount : integer;
  lastUpdateTime : TDateTime;
//  lastStaffID:string;
  ADataSet,LocDataSet : TDataSet;
begin
  sCount := 0;
  //同步本地和服务器的员工信息
  lastUpdateTime := dmLocal_old.GetLastStaffUpdateTime;
//  lastStaffID := dmLocal_old.GetLastStaffID;
  LocDataSet := dmLocal_old.GetAllStaffID;
  ADataSet := dmServer.GetStaffDataByUpdateTime(lastUpdateTime);
  if ADataSet.RecordCount > 0 then
  begin
    sCount := sCount + dmLocal_old.MergeStaffData(ADataSet, LocDataSet);
  end;
  ADataSet.Close;
  //end

  //记录日志
  if sCount > 0 then
  begin
    KFile.LogWrite(sp_Update.Caption);
  end;
  sp_Update.Caption := 'Download Staff Info : ' +IntToStr(sCount);
  //end
  Result := sCount;
end;


end.
