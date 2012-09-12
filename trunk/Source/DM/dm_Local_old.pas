{***************************************************************************************************
Module: �������ݿ�ģ��
Effect�������������ݣ������������Ϣ������Ա�����ϡ�ָ�Ƶ�
Author��JackyZhou
Data: 2006-07-05 to 2006-07-05
Remark: ��sDb_Local�����Ƶ�Щģ��
***************************************************************************************************}
unit dm_Local_old;

interface
uses
  unt_Control,unt_File, unt_XML, Classes, SysUtils, ADODB, DB, siComp,
  DateUtils,UnicodeFile,Dialogs,unt_domain, kbmMemTable;

type
  TdmLocal_old = class(TDataModule)
    ADOConn: TADOConnection;
    ADOQuery: TADOQuery;
    IntraDateSet: TADOQuery;
    ADOComm: TADOCommand;
    ado_Data: TADOQuery;
    aq_Staff: TADOQuery;
    siLang: TsiLang;
    cmdSigndet: TADOCommand;
    qrySigndet: TADOQuery;
    ADOQuery_MealTime: TADOQuery;
    ADOQry_SysTime: TADOQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    FStaffSQL: TKXML;
    FSQL : TKXML;
    FDBFile: String;
    FDBPWD: String;
    FAreaCode: String;
    FStoreCode: String;
    FmailHost: string;
    FmailUsername: String;
    FmailPassword: String;
    FLanguage: Integer;
    { Private declarations }
  protected
    //Author: JackyZhou at 2006-09-22             //Effect: ��ñ������ݺ�Ĵ����
    function GetMaxSEQ(): Integer;

  public
    //Author: JackyZhou at 2008-02-16             //Effect: �������
    procedure DropTable(ATable: string);
    procedure EmptyTable(ATable: string);
    function SelectTable(ATable: string): TDataSet;

    //Author: JackyZhou at 2006-07-05             //Effect: ���ļ�����
    function OpenDatabase(Const dbFile: String=''): Boolean;

    //Author: JackyZhou at 2006-07-05             //Effect: �ر��ļ�����
    function CloseDatabase(): Boolean;

    //Author: JackyZhou at 2006-07-05             //Effect: ���Ա����
    function GetStaffName(StaffID: String; lang: TLang): String;

    //Author: JackyZhou at 2006-07-05             //Effect: ���Ա��ָ�Ʊ��
    function GetStaffFPID(stffID: String): String;

    //Author: JackyZhou at 2006-07-05             //Effect: ������һ����ָ��
    function GetLastFingerNo(fpID: String): Integer;

    //Author: JackyZhou at 2006-07-05             //Effect: ���Ա�����
    function GetStaffID(fpID: String): String;

    //Author: JackyZhou at 2006-07-05             //Effect: ������һ��Ա�����
    function GetLastStaffID: String;

    ////Author: NifooNing at 2008-04-21             //Effect: ��������µ�Ա����Ϣ�ĸ���ʱ��
    function GetLastStaffUpdateTime: TDateTime;

    //Author: JackyZhou at 2006-07-05             //Effect: ��õ���Ա������Ϣ
    function GetIntraData(): TDataSet;

    //Author: JackyZhou at 2006-07-05             //Effect: ����һ������Ա������Ϣ       //����
    procedure InsertData(StaffID, SignCode: String; SignTime: TDateTime);

    //Author: JackyZhou at 2006-07-05             //Effect: ��õ����ϴ�������Ĵ�����
    function GetUploadData(): TDataSet;
    function GetUploadErrorTimeData: TDataSet;
    //Author: JackyZhou at 2006-07-05             //Effect: ����δ�ϴ������ݵ�ʱ��
    //update by nifooning at 2009-04-17           //Effect: ֻ����ʵ���ϴ�������.����SEQ������UpdateTime=null
    procedure UpdateUploadData(dataSet:TDataSet;upTime: TDateTime);

    //Author: JackyZhou at 2006-07-05             //Effect: �����µ�Ա������
    function InsertStaffData(staffData: TDataSet): Integer;

    //Author: NifooNing at 2008-04-21             //Effect: ����Ա������
    function UpdateStaffData(staffData: TDataSet): Integer;

    //Author: NifooNing at 2008-04-21             //Effect: �ϲ�(�������뱾��)Ա������
    function MergeStaffData(staffData,LocalStaffID: TDataSet): Integer;

    //Author: JackyZhou at 2006-07-05             //Effect: ����һ���򿨼�¼
    procedure InsertSignData(StaffID, SignCode: String; SignTime: TDateTime);
    procedure InsertErrorTimeData(StaffID, SignCode: String; SignTime, LastTime, LastSysTime: TDateTime);

    //Author: NifooNing at 2009-04-20             //Effect: ���������Ƿ񱣴�ɹ�
    function checkInsertSignData(StaffID, SignCode: String; SignTime: TDateTime):boolean;

    //Author: JackyZhou at 2006-07-05             //Effect: ����һָ������
    function AddFMData(fpID, fmData: String): Integer;

    //Author: JackyZhou at 2006-07-05             //Effect: �������ָ������
    function GetAllFMData(): TDataSet;

    //Author: NifooNing at 2009-04-17             //Effect: ���ĳ����������Ա����ָ������
    function loadFMDataByStore(StoreCode:String): TDataSet;

    //Author: NifooNing at 2009-04-17             //Effect: ���ĳ����������Ա����ָ������
    function loadFMDataByArea(AreaCode:String): TDataSet;

    //Author: NifooNing at 2009-04-17             //Effect: ���ָ����Ա����ָ������
    function loadFMDataByStaffId(staffIdList:String): TDataSet;

    //Author: JackyZhou at 2006-07-07             //Effect: ��õ�������Ա��ָ�ƺ�
    function GetAllFPID(storeCode : String): TDataSet;

    //Author: JackyZhou at 2006-07-07             //Effect: ɾ��һָ��
    procedure DelFMData(fpID: String);

    //Author: JackyZhou at 2006-07-10             //Effect: ���һָ������
    function GetFMData(fpID: String): TDataSet;

    //Author: JackyZhou at 2006-07-10             //Effect: ����ָ������
    procedure DownloadFMData(AData: TDataSet);

    //Author: JackyZhou at 2006-09-22             //Effect: ��ñ������ݵ�����ʱ��
    function GetLastSignTime(): TDateTime;

    //Author: JackyZhou at 2006-10-25             //Effect: ��õ����б�
    function GetStoreList(): TDataset;

    //Author: JackyZhou at 2007-02-20             //Effect: ����ò�ʱ��
    function GetMealTime(StaffID: String): TDateTime;

    //Author: JackyZhou at 2007-08-01             //Effect: ɾ��ĳ�³ٵ���Ϣ
    function DeleteLateInfo(sYear, sMonth: string): Integer;

    //Author: JackyZhou at 2006-07-05             //Effect: �����³ٵ���Ϣ
    function InsertLateInfo(LateData: TkbmMemTable): Integer;

    //Author: JackyZhou at 2007-08-01             //Effect: ��óٵ���Ϣ
    function GetLateInfo(StaffID: String; var Latetime, Frequency: Integer): Boolean;

    //Author: JackyZhou at 2008-02-20             //Effect: ����ռ���/������
    function LoadRecipients(StroeCode: string): TDataSet;

    //Author: DelphyFU at 2009-11-05             //Effect: �������StaffID
    function GetAllStaffID: TDataSet;
    //======================================== Staff ========================================//
    //----------------------------------------//Effect: ��õ�����Ϣ
    //Author: JackyZhou at 2007-10-17         //Remark:
    function LoadAreaMas(): TDataSet;
    function LoadStoreMas(Area_Code: String): TDataSet;
    function LoadStoreStaff(StoreCode: String): TDataSet;

    //----------------------------------------//Effect: ��õ���Ա������¼ָ�Ƶ�����
    //Author: JackyZhou at 2008-02-29         //Remark:
    function LoadStaffFingerCount(StoreCode: String): TDataSet;

    //====================�����ʼ�����==========================================
    //Author: NifooNing at 2008-04-22
    function updateEmailMas(SqlDel,SqlIns:String;aDataSet:TDataSet):Integer;
    function updateEmailList(SqlDel,SqlIns:String;aDataSet:TDataSet):Integer;
    function updateEmailDomain(SqlDel,SqlIns:String;aDataSet:TDataSet):Integer;
    //--------------------------------------------------------------------------

    //Author: NifooNing at 2008-04-21             //Effect: ����ռ����б�
    procedure GetRecipientsList(var RecList,RecCCList,RecBCCList:TStrings);

    function findStaffByFpid(fpId:String):TStaff;
    function getStaff(staffId:String):TStaff;
    //
    function GetSysTime: TDateTime;
    function GetLastTime: TDateTime;
    procedure SetSysTime(LastSysTime, SignTime : TDateTime);
  published
    property DBFile: String read FDBFile write FDBFile;
    property DBPWD: String read FDBPWD write FDBPWD;
    property AreaCode: String read FAreaCode write FAreaCode;
    property StoreCode: String read FStoreCode write FStoreCode;
    property Language: Integer read FLanguage write FLanguage;
  end;

