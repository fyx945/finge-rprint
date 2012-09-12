{***************************************************************************************************
Module: 服务器数据库模块
Effect：操作服务器数据，包括上传打卡信息、下载员工资料、指纹等
Author：JackyZhou
Data: 2006-07-07 to 2006-09-21
Remark: 将sDb_Server功能移到此模块
***************************************************************************************************}

unit dm_Server;

interface

uses
  Windows,Forms,Messages,unt_XML, SysUtils, Classes, DB, Controls, DateUtils, MemDS, DBAccess, MyAccess, IdMessage,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdEMailAddress,
  IdMessageClient, IdSMTP, IdSMTPBase, IdExplicitTLSClientServerBase,
  siComp,unt_BbsConfig, kbmMemTable,Mail2000, Dialogs;

type
  TdmServer = class(TDataModule)
    IdSMTP: TIdSMTP;
    IdMsg: TIdMessage;
    MyC_Server: TMyConnection;
    MyQ_Server: TMyQuery;
    MyM_UploadSign: TMyCommand;
    MyM_InsertFM: TMyCommand;
    MyQ_Mail: TMyQuery;
    SMTP_WarningLetter: TIdSMTP;
    idM_Warning: TIdMessage;
    siLang: TsiLang;
    MyC_HKServer: TMyConnection;
    MyQ_Time: TMyQuery;
    MyQ_ServerData: TMyQuery;
    MySQL_BBS: TMyConnection;
    myqry_bbs: TMyQuery;
    MyQ_ServerStaff: TMyQuery;
    MyQ_LateInfo: TMyQuery;
    MailMessage20001: TMailMessage2000;
    SMTP20001: TSMTP2000;
    procedure DataModuleCreate(Sender: TObject);
  private
    FSQL : TKXML;
    FServerIP: String;
    FUserName: String;
    FDatabase: String;
    FPassword: String;
    FmailHost: string;
    FmailUsername: String;
    FmailPassword: String;
    FStoreCode: String;
    FAreaCode: String;
    FEmailAddress: String;
    FRecipients: TStrings;
    FCCList: TStrings;
    procedure SetMailHost(const Value: string);
    procedure SetmailPassword(const Value: String);
    procedure SetMailUsername(const Value: String);

  protected    
    //Author: JackyZhou at 2006-07-07             //Effect: 获得当天当卡的最后记录
    function GetSignLastRecord(ADate: TDate; ACount: Integer): TDataSet;

    //Author: JackyZhou at 2006-07-07             //Effect: 将数据转为邮件正文
    function MailBody(AData: TDataSet; StoreCode: String): TStrings;

    //Author: JackyZhou at 2006-09-21             //Effect: 当天（或ADate）是否已经发邮件
    function HaveSendMail(const ADate: TDate=0): Boolean;

    //Author: JackyZhou at 2006-09-21             //Effect: 记录发送邮件信息
    procedure AddSendRecord(staffCount: Integer);

  public

    //Author: NifooNing at 2008-04-21             //Effect: 获得收件人列表
    procedure GetRecipientsList(var RecList,RecCCList,RecBCCList:TStrings);

    //Author: JackyZhou at 2008-02-16             //Effect: 基本语句
    function SelectTable(ATable: string): TDataSet;

    //Author: JackyZhou at 2006-07-07             //Effect: 打开数据库
    function OpenDatabase: Boolean;

    //Author: Nifooning at 2009-02-06             //Effect: 打开数据库
    function DatabaseOpened: Boolean;

    //Author: JackyZhou at 2006-07-07             //Effect: 关闭数据库
    function CloseDatabase: Boolean;

    //Author: JackyZhou at 2006-08-16             //Effect: 获得服务器时间
    function GetServerTime: TDateTime;

    //Author: JackyZhou at 2006-07-07             //Effect: 上传打卡记录
    function UploadSignData(AData: TDataSet): Integer;
    function UploadErrorTimeSignData(AData: TDataSet): Integer;
    //Author: JackyZhou at 2006-07-07             //Effect: 通过比较员工ID获得员工信息
    //ModifyBy:NifooNing at 2008-04-21
    function GetStaffDataByID(aStaffID: string): TDataSet;

    //Author: NifooNing at 2008-04-21             //Effect: 通过比较更新时间获得员工信息
    function GetStaffDataByUpdateTime(UpdateTime: TDateTime): TDataSet;

    //Author: JackyZhou at 2006-07-07             //Effect: 初始化邮件信息
    procedure InitIdMsg();
    procedure SendMial_errorTime(strBody : string);

    //Author: JackyZhou at 2006-07-07             //Effect: 发送最后离开邮件
    procedure SendEMail(ADate: TDate; storeCode: String; ACount: Integer);

    //Author: JackyZhou at 2006-07-10             //Effect: 获得员工已登记指纹的个数
    function GetFMCount(fpID: String): Integer;

    //Author: JackyZhou at 2006-07-10             //Effect: 删除员工登记指纹
    procedure DelFMData(fpID: String);

    //Author: JackyZhou at 2006-07-10             //Effect: 获得一指纹数据
    function GetFMData(fpID: String): TDataSet;

    //Author: JackyZhou at 2006-07-10             //Effect: 上传指纹数据
    procedure UploadFMData(AData: TDataSet);

    //Author: JackyZhou at 2006-09-22             //Effect: 发打卡警告信
    procedure SendSingWarningLetter(staffID, staffName, signType: String; signTime, lastSignTime: TDateTime);

    //Author: JackyZhou at 2007-08-01             //Effect: 下载某月迟到信息
    function DownloadLateInfo(sYear, sMonth: string): TkbmMemTable;

    //Author: NifooNing at 2008-04-22             //Effect: 根据SQL语句获得一个数据集
    function GetDataSet(aSQL:string): TDataSet;

    //Author: NifooNing at 2008-04-22             //Effect: 根据文件名获得SQL语句
    function GetSQL(fName:string): WideString;

    //Author: NifooNing at 2008-08-06             //Effect: 获取最新的公告
    function GetFreshBlt(store:string;limit:Integer): TStrings;

  published
    property AreaCode: String read FAreaCode write FAreaCode;
    property StoreCode: String read FStoreCode write FStoreCode;
    property ServerIP: String read FServerIP write FServerIP;
    property UserName: String read FUserName write FUserName;
    property Password: String read FPassword write FPassword;
    property Database: String read FDatabase write FDatabase;
    property MailHost: string read FmailHost write SetMailHost;
    property MailUsername: String read FmailUsername write SetMailUsername;
    property MailPassword: String read FmailPassword write SetmailPassword;
    property Recipients: TStrings read FRecipients write FRecipients;
    property CCList: TStrings read FCCList write FCCList;
  end; 

