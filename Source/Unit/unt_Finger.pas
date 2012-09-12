unit unt_Finger;

interface

uses
  DB, kbmMemTable;

type
  TFinger = class
  private

  protected

  public
    //----------------------------------------//Effect: 获得已注册指纹数
    //Author: JackyZhou at 2007-10-23         //Remark:
    function GetFingerCount(fpID: String): Integer;
    function GetFingerCount_Server(fpID: String): Integer;

    //----------------------------------------//Effect: 保存指纹数据
    //Author: JackyZhou at 2007-10-23         //Remark:
    function AddFMData(fpID, fmData: String): Integer;

    //----------------------------------------//Effect: 删除指纹
    //Author: JackyZhou at 2007-10-23         //Remark:
    function DeleteFinger_Local(fpID: String): Integer;
    function DeleteFinger_Server(fpID: String): Integer;

    //----------------------------------------//Effect: 上传下载数据
    //Author: JackyZhou at 2008-03-05         //Remark:
    function UploadFMData(FPID: String): Integer;
    function DownloadFMData(FPID: String): Integer;
  end;

var
  Finger : TFinger;

implementation

uses
  dm_Finger, unt_Update;

{ TFinger }

function TFinger.GetFingerCount(fpID: String): Integer;
begin
  if fpID <> '' then
  begin
    Result := dmFinger.GetFingerCount(fpID);
  end;
end;

function TFinger.GetFingerCount_Server(fpID: String): Integer;
begin
  if fpID <> '' then
  begin
    Result := dmFinger.GetFingerCount_Server(fpID);
  end;
end;

function TFinger.AddFMData(fpID, fmData: String): Integer;
var
  fingerNo: Integer;
begin
  fingerNo := GetFingerCount(fpID) + 1;
  if (fpID <> '') and (fmData <> '') then
  begin
    dmFinger.InsertFMData(fingerNo, fpID, fmData);
    Result := fingerNo;
  end;                 
end;

function TFinger.DeleteFinger_Local(fpID: String): Integer;
begin
  if fpID <> '' then
  begin
    Result := dmFinger.DeleteFinger_Local(fpID);
  end;
end;

function TFinger.DeleteFinger_Server(fpID: String): Integer;
begin
  if fpID <> '' then
  begin
    Result := dmFinger.DeleteFinger_Server(fpID);
  end;

end;

function TFinger.UploadFMData(FPID: String): Integer;
var
  fpUpdate : TFPUpdate;
  ADataSet: TDataSet;
begin
  ADataSet := TDataSet.Create(nil);
  ADataSet := dmFinger.GetFingerMark_Local(FPID);
  fpUpdate.UploadToServer(ADataSet , 'fp_fingermark');
  Result := ADataSet.RecordCount;
end;

function TFinger.DownloadFMData(FPID: String): Integer;
var
  fpUpdate : TFPUpdate;
  ADataSet: TDataSet;
begin
  ADataSet := TDataSet.Create(nil);
  ADataSet := dmFinger.GetFingerMark_Server(FPID);
  fpUpdate.DownLoadToLocal(ADataSet , 'fp_fingermark');
  Result := ADataSet.RecordCount;
end;

end.
