unit unt_Update;

interface
uses
  DB, kbmMemTable, Classes, SysUtils, DateUtils;

Type
  TUpdateType = Byte;
  const
    UT_CUSTOM  = 0;
    UT_EMPTY = 1;
    UT_APPEND = 2;

Type
  TFPUpdate = class
  private

  protected
    //Author: JackyZhou at 2008-02-17             //Effect: 更新数据表
    function UpdateTable(ATableName: string; UpdateType: TUpdateType): Integer;

  public
    constructor Create(); virtual;

    //Author: JackyZhou at 2008-02-16             //Effect: 检查、更新配置表
    function CheckConfigTable(): Boolean;
    //function UpdateConfigTable(): Integer;

    //Author: JackyZhou at 2008-02-17             //Effect: 更新数据表
    function UpdateAllTable(): Integer;

    //Author: JackyZhou at 2008-02-18             //Effect: 更新员工信息表
    function UpdateStaffInfo(): Integer;

    function UploadToServer(SrcDataSet: TDataSet; DesTable: string): Integer;
    function DownLoadToLocal(SrcDataSet: TDataSet; DesTable: string): Integer;

  end;

implementation
uses
  unt_Control, dm_Update, dm_Local_old, dm_Server, unt_DataVar;

const
  CONFIG_TABLE = 'fp_updatetable';

{ TFPUpdate }

constructor TFPUpdate.Create;
begin

end;

function TFPUpdate.UpdateTable(ATableName: string; UpdateType: TUpdateType): Integer;
var
  ServerTable: TkbmMemTable;
  LocalDataSet: TDataSet;
begin
  if UpdateType = 0 then
    Exit;

  LocalDataSet := TDataSet.Create(nil);
  ServerTable := TkbmMemTable.Create(nil);
  ServerTable.LoadFromDataSet(dmUpdate.LoadServerData(ATableName), [mtcpoStructure]);

  try
    dmLocal_old.ADOConn.BeginTrans;
    case UpdateType of
      UT_EMPTY:
      begin

        dmLocal_old.EmptyTable(ATableName);
        LocalDataSet := dmLocal_old.SelectTable(ATableName);
        ServerTable.SaveToDataSet(LocalDataSet, [mtcpoStructure, mtcpoProperties]);
      end;
      UT_APPEND:
      begin
        LocalDataSet := dmLocal_old.SelectTable(ATableName);
        ServerTable.SaveToDataSet(LocalDataSet, [mtcpoAppend]);
      end;
    end;
    dmLocal_old.ADOConn.CommitTrans;
  except
    dmLocal_old.ADOConn.RollbackTrans;
  end;
  Result := ServerTable.RecordCount;
end;


//======================================== public ========================================//

function TFPUpdate.CheckConfigTable: Boolean;
var
  LocalLUT, ServerLUT: TDateTime;
begin
  LocalLUT := dmUpdate.GetLastUpdateTime_Local(CONFIG_TABLE);
  ServerLUT := dmUpdate.GetLastUpdateTime_Server(CONFIG_TABLE);
  if LocalLUT >= ServerLUT then
    Result := False
  else
    Result := True;
end;

{function TFPUpdate.UpdateConfigTable: Integer;
var
  mt_Temp: TkbmMemTable;
begin
  mt_Temp := TkbmMemTable.Create(nil);
  mt_Temp.LoadFromDataSet(dmUpdate.LoadServerData(CONFIG_TABLE), [mtcpoStructure]);
  //-------------------- 重新建立表 --------------------//
  dmLocal.DropTable(CONFIG_TABLE);
  dmUpdate.CreateConfigTable;
  //-------------------- 记录新数据 --------------------//
  dmLocal.SelectTable(CONFIG_TABLE);
  mt_Temp.SaveToDataSet(dmLocal.ado_Data, [mtcpoAppend]);

  Result := mt_Temp.RecordCount;
end; }

function TFPUpdate.UpdateAllTable: Integer;
var
  UpdateDataSet: TkbmMemTable;
  TableName: String;
  LUTime: TDateTime;
  UpdateType, Tally, Frequency: Integer;