var
  dmServer: TdmServer;

implementation
uses
  unt_File, unt_System,UnicodeFile,dm_Local_old,unt_bulletinUtils, unt_Control, unt_DataVar;

var
  SQLPath: String;

{$R *.dfm}

function TdmServer.DatabaseOpened: Boolean;
begin
  Result := self.MyC_Server.Connected;
end;

procedure TdmServer.DataModuleCreate(Sender: TObject);
begin
  SQLPath := ExtractFileDir(Application.ExeName) + '\SQL\';

  siLang.LoadFromFile(stStrings, ExtractFileDir(Application.ExeName) +'\Lang\dmServer.sil', True);
  FSQL := TKXML.Create(SQLPath +'Server.xml');
end;

//============================== private ==============================//

procedure TdmServer.SetMailHost(const Value: string);
begin
  FmailHost := Value;
  IdSMTP.Host := FmailHost;
  SMTP_WarningLetter.Host := FmailHost;
end;

procedure TdmServer.SetMailUsername(const Value: String);
begin
  FmailUsername := Value;
  IdSMTP.Username := FmailUsername;
  SMTP_WarningLetter.Username := FmailUsername;
end;

procedure TdmServer.SetmailPassword(const Value: String);
begin
  FmailPassword := Value;
  IdSMTP.Password := FmailPassword;
  SMTP_WarningLetter.Password := FmailPassword;
end;

//============================== protected ==============================//

