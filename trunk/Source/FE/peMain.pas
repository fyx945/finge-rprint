unit peMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, StdCtrls, ComCtrls, ZKFPEngXControl_TLB, ExtCtrls, siComp,
  DB, Grids, DBGrids, XPMan, Buttons, kbmMemTable, DBCtrls, RzCmboBx,
  RzButton, RzRadChk, RzDBGrid, GridsEh, DBGridEh;

type
  TfrmBiiokey = class(TForm)
    ZKEngine: TZKFPEngX;
    siLang: TsiLang;
    ds_FPID: TDataSource;
    XPManifest: TXPManifest;
    gb_function: TGroupBox;
    le_FPID: TLabeledEdit;
    gb_Info: TGroupBox;
    le_Nickname: TLabeledEdit;
    DBGrid1: TDBGrid;
    StatusBar: TStatusBar;
    mt_Staff: TkbmMemTable;
    bbn_Enroll: TBitBtn;
    bbn_Delete: TBitBtn;
    bbn_Identify: TBitBtn;
    bbn_Cancel: TBitBtn;
    bbn_Upload: TBitBtn;
    bbn_Download: TBitBtn;
    ds_StoreLise: TDataSource;
    mt_StoreList: TkbmMemTable;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    cb_Language: TRzComboBox;
    lab_Language: TLabel;
    siLangDispatcher: TsiLangDispatcher;
    Label1: TLabel;
    Label2: TLabel;
    le_Infoid: TEdit;
    le_StaffName: TEdit;
    dbg_FPID: TDBGridEh;
    DBGridEh2: TDBGridEh;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ds_FPIDDataChange(Sender: TObject; Field: TField);
    procedure bbn_EnrollClick(Sender: TObject);
    procedure bbn_CancelClick(Sender: TObject);
    procedure bbn_DeleteClick(Sender: TObject);
    procedure bbn_IdentifyClick(Sender: TObject);
    procedure ZKEngineFeatureInfo(ASender: TObject; AQuality: Integer);
    procedure ZKEngineEnroll(ASender: TObject; ActionResult: WordBool; ATemplate: OleVariant);
    procedure ZKEngineCapture(ASender: TObject; ActionResult: WordBool; ATemplate: OleVariant);
    procedure ZKEngineFingerTouching(Sender: TObject);
    procedure ZKEngineFingerLeaving(Sender: TObject);
    procedure ZKEngineImageReceived(ASender: TObject; var AImageValid: WordBool);
    procedure bbn_UploadClick(Sender: TObject);
    procedure bbn_DownloadClick(Sender: TObject);
    procedure ds_StoreLiseDataChange(Sender: TObject; Field: TField);
    procedure cb_LanguageChange(Sender: TObject);

  private
    FRegTemplate: OleVariant;
    FfpcHandle: Integer;
    FFingerName: TStringList;
    FActive: Boolean;
  protected
    //Author: JackyZhou at 2006-07-07             //Effect: 连接数据库
    procedure ConfigDB;

    //Author: JackyZhou at 2006-07-04             //Effect: 清空员工信息
    procedure ClearStaffInfo();

    //Author: JackyZhou at 2006-07-04             //Effect: 打开URU指纹仪
    function OpenURU: Boolean;

    //Author: JackyZhou at 2006-07-03             //Effect: 开始登记指纹
    procedure StartEnroll(fpID: String);

    //Author: JackyZhou at 2006-07-03             //Effect: 停止登记指纹
    procedure CancelEnroll();

    //Author: JackyZhou at 2006-07-03             //Effect: 注册员工指纹完成
    procedure onEnroll(fpID: String; ActionResult: WordBool; ATemplate: OleVariant);

    //Author: JackyZhou at 2006-07-03             //Effect: 显示员工信息
    procedure ShowStaffInfo(staffID: String);

    //Author: JackyZhou at 2006-07-07             //Effect: 显示当地所有员工指纹号
    procedure ShowAllFPID(storeCode : String);

  public
    //Author: JackyZhou at 2006-07-10             //Effect: 上传员工指纹数据
    function UploadFMData(fpID: String): Integer;

    //Author: JackyZhou at 2006-07-10             //Effect: 下载员工指纹数据
    function DownloadFMData(fpID: String): Integer;

  published

  end;

