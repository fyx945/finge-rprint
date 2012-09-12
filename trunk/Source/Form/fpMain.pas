unit fpMain;

interface

uses
  StrUtils, khProgressFrom,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  ExtCtrls, XPMan, ComCtrls, StdCtrls, DB, ToolWin, ImgList, Grids, DateUtils,
  DBGrids, Buttons, OleCtrls, RzPanel, RzButton, RzLstBox, RzDBGrid, RzTabs,
  RzStatus, RzCmboBx, ZKFPEngXControl_TLB, RzLabel, siComp, siLangCombo,
  RzLaunch,WSDLIntf,unt_bulletinUtils,unt_BbsConfig, Dialogs, unt_domain, kbmMemTable, GridsEh,
  DBGridEh, MemDS, DBAccess, MyAccess, unt_Message;


type
  TfrmFingerprint = class(TForm,IBulletinObserver)
    XPManifest: TXPManifest;
    il_Tool: TImageList;
    Timer_Update: TTimer;
    tbr_Main: TRzToolbar;
    pc_Staff: TRzPageControl;
    ts_StaffInfo: TRzTabSheet;
    lab_Employee: TLabel;
    lab_Time: TLabel;
    lab_Type: TLabel;
    lab_State: TLabel;
    lab_eName: TLabel;
    lab_sName: TLabel;
    lab_SignTime: TLabel;
    lab_SignType: TLabel;
    ts_StaffList: TRzTabSheet;
    sb_Main: TRzStatusBar;
    sp_Update: TRzStatusPane;
    sp_Msg: TRzStatusPane;
    vis_FileVer: TRzVersionInfoStatus;
    ver_Main: TRzVersionInfo;
    pan_Time: TRzPanel;
    lab_STime: TLabel;
    lab_NowTime: TLabel;
    RzPanel1: TRzPanel;
    DataSource: TDataSource;
    RzPanel3: TRzPanel;
    cb_Language: TRzComboBox;
    lab_Language: TLabel;
    ZKEngine: TZKFPEngX;
    lab_LinkState: TRzLabel;
    siLang: TsiLang;
    siLangDispatcher: TsiLangDispatcher;
    RzLauncher: TRzLauncher;
    lab_LateInfo: TLabel;
    lab_delay: TLabel;
    btn_Connect: TRzBitBtn;
    btn_ClearInfo: TRzBitBtn;
    btn_disconnect: TRzBitBtn;
    rzpnl1: TRzPanel;
    lblBlt: TRzURLLabel;
    timer_bbs: TTimer;
    lbl_freshblt: TRzLabel;
    chkConFpForAll: TCheckBox;
    RzButton1: TRzButton;
    RzButton2: TRzButton;
    dbg_Intra: TRzDBGrid;
    sp_StoreCode: TRzStatusPane;
    Timer_LastSystime: TTimer;
    Timer_ShowTime: TTimer;
    procedure switchSigndetAsTime(time:TDateTime);
    procedure ChangeSignType(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btn_ClearInfoClick(Sender: TObject);
    procedure Timer_UpdateTimer(Sender: TObject);
    procedure cb_LanguageChange(Sender: TObject);
    procedure ZKEngineCapture(ASender: TObject; ActionResult: WordBool; ATemplate: OleVariant);
    procedure FormShow(Sender: TObject);
    procedure btn_ConnectClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btn_disconnectClick(Sender: TObject);
    procedure timer_bbsTimer(Sender: TObject);
    procedure RzButton1Click(Sender: TObject);
    procedure RzButton2Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Timer_LastSystimeTimer(Sender: TObject);
    procedure Timer_ShowTimeTimer(Sender: TObject);
  private
    FSignType: String;
    FLinkState: Integer;
    FNoSignTime: Word;
    FPreStaff: String;
    FPerSignType: String;
    FPerSignTime: TTime;
    fLastSignTime:TTime;
    FFreshBulletins:TStrings;
    BltService:TBulletinService;
    Bulletins:TStrings;
    bltIndex:integer;

    procedure InitForm;
    procedure ConfigDB;
    function FindLang(): Integer;
    procedure ClearInfo;
    procedure ShowSingList;
    procedure SetLinkState(const Value: Integer);

    //Author: JackyZhou at 2006-09-22             //Effect: 载入图片资源
    procedure LoadResource(imageList: TImageList);

    // Added by JackyZhou 2010-03-19    //系统时间改变消息
    procedure WMTIMECHANGE(var Msg: TWMTimeChange); message WM_TIMECHANGE;
  protected
    //Author: JackyZhou at 2006-07-19             //Effect: 填补六位指纹号
    //Update: NifooNing at 2009-02-25
    function FillUp(fpID: String): String;

    //Author: JackyZhou at 2006-07-04             //Effect: 打开科密指纹机
    //function OpenComet: Boolean;

    //Author: JackyZhou at 2006-07-04             //Effect: 打开URU指纹仪
    function OpenURU: Boolean;

    //Author: JackyZhou at 2006-07-04             //Effect: 重新连接指纹仪
    function ConnectURU: Boolean;

    //Author: JackyZhou at 2006-07-06             //Effect: 重新连接指纹机
    //function ConnectComet: Boolean;

    //Author: JackyZhou at 2006-07-04             //Effect: 重新连接指纹机（仪）
    function ConnectFP: Boolean;

    //Author: NifooNing at 2007-04-17             //Effect: 断开指纹机（仪）
    function DisconnectFP: Boolean;

    ///Author: NifooNing at 2007-04-17             //Effect: 关闭URU4000B指纹机
    function CloseURU:Boolean;

    //Author: JackyZhou at 2006-07-19             //Effect: 关闭指纹机
    //function CloseComet: Boolean;

    //Author: JackyZhou at 2006-07-06             //Effect: 上传打卡数据到服务嚣
    function UploadData: Integer;
    //Author: Petermai at 2011-07-01             //Effect: 上传errortime数据到服务嚣
    function UploadErrorTimeData: Integer;

    //Author: JackyZhou at 2006-07-06             //Effect: 下载员工信息
    function DownloadStaff: Integer;

    //Author: JackyZhou at 2006-09-21             //Effect: 检查打卡的有效性
    function CheckSign(staffID, SignType: String): Boolean;

    //Author: JackyZhou at 2006-09-22             //Effect: 检查打卡时间
    procedure CheckSignTime(signTime: TDateTime);

    //Author: JackyZhou at 2007-02-02             //Effect: 检查用餐间隔时间
    function CheckMealTime(staffID: String; signTime: TDateTime): Boolean;

    //Author: JackyZhou at 2007-08-01             //Effect: 下载某月迟到信息
    function DownloadLateInfo(): Integer;

    //Author: JackyZhou at 2007-08-16             //Effect: 显示迟到信息
    procedure ShowLateInfo(StaffID: String);

    //Author: NifooNing at 2008-04-22            //Effect: 下载服务器上的邮件列表数据
    //function DownloadEmailData(): Integer;

  public
    procedure ShowSignInfo(staff: TStaff);

    //Author: JackyZhou at 2007-08-16             //Effect: 与服务器同步时间
    function SyncTime():boolean;

    //Author: NifooNing at 2008-08-06             //Effect: 观察者
    procedure refresh(blts:TStrings);

  published
    property SignType: String read FSignType write FSignType;
    property NoSignTime: Word read FNoSignTime write FNoSignTime;
    property LinkState: Integer read FLinkState write SetLinkState;
  end;

  TDspThread = class(TThread)
  private
    { Private declarations }
    procedure syncDate();
  protected
    procedure Execute; override;
    procedure DoWork;virtual;
  public
    constructor Create(CreateSuspended:boolean);
  end;

var
  frmFingerprint: TfrmFingerprint;
  tbSignType: Array[1..6] of TRzToolButton;
  likeStateStr: Array[0..5] of string;
  //Comet : TComet;
  updating:Boolean = false;

const
  FINGER_PRING_LOG :String = 'finger_print.log';

implementation
uses
  unt_System, unt_DataVar, unt_File,
  unt_Control, unt_Biokey, dm_Local, dm_Server, unt_Update, unt_Sign,
  dm_Local_old;

var
  Biokey : TBiokey;
//  FPThread : TFPThread;
  FPSign : TFPSign;

{$R *.dfm}
procedure TfrmFingerprint.SetLinkState(const Value: Integer);
begin
  FLinkState := Value;
  lab_LinkState.Caption := likeStateStr[FLinkState];
end;

procedure TfrmFingerprint.InitForm;
var
  I : integer;
begin
  Self.WindowState := wsMaximized;
  FPreStaff := '';
  FPerSignType := '';
  FPerSignTime := 0;
  for I := 1 to 6 do          //动态创建6个打卡类型按钮
  begin
    tbSignType[i] := TRzToolButton.Create(Self);
    tbSignType[i].Parent := tbr_Main;
    tbSignType[i].Tag := i;
    tbSignType[i].Visible := true;
    tbSignType[i].GroupIndex := 1;
    tbSignType[i].ImageIndex := i-1;
    //tbSignType[i].Caption := '0' +IntToStr(I);
    tbSignType[i].OnClick :=  ChangeSignType;
  end;

  i := FPSign.RuleSignType();
  tbSignType[i].OnClick(tbSignType[i]);
  pc_Staff.ActivePageIndex := 0;
  vis_FileVer.FieldLabel := 'Ver : ' +ver_Main.FileVersion;
  sp_StoreCode.Caption := 'Store Code : ' + config.StoreCode;
  FindLang();
end;

procedure TfrmFingerprint.ConfigDB;
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
    SyncTime;
    // 设置DBLastSystime
    dmLocal_old.SetSysTime(dmLocal_old.GetSysTime,Now);
    //
    dmServer.AreaCode := Config.AreaCode;
    dmServer.StoreCode := Config.StoreCode;
    dmServer.MailHost := Config.MailHost;
    dmServer.MailUsername := Config.MailUsername;
    dmServer.MailPassword := Config.MailPassword;
    dmServer.Recipients := Config.Recipients;
    dmServer.CCList := Config.CCList;
  end;
  //dmServer.InitIdMsg;

  dmLocal_old.siLang.LangDispatcher := siLangDispatcher;
  dmServer.siLang.LangDispatcher := siLangDispatcher;
end;

function TfrmFingerprint.FindLang(): Integer;
var
  i : integer;
begin
  cb_Language.Items.Clear;
  for i := 0 to Config.Languages.Count -1 do
    cb_Language.Items.Add(Config.Languages.ValueFromIndex[i]);
  cb_Language.ItemIndex := Config.ShowLang;
  cb_LanguageChange(nil);
  Result := Config.Languages.Count;
end;

procedure TfrmFingerprint.ChangeSignType(Sender: TObject);
begin
  if Sender is TRzToolButton then
  begin
    lab_SignType.Caption := (Sender as TRzToolButton).Caption;
    (Sender as TRzToolButton).Down := true;
    SignType := '0' +IntToStr((Sender as TRzToolButton).Tag);
    ClearInfo;
  end;
end;

procedure TfrmFingerprint.ClearInfo;
var
  info:String;
begin
  info := '----------';
  lab_eName.Caption := info;
  lab_sName.Caption := info;
  lab_SignTime.Caption := info;
  lab_LateInfo.Caption := info;
  sp_Msg.Caption := ''; 
end;

procedure TfrmFingerprint.ShowSingList;
begin
  //DataSource.DataSet := nil;
  DataSource.DataSet := dmLocal_old.GetIntraData();
  dbg_Intra.Columns.Items[0].Width := 200;
  dbg_Intra.Columns.Items[1].Width := 200;
  dbg_Intra.Columns.Items[2].Width := 200;
end;

procedure TfrmFingerprint.switchSigndetAsTime(time:TDateTime);
var
  timeStr:String;
  _pos:integer;
  signCode:integer;
begin
  timeStr :=FormatDateTime('hh:nn:ss', time);
  if AnsiContainsText(Config.SwitchSigndetTime,timeStr) then
  begin
    _pos := pos(timeStr,Config.SwitchSigndetTime);
    signCode := StrToInt(copy(Config.SwitchSigndetTime,_pos - 2, 1));
    tbSignType[signCode].click();
  end;
end;

procedure TfrmFingerprint.ShowSignInfo(staff: TStaff);
var
  nowTime : TDatetime;
  staffId: String;
begin
  if(staff = nil) then
    Exit;

  nowTime := now();
  staffId := staff.staffId;

  //是否重复打卡
  if not CheckSign(staffId, SignType) then
  begin
    sp_Msg.Caption := siLang.GetText('MS01');
    Exit;
  end;

  //检查用餐间隔
  if SignType='06' then
  begin
    if not CheckMealTime(staffId, nowTime)  then
    begin
      sp_Msg.Caption := siLang.GetText('MS02');
      Exit;
    end;
  end;

  //保存打卡数据到MDB
  dmLocal_old.InsertSignData(staffID, SignType, nowTime);
  //是否记录成功
  if not dmLocal_old.checkInsertSignData(staffID, SignType, nowTime) then
    exit;

  //是否非法打卡
  CheckSignTime(nowTime);

  //显示打卡信息
  pc_Staff.ActivePageIndex := 0;
  sp_Msg.Caption := '';
  lab_eName.Caption := staff.nickname;
  case Config.ShowLang of
    0: lab_sName.Caption := staff.staffNameEn;
    1: lab_sName.Caption := staff.staffNameCn;
    2: lab_sName.Caption := staff.staffNameTw;
  end;
  lab_SignTime.Caption := FormatDateTime('YYYY-MM-DD  HH:NN:SS', nowTime);
  //显示迟到信息
  ShowLateInfo(staff.staffId);
  //更新打卡列表
  ShowSingList;
end;

function TfrmFingerprint.UploadData: Integer;
var
  rci, upi : Integer;
  ADataSet : TDataSet;
begin
  upi := 0;
  if Config.AutoUpload > 0 then
  try
    try
      begin
        ADataSet := dmLocal_old.GetUploadData;
        rci := ADataSet.RecordCount;
        if rci > 0 then
        begin
          upi := dmServer.UploadSignData(ADataSet);
          //dmLocal_old.UpdateUploadData(ADataSet,now);
        end;
        sp_Msg.Caption := 'Upload Data : ' +IntToStr(rci);
      end;
    except
      on E:Exception do
      begin
        sp_Msg.Caption := 'Upload Error!!'+E.Message;
      end;
    end;
  finally
    if Assigned(ADataSet) then
      FreeAndNil(ADataSet);
  end;
  if sp_Msg.Caption <> '' then
    KFile.LogWrite(sp_Msg.Caption);
  Result := upi;
end;

function TfrmFingerprint.UploadErrorTimeData: Integer;
var
  rci, upi : Integer;
  ADataSet : TDataSet;
begin
  upi := 0;
  if Config.AutoUpload > 0 then
  try
    try
      begin
        ADataSet := dmLocal_old.GetUploadErrorTimeData;
        rci := ADataSet.RecordCount;
        if rci > 0 then
        begin
          upi := dmServer.UploadErrorTimeSignData(ADataSet);
          //dmLocal_old.UpdateUploadData(ADataSet,now);
        end;
        sp_Msg.Caption := 'Upload Errortime Data : ' +IntToStr(rci);
      end;
    except
      on E:Exception do
      begin
        sp_Msg.Caption := 'Upload Errottime Data Error!!'+E.Message;
      end;
    end;
  finally
    if Assigned(ADataSet) then
      FreeAndNil(ADataSet);
  end;
  if sp_Msg.Caption <> '' then
    KFile.LogWrite(sp_Msg.Caption);
  Result := upi;
end;




function TfrmFingerprint.DownloadStaff: Integer;
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
    sp_Update.Caption := 'Download Staff Info : ' +IntToStr(sCount);
    KFile.LogWrite(sp_Update.Caption);
  end;
  //end
  Result := sCount;
end;

procedure TfrmFingerprint.LoadResource(imageList: TImageList);
var
	myBitmap : TBitmap ;
	hBitmap : THandle ;
  i : integer;
  resName : String;
begin
	hBitmap := LoadLibrary('fpRes.dll') ;
	if hBitmap > 0 then
  begin
    ImageList.Clear ;
    myBitmap := TBitmap.Create;
    try
      for I := 1 to 13 do    // Iterate
      begin
        if i < 10 then
          resName := 'TB00' + IntToStr(i)
        else
          resName := 'TB0' + IntToStr(i);
     		myBitmap.LoadFromResourceName( hBitmap, resName);
        imageList.AddMasked(myBitmap, clWhite);
      end;
    finally
      myBitmap.Free ;
    end;
  end;
end;

procedure TfrmFingerprint.WMTIMECHANGE(var Msg: TWMTimeChange);
begin
{  2011.7.1 petermai 暂时取消
  if Config.SyncTime  then
    SyncTime();
    }
end;

//============================== protected ==============================// 
function TfrmFingerprint.FillUp(fpID: String): String;
begin
  Result := RightStr('000000' + fpID,6);
end;

{function TfrmFingerprint.OpenComet;
begin
  comet := TComet.Create(Self);
  comet.Host := Config.AVHost;
  comet.Port := Config.AVPort;
  comet.Password := Config.AVPassword;
  comet.MachineNum := config.AVNum;
  try
    if comet.OpenFP() then
    begin
      lab_LinkState.Caption := likeStateStr[1];
      comet.ReadGeneralData;
      FPThread := TFPThread.Create(false);
      Result := true
    end
    else
      Result := false;
  except
    lab_LinkState.Caption := likeStateStr[2];
    Result := false;
  end;
end;  }

function TfrmFingerprint.OpenURU: Boolean;
begin
  BioKey := TBiokey.Create(Self, ZKEngine);
  try
    KFile.LogWrite('Trying open URU');
    if Biokey.OpenFP then
    begin
      if(chkConFpForAll.Checked) then
        Biokey.LoadAllFMData(dmLocal_old.GetAllFMData)
      else
      begin
        Biokey.LoadAllFMData(dmLocal_old.loadFMDataByArea(Config.AreaCode));
        if(config.LoadFingermarkAlways <> '') then
        begin
          Biokey.LoadAllFMData(dmLocal_old.loadFMDataByStaffId(Config.LoadFingermarkAlways));
        end;
      end;
      Biokey.StartIdentify;
      lab_LinkState.Caption := likeStateStr[0];
      Result := true;
      KFile.LogWrite('U.R.U Opened.');
    end
    else
    begin
      lab_LinkState.Caption := likeStateStr[2];
      Result := false;
    end;
  except
    Raise ERangeError.CreateFmt('Can"t Open Fingerprint at U.R.U 4000!', []);
    Result := false;
  end;
end;

function TfrmFingerprint.ConnectFP: Boolean;
begin
  {case config.fpType of
   /1: Result := ConnectComet;
     2: Result := ConnectURU;
  else
    Result := false;
  end;
  }
  Result := ConnectURU;
end;

{
function TfrmFingerprint.CloseComet: Boolean;
begin
  if Comet <> nil then
  begin
    if Comet.IsOpen then
      Comet.CloseFP;
    comet := nil;
  end;

  if FPThread <> nil then
  begin
    FPThread.Terminate;
    FPThread.Free;
    FPThread := nil;
  end;
end;
}

function TfrmFingerprint.CloseURU:Boolean;
begin
  //ZKEngine.Free;
  if Biokey <> nil then
  begin       
    if Config.ControlDriver then
    begin
      Biokey.CloseFP;
      Biokey.DisableBiokey;
      Biokey := nil;
      Result := true;
    end
    else
    begin
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;
end;

function TfrmFingerprint.ConnectURU: Boolean;
begin
  KFile.LogWrite('ConnectURU...');
  if Assigned(ZKEngine) then
    FreeAndNil(ZKEngine);
  ZKEngine := TZKFPEngX.Create(Self);
  ZKEngine.OnCapture := ZKEngineCapture;
  if Assigned(Biokey) then
    FreeAndNil(Biokey);
  if (not Config.ControlDriver) or ( Config.ControlDriver and Biokey.EnableBiokey) then
    Result := OpenURU
  else
    Result := False;
end;

{
function TfrmFingerprint.ConnectComet: Boolean;
begin
  CloseComet;
  Result := OpenComet;
  NoSignTime := 0;
end;
}

function TfrmFingerprint.CheckSign(staffID, SignType: String): Boolean;
begin
  if (staffID = FPreStaff) and (SignType = FPerSignType) then
  begin
    if SecondsBetween(Time(), FPerSignTime) > 60 then
    begin
      FPerSignTime := Time();
      Result := true;
    end else begin
      Result := false;
    end;
  end else begin
    FPerSignTime := Time();
    FPreStaff := staffID;
    FPerSignType := SignType;
    Result := true;
  end;           
end;

procedure TfrmFingerprint.CheckSignTime(signTime: TDateTime);
var
  lastSignTime : TDateTime;
  staffName : String;
  staff:TStaff;
begin
  lastSignTime := dmLocal_old.GetLastSignTime;
  if (Config.SendWarningLetter) and (SignTime < lastSignTime) and (lastSignTime > 0) and
    (SecondsBetween(SignTime, lastSignTime) > 100) then
  begin
    staff := dmLocal_old.getStaff(FPreStaff);
    staffName := staff.StaffNameCn + '(' + staff.StaffNameEn + ')';
    dmServer.SendSingWarningLetter(FPreStaff, staffName, FPerSignType, SignTime, lastSignTime);
  end;
end;

function TfrmFingerprint.CheckMealTime(staffID: String; signTime: TDateTime): Boolean;
var
  mealTime : TDateTime;
begin
  mealTime := dmLocal_old.GetMealTime(staffID);
  if (IncMinute(mealTime , config.MealTime) <= signTime) or (mealTime=0) then
    Result := true
  else
    Result := false;
end;

function TfrmFingerprint.DisconnectFP: Boolean;
begin
  {
  case config.fpType of
    1: Result := CloseComet;
    2: Result := CloseURU;
  else
    Result := false;
  end;
  }
  Result := CloseURU;
end;

{
function TfrmFingerprint.DownloadEmailData: Integer;
var
  SQLs:TStrings;
  DataSet:TDataSet;
begin
  result := 0;
  // Deleted by JackyZhou 2010-04-07
//  SQLs := TStringList.Create;
//  SQLs.Text := dmServer.GetSQL('SyncEMailData.sql');
//
//  //更新本地EmailMas表
//  DataSet := dmServer.GetDataSet(SQLs[0]);
//  dmLocal_old.updateEmailMas(SQLs[1],SQLs[2],DataSet);
//  DataSet.Close;
//
//  //更新本地EmailDomain表
//  DataSet := dmServer.GetDataSet(SQLs[3]);
//  dmLocal_old.updateEmailDomain(SQLs[4],SQLs[5],DataSet);
//  DataSet.Close;
//
//  //更新本地EmailList表
//  DataSet := dmServer.GetDataSet(SQLs[6]);
//  dmLocal_old.updateEmailList(SQLs[7],SQLs[8],DataSet);
//  DataSet.Close;
//
//  SQLs.Clear;
//  SQLs.Free;
end;
}

function TfrmFingerprint.DownloadLateInfo: Integer;
var
  sYear, sMonth: String;
  ADataSet : TDataSet;
  mtLateInfo: TkbmMemTable;
begin
  Result := 0;
  sYear := IntToStr(YearOf(Today()));
  sMonth := IntToStr(MonthOf(Today()));
  mtLateInfo := TkbmMemTable.Create(Self);
  mtLateInfo := dmServer.DownloadLateInfo(sYear, sMonth);
  KFile.LogWrite('DownloadLateInfo...');
  mtLateInfo.Open;
  if mtLateInfo.RecordCount > 0 then
  begin
    dmLocal_old.DeleteLateInfo(sYear, sMonth);
    KFile.LogWrite('mtLateInfo.RecordCount: ' + IntToStr(mtLateInfo.RecordCount));
    dmLocal_old.InsertLateInfo( mtLateInfo );
  end;
  KFile.LogWrite('DownloadLateInfo End.');
end;

procedure TfrmFingerprint.ShowLateInfo(StaffID: String);
var
  Latetime, Frequency: Integer;
  msg: String;
begin
  dmLocal_old.GetLateInfo(StaffID, Latetime, Frequency);
  if Frequency > 0 then
  begin
    lab_LateInfo.Caption := Format(siLang.GetText('LAB_LATE_INFO'), [Frequency, Latetime]);
    if Frequency >= 3 then
      lab_LateInfo.Font.Color := clRed
    else
      lab_LateInfo.Font.Color := clLime;
  end
  else
  begin
    lab_LateInfo.Caption := siLang.GetText('LAB_LATE_NOT');
    lab_LateInfo.Font.Color := clBlack;
  end;
end;

//============================== Public ==============================//
procedure TfrmFingerprint.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if Application.MessageBox('Exit?','Information', 1) = 1 then
  begin
    if Config.ControlDriver then
    begin
      Biokey.DisableBiokey;
    end;
    FreeAndNil(Biokey);
    try
    // Added by JackyZhou 2010-04-07
    if Config.ExitUpload then
    begin
      if dmServer.OpenDatabase then
      begin
        ShowProgress('Upload data.');
        try
          UpdateProgress(10);
          UpdateProgress(40);
          frmFingerprint.UploadData;
          //
          UploadErrorTimeData;
          UpdateProgress(80);
          KFile.LogWrite('Exit upload data completed.');
          UpdateProgress(100);
        finally
          HideProgress;
        end;
      end;
    end;
    finally
      dmLocal_old.CloseDatabase;
      dmServer.CloseDatabase;
      KFile.LogWrite('Exit Fingerprint at: ' + KSys.GetUser );
      CanClose := True;
    end;
  end
  else
    CanClose := False;

end;

procedure TfrmFingerprint.FormCreate(Sender: TObject);
var
  dspThread:TDspThread;
begin
  KFile.LogWrite('FormCreate.');
  //Control := TControl.Create(ExtractFileDir(Application.ExeName));
  InitForm;

  siLang.LoadFromFile(stCaptions, ExtractFileDir(Application.ExeName) + '\Lang\fpMain.sil', True);
  siLang.LoadFromFile(stStrings, ExtractFileDir(Application.ExeName) + '\Lang\fpMain.sil', True);

  ConfigDB;
  ShowSingList;
  NoSignTime := 0;
  fLastSignTime := Now;
  dspThread := TDspThread.Create(false);
end;

function TfrmFingerprint.SyncTime:boolean;
var
  nowTime,LocalnowTime : TDateTime;
begin
  Result := false;
  if dmServer.MyC_Server.Connected then
  begin
    try
      nowTime := dmServer.GetServerTime;
      LocalnowTime := Now;
      if ((nowTime-LocalnowTime)>0.0005) or ((LocalnowTime-nowTime)>0.0005) then      //相差0.5分钟
        KSys.SetLocalTime(nowTime);
      Result := true;
    except

    end;
  end;
end;

procedure TfrmFingerprint.timer_bbsTimer(Sender: TObject);
var
  bltInfo:String;
  blt:TBulletin;
  blt_count:integer;
begin
  if (Bulletins <> nil) and (Bulletins.Count > 0) then
  begin
    blt_count := Bulletins.Count;
    if bltIndex >= blt_count then
      bltIndex := 0;
    lblBlt.URL := BbsConfig.BltIntranetSite;
    blt := Bulletins.Objects[bltIndex] as TBulletin;
    bltInfo := blt.Id;
    bltInfo := bltInfo + #9 + DateTimeToStr(blt.PublishTime);
    bltInfo := bltInfo + #9 + blt.Title;
    lblBlt.Caption := bltInfo;
    bltIndex := bltIndex + 1;
  end;
end;

{============================================= Event =============================================}
procedure TfrmFingerprint.FormShow(Sender: TObject);
begin
  LoadResource(il_Tool);
  ConnectFP;
  if Config.ActivateBBS then
  begin
    rzpnl1.Visible := True;
    timer_bbs.Interval := 10000;
    timer_bbs.Enabled := true;
    bltIndex := 0;
  end
  else
  begin
    rzpnl1.Visible := False;
    timer_bbs.Enabled := False;
  end;
end;

procedure TfrmFingerprint.refresh(blts: TStrings);
begin
  if Bulletins <> nil then
  begin
    Bulletins.Clear;
    FreeAndNil(Bulletins);
  end;
  Bulletins := blts;
  bltIndex := 0;
end;

procedure TfrmFingerprint.RzButton1Click(Sender: TObject);
begin
  if dmServer.OpenDatabase then
  begin
  // Added by JackyZhou 2010-04-07
    ShowProgress('Upload data.');
    try
      try
        UpdateProgress(30);
        frmFingerprint.UploadData;
        //
        UploadErrorTimeData;
        //
        UpdateProgress(80);
        KFile.LogWrite('Upload data completed.');
        UpdateProgress(100);
        //2011.2.28 petermai
        KMessage.MessageInformation('Upload data completed!');
      except
        KMessage.MessageInformation('Upload data fail!');
      end;
    finally
      HideProgress;
    end;
  end;
end;

procedure TfrmFingerprint.RzButton2Click(Sender: TObject);
begin
  // Added by JackyZhou 2010-04-07
  if dmServer.OpenDatabase then
  begin
    try
      DownloadStaff;
      DownloadLateInfo();
      KFile.LogWrite('Download data completed.');
      //2011.2.28 petermai
      KMessage.MessageInformation('Upload data completed!');
    except
      KMessage.MessageInformation('Upload data fail!');
    end;
  end;
end;

procedure TfrmFingerprint.FormResize(Sender: TObject);
begin
  tbr_Main.ButtonWidth := Trunc(Self.Width/6)-3;
  pc_Staff.Width := Self.Width - 80;
  pc_Staff.Height := Self.Height - 350;
  pan_Time.Width := pc_Staff.Width;
  pan_Time.Top := Self.Height - 180;
end;

procedure TfrmFingerprint.btn_ClearInfoClick(Sender: TObject);
begin
  ClearInfo;
end;

procedure TfrmFingerprint.Timer_LastSystimeTimer(Sender: TObject);
begin
  dmLocal_old.SetSysTime(dmLocal_old.GetSysTime,Now);
end;

procedure TfrmFingerprint.Timer_ShowTimeTimer(Sender: TObject);
var
  nowTime: TDateTime;
begin
  nowTime := now();
  lab_NowTime.Caption := DateTimeToStr(nowTime);
  if Config.SwitchSigndet then
    switchSigndetAsTime(nowTime);
end;

procedure TfrmFingerprint.Timer_UpdateTimer(Sender: TObject);
var
  sNow: String;
  nowTime: TDateTime;
  jj:word;
  dspThread:TDspThread;
begin
  nowTime := now();
//  lab_NowTime.Caption := DateTimeToStr(nowTime);

  if Config.SwitchSigndet then
    switchSigndetAsTime(nowTime);
  
  if (SecondsBetween(nowTime, Config.LastUploadTime) >= Config.UploadFrequency) then
  begin
    dspThread := TDspThread.Create(false);
  end;

  if (SecondsBetween(nowTime, fLastSignTime)>= Config.PowerOffTime) then
  begin
    if DisconnectFP then
    begin
      LinkState := 3;
    end;
  end;
end;

procedure TfrmFingerprint.cb_LanguageChange(Sender: TObject);
var
  i : integer;
begin
  try
    Config.ShowLang := cb_Language.ItemIndex;
    Control.Language := Config.ShowLang;
    siLangDispatcher.Language := siLang.LangNames[Config.ShowLang];
    {siLang.Language := siLang.LangNames[Config.ShowLang];
    dmServer.siLang.Language := siLang.Language;
    dmLocal_old.siLang.Language := siLang.Language;}

    for I := 1 to 6 do    // Iterate
    begin
      tbSignType[i].Caption := siLang.GetText('ST00' + IntToStr(i));
    end;    // for
    for i := 0 to 5 do
    begin
      likeStateStr[i] := siLang.GetText('LS00' + IntToStr(i));
    end;
    lab_SignType.Caption := tbSignType[StrToInt(SignType)].Caption;
    ClearInfo;
    sp_Msg.Caption := '';
  except
  end;
end;

procedure TfrmFingerprint.ZKEngineCapture(ASender: TObject; ActionResult: WordBool; ATemplate: OleVariant);
var
  fpID, staffID: String;
  staff:TStaff;
  logPath:String;
begin
  fLastSignTime := Now;
  fpID := Biokey.Capture(ATemplate);
  lab_LinkState.Caption := likeStateStr[0];
  if fpID <> '' then
  begin
    logPath := GetCurrentDir +'\Log\' + FINGER_PRING_LOG;
    KFile.LogWrite('Staff FPID: ' +fpID + ' (' + SignType +')',logPath);
    staff := dmLocal_old.findStaffByFpid(fpID);
    ShowSignInfo(staff);
  end;
end;

procedure TfrmFingerprint.btn_ConnectClick(Sender: TObject);
begin
  ConnectFP;
  fLastSignTime := Now;
end;

procedure TfrmFingerprint.btn_disconnectClick(Sender: TObject);
begin
  if DisconnectFP then
    lab_LinkState.Caption := likeStateStr[3];
end;

procedure TfrmFingerprint.Button1Click(Sender: TObject);
begin

end;    

{ *=============================================================================
  * CLASS: DspThread
  * DESCR: 数据同步处理线程
  *============================================================================}  
constructor TDspThread.Create(CreateSuspended: boolean);
begin
  inherited Create(CreateSuspended);
  //2011.12.05 petermai
  FreeOnTerminate := True;
end;

procedure TDspThread.Execute;
var
  delayTime:Integer;
begin
  inherited;
  if(not updating) then
  begin
    updating := True;
    try
      if System.DebugHook = 1 then    //是否运行在IDE中
        delayTime := 1000 *10
      else
      begin
        delayTime := 1000 *60 *Config.AutoUpload;
      end;
      sleep(delayTime);
      if Config.AutoUpload > 0 then
        DoWork;
    finally
      updating := False;
      Config.LastUploadTime := now;
    end;
  end;
end;

procedure TDspThread.DoWork;
begin
  if dmServer.OpenDatabase then
  begin
    try
      if(dmServer.DatabaseOpened)then
      begin
        syncDate();
      end
      else
      begin
        KFile.LogWrite('Connect the database failed, can not sync the data.');
      end;
    finally
      dmServer.CloseDatabase();
    end;
  end;
end;

procedure TDspThread.syncDate;
var
  BltService : TBulletinService;
begin
  if dmServer.OpenDatabase then
  begin
    KFile.LogWrite('Sync begin.');
    if Config.SyncTime then
    begin
      frmFingerprint.SyncTime();
      KFile.LogWrite('SyncTime.');
    end;

    frmFingerprint.UploadData;
    //
    frmFingerprint.UploadErrorTimeData;
    KFile.LogWrite('Upload data completed.');

    frmFingerprint.DownloadStaff;
    KFile.LogWrite('Download Staff completed.');

    KFile.LogWrite('Start Download LateInfo...');
    frmFingerprint.DownloadLateInfo();
    KFile.LogWrite('Download data completed.');

  // Deleted by JackyZhou 2010-03-19 16:49:37
  //  dmServer.SendEMail(Now() -1, Config.StoreCode, config.SendCount);
  //  KFile.LogWrite('Send email completed.');

    if Config.ActivateBBS then
    begin
      BltService := TBulletinService.Create;
      BltService.BbsConfig := BbsConfig;
      BltService.Observer := frmFingerprint;
      BltService.refresh;
      FreeAndNil(BltService);
    end;

    KFile.LogWrite('Refresh bulletins completed.');
    KFile.LogWrite('Sync end.');
  end;
end;


end.