var
  dmLocal_old: TdmLocal_old;

implementation

uses dm_Server, unt_System;

var
  LateInfo_Insert: TStringList;
  SQLPath: String;

const
  ConnStr = 'Provider=Microsoft.Jet.OLEDB.4.0;Password="%S";Data Source=%S;Persist Security Info=True';
  cmdStr = 'Insert Into STAFF (STAFFID, Area_Code, Store_Code, STAFF_NAME_C, STAFF_NAME_E, STAFF_NAME_S, ' +
           'NICKNM_E, FPID, UpdateTime,ResignDate,Date_Of_Join)' + 
           ' Values (:pStaffID, :pAreaCode, :pStoreCode, :pNameC, :pNameE, :pNameS, :pNicknmE, :pFPID, :pUpdateTime, :pResignDate, :pDate_Of_Join)';

  cmdDownload = 'Insert Into fp_fingermark Values(:pFPID, :pFingerNo, :pMarkData, :pEnrollDate, :pDownloadData)';

  SQL_UPDATE_STUFF = 'UPDATE staff SET area_code=:pAreaCode,store_code=:pStoreCode,'+
                                      'staff_name_c=:pNameC,staff_name_e=:pNameE,'+
                                      'staff_name_s=:pNameS,nicknm_e=:pNicknmE,'+
                                      'fpid=:pFpid,UpdateTime=:pUpdateTime, '+
                                      'ResignDate=:pResignDate,Date_Of_Join=:pDate_Of_Join ' +
                                'WHERE staffID=:pStaffID';

  SQL_DROP_TABLE = 'DROP TABLE ';
  SQL_EMPTY_TABLE = 'Delete From  ';
  SQL_SELECT_TABLE = 'SELECT * FROM ';

{$R *.dfm}

procedure TdmLocal_old.DataModuleCreate(Sender: TObject);
begin
  SQLPath := Control.AppPath + '\SQL\';
  FSQL := TKXML.Create(SQLPath +'Local.xml');

  LateInfo_Insert := TStringList.Create;
  //LateInfo_Insert.LoadFromFile(SQLPath +'hr.Late.Insert.sql');
  LateInfo_Insert.Text := 'Insert Into hr_late_info(syear, smonth, staffid, latetime, frequency) '+
    ' Values(:pYear, :pMonth, :pStaffID, :pLateTime, :pFrequency)';
  OpenDatabase();
end;

//============================== protected ==============================//

function TdmLocal_old.GetMaxSEQ: Integer;
begin
  with ADOQuery do
  begin
    //SQL.LoadFromFile(SQLPath + 'GetMaxSEQ.sql');
    SQL.Text := LoadUnicodeFile(SQLPath + 'GetMaxSEQ.sql');
    Parameters.ParamByName('pAreaCode').Value := AreaCode;
    Parameters.ParamByName('pStoreCode').Value := StoreCode;
    Open;
    if RecordCount > 0 then
      Result := FieldByName('SEQ').AsInteger
    else
      Result := 0;
  end;    // with
end;

//============================== Public ==============================//
function TdmLocal_old.GetAllStaffID: TDataSet;
begin
  with ADOQuery do
  begin
    SQL.Clear;
    SQL.Text := 'SELECT staffid FROM staff where ResignDate is null';
    OPEN;           
  end;
  Result := ADOQuery;
