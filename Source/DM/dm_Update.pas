unit dm_Update;

interface

uses
  unt_XML,
  SysUtils, Classes, siComp, DB, ADODB, MemDS, DBAccess, MyAccess, Forms, kbmMemTable;

type
  THandleProgress=Procedure(var total,curr:integer) of object;

  TdmUpdate = class(TDataModule)
    MyQ_Server: TMyQuery;
    aq_Local: TADOQuery;
    siLang: TsiLang;
    MyQ_ServerData: TMyQuery;
    mt_Temp: TkbmMemTable;
    aq_LocalData: TADOQuery;
    MyQ_UploadServer: TMyQuery;
    aq_DownloadLocal: TADOQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    FSQL : TKXML;
  public
    //Author: JackyZhou at 2008-02-17             //Effect: 获得表数据
    function LoadServerData(ATable: string): TDataSet;
    function LoadLocalData(ATable: string): TDataSet;

    //Author: JackyZhou at 2008-02-16             //Effect: 获得最后更新时间
    function GetLastUpdateTime_Local(ATable: string): TDateTime;
    function GetLastUpdateTime_Server(ATable: string): TDateTime;

    //Author: JackyZhou at 2008-02-19             //Effect: 后更最后更新时间
    function UpdateLUT_Local(ATable: string; UpdateTime: TDateTime): TDateTime;

    //Author: JackyZhou at 2008-02-17             //Effect: 建立配置表
    procedure CreateConfigTable();

    //Author: JackyZhou at 2008-02-18             //Effect: 获得员工信息最后更新时间
    function GetStaffMaxUpdateTime_Local(): TDateTime;
    function GetStaffMaxUpdateTime_Server(): TDateTime;

    //Author: JackyZhou at 2008-02-18             //Effect: 载入最新的员工信息
    function LoadNewStaffInfo(UpdateTime: TDateTime): TDataSet;

    //Author: JackyZhou at 2008-02-18             //Effect: 删除本地数据库中需更新员工数据
    function DeleteOldStaffInfo(StaffList: String): Integer;

    //Author: NifooNing at 2009-02-26             //Effect: 更新本地的Areamas表
    function DownloadAreamas(handleProgress:THandleProgress): Integer;

    //Author: NifooNing at 2009-02-26             //Effect: 更新本地的Areamas表
    function DownloadStoremas(handleProgress:THandleProgress): Integer;

    //Author: NifooNing at 2009-02-26             //Effect: 更新本地的Areamas表
    function DownloadDeptmas(handleProgress:THandleProgress): Integer;

  end;

var
  dmUpdate: TdmUpdate;

implementation

uses
  dm_Main, dm_Server;

const
  SQL_SHOW_CREATE_TABLE = 'show create table ';
  SQL_SELECT_ALL_DATA = 'select * from ';

{$R *.dfm}

{ TdmUpdate }

procedure TdmUpdate.DataModuleCreate(Sender: TObject);
var
  SQLPath: string;
begin
  SQLPath := ExtractFileDir(Application.ExeName) + '\SQL\';
  FSQL := TKXML.Create(SQLPath +'Update.xml');
end;

function TdmUpdate.LoadServerData(ATable: string): TDataSet;
begin
  with MyQ_ServerData do
  begin
    SQL.Text := SQL_SELECT_ALL_DATA + ATable;
    Execute;
    if RecordCount > 0 then
      Result := MyQ_ServerData;
  end;
end;


function TdmUpdate.LoadLocalData(ATable: string): TDataSet;
begin
  with aq_LocalData do
  begin
    SQL.Text := SQL_SELECT_ALL_DATA + ATable;
    Open;
    if RecordCount > 0 then
      Result := MyQ_ServerData;
  end;
end;

function TdmUpdate.GetLastUpdateTime_Local(ATable: string): TDateTime;
begin
  with aq_Local do
  begin
    SQL.Text := FSQL.GetNodeValue('Update.ConfigTable.LastUpdateTime') + ATable;
    Open;
    if FieldByName('LUT').IsNull then
      Result := 0
    else
      Result := FieldByName('LUT').AsDateTime;
  end;
end;

function TdmUpdate.GetLastUpdateTime_Server(ATable: string): TDateTime;
begin
  with MyQ_Server do
  begin
    SQL.Text := FSQL.GetNodeValue('Update.ConfigTable.LastUpdateTime') + ATable;
    Execute;
    if FieldByName('LUT').IsNull then
      Result := 0
    else
      Result := FieldByName('LUT').AsDateTime;
  end;
end;

procedure TdmUpdate.CreateConfigTable;
begin
  with aq_Local do
  begin
    SQL.Text := FSQL.GetNodeValue('Update.ConfigTable.CreateTable');
    ExecSQL;
  end;
