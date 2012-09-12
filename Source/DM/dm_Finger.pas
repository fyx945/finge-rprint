unit dm_Finger;

interface

uses
  unt_XML,
  SysUtils, Classes, DB, ADODB, DBAccess, MyAccess, MemDS;

type
  TdmFinger = class(TDataModule)
    aq_Finger: TADOQuery;
    am_Finger: TADOCommand;
    MyQ_Finger: TMyQuery;
    MyM_Finger: TMyCommand;
    procedure DataModuleCreate(Sender: TObject);
  private
    FFingerSQL : TKXML;
  public
    //----------------------------------------//Effect: 指纹操作
    //Author: JackyZhou at 2007-10-17         //Remark:
    procedure InsertFMData(fingerNo: Integer; fpID, fmData: String);

    function GetFingerMark_Local(FPID: String): TDataSet;
    function GetFingerMark_Server(FPID: String): TDataSet;

    //----------------------------------------//Effect: 获得已注册指纹数
    //Author: JackyZhou at 2007-10-23         //Remark:
    function GetFingerCount(fpID: String): Integer;
    //2011.9.13 petermai
    function GetFingerCount_Server(fpID: String): Integer;


    //----------------------------------------//Effect: 删除指纹
    //Author: JackyZhou at 2007-10-23         //Remark:
    function DeleteFinger_Local(fpID: String): Integer;
    function DeleteFinger_Server(fpID: String): Integer;

  end;

var
  dmFinger: TdmFinger;

implementation

uses
  dm_Main, unt_Control;

{$R *.dfm}

procedure TdmFinger.DataModuleCreate(Sender: TObject);
begin
  FFingerSQL := TKXML.Create(Control.AppPath + '\SQL\Finger.xml');
end;

function TdmFinger.GetFingerCount(fpID: String): Integer;
begin
  with aq_Finger do
  begin
    SQL.Text := FFingerSQL.GetNodeValue('Finger.FingerCount');
    Parameters.ParamByName('pfpID').Value := fpID;
    Open;
  end;
  Result := aq_Finger.FieldByName('fpCount').AsInteger;
end;

function TdmFinger.GetFingerCount_Server(fpID: String): Integer;
begin
  with MyQ_Finger do
  begin
    SQL.Text := FFingerSQL.GetNodeValue('Finger.FingerCount');
    //Parameters.ParamByName('pfpID').Value := fpID;
    ParamByName('pfpID').Value := fpID;
    Open;
  end;
  Result := MyQ_Finger.FieldByName('fpCount').AsInteger;
end;



function TdmFinger.GetFingerMark_Local(FPID: String): TDataSet;
begin
  with aq_Finger do
  begin
    SQL.Text := FFingerSQL.GetNodeValue('Finger.GetFM');
    Parameters.ParamByName('pfpID').Value := fpID;
    Open;
  end;
  Result := aq_Finger;
end;

function TdmFinger.GetFingerMark_Server(FPID: String): TDataSet;
begin
  with MyQ_Finger do
  begin
    SQL.Text := FFingerSQL.GetNodeValue('Finger.GetFM');
    ParamByName('pfpID').Value := fpID;
    Execute;
  end;
  Result := MyQ_Finger;
end;

procedure TdmFinger.InsertFMData(fingerNo: Integer; fpID, fmData: String);
begin
  with am_Finger do
  begin
    CommandText := FFingerSQL.GetNodeValue('Finger.Inster');
    Parameters.ParamByName('pFPID').Value := fpID;
    Parameters.ParamByName('pFingerNo').Value := fingerNo;
    Parameters.ParamByName('pMarkData').Value := fmData;
    Parameters.ParamByName('pEnrollDate').Value := Now();
    Execute();
  end;
end;

function TdmFinger.DeleteFinger_Local(fpID: String): Integer;
begin
  with aq_Finger do
  begin
    SQL.Text := FFingerSQL.GetNodeValue('Finger.Delete');
    Parameters.ParamByName('pfpID').Value := fpID;
    ExecSQL;
  end;
  Result := aq_Finger.RowsAffected;
end;

function TdmFinger.DeleteFinger_Server(fpID: String): Integer;
begin
  with MyQ_Finger do
  begin
    SQL.Text := FFingerSQL.GetNodeValue('Finger.Delete');
    ParamByName('pfpID').Value := fpID;
    Execute;
  end;
  Result := MyQ_Finger.RowsAffected;  
end;

end.