end;

procedure TdmLocal_old.DropTable(ATable: string);
begin     
  with ADOQuery do
  try
    SQL.Text := SQL_DROP_TABLE + ATable;
    ExecSQL;
  except

  end;
end;

procedure TdmLocal_old.EmptyTable(ATable: string);
begin
  with ADOQuery do
  begin
    SQL.Text := SQL_EMPTY_TABLE + ATable;
    ExecSQL;
  end;
end;

function TdmLocal_old.findStaffByFpid(fpId: String): TStaff;
var
  staff:TStaff;
begin
  staff := nil;
  with ADOQuery do
  begin
    Close;
    SQL.Text := 'Select * From STAFF Where FPID = :pPFID';
    Parameters.ParamByName('pPFID').Value := fpID;
    Open;
    if (RecordCount > 0) then
    begin
      staff := TStaff.Create;
      staff.staffId := FieldByName('StaffID').AsString;
      staff.fpId := FieldByName('FPID').AsString;
      staff.AreaCode := FieldByName('Area_Code').AsString;
      staff.StoreCode := FieldByName('Store_Code').AsString;
      staff.StaffNameEn := FieldByName('STAFF_NAME_E').AsString;
      staff.StaffNameCn := FieldByName('STAFF_NAME_S').AsString;
      staff.StaffNameTw := FieldByName('STAFF_NAME_C').AsString;
      staff.Nickname := FieldByName('NICKNM_E').AsString;
      staff.DateOfJoin := FieldByName('Date_Of_Join').AsDateTime;
      staff.ResignDate := FieldByName('ResignDate').AsDateTime;
      staff.UpdateTime := FieldByName('UpdateTime').AsDateTime;
    end;
    Close;
  end;
  Result := staff;
end;

function TdmLocal_old.SelectTable(ATable: string): TDataSet;
begin
  with ado_Data do
  begin
    SQL.Text := SQL_SELECT_TABLE + ATable;
    Open;
    Result := ado_Data;
  end;
end;

function TdmLocal_old.updateEmailDomain(SqlDel, SqlIns: String;
  aDataSet: TDataSet): Integer;
var
  i:Integer;
begin
  with ADOQuery do
  begin
    //ɾ���ɵ�����
    Close;
    SQL.Text := SqlDel;
    ExecSQL;
    //�����µ�����
    Close;
    SQL.Text := SqlIns;
    Prepared := true;
    aDataSet.First;
    while not aDataSet.Eof do
    begin
      Parameters.ParamByName('pDomainID').Value     := aDataSet.FieldByName('DomainID').AsString;
      Parameters.ParamByName('pRecipient').Value    := aDataSet.FieldByName('Recipient').AsString;
      Parameters.ParamByName('pRecipientBCC').Value := aDataSet.FieldByName('RecipientBCC').AsString;
      Parameters.ParamByName('pRecipientCC').Value  := aDataSet.FieldByName('RecipientCC').AsString;
      aDataSet.Next;
      ExecSQL;
    end;
  end;
  Result := aDataSet.RecordCount;
end;

function TdmLocal_old.updateEmailList(SqlDel, SqlIns: String;
  aDataSet: TDataSet): Integer;
var
  i:Integer;
begin
  with ADOQuery do
  begin
    //ɾ���ɵ�����
    Close;
    SQL.Text := SqlDel;
    ExecSQL;
    //�����µ�����
    Close;
    SQL.Text := SqlIns;
    Prepared := true;
    aDataSet.First;
    while not aDataSet.Eof do begin
      Parameters.ParamByName('pAreaCode').Value  := aDataSet.FieldByName('AreaCode').AsString;
      Parameters.ParamByName('pStoreCode').Value := aDataSet.FieldByName('StoreCode').AsString;
      Parameters.ParamByName('pDomainID').Value  := aDataSet.FieldByName('DomainID').AsString;
      Parameters.ParamByName('pPurposes').Value  := aDataSet.FieldByName('purposes').AsString;
      aDataSet.Next;
      ExecSQL;
    end;
  end;
  Result := aDataSet.RecordCount;
end;

function TdmLocal_old.updateEmailMas(SqlDel, SqlIns: String;
  aDataSet: TDataSet): Integer;
var
  i:Integer;
begin
  with ADOQuery do
  begin
    //ɾ���ɵ�����
    Close;
    SQL.Text := SqlDel;
    ExecSQL;
    //�����µ�����
    Close;
    SQL.Text := SqlIns;
    Prepared := true;
    aDataSet.First;
    while not aDataSet.Eof do
    begin
      Parameters.ParamByName('pFMID').Value      := aDataSet.FieldByName('FMID').AsInteger;
      Parameters.ParamByName('pEmailName').Value := aDataSet.FieldByName('EmailName').AsString;
      Parameters.ParamByName('pEAddress').Value  := aDataSet.FieldByName('EAddress').AsString;
      Parameters.ParamByName('pActivate').Value  := aDataSet.FieldByName('Activate').AsString;
      aDataSet.Next;
      ExecSQL;
    end;
  end;
  Result := aDataSet.RecordCount;
end;
function TdmLocal_old.OpenDatabase(const dbFile: String): Boolean;
var
  openFile: String;
begin
  Self.DBFile := Config.LDBFile;
  DBPWD := Config.LDBPassword;
  AreaCode := Config.AreaCode;
  StoreCode := Config.StoreCode;
  Language := Config.ShowLang;

  if dbFile = ''  then
    openFile := Control.AppPath + '\' + Self.DBFile
  else
    openFile := Control.AppPath + '\' + dbFile;
  try
    CloseDatabase;
    ADOConn.LoginPrompt := False;
    ADOConn.ConnectionString := Format(ConnStr, [DBPWD ,openFile]);
    ADOConn.Connected := true;
    Result := true;
  except

    //Raise ERangeError.CreateFmt(siLang.GetText('NOT_OPEN_DB'), [openFile]);
  end;
end;

function TdmLocal_old.CloseDatabase(): Boolean;
begin
  try
    if ADOConn.Connected then
      ADOConn.Connected := false;
    Result := true;
  except
    //Raise ERangeError.CreateFmt(siLang.GetText('NOT_CLOSE_DB'), []);
    Result := false;
  end;
end;