end;

function TdmUpdate.UpdateLUT_Local(ATable: string; UpdateTime: TDateTime): TDateTime;
begin
  with aq_Local do
  begin
    SQL.Text := FSQL.GetNodeValue('Update.ConfigTable.UpdateLUT');
    Parameters.ParamByName('pTableName').Value := ATable;
    Parameters.ParamByName('pLUT').Value := UpdateTime;
    ExecSQL;
  end;
end;

function TdmUpdate.GetStaffMaxUpdateTime_Local: TDateTime;
begin
  with aq_Local do
  begin
    SQL.Text := FSQL.GetNodeValue('Update.StaffData.Comm.MaxUpdateTime');
    Open;
    if FieldByName('MUT').IsNull then
      Result := 0
    else
      Result := FieldByName('MUT').AsDateTime;
  end;
end;

function TdmUpdate.GetStaffMaxUpdateTime_Server: TDateTime;
begin
  with MyQ_Server do
  begin
    SQL.Text := FSQL.GetNodeValue('Update.StaffData.Comm.MaxUpdateTime');
    Execute;
    if FieldByName('MUT').IsNull then
      Result := 0
    else
      Result := FieldByName('MUT').AsDateTime;
  end;
end;

function TdmUpdate.LoadNewStaffInfo(UpdateTime: TDateTime): TDataSet;
begin
  with MyQ_ServerData do
  begin
    SQL.Text := FSQL.GetNodeValue('Update.StaffData.Server.LoadNewInfo');
    ParamByName('pUpdateTime').AsDateTime := UpdateTime;
    Execute;
    Result := MyQ_ServerData;
  end;
end;

function TdmUpdate.DeleteOldStaffInfo(StaffList: String): Integer;
var
  SQLText: String;
begin
  with aq_Local do
  begin
    SQLText := FSQL.GetNodeValue('Update.StaffData.Local.DeleteOldInfo');
    SQL.Text := Format(SQLText, [StaffList]);
    ExecSQL;
    Result := RowsAffected;
  end;
end;

function TdmUpdate.DownloadAreamas(handleProgress:THandleProgress): Integer;
var
  total,curr:Integer;
  remoteQuery: TMyQuery;
  localeQuery: TADOQuery;
  _sql:String;
begin
  total := 0;
  curr := 0;

  remoteQuery := TMyQuery.Create(nil);
  remoteQuery.Connection := dmMain.MyC_Server;
  localeQuery := TADOQuery.Create(nil);
  localeQuery.Connection := dmMain.ac_Local;

  _sql := 'select Area_Code,AreaNameE,AreaNameC,AreaNameS,ST_Prefix,RateCode,StartValue from AREAMAS';
  with remoteQuery do
  begin
    Close;
    SQL.Text := _sql;
    Open;
  end;

  total := remoteQuery.RecordCount;
  if total > 0 then
  begin
    with localeQuery do
    begin
      Close;
      SQL.Text := 'delete from areamas';
      ExecSQL;
      Close;
      SQL.Text := _sql;
      Open;
    end;
    remoteQuery.First;
    while not remoteQuery.Eof do
    begin
      localeQuery.Append;
      localeQuery.FieldByName('Area_Code').AsString := remoteQuery.FieldByName('Area_Code').AsString;
      localeQuery.FieldByName('AreaNameE').AsString := remoteQuery.FieldByName('AreaNameE').AsString;
      localeQuery.FieldByName('AreaNameC').AsString := remoteQuery.FieldByName('AreaNameC').AsString;
      localeQuery.FieldByName('AreaNameS').AsString := remoteQuery.FieldByName('AreaNameS').AsString;
      localeQuery.FieldByName('ST_Prefix').AsString := remoteQuery.FieldByName('ST_Prefix').AsString;
      localeQuery.FieldByName('RateCode').AsString := remoteQuery.FieldByName('RateCode').AsString;
      localeQuery.FieldByName('StartValue').AsInteger := remoteQuery.FieldByName('StartValue').AsInteger;
      remoteQuery.Next;
      curr := curr + 1;
      handleProgress(total,curr);
    end;
    localeQuery.Post;
  end;

  remoteQuery.Close;
  FreeAndNil(remoteQuery);
  localeQuery.Close;
  FreeAndNil(localeQuery);
end;

function TdmUpdate.DownloadDeptmas(handleProgress:THandleProgress): Integer;
var
  total,curr:Integer;
  remoteQuery: TMyQuery;
  localeQuery: TADOQuery;
  _sql:String;