procedure TdmServer.GetRecipientsList(var RecList,RecCCList,RecBCCList:TStrings);
var
  SQLs:TStrings;
  Recipient,RecipientCC,RecipientBCC:string;
  fSQL,address:string;

  function getAddrList(aSQL,param:string):TStrings;
  var
    addrList: TStrings;
  begin
    addrList := TStringList.Create;
    with MyQ_Server do begin
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
    end;
    Result := addrList;
  end;

begin
  SQLs := TStringList.Create;
  SQLs.Text := AnsiString(LoadUnicodeFile(SQLPath + 'EMailAddList.sql'));
  fSQL := SQLs.Strings[0];
  with MyQ_Server do
  begin
    Close;
    SQL.Text := fSQL;
    ParamByName('pAreaCode').AsString := AreaCode;
    ParamByName('pStoreCode').AsString := StoreCode;
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

function TdmServer.GetSignLastRecord(ADate: TDate; ACount: Integer): TDataSet;
begin
  with MyQ_Server do
  begin
    Close;
    //SQL.LoadFromFile(SQLPath + 'LastLeave.sql');
    SQL.Text := LoadUnicodeFile(SQLPath + 'LastLeave.sql');
    ParamByName('pDate').AsDate := ADate;
    ParamByName('pAreaCode').AsString := AreaCode;
    ParamByName('pStoreCode').AsString := StoreCode;
    ParamByName('pCount').AsInteger := ACount;
    Execute;
  end;
  Result := MyQ_Server;
end;

function TdmServer.GetSQL(fName: string): WideString;
begin
  if FileExists(SQLPath + fName) then
    Result := LoadUnicodeFile(SQLPath + fName)
  else
    raise Exception.Create('File['+fName+'] is not exist!');
end;

function TdmServer.MailBody(AData: TDataSet; StoreCode: String): TStrings;
var
  sName, nickname, signTime, signType: String;
  i : Integer;
  body : TStrings;
begin
  body := TStringList.Create;
  body.Add(StoreCode +' '+ DateTimeToStr(Today -1) + ' 最迟离开办公室的员工是：');
  with AData do
  begin
    First;
    for I := 0 to RecordCount - 1 do    // Iterate
    begin
      sName := FieldByName('STAFF_NAME_S').AsString;
      nickname := FieldByName('NICKNM_E').AsString;
      signTime := DateTimeToStr( FieldByName('SIGN_DATETIME').AsDateTime );
      signType := FieldByName('SIGN_TYPES').AsString;
      body.Add('    员工 ' + sName +'.' +nickname +' 于 ' +signTime +' ' +signType);
      Next;
    end;    // for
    body.Add('');
    body.Add('');
    body.Add('邮件发送于：' + KSys.Get_ComputerName);
    body.Add('IP地址为：' +KSys.GetLocalIP);
  end;    // with
  Result := body;
end;

function TdmServer.HaveSendMail(const ADate: TDate=0): Boolean;
var
  pDate : TDate;
begin
  if ADate <= 0 then
    pDate := ToDay()
  else
    pDate := ADate;
  with MyQ_Mail do
  begin
    Close;
    //SQL.LoadFromFile(SQLPath + 'HaveSend.sql');
    SQL.Text := LoadUnicodeFile(SQLPath + 'HaveSend.sql');
    ParamByName('pDate').AsDate := pDate;
    ParamByName('pAreaCode').AsString := AreaCode;
    ParamByName('pStoreCode').AsString := StoreCode;
    Execute;
    if RecordCount > 0 then
      Result := true
    else
      Result := false;
  end;    // with
end;

procedure TdmServer.AddSendRecord(staffCount: Integer);
begin
  with MyQ_Mail do
  begin
    Close;
    //SQL.LoadFromFile(SQLPath + 'InsertSendRecord.sql');
    SQL.Text := LoadUnicodeFile(SQLPath + 'InsertSendRecord.sql');
    ParamByName('pAreaCode').AsString := AreaCode;
    ParamByName('pStoreCode').AsString := StoreCode;
    ParamByName('pStaffCount').AsInteger := staffCount;
    Execute;
  end;    // with
end;

//============================== Public ==============================//
function TdmServer.SelectTable(ATable: string): TDataSet;
begin
  //
end;