function TdmLocal_old.GetStaffName(StaffID: String; lang: TLang): String;
begin
  with ADOQuery do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT STAFF_NAME_C, STAFF_NAME_E, STAFF_NAME_S, NICKNM_E');
    SQL.Add(' FROM STAFF WHERE STAFFID=:StaffID');
    Parameters.ParamByName('StaffID').Value := StaffID;
    Open;
    if RecordCount > 0 then
    case lang of
      ENG : Result := FieldByName('NICKNM_E').AsString;
      CHS : Result := FieldByName('STAFF_NAME_S').AsString;
      GB5 : Result := FieldByName('STAFF_NAME_C').AsString; 
      CPY : Result := FieldByName('STAFF_NAME_E').AsString;
    else
      Result := FieldByName('NICKNM_E').AsString;
    end
    else
      Result := 'No Name!';
  end;
end;

function TdmLocal_old.GetStaffFPID(stffID: String): String;
var
  fpID : String;
begin
  with ADOQuery do
  begin
    Close;
    SQL.Text := 'Select FPID From STAFF Where StaffID = :pStaffID';
    Parameters.ParamByName('pStaffI').Value := stffID;
    Open;
    if (RecordCount < 0) or (FieldByName('FPID').IsNull) then
      fpID := ''
    else
      fpID := FieldByName('FPID').AsString;
  end;
  Result := fpID;
end;

function TdmLocal_old.GetLastFingerNo(fpID: String): Integer;
var
  fingerNo : Integer;
begin
  with ADOQuery do
  begin
    Close;
    //SQL.LoadFromFile(SQLPath + 'SearchFPdata.sql');
    SQL.Text := LoadUnicodeFile(SQLPath + 'SearchFPdata.sql');
    Parameters.ParamByName('pFPID').Value := fpID;
    Open;
    if (RecordCount < 0) or (FieldByName('FingerNo').IsNull) then
      fingerNo := 0
    else
      fingerNo := FieldByName('FingerNo').AsInteger;
  end;
  Result := fingerNo;
end;


function TdmLocal_old.GetStaffID(fpID: String): String;
var
  staffID : String;
begin
  with ADOQuery do
  begin
    Close;
    SQL.Text := 'Select StaffID From STAFF Where FPID = :pPFID';
    Parameters.ParamByName('pPFID').Value := fpID;
    Open;
    if (RecordCount < 0) or (FieldByName('StaffID').IsNull) then
      staffID := ''
    else
      staffID := FieldByName('StaffID').AsString;
  end;
  Result := staffID;
end;

function TdmLocal_old.GetLastStaffID: String;
begin
  with ADOQuery do
  begin
    Close;
    SQL.Text := 'Select Max(STAFFID) as LastStaffID From STAFF';
    Open;
    if RecordCount > 0 then
      Result := FieldByName('LastStaffID').AsString
    else
      Result := '';
    Close;
  end;
end;

function TdmLocal_old.GetLastStaffUpdateTime: TDateTime;
begin
  with ADOQuery do
  begin
    Close;
    SQL.Text := 'Select Max(UpdateTime) as LastUpdateTime From STAFF';
    Open;
    if RecordCount > 0 then
      Result := FieldByName('LastUpdateTime').AsDateTime
    else
      Result := Date;
    Close;
  end;
end;

function TdmLocal_old.GetIntraData: TDataSet;
begin
  with IntraDateSet do
  begin
    Close;
    case Language of
      0: SQL.Text := LoadUnicodeFile(SQLPath + '\intra_en.sql');
      1: SQL.Text := LoadUnicodeFile(SQLPath + '\intra_cn.sql');
      2: SQL.Text := LoadUnicodeFile(SQLPath + '\intra_tw.sql');
    end;
    Parameters.ParamByName('date').Value := Date;
    Open;
  end;
  Result := IntraDateSet;
end;

procedure TdmLocal_old.InsertData(StaffID, SignCode: String; SignTime: TDateTime);
begin
  try
    with ADOQuery do
    begin
      Close;
      SQL.Clear;
      SQL.Add('Insert Into signdet(SIGN_DATETIME, STAFFID, SIGN_CODE, AREA_CODE, STORE_CODE, IPADDRESS)');
      SQL.Add(' Values(:SignTime, :StaffID, :SignCode, :AreaCode, :StoreCode, :IPAddress)');
      Parameters.ParamByName('SignTime').Value := SignTime;
      Parameters.ParamByName('StaffID').Value := StaffID;
      Parameters.ParamByName('SignCode').Value := SignCode;
      Parameters.ParamByName('AreaCode').Value := AreaCode;
      Parameters.ParamByName('StoreCode').Value := StoreCode;
      Parameters.ParamByName('IPAddress').Value := KSys.GetLocalIP;
      ExecSQL;
    end;
  except
    //Raise ERangeError.Create(siLang.GetText('NOT_INSERT_DATA'));
  end;
end;

function TdmLocal_old.GetUploadData: TDataSet;
var
  dataset:TADOQuery;
begin
  dataset := TADOQuery.Create(nil);
  dataset.Connection := ADOConn;
  with dataset do
  begin
    Close;
    SQL.Text := 'Select * From signdet Where UPLOAD_TIME is Null Order By SEQ';
    Open;
  end;
  Result := dataset;
end;

function TdmLocal_old.GetUploadErrorTimeData: TDataSet;
var
  dataset:TADOQuery;
begin
  dataset := TADOQuery.Create(nil);
  dataset.Connection := ADOConn;
  with dataset do
  begin
    Close;
    SQL.Text := 'Select * From errortime Where UPLOAD_TIME is Null Order By SEQ';
    Open;
  end;
  Result := dataset;
end;



procedure TdmLocal_old.UpdateUploadData(dataSet:TDataSet;upTime: TDateTime);
begin
  dataSet.First;
  while not dataSet.Eof do
  begin
    dataSet.Edit;
    dataSet.FieldByName('UPLOAD_TIME').AsDateTime := upTime;
    dataSet.Post;
    dataSet.Next;
  end;
end;