var
  frmBiiokey: TfrmBiiokey;

implementation

uses
  dm_Local, unt_Biokey, unt_Config, dm_Server;

var
  config : TConfig;
  Biokey : TBiokey;

{$R *.dfm}

procedure TfrmBiiokey.ConfigDB;
begin
  dmLocal.DBFile := Config.LDBFile;
  dmLocal.DBPWD := Config.LDBPassword;
  dmLocal.AreaCode := Config.AreaCode;
  dmLocal.StoreCode := Config.StoreCode;   
  dmLocal.OpenDatabase();

  dmServer.ServerIP := Config.SDBServer;
  dmServer.UserName := Config.SDBUserName;
  dmServer.Password := Config.SDBPassword;
  dmServer.Database := Config.SDBDatabase;
  dmServer.OpenDatabase;

  dmServer.AreaCode := Config.AreaCode;
  dmServer.StoreCode := Config.StoreCode;
end;

//============================== protected ==============================//

function TfrmBiiokey.OpenURU: Boolean;
begin
  BioKey := TBiokey.Create(Self, ZKEngine);
  try
    if Biokey.OpenFP then
    begin
      //Biokey.LoadAllFMData(dmLocal.GetAllFMData);
      //Biokey.StartIdentify;
      StatusBar.Panels[0].Text := siLang.GetText('FE001');
      Result := true;
    end
    else
    begin
      StatusBar.Panels[0].Text := siLang.GetText('FE002');
      Result := false;
    end;
  except
    Raise ERangeError.CreateFmt('Can"t Open Fingerprint at U.R.U 4000!', []);
    Result := false;
  end;
end;

procedure TfrmBiiokey.StartEnroll(fpID: String);
var
  fpIndex : integer;
  staffID : String;
begin
  staffID := dmLocal.GetStaffID(fpID);
  ShowStaffInfo(staffID);
  Biokey.StartEnroll;
  StatusBar.Panels[1].Text := siLang.GetText('FE003');
end;

procedure TfrmBiiokey.CancelEnroll;
begin
  Biokey.CancelEnroll;
  StatusBar.Panels[1].Text := siLang.GetText('FE004');
end;

procedure TfrmBiiokey.onEnroll(fpID: String; ActionResult: WordBool; ATemplate: OleVariant);
var
  leg: Integer;
  pmData : String;
begin
  if ActionResult then
  begin       
    pmData := ZKEngine.EncodeTemplate1(ATemplate);
    dmLocal.AddFMData(fpID, pmData);
    bbn_Cancel.SendToBack;
    ShowAllFPID(Config.StoreCode);
    StatusBar.Panels[1].Text := siLang.GetText('FE005');
  end
  else
    StatusBar.Panels[1].Text := siLang.GetText('FE006');
end;

procedure TfrmBiiokey.ClearStaffInfo;
begin
  le_InfoID.Text := '';
  le_StaffName.Text := '';
  le_Nickname.Text := '';
end;

procedure TfrmBiiokey.ShowStaffInfo(staffID: String);
begin
  le_InfoID.Text := staffID;
  if config.ShowLang > 1 then
    le_StaffName.Text := dmLocal.GetStaffName(staffID, BG5)
  else
    le_StaffName.Text := dmLocal.GetStaffName(staffID, CHS);
  le_Nickname.Text := dmLocal.GetStaffName(staffID, ENG);
end;

procedure TfrmBiiokey.ShowAllFPID(storeCode : String);
begin
  if mt_Staff.Active then
    mt_Staff.EmptyTable;
  mt_Staff.LoadFromDataSet(dmLocal.GetAllFPID(storeCode), [mtcpoStructure, mtcpoProperties]);
  if dbg_FPID.Columns.Count = 4 then
  begin
    dbg_FPID.Columns[0].Width := 80;
    dbg_FPID.Columns[1].Width := 80;
    dbg_FPID.Columns[2].Width := 50;
    dbg_FPID.Columns[3].Width := 50;
  end;