begin
  total := 0;
  curr := 0;

  remoteQuery := TMyQuery.Create(nil);
  remoteQuery.Connection := dmMain.MyC_Server;
  localeQuery := TADOQuery.Create(nil);
  localeQuery.Connection := dmMain.ac_Local;

  _sql := 'select DEPT_CODE,DEPT_NAMEC,DEPT_NAMEE,DEPT_NAMES from DEPTMAS';
  with remoteQuery do
  begin
    Close;
    SQL.Text := _sql;
    Open;
  end;

  total := remoteQuery.RecordCount;
  if total > 0 then
  begin
    with localeQuery do
    begin
      Close;
      SQL.Text := 'delete from deptmas';
      ExecSQL;
      Close;
      SQL.Text := _sql;
      Open;
    end;
    remoteQuery.First;
    while not remoteQuery.Eof do
    begin
      localeQuery.Append;
      localeQuery.FieldByName('DEPT_CODE').AsString := remoteQuery.FieldByName('DEPT_CODE').AsString;
      localeQuery.FieldByName('DEPT_NAMEC').AsString := remoteQuery.FieldByName('DEPT_NAMEC').AsString;
      localeQuery.FieldByName('DEPT_NAMEE').AsString := remoteQuery.FieldByName('DEPT_NAMEE').AsString;
      localeQuery.FieldByName('DEPT_NAMES').AsString := remoteQuery.FieldByName('DEPT_NAMES').AsString;
      remoteQuery.Next;
      curr := curr + 1;
      handleProgress(total,curr);
    end;
    localeQuery.Post;
  end;

  remoteQuery.Close;
  FreeAndNil(remoteQuery);
  localeQuery.Close;
  FreeAndNil(localeQuery);
end;

function TdmUpdate.DownloadStoremas(handleProgress:THandleProgress): Integer;
var
  total,curr:Integer;
  remoteQuery: TMyQuery;
  localeQuery: TADOQuery;
  _sql:String;
begin
  total := 0;
  curr := 0;

  remoteQuery := TMyQuery.Create(nil);
  remoteQuery.Connection := dmMain.MyC_Server;
  localeQuery := TADOQuery.Create(nil);
  localeQuery.Connection := dmMain.ac_Local;

  _sql := 'select STORE_CODE, CUS_CODE, LOCATION_ENG, LOCATION_CHI, LOCATION_CHS,Area_Code, UNITCODE,CompID, LocID,Brand,Active,NC_NM_S from STOREMAS';
  with remoteQuery do
  begin
    Close;
    SQL.Text := _sql;
    Open;
  end;

  total := remoteQuery.RecordCount;
  if total > 0 then
  begin
    with localeQuery do
    begin
      Close;
      SQL.Text := 'delete from storemas';
      ExecSQL;
      Close;
      SQL.Text := _sql;
      Open;
    end;
    remoteQuery.First;
    while not remoteQuery.Eof do
    begin
      localeQuery.Append;
      localeQuery.FieldByName('STORE_CODE').AsString := remoteQuery.FieldByName('STORE_CODE').AsString;
      localeQuery.FieldByName('CUS_CODE').AsString := remoteQuery.FieldByName('CUS_CODE').AsString;
      localeQuery.FieldByName('LOCATION_ENG').AsString := remoteQuery.FieldByName('LOCATION_ENG').AsString;
      localeQuery.FieldByName('LOCATION_CHI').AsString := remoteQuery.FieldByName('LOCATION_CHI').AsString;
      localeQuery.FieldByName('LOCATION_CHS').AsString := remoteQuery.FieldByName('LOCATION_CHS').AsString;
      localeQuery.FieldByName('Area_Code').AsString := remoteQuery.FieldByName('Area_Code').AsString;
      localeQuery.FieldByName('UNITCODE').AsString := remoteQuery.FieldByName('UNITCODE').AsString;
      localeQuery.FieldByName('CompID').AsString := remoteQuery.FieldByName('CompID').AsString;
      localeQuery.FieldByName('LocID').AsString := remoteQuery.FieldByName('LocID').AsString;
      localeQuery.FieldByName('Brand').AsString := remoteQuery.FieldByName('Brand').AsString;
      localeQuery.FieldByName('Active').AsString := remoteQuery.FieldByName('Active').AsString;
      localeQuery.FieldByName('NC_NM_S').AsString := remoteQuery.FieldByName('NC_NM_S').AsString;
      remoteQuery.Next;
      curr := curr + 1;
      handleProgress(total,curr);
    end;
    localeQuery.Post;
  end;

  remoteQuery.Close;
  FreeAndNil(remoteQuery);
  localeQuery.Close;
  FreeAndNil(localeQuery);
end;

end.