begin
  UpdateDataSet := TkbmMemTable.Create(nil);
  UpdateDataSet.LoadFromDataSet(dmLocal_old.SelectTable(CONFIG_TABLE), [mtcpoStructure]);
  with UpdateDataSet do
  begin
    First;
    while not(Eof) do
    begin
      if FieldByName('Activate').AsBoolean then
      begin
        TableName := FieldByName('TableName').AsString;
        UpdateType := FieldByName('UpdateType').AsInteger;
        LUTime := FieldByName('LastUpdateTime').AsDateTime;
        Tally := FieldByName('Tally').AsInteger;
        Frequency := FieldByName('Frequency').AsInteger;

        if (UpdateType <> UT_CUSTOM) and ( (Tally = 0) or (IncHour(LUTime, Frequency) > now) ) then
        begin
          UpdateTable(TableName, UpdateType);
          dmUpdate.UpdateLUT_Local(TableName, now);
        end;
      end;
      Next;
    end;
  end;
end;

function TFPUpdate.UpdateStaffInfo: Integer;
  function GetStaffIDList(ADataSet: TDataSet): string;
  var
    StaffIDList: TStringList;
  begin
    StaffIDList := TStringList.Create;
    ADataSet.First;
    while not(ADataSet.Eof) do
    begin
      StaffIDList.Add( ADataSet.FieldByName('STAFFID').AsString );
      ADataSet.Next;
    end;
    Result := KString.ListToString(StaffIDList);
  end;
var
  LocalMUT, ServerMUT: TDateTime;
  StaffTable: TkbmMemTable;
  StaffIDString: String;
  LocalStaff: TDataSet;
begin
  LocalMUT := dmUpdate.GetStaffMaxUpdateTime_Local();
  ServerMUT := dmUpdate.GetStaffMaxUpdateTime_Server();
  if LocalMUT < ServerMUT then
  begin
    LocalStaff := TDataSet.Create(nil);
    StaffTable := TkbmMemTable.Create(nil);
    StaffTable.LoadFromDataSet(dmUpdate.LoadNewStaffInfo(LocalMUT), [mtcpoStructure]);
    StaffIDString := GetStaffIDList(StaffTable);

    dmUpdate.DeleteOldStaffInfo(StaffIDString);
    LocalStaff := dmLocal_old.SelectTable('STAFF');
    StaffTable.SaveToDataSet(LocalStaff, [mtcpoAppend]);

    Result := StaffTable.RecordCount;
  end
  else
  begin
    Result := 0;
  end;
end;


function TFPUpdate.UploadToServer(SrcDataSet: TDataSet; DesTable: string): Integer;
var
  kbmTable: TkbmMemTable;
begin
  kbmTable := TkbmMemTable.Create(nil);
  kbmTable.LoadFromDataSet(SrcDataSet, [mtcpoStructure]);

  with dmUpdate.MyQ_UploadServer do
  begin
    Close;
    MacroByName('mTable').Value := DesTable;
    Open;
    try
      Connection.StartTransaction;
      kbmTable.SaveToDataSet(dmUpdate.MyQ_UploadServer, [mtcpoAppend]);
      Connection.Commit;
    except
      Connection.Rollback;
    end;
  end;
end;

function TFPUpdate.DownLoadToLocal(SrcDataSet: TDataSet; DesTable: string): Integer;
var
  kbmTable: TkbmMemTable;
const
  SSQL = 'SELECT * FROM %S WHERE 1 <> 1';
begin
  kbmTable := TkbmMemTable.Create(nil);
  kbmTable.LoadFromDataSet(SrcDataSet, [mtcpoStructure]);

  with dmUpdate.aq_DownloadLocal do
  begin
    Close;
    SQL.Text := Format(SSQL, [DesTable]);
    Open;
    try
      ControlDB.Local_StartTransaction;
      kbmTable.SaveToDataSet(dmUpdate.aq_DownloadLocal, [mtcpoAppend]);
      ControlDB.Local_Commit;
    except
      ControlDB.Local_Rollback;
    end;
  end;
end;

end.