function TdmLocal_old.InsertStaffData(staffData: TDataSet): Integer;
begin
  ADOComm.ParamCheck := true;
  ADOComm.CommandText := cmdStr;
  ADOComm.Prepared := true;
  staffData.First;
  while Not(staffData.Eof) do
  try
    with ADOComm do
    begin
      Parameters.ParamByName('pStaffID').Value := staffData.FieldByName('STAFFID').AsString;
      Parameters.ParamByName('pAreaCode').Value := staffData.FieldByName('Area_Code').AsString;
      Parameters.ParamByName('pStoreCode').Value := staffData.FieldByName('Store_Code').AsString;
      Parameters.ParamByName('pNameC').Value := staffData.FieldByName('STAFF_NAME_C').AsString;
      Parameters.ParamByName('pNameE').Value := staffData.FieldByName('STAFF_NAME_E').AsString;
      Parameters.ParamByName('pNameS').Value := staffData.FieldByName('STAFF_NAME_S').AsString;
      Parameters.ParamByName('pNicknmE').Value := staffData.FieldByName('NICKNM_E').AsString;
      Parameters.ParamByName('pFPID').Value := staffData.FieldByName('FPID').AsString;
      Parameters.ParamByName('pUpdateTime').Value := staffData.FieldByName('UpdateTime').AsDateTime;
      Parameters.ParamByName('pDate_Of_Join').Value := staffData.FieldByName('Date_Of_Join').AsDateTime;
      Parameters.ParamByName('pResignDate').Value := staffData.FieldByName('ResignDate').Value;
      Execute();
    end;
    staffData.Next;
  except
     //Raise ERangeError.Create(siLang.GetText('NOT_INSERT_STAFF'));
  end;
  Result := staffData.RecordCount;
end;

function TdmLocal_old.UpdateStaffData(staffData: TDataSet): Integer;
begin
  ADOComm.ParamCheck := true;
  ADOComm.CommandText := SQL_UPDATE_STUFF;
  ADOComm.Prepared := true;
  staffData.First;
  while Not(staffData.Eof) do
  try
    with ADOComm do
    begin
      Parameters.ParamByName('pAreaCode').Value := staffData.FieldByName('Area_Code').AsString;
      Parameters.ParamByName('pStoreCode').Value := staffData.FieldByName('Store_Code').AsString;
      Parameters.ParamByName('pNameC').Value := staffData.FieldByName('STAFF_NAME_C').AsString;
      Parameters.ParamByName('pNameE').Value := staffData.FieldByName('STAFF_NAME_E').AsString;
      Parameters.ParamByName('pNameS').Value := staffData.FieldByName('STAFF_NAME_S').AsString;
      Parameters.ParamByName('pNicknmE').Value := staffData.FieldByName('NICKNM_E').AsString;
      Parameters.ParamByName('pFpid').Value := staffData.FieldByName('FPID').AsString;
      Parameters.ParamByName('pUpdateTime').Value := staffData.FieldByName('UpdateTime').AsDateTime;
      Parameters.ParamByName('pStaffID').Value := staffData.FieldByName('STAFFID').AsString;
      Parameters.ParamByName('pDate_Of_Join').Value := staffData.FieldByName('Date_Of_Join').AsDateTime;
      Parameters.ParamByName('pResignDate').Value := staffData.FieldByName('ResignDate').Value;
      Execute();
    end;
    staffData.Next;
  except
     //Raise ERangeError.Create(siLang.GetText('NOT_INSERT_STAFF'));
  end;
  ADOComm.Prepared := false;
  Result := staffData.RecordCount;
end;

function TdmLocal_old.MergeStaffData(staffData,LocalStaffID: TDataSet): Integer;
var
  StaffID:string;
begin
  ADOComm.ParamCheck := true;
  staffData.First;
  while Not(staffData.Eof) do
  try
    StaffID := staffData.FieldByName('STAFFID').AsString;
//    if CompareStr(StaffID,LastStaffID) <= 0 then
    if LocalStaffID.Locate('STAFFID',StaffID,[]) then
    
      ADOComm.CommandText := SQL_UPDATE_STUFF
    else
      ADOComm.CommandText := cmdStr;
    ADOComm.Prepared := true;
    with ADOComm do
    begin
      Parameters.ParamByName('pAreaCode').Value := staffData.FieldByName('Area_Code').AsString;
      Parameters.ParamByName('pStoreCode').Value := staffData.FieldByName('Store_Code').AsString;
      Parameters.ParamByName('pNameC').Value := staffData.FieldByName('STAFF_NAME_C').AsString;
      Parameters.ParamByName('pNameE').Value := staffData.FieldByName('STAFF_NAME_E').AsString;
      Parameters.ParamByName('pNameS').Value := staffData.FieldByName('STAFF_NAME_S').AsString;
      Parameters.ParamByName('pNicknmE').Value := staffData.FieldByName('NICKNM_E').AsString;
      Parameters.ParamByName('pFpid').Value := staffData.FieldByName('FPID').AsString;
      Parameters.ParamByName('pUpdateTime').Value := staffData.FieldByName('UpdateTime').Value;
      Parameters.ParamByName('pStaffID').Value := StaffID;
      Parameters.ParamByName('pDate_Of_Join').Value := staffData.FieldByName('Date_Of_Join').Value;
      Parameters.ParamByName('pResignDate').Value  := staffData.FieldByName('ResignDate').Value;

      Execute();
    end;
    staffData.Next;
  except
     KFile.LogWrite(Format(siLang.GetText('MERGE_STAFF_FAIL'),[staffID]));
  end;
  ADOComm.Prepared := false;
  Result := staffData.RecordCount;
end;

procedure TdmLocal_old.InsertErrorTimeData(StaffID: string; SignCode: string; SignTime: TDateTime; LastTime, LastSysTime: TDateTime);
begin
    with ADOQuery do
    begin
      Close;
      SQL.Clear;
      SQL.Text := 'Insert Into Errortime(SIGN_DATETIME, STAFFID, SIGN_CODE, AREA_CODE, STORE_CODE,IPADDRESS, Lasttime, LastSysTime)' +
                  ' Values(:SignTime, :StaffID, :SignCode, :AreaCode, :StoreCode, :IPAddress, :Lasttime, :LastSystime)';
      Parameters.ParamByName('SignTime').Value := SignTime;
      Parameters.ParamByName('StaffID').Value := StaffID;
      Parameters.ParamByName('SignCode').Value := SignCode;
      Parameters.ParamByName('AreaCode').Value := AreaCode;
      Parameters.ParamByName('StoreCode').Value := StoreCode;
      Parameters.ParamByName('IPAddress').Value := KSys.GetLocalIP;
      Parameters.ParamByName('LastTime').Value := LastTime;
      Parameters.ParamByName('LastSysTime').Value := LastSysTime;
      ExecSQL;
      Close;
   end;