function TdmServer.OpenDatabase: Boolean;
begin
  try
    //with MyC_Server do
    if not MyC_Server.Connected then
    begin
      MyC_Server.Close;
      MyC_Server.Server := ServerIP;
      MyC_Server.Username := UserName;
      MyC_Server.Password := Password;
      MyC_Server.Database := Database;
      //try
        MyC_Server.Connect;
      //except
        //Raise ERangeError.Create(siLang.GetText('NOT_CONNNET_DB'));
      //end;
    end;
    //with MySQL_BBS do
    if (Config.ActivateBBS) and (not MySQL_BBS.Connected) then
    begin
      MySQL_BBS.Close;
      MySQL_BBS.Server := BbsConfig.DbServer;
      MySQL_BBS.Username := BbsConfig.DbUserName;
      MySQL_BBS.Password := BbsConfig.DbPassword;
      MySQL_BBS.Database := BbsConfig.DbDatabase;
      MySQL_BBS.Options.Charset := 'utf8';
      try
        MySQL_BBS.Connect;
      except
        //Raise ERangeError.Create(siLang.GetText('NOT_CONNNET_BBSDB'));
      end;
    end;

  except
    Result := MyC_Server.Connected;
    ShowMessage(siLang.GetText('NOT_CONNNET_DB'));
    //Raise ERangeError.Create(siLang.GetText('NOT_CONNNET_DB'));
  end;
  Result := MyC_Server.Connected;
end;

function TdmServer.CloseDatabase: Boolean;
begin
  try
    MyC_Server.Disconnect;
  except
    KFile.LogWrite('DB Error:Close the PSDB connection.');
  end;
  try
    MySQL_BBS.Disconnect;
  except
    KFile.LogWrite('DB Error:Close the BBS connection.');
  end;
  Result := (not MyC_Server.Connected) and (not MySQL_BBS.Connected);
end;

function TdmServer.GetServerTime: TDateTime;
begin
  try
    with MyQ_Time do
    begin
      Execute();
      if RecordCount = 1 then
        Result := FieldByName('now()').AsDateTime
      else
        Result := Now();
    end;
  except
    Result := Now();
  end;
end;

function TdmServer.UploadSignData(AData: TDataSet): Integer;
var
  staffID, signCode : String;
  areaCode, storeCode : String;
  signTime, uploadTime: TDateTime;
  ulCount : integer;
  query:TCustomDADataSet;
begin
  if not MyC_Server.Connected then
    OpenDatabase;
  if not MyC_Server.Connected then
  begin
    result := 0;
    exit;
  end;

  ulCount := 0;
  uploadTime := now;
  try
    query := MyC_Server.CreateDataSet;
    query.SQL.Text := FSQL.GetNodeValue('Server.SignData.getEmpty');
    query.Open;

    AData.First;
    While Not(AData.Eof) do
    begin
      staffID := AData.FieldByName('STAFFID').AsString;
      signCode := AData.FieldByName('SIGN_CODE').AsString;
      signTime := AData.FieldByName('SIGN_DATETIME').AsDateTime;
      areaCode := AData.FieldByName('AREA_CODE').AsString;
      storeCode := AData.FieldByName('STORE_CODE').AsString;
      with query do
      begin
        Append;
        FieldByName('SIGN_DATETIME').AsDateTime := signTime;
        FieldByName('STAFFID').AsString := staffID;
        FieldByName('SIGN_CODE').AsString := signCode;
        FieldByName('AREA_CODE').AsString := areaCode;
        FieldByName('STORE_CODE').AsString := storeCode;
        FieldByName('UPLOAD_TIME').AsDateTime := uploadTime;
        //
        FieldByName('ClientIP').AsString := KSys.GetLocalIP;
        Post;
      end;
      AData.Edit;
      AData.FieldByName('UPLOAD_TIME').AsDateTime := uploadTime;
      AData.Post;
      AData.Next;
      Inc(ulCount);
    end;
  finally
    if Assigned(query) then
      FreeAndNil(query);
    Result := ulCount;
  end;
end;