end;

//============================== public ==============================//

function TfrmBiiokey.UploadFMData(fpID: String): Integer;
var
  lCount, sCount : integer;
  msg : PChar;
  AData : TDataSet;
begin
  lCount := dmLocal.GetLastFingerNo(fpID);
  if lCount > 0 then
  begin
    msg := PChar(siLang.GetText('FE007'));
    sCount := dmServer.GetFMCount(fpID);
    if (sCount <= 0) or (Application.MessageBox(msg, PChar(siLang.GetText('FE009')), 1) =1) then
    begin
      dmServer.DelFMData(fpID);
      AData := dmLocal.GetFMData(fpID);
      dmServer.UploadFMData(AData);
    end;
  end
  else
  begin
    Application.MessageBox(PChar(siLang.GetText('FE008')), PChar(siLang.GetText('FE009')), 0);
  end;
  Result := lCount;
end;

function TfrmBiiokey.DownloadFMData(fpID: String): Integer;
var
  lCount, sCount : integer;
  msg : PChar;
  AData : TDataSet;
begin
  sCount := dmServer.GetFMCount(fpID);
  if sCount > 0 then
  begin
    msg := PChar(siLang.GetText('FE010'));
    lCount := dmLocal.GetLastFingerNo(fpID);
    if (lCount <= 0) or (Application.MessageBox(msg, PChar(siLang.GetText('FE009')), 1) =1) then
    begin
      dmLocal.DelFMData(fpID);
      AData := dmServer.GetFMData(fpID);
      dmLocal.DownloadFMData(AData);
    end;
  end
  else
  begin
    Application.MessageBox(PChar(siLang.GetText('FE011')), PChar(siLang.GetText('FE009')), 0);
  end;
  Result := sCount;
end;

//============================== Event ==============================//
procedure TfrmBiiokey.FormCreate(Sender: TObject);
begin
  ClearStaffInfo();
  Config := TConfig.Create('Config.ini');
  Config.ReadConfig;
  ConfigDB;
end;

procedure TfrmBiiokey.FormShow(Sender: TObject);        
begin
  PageControl1.ActivePageIndex := 1;

  mt_StoreList.LoadFromDataSet(dmLocal.GetStoreList, [mtcpoStructure, mtcpoProperties]);
  ShowAllFPID(Config.StoreCode);
  StatusBar.Panels[2].Text := ZKEngine.SensorSN;

  cb_Language.ItemIndex := Config.ShowLang;
  cb_LanguageChange(nil);

  OpenURU;
end;

procedure TfrmBiiokey.ds_FPIDDataChange(Sender: TObject; Field: TField);
var
  fpID : String;
begin
  fpID := mt_Staff.Fields[2].AsString;
  le_FPID.Text := fpID
end;

procedure TfrmBiiokey.bbn_EnrollClick(Sender: TObject);
var
  fpID : String;
  fpNo : integer;
begin
  fpID := le_FPID.Text;
  if fpID <> '' then
  begin
    fpNo := dmLocal.GetLastFingerNo(fpID);
    if fpNo < 10 then
    begin
      StartEnroll(fpID);
      TButton(Sender).SendToBack;
    end
    else
      StatusBar.Panels[1].Text := siLang.GetText('FE012');
  end
  else
    StatusBar.Panels[1].Text := siLang.GetText('FE013');
end;

procedure TfrmBiiokey.bbn_CancelClick(Sender: TObject);
begin
  TButton(Sender).SendToBack;
  CancelEnroll;      
end;

procedure TfrmBiiokey.bbn_DeleteClick(Sender: TObject);
var
  fpID : String;
begin
  fpID := le_FPID.Text;
  if fpID <> '' then
  begin
    if Application.MessageBox(PChar(siLang.GetText('FE014')), PChar(siLang.GetText('FE009')), 1) = 1 then
    begin
      dmLocal.DelFMData(fpID);
      ShowAllFPID(Config.StoreCode);
      StatusBar.Panels[1].Text := siLang.GetText('FE015');
    end;
  end
  else
    StatusBar.Panels[1].Text := siLang.GetText('FE016');