end;

procedure TdmLocal_old.InsertSignData(StaffID, SignCode: String; SignTime: TDateTime);
var
  errorStr : string;
  errorMailFlag :Boolean;
  myLastTime : TDateTime;
  myLastSysTime : TDateTime;
begin
  try
    errorMailFlag := False;
    with qrySigndet do
    begin
      //CommandText := 'Insert Into signdet(SIGN_DATETIME, STAFFID, SIGN_CODE, AREA_CODE, STORE_CODE)' +
      //               ' Values(:SignTime, :StaffID, :SignCode, :AreaCode, :StoreCode)';
      Close;
      SQL.Clear;
      //2011.6.30 petermai ���IP�ֶ�
      SQL.Text := 'Insert Into signdet(SIGN_DATETIME, STAFFID, SIGN_CODE, AREA_CODE, STORE_CODE,IPADDRESS)' +
                  ' Values(:SignTime, :StaffID, :SignCode, :AreaCode, :StoreCode, :IPAddress)';
      Parameters.ParamByName('SignTime').Value := SignTime;
      Parameters.ParamByName('StaffID').Value := StaffID;
      Parameters.ParamByName('SignCode').Value := SignCode;
      Parameters.ParamByName('AreaCode').Value := AreaCode;
      Parameters.ParamByName('StoreCode').Value := StoreCode;
      Parameters.ParamByName('IPAddress').Value := KSys.GetLocalIP;
      ExecSQL;
      Close;
      //
      myLastSysTime := GetSysTime;
      myLastTime := GetLastTime;
      //�ж�ϵͳ����ʱ���Ƿ��쳣  False :������ True : �쳣
      if (myLastTime<IncMilliSecond(SignTime,3000)) and (myLastSysTime<IncMilliSecond(SignTime,3000)) then
      begin
        //����
        SQL.Clear;
        SQL.Text := 'update LastTime set Lasttime = :pdLastTime, Lastsystime = :pdLastsysTime';
        Parameters.ParamByName('pdLastTime').Value := SignTime;
        Parameters.ParamByName('pdLastsysTime').Value := SignTime;
        try
          ExecSQL;
        finally
          errorMailFlag := False;
        end;
      end
      else
        errorMailFlag := True;
      //
      if errorMailFlag then     //�����쳣����Email
      begin
        //д���쳣����
        InsertErrorTimeData(StaffID, SignCode, SignTime, myLastTime, myLastSysTime);
        //д�쳣��Ϣ
        errorStr := ('error time : '+
                           ' LastTime : '+DateTimeTostr(myLastTime)+
                           ' SignTime : '+DateTimeTostr(SignTime)+
                           ' StaffID : '+ StaffID +
                           ' SignCode : '+ SignCode +
                           ' AreaCode : '+ AreaCode +
                           ' StoreCode : '+ StoreCode +
                           ' LocalIP : '+ KSys.GetLocalIP
                           );
        //KFile.LogWrite(errorStr);
        //��Email
        dmServer.SendMial_errorTime(errorStr);
      end;
    end;
  except
    Raise ERangeError.Create('Fail! Database Error!');
  end;
end;

procedure TdmLocal_old.SetSysTime(LastSysTime, SignTime : TDateTime);
begin
  if LastSysTime<SignTime then
  with ADOQry_SysTime do
  begin
    Close;
    Parameters.ParamByName('pdLastsysTime').Value := SignTime;
    try
      ExecSQL;
    except
    end;
  end;

end;


function  TdmLocal_old.GetSysTime: TDateTime;
begin
  with ADOQuery do
  begin
    Close;
    SQL.Clear;
    SQL.Text := 'select * from LastTime';
    Open;
    Result := FieldByName('LastsysTime').AsDateTime;
    Close;
  end;
end;

function  TdmLocal_old.GetLastTime: TDateTime;
begin
  with ADOQuery do
  begin
    Close;
    SQL.Clear;
    SQL.Text := 'select * from LastTime';
    Open;
    Result := FieldByName('LastTime').AsDateTime;
    Close;
  end;
end;


function TdmLocal_old.checkInsertSignData(StaffID, SignCode: String; SignTime: TDateTime):boolean;
begin
  try
    with qrySigndet do
    begin
      Close;
      SQL.Clear;
      SQL.Text := ' select 1 from signdet where SIGN_DATETIME = :SignTime and STAFFID = :StaffID and SIGN_CODE = :SignCode';
      Parameters.ParamByName('SignTime').value := SignTime;
      Parameters.ParamByName('StaffID').Value := StaffID;
      Parameters.ParamByName('SignCode').Value := SignCode;
      Open;
      Result := RecordCount > 0;
      Close;
    end;
  except
    Raise ERangeError.Create('Fail! Database Error!');
  end;
end;


function TdmLocal_old.AddFMData(fpID, fmData: String): Integer;
var
  fingerNo : integer;
begin
  try
    fingerNo := GetLastFingerNo(fpID) + 1;
    with ADOQuery do
    begin
      Close;
      //SQL.LoadFromFile(SQLPath + 'InserFPdata.sql');
      SQL.Text := LoadUnicodeFile(SQLPath + 'InserFPdata.sql');
      Parameters.ParamByName('pFPID').Value := fpID;
      Parameters.ParamByName('pFingerNo').Value := fingerNo;
      Parameters.ParamByName('pMarkData').Value := fmData;
      Parameters.ParamByName('pEnrollDate').Value := Now();      
      ExecSQL;
    end;
  except
    //Raise ERangeError.Create(siLang.GetText('NOT_INSERT_FM'));
  end;
  Result := fingerNo;
end;

function TdmLocal_old.GetAllFMData: TDataSet;
begin
  with ADOQuery do
  begin
    Close;
    SQL.Text := 'Select * From fp_fingermark';
    Open;
  end;
  Result := ADOQuery;
end;