function TdmServer.UploadErrorTimeSignData(AData: TDataSet): Integer;
var
  staffID, signCode : String;
  areaCode, storeCode, IPAddress : String;
  signTime, uploadTime, lasttime, Lastsystime: TDateTime;
  ulCount : integer;
  query:TCustomDADataSet;
begin
  if not MyC_Server.Connected then
    OpenDatabase;
  if not MyC_Server.Connected then
  begin
    result := 0;
    exit;
  end;

  ulCount := 0;
  uploadTime := now;
  try
    query := MyC_Server.CreateDataSet;
    query.SQL.Text := FSQL.GetNodeValue('Server.SignData.getErrortimeEmpty');
    query.Open;

    AData.First;
    While Not(AData.Eof) do
    begin
      staffID := AData.FieldByName('STAFFID').AsString;
      signCode := AData.FieldByName('SIGN_CODE').AsString;
      signTime := AData.FieldByName('SIGN_DATETIME').AsDateTime;
      areaCode := AData.FieldByName('AREA_CODE').AsString;
      storeCode := AData.FieldByName('STORE_CODE').AsString;
      IPAddress := AData.FieldByName('IPAddress').AsString;
      lasttime := AData.FieldByName('lasttime').AsDateTime;
      lastsystime := AData.FieldByName('lastsystime').AsDateTime;
      with query do
      begin
        Append;
        FieldByName('SIGN_DATETIME').AsDateTime := signTime;
        FieldByName('STAFFID').AsString := staffID;
        FieldByName('SIGN_CODE').AsString := signCode;
        FieldByName('AREA_CODE').AsString := areaCode;
        FieldByName('STORE_CODE').AsString := storeCode;
        FieldByName('UPLOAD_TIME').AsDateTime := uploadTime;
        FieldByName('lasttime').AsDateTime := lasttime;
        FieldByName('lastsystime').AsDateTime := lastsystime;
        FieldByName('IPAddress').AsString := IPAddress;
        Post;
      end;
      AData.Edit;
      AData.FieldByName('UPLOAD_TIME').AsDateTime := uploadTime;
      AData.Post;
      AData.Next;
      Inc(ulCount);
    end;
  finally
    if Assigned(query) then
      FreeAndNil(query);
    Result := ulCount;
  end;
end;



function TdmServer.GetStaffDataByID(aStaffID: String): TDataSet;
begin
  with MyQ_Server do
  begin
    Close;
    SQL.Text := 'Select STAFFID, Area_Code, Store_Code, STAFF_NAME_C, STAFF_NAME_E, STAFF_NAME_S, ';
    SQL.Add(' NICKNM_E, FPID, UpdateTime From STAFF Where StaffID > :pStaffID');
    ParamByName('pStaffID').AsString := aStaffID;
    Open;
  end;
  Result := MyQ_Server;
end;

function TdmServer.GetStaffDataByUpdateTime(UpdateTime: TDateTime): TDataSet;
begin
  with MyQ_ServerStaff do
  begin
    Close;
    SQL.Text := 'Select STAFFID, Area_Code, Store_Code, STAFF_NAME_C, STAFF_NAME_E,';
    SQL.Add(' STAFF_NAME_S, NICKNM_E, FPID, UpdateTime, Date_Of_Join, ResignDate');
    SQL.Add(' From STAFF WHERE UpdateTime > :pUpdateTime ');
    SQL.Add(' ORDER BY STAFFID');
    ParamByName('pUpdateTime').AsDateTime := UpdateTime;
    Open;
  end;
  Result := MyQ_ServerStaff;
end;

procedure TdmServer.SendMial_errorTime(strBody : string);
var
  i :ShortInt;
begin
  with MailMessage20001 do
  begin
    SetFrom('Fingerprint', 'smtpzh@KwokHang.com');
    Subject := 'FingerPrint error time!';
    SetTextPlain( strBody );
    Date := now();
    Priority := mpNormal;
    //
    ToList.Clear;                     //收件人
    for i := 0 to Config.Recipients.Count - 1 do
    begin
      ToList.Add(Config.Recipients[i],Config.Recipients[i]);
    end;
    CcList.Clear;      //暗送
    for i := 0 to Config.CCList.Count - 1 do
    begin
      CcList.Add(Config.CCList[i],Config.CCList[i]);
    end;
  end;
  with SMTP20001 do
  begin
    Host := Config.MailHost;
    UserName := Config.MailUsername;
    Password := Config.MailPassword;
    MailMessage := MailMessage20001;
  end;

  if SMTP20001.Connect then
  begin
    try
      if MailMessage20001.NeedRebuild then
        MailMessage20001.RebuildBody;
      SMTP20001.SendMessage;
      SMTP20001.Quit;
    except
      on e: Exception do
      begin
       // raise e.Create(e.Message);
       KFile.LogWrite(e.Message);
      end;
    end;
  end