end;

procedure TfrmBiiokey.bbn_IdentifyClick(Sender: TObject);
begin
  Biokey.LoadAllFMData(dmLocal.GetAllFMData);
  Biokey.StartIdentify;
  StatusBar.Panels[1].Text := siLang.GetText('FE017');
end;

procedure TfrmBiiokey.ZKEngineFeatureInfo(ASender: TObject; AQuality: Integer);
var
  index : integer;
begin
  index := 4;
  index := Biokey.FeatureInfo(AQuality);
  if index > 1 then
    StatusBar.Panels[1].Text := Format(siLang.GetText('FE018'), [index -1]);
end;

procedure TfrmBiiokey.ZKEngineEnroll(ASender: TObject; ActionResult: WordBool; ATemplate: OleVariant);
begin
  onEnroll(le_FPID.Text, ActionResult, ATemplate);
end;

procedure TfrmBiiokey.ZKEngineCapture(ASender: TObject; ActionResult: WordBool; ATemplate: OleVariant);
var
  fpID, staffID: String;
begin
  fpID := Biokey.Capture(ATemplate);
  if fpID <> '' then
  begin
    staffID := dmLocal.GetStaffID(fpID);
    ShowStaffInfo(staffID);
  end;
end;

procedure TfrmBiiokey.ZKEngineFingerTouching(Sender: TObject);
begin
  StatusBar.Panels[0].Text := siLang.GetText('FE019');
end;

procedure TfrmBiiokey.ZKEngineFingerLeaving(Sender: TObject);
begin
  StatusBar.Panels[0].Text := siLang.GetText('FE020');
end;

procedure TfrmBiiokey.ZKEngineImageReceived(ASender: TObject; var AImageValid: WordBool);
begin
  StatusBar.Panels[0].Text := siLang.GetText('FE021');
end;

procedure TfrmBiiokey.bbn_UploadClick(Sender: TObject);
var
  fpID, staffID: String;
  fmCount : integer;
begin
  fpID := le_FPID.Text;
  if fpID <> '' then
  begin
    fmCount := UploadFMData(fpID);
    if fmCount > 0 then
    begin
      StatusBar.Panels[1].Text := Format(siLang.GetText('FE022'), [fmCount]);
      ShowAllFPID(Config.StoreCode);
    end;
  end;
end;

procedure TfrmBiiokey.bbn_DownloadClick(Sender: TObject);
var
  fpID, staffID: String;
  fmCount : integer;
begin
  fpID := le_FPID.Text;
  if fpID <> '' then
  begin
    fmCount := DownloadFMData(fpID);
    if fmCount > 0 then
    begin
      StatusBar.Panels[1].Text := Format(siLang.GetText('FE023'), [fmCount]);
      ShowAllFPID(Config.StoreCode);
    end;
  end;
end;

procedure TfrmBiiokey.ds_StoreLiseDataChange(Sender: TObject;
  Field: TField);
begin
  ShowAllFPID(mt_StoreList.Fields[0].ASString);
  //PageControl1.ActivePageIndex := 1;
end;

procedure TfrmBiiokey.cb_LanguageChange(Sender: TObject);
begin
  Config.ShowLang := cb_Language.ItemIndex;
  siLangDispatcher.Language := siLang.LangNames[Config.ShowLang];
  dmLocal.Language := Config.ShowLang;
  if Config.ShowLang > 1 then
  begin
    mt_StoreList.FieldByName('LOCATION_CHS').Visible := false;
    mt_StoreList.FieldByName('LOCATION_CHI').Visible := true;
  end
  else
  begin
    mt_StoreList.FieldByName('LOCATION_CHS').Visible := true;
    mt_StoreList.FieldByName('LOCATION_CHI').Visible := false;
  end;
  ShowAllFPID(Config.StoreCode);
  //ShowAllFPID(mt_StoreList.Fields[0].ASString);

  StatusBar.Panels[0].Text := '';
  StatusBar.Panels[1].Text := '';
  StatusBar.Panels[2].Text := '';
end;

end.