function TdmLocal_old.GetAllFPID(storeCode : String): TDataSet;
begin
  with ADOQuery do
  begin
    if Language > 1 then
      //SQL.LoadFromFile(SQLPath + '\fpCount_C.sql')
      SQL.Text := LoadUnicodeFile(SQLPath + '\fpCount_C.sql')
    else
      //SQL.LoadFromFile(SQLPath + '\fpCount.sql');
      SQL.Text := LoadUnicodeFile(SQLPath + '\fpCount.sql');
    Parameters.ParamByName('pStoreCode').Value := StoreCode;
    Open;
  end;
  Result := ADOQuery;
end;

procedure TdmLocal_old.DelFMData(fpID: String);
begin
  With ADOComm do
  begin
    CommandText := 'Delete From fingermark Where FPID = :pFPID';
    Parameters.ParamByName('pFPID').Value := fpID;
    Execute();
  end;
end;

function TdmLocal_old.GetFMData(fpID: String): TDataSet;
begin
  with ADOQuery do
  begin
    SQL.Text := 'Select * From FingerMark Where FPID = :pFPID';
    Parameters.ParamByName('pFPID').Value := fpID;
    Open;
  end;    // with
  Result := ADOQuery;
end;

function TdmLocal_old.loadFMDataByArea(AreaCode: String): TDataSet;
begin
  with ADOQuery do
  begin
    Close;
    SQL.Text := 'select fm.* from fp_fingermark fm,staff s where fm.FPID = s.FPID and s.Area_Code = :AreaCode';
    Parameters.ParamByName('AreaCode').Value := AreaCode;
    Open;
  end;
  Result := ADOQuery;
end;

function TdmLocal_old.loadFMDataByStaffId(staffIdList: String): TDataSet;
begin
  with ADOQuery do
  begin
    Close;
    SQL.Text := 'select fm.* from fp_fingermark fm,staff s where fm.FPID = s.FPID and s.staffId in ("'+staffIdList+'")';
    Open;
  end;
  Result := ADOQuery;
end;

function TdmLocal_old.loadFMDataByStore(StoreCode: String): TDataSet;
begin
  with ADOQuery do
  begin
    Close;
    SQL.Text := 'select fm.* from fp_fingermark fm,staff s where fm.FPID = s.FPID and s.Store_Code = :StoreCode';
    Parameters.ParamByName('StoreCode').Value := StoreCode;
    Open;
  end;
  Result := ADOQuery;
end;

procedure TdmLocal_old.DownloadFMData(AData: TDataSet);
begin
  try
    AData.First;
    ADOComm.CommandText := cmdDownload;
    while Not(AData.Eof) do
    begin
      with ADOComm do
      begin
        Parameters.ParamByName('pFPID').Value := AData.FieldByName('FPID').AsString;
        Parameters.ParamByName('pFingerNo').Value := AData.FieldByName('FingerNo').AsString;
        Parameters.ParamByName('pMarkData').Value := AData.FieldByName('MarkData').AsString;
        Parameters.ParamByName('pEnrollDate').Value := AData.FieldByName('EnrollDate').AsDateTime;
        Parameters.ParamByName('pDownloadData').Value := now();
        Execute();
      end;
      AData.Next;
    end;
  except
   // Raise ERangeError.Create(siLang.GetText('NOT_DOWNLOAD_FM'));
  end;
end;

function TdmLocal_old.GetLastSignTime: TDateTime;
var
  seq : Integer;
begin
  seq := GetMaxSEQ -1;
  with ADOQuery do
  begin
    //SQL.LoadFromFile(SQLPath + 'GetLastSignTime.sql');
    SQL.Text := LoadUnicodeFile(SQLPath + 'GetLastSignTime.sql');
    Parameters.ParamByName('pSEQ').Value := seq;
    Open;
    if RecordCount > 0 then
      Result := FieldByName('LastTime').AsDateTime
    else
      Result := 0;
  end;    // with
end;

function TdmLocal_old.GetStoreList: TDataset;
begin
  with ADOQuery do
  begin
    Close;
    //SQL.LoadFromFile(SQLPath + 'StoreList.sql');
    SQL.Text := LoadUnicodeFile(SQLPath + 'StoreList.sql');
    Open;
  end;    // with
  Result := ADOQuery;
end;

function TdmLocal_old.GetMealTime(StaffID: String): TDateTime;
begin
  with ADOQuery_MealTime do
  begin
    Close;
  //  SQL.LoadFromFile(SQLPath + 'GetMealTime.sql');
    Parameters.ParamByName('pStaffID').Value := StaffID;
    Parameters.ParamByName('pToday').Value := Today();
    Open;
    if RecordCount > 0 then
      Result := FieldByName('SIGNDATETIME').AsDateTime
    else                     
      Result := 0;
  end;    // with
end;

procedure TdmLocal_old.GetRecipientsList(var RecList, RecCCList,
  RecBCCList: TStrings);
var
  SQLs:TStrings;
  Recipient,RecipientCC,RecipientBCC:string;
  fSQL,address:string;

  function getAddrList(aSQL,param:string):TStrings;
  var
    addrList: TStrings;
  begin
    addrList := TStringList.Create;
    with ADOQuery do begin
      Close;
      SQL.Text := Format(aSQL,[param]);
      Open;
      if RecordCount > 0 then
        while not(EOF) do
        begin
          address := FieldByName('EAddress').AsString;
          addrList.Add(address);
          Next;
        end;    // while
      Close;
    end;
    Result := addrList;
  end;

begin
  SQLs := TStringList.Create;
  SQLs.Text := dmServer.GetSQL('EMailAddList.sql');
  fSQL := SQLs.Strings[0];
  with ADOQuery do
  begin
    Close;
    SQL.Text := fSQL;
    Parameters.ParamByName('pAreaCode').value := AreaCode;
    Parameters.ParamByName('pStoreCode').value := StoreCode;
    Open;
    Recipient := FieldByName('Recipient').AsString;
    RecipientCC := FieldByName('RecipientCC').AsString;
    RecipientBCC := FieldByName('RecipientBCC').AsString;
    Close;
  end;

  if Trim(Recipient) <> ''  then
    RecList := getAddrList(SQLs[1],Recipient)
  else
    RecList := TStringList.Create;
  if Trim(RecipientCC) <> ''  then
    RecCCList := getAddrList(SQLs[1],RecipientCC)
  else
    RecCCList := TStringList.Create;
  if Trim(RecipientBCC) <> ''  then
    RecBCCList := getAddrList(SQLs[1],RecipientBCC)
  else
    RecBCCList := TStringList.Create;