end;


procedure TdmServer.InitIdMsg;
var
  addItem : TIdEMailAddressItem;
  addList : TStrings;
  address, addType : String;
  i : integer;
  Reci,ReciCC,ReciBCC:TStrings;
begin
  IdMsg.From.Name := 'Fingerprint';
  IdMsg.From.Address := 'office@KwokHang.com';

  addList := TStringList.Create;
  //addList := GetRecipientsList;
  dmLocal_old.GetRecipientsList(Reci,ReciCC,ReciBCC);
  for I := 0 to Reci.Count - 1 do
  begin
    addItem := IdMsg.Recipients.Add;
    addItem.Address := Reci[i];
  end;
  for I := 0 to ReciCC.Count - 1 do
  begin
    addItem := IdMsg.CCList.Add;
    addItem.Address := ReciCC[i];
  end;
  for I := 0 to ReciBCC.Count - 1 do
  begin
    addItem := IdMsg.BccList.Add;
    addItem.Address := ReciBCC[i];
  end;
  IdMsg.Subject := 'Last leave the company';

end;

procedure TdmServer.SendEMail(ADate: TDate; storeCode: String; ACount: Integer);
var
  AData: TDataSet;
  sendCount : integer;
begin
  if IdMsg.Recipients.Count <= 0 then
  begin
    KFile.LogWrite('Not Recipients, send email to the default!');
    IdMsg.Recipients.Add().Address :='Fingerprint@kwokhang.com';
  end;

  IdSMTP.Connect;
  AData := GetSignLastRecord(ADate, ACount);
  sendCount := AData.RecordCount;
  if sendCount > 0 then
  begin
    if not(HaveSendMail()) then
    begin
      IdMsg.Body := MailBody(AData, storeCode);
      IdSMTP.Send(IdMsg);
      KFile.LogWrite('Send eMail Succeed!');
      AddSendRecord(sendCount);
    end
    else
    begin
      KFile.LogWrite('Alread Send eMail!');
    end;
  end
  else
  begin
    KFile.LogWrite('Not Record Send eMail!');
    AddSendRecord(0);
  end;
  IdSMTP.Disconnect;
end;

function TdmServer.GetDataSet(aSQL: string): TDataSet;
begin
  with MyQ_Server do
  begin
    Close;
    SQL.Text := aSQL;
    Open;
  end;
  Result := MyQ_Server;
end;

function TdmServer.GetFMCount(fpID: String): Integer;
var
  fmCount: Integer;
begin
  with MyQ_Server do
  begin
    Close;
    SQL.Text := 'Select Count(*) as fmCount From FingerMark Where FPID = :pFPID';
    ParamByName('pFPID').Value := fpID;
    Open;
    fmCount := FieldByName('fmCount').AsInteger;
  end;
  Result := fmCount;
end;

procedure TdmServer.DelFMData(fpID: String);
begin
  with MyQ_Server do
  begin
    Close;
    SQL.Text := 'Delete From FingerMark Where FPID = :pFPID';
    ParamByName('pFPID').Value := fpID;
    Execute;
  end;
end;

function TdmServer.GetFMData(fpID: String): TDataSet;
begin
  with MyQ_Server do
  begin
    SQL.Text := 'Select * From FingerMark Where FPID = :pFPID';
    ParamByName('pFPID').Value := fpID;
    Open;
  end;    // with
  Result := MyQ_Server;
end;

function TdmServer.GetFreshBlt(store: string; limit: Integer): TStrings;
var
  bulletin:TBulletin;
  blts:TStrings;
begin
  if not myqry_bbs.Connection.Connected then
  begin
    Result := nil;
    Exit;
  end;

  blts := TStringList.Create;
  with myqry_bbs do
  begin
    close;
    SQL.Text := GetSQL('bbs.freshblt.sql');
    if limit >= 0 then begin
      SQL.Append(' limit 0,'+IntToStr(limit));
    end;
    ParamByName('store_code').Value := store;
    Open;
    First;
    while not Eof do
    begin
      bulletin := TBulletin.Create();
      bulletin.Id :=  FieldByName('blt_id').AsString;
      bulletin.PublishTime :=  FieldByName('publish_time').AsDateTime;
      bulletin.Title := FieldByName('blt_title').AsString;
      blts.AddObject(bulletin.Id,bulletin);
      Next;
    end;
    Close;
  end;

  Result := blts;
end;

procedure TdmServer.UploadFMData(AData: TDataSet);
begin
  try
    AData.First;
    while Not(AData.Eof) do
    begin
      with MyM_InsertFM do
      begin
        ParamByName('pFPID').AsString := AData.FieldByName('FPID').AsString;
        ParamByName('pFingerNo').AsString := AData.FieldByName('FingerNo').AsString;
        ParamByName('pMarkData').AsString := AData.FieldByName('MarkData').AsString;
        ParamByName('pEnrollDate').AsDateTime := AData.FieldByName('EnrollDate').AsDateTime;
        ParamByName('pUploadData').AsDateTime := now();
        Execute();
      end;
      AData.Next;
    end;
  except
    Raise ERangeError.Create('Can"t Upload FingerMark Data');
  end;
end;

procedure TdmServer.SendSingWarningLetter(staffID, staffName, signType: String; signTime, lastSignTime: TDateTime);
var
  addItem : TIdEMailAddressItem;
  i : integer;
  Reci,ReciCC,ReciBCC:TStrings;
begin
  with idM_Warning do
  begin
    From.Text := 'office';
    From.Address := 'office@KwokHang.com';
    dmLocal_old.GetRecipientsList(Reci,ReciCC,ReciBCC);
    for I := 0 to Reci.Count - 1 do
    begin
      addItem := Recipients.Add;
      addItem.Address := Reci[i];
    end;
    for I := 0 to ReciCC.Count - 1 do
    begin
      addItem := CCList.Add;
      addItem.Address := ReciCC[i];
    end;
    for I := 0 to ReciBCC.Count - 1 do
    begin
      addItem := BccList.Add;
      addItem.Address := ReciBCC[i];
    end;
    Subject := 'Sign Warning Letter';
    Body.Clear;
    Body.Add(StoreCode +' 打卡出现异常，请查看：');
    Body.Add('    打卡员工: ' + staffID +'  ' +staffName);
    Body.Add('    打卡时间: ' + DateTimeToStr(signTime));
    Body.Add('    上次打卡: ' + DateTimeToStr(lastSignTime));
    Body.Add('    打卡类型: ' + signType);
    Body.Add('');
    Body.Add('当前电脑时间：' + DateTimeToStr(now) );
    Body.Add('邮件发送于：' + KSys.Get_ComputerName);
    Body.Add('IP地址为：' +KSys.GetLocalIP);
  end;    // with

  try
    SMTP_WarningLetter.Connect;   
    SMTP_WarningLetter.Send(idM_Warning);
    KFile.LogWrite('Send Sign Warning Letter!');
    SMTP_WarningLetter.Disconnect;
  except

  end;
end;

function TdmServer.DownloadLateInfo(sYear, sMonth: string): TkbmMemTable;
var
  mtLateInfo: TkbmMemTable;
begin
  mtLateInfo := TkbmMemTable.Create(Self);
  with MyQ_LateInfo do
  begin
    SQL.Clear;
    SQL.LoadFromFile(SQLPath + 'hr.Late.Download.sql');
    ParamByName('pYear').AsString := sYear;
    ParamByName('pMonth').AsString := sMonth;
    Execute;
  end;    // with
  mtLateInfo.LoadFromDataSet( MyQ_LateInfo, [mtcpoStructure, mtcpoProperties] );
  Result := mtLateInfo;
end;

end.