end;

function TdmLocal_old.getStaff(staffId: String): TStaff;
var
  staff:TStaff;
begin
  staff := nil;
  with ADOQuery do
  begin
    Close;
    SQL.Text := 'Select * From STAFF Where StaffId = :StaffId';
    Parameters.ParamByName('StaffId').Value := staffId;
    Open;
    if (RecordCount > 0) then
    begin
      staff.staffId := FieldByName('StaffID').AsString;
      staff.fpId := FieldByName('FPID').AsString;
      staff.AreaCode := FieldByName('Area_Code').AsString;
      staff.StoreCode := FieldByName('Store_Code').AsString;
      staff.StaffNameEn := FieldByName('STAFF_NAME_E').AsString;
      staff.StaffNameCn := FieldByName('STAFF_NAME_S').AsString;
      staff.StaffNameTw := FieldByName('STAFF_NAME_C').AsString;
      staff.Nickname := FieldByName('NICKNM_E').AsString;
      staff.DateOfJoin := FieldByName('Date_Of_Join').AsDateTime;
      staff.ResignDate := FieldByName('ResignDate').AsDateTime;
      staff.UpdateTime := FieldByName('UpdateTime').AsDateTime;
    end;
    Close;
  end;
  Result := staff;
end;

function TdmLocal_old.DeleteLateInfo(sYear, sMonth: string): Integer;
var
  strSQL:WideString;
begin
  with ADOQuery do
  begin
    SQL.Clear;
    //SQL.LoadFromFile(SQLPath + 'hr.Late.Delete.sql');
    SQL.Text := LoadUnicodeFile(SQLPath + 'hr.Late.Delete.sql');
    strSQL := SQL.Text;
    Parameters.ParamByName('pYear').Value := sYear;
    Parameters.ParamByName('pMonth').Value := sMonth;
    ExecSQL;
  end;    // with
  Result := ADOQuery.RowsAffected;
end;

function TdmLocal_old.InsertLateInfo(LateData: TkbmMemTable): Integer;
var
  memTable: TkbmMemTable;
begin
  memTable := TkbmMemTable.Create(Self);
  memTable.LoadFromDataSet(LateData, [mtcpoStructure, mtcpoProperties]);
  ADOComm.ParamCheck := true;
  ADOComm.CommandText := LateInfo_Insert.Text;
  ADOComm.Prepared := true;
  memTable.First;
  KFile.LogWrite('memTable Count: ' + IntToStr(memTable.RecordCount));
  while Not(memTable.Eof) do
  try
    with ADOComm do
    begin
      Parameters.ParamByName('pYear').Value := memTable.FieldByName('syear').AsString;
      Parameters.ParamByName('pMonth').Value := memTable.FieldByName('smonth').AsString;
      Parameters.ParamByName('pStaffID').Value := memTable.FieldByName('staffid').AsString;
      Parameters.ParamByName('pLateTime').Value := memTable.FieldByName('latetime').AsInteger;
      Parameters.ParamByName('pFrequency').Value := memTable.FieldByName('frequency').AsInteger;
      Execute();
    end;
    memTable.Next;
  except
     //Raise ERangeError.Create(siLang.GetText('NOT_INSERT_LATE_DATA'));
  end;
  Result := memTable.RecordCount;
end;

function TdmLocal_old.GetLateInfo(StaffID: String; var Latetime, Frequency: Integer): Boolean;
var
  sYear, sMonth: String;
begin
  Latetime := 0;
  Frequency := 0;
  sYear := IntToStr(YearOf(Today()));
  sMonth := IntToStr(MonthOf(Today()));
  with ADOQuery do
  begin
    Close;
    //SQL.LoadFromFile(SQLPath + 'hr.Late.GetInfo.sql');
    SQL.Text := LoadUnicodeFile(SQLPath + 'hr.Late.GetInfo.sql');
    Parameters.ParamByName('pStaffID').Value := StaffID;
    Parameters.ParamByName('pYear').Value := sYear;
    Parameters.ParamByName('pMonth').Value := sMonth;
    Open;
    if RecordCount = 1 then
    begin
      Latetime := FieldByName('Latetime').AsInteger;
      Frequency := FieldByName('Frequency').AsInteger;
    end
    else
    begin
      Latetime := 0;
      Frequency := 0;
    end;
  end;
end;

function TdmLocal_old.LoadRecipients(StroeCode: string): TDataSet;
begin
  with ado_Data do
  begin
    SQL.Text := FSQL.GetNodeValue('Local.EMail.GetRecipients');
    Parameters.ParamByName('pStroeCode').Value := StroeCode;
    Open;
    Result := ado_Data;
  end;
end;

//======================================== Staff ========================================//
function TdmLocal_old.LoadAreaMas: TDataSet;
begin
  with aq_Staff do
  begin
    SQL.Text := FSQL.GetNodeValue('Local.Staff.AreaMas');
    Open;
  end;
  Result := aq_Staff;
end;

function TdmLocal_old.LoadStoreMas(Area_Code: String): TDataSet;
begin
   with aq_Staff do
  begin
    SQL.Text := FSQL.GetNodeValue('Local.Staff.SotreMas');
    Parameters.ParamByName('pArea_Code').Value := Area_Code;
    Open;
  end;
  Result := aq_Staff;
end;

function TdmLocal_old.LoadStoreStaff(StoreCode: String): TDataSet;
begin
  with aq_Staff do
  begin
    SQL.Text := FSQL.GetNodeValue('Local.Staff.StoreStaff');
    Parameters.ParamByName('pStore_Code').Value := StoreCode;
    Open;
  end;
  Result := aq_Staff;
end;

function TdmLocal_old.LoadStaffFingerCount(StoreCode: String): TDataSet;
begin
  with aq_Staff do
  begin
    SQL.Text := FSQL.GetNodeValue('Local.Staff.LoadStaffFingerCount');
    Parameters.ParamByName('pStoreCode').Value := StoreCode;
    Open;
  end;
  Result := aq_Staff;
end;



end.
