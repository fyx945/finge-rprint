unit unt_Biokey;

interface
uses
  ZKFPEngXControl_TLB, Classes, SysUtils, DB;

Type
  TMatchType = Integer;
  const
    NULL = 0;
    ENROLL = 1;
    VERIFY = 2;
    IDENTIFY = 3;
    
Type
  TBiokey = class(TComponent)
    procedure ZKEngineCapture(ASender: TObject; ActionResult: WordBool; ATemplate: OleVariant);
  private
    ZKEngine: TZKFPEngX;
    FMatchType: TMatchType;
    FRegTemplate: OleVariant;
    FfpcHandle: Integer;
    FFingerName: TStringList;
    FActive: Boolean;
    FFMCount: integer;
    FOnCapture: TZKFPEngXOnCapture;

  protected
    //Author: JackyZhou at 2006-07-04             //Effect: 以0填写6位的FPID
    function FillFPID(fpID: String): String;

    //Author: JackyZhou at 2006-07-03             //Effect: 鉴别指纹
    function DoIdentify(ATemplate: OleVariant): String;

  public
    constructor Create(AOwner: TComponent; ZKEngine: TZKFPEngX); virtual;
    destructor Destroy; override;

    function OpenFP: Boolean;
    procedure CloseFP;

    //Author: JackyZhou at 2006-07-04             //Effect: 检查当前是否准备好
    function Connect(): Boolean;

    //Author: JackyZhou at 2006-07-04             //Effect: 读取所有指纹数据到高速缓存
    procedure LoadAllFMData(ADataSet: TDataSet);

    //Author: JackyZhou at 2006-07-04             //Effect: 开始验证指纹
    procedure StartIdentify();

    //Author: JackyZhou at 2006-07-04             //Effect: 触发-获得指纹
    function Capture(ATemplate: OleVariant): String;

    //Author: JackyZhou at 2006-07-04             //Effect: 触发-登记指纹
    function FeatureInfo(AQuality: Integer): Integer;

    //Author: JackyZhou at 2006-07-04             //Effect: 开始登记指纹
    procedure StartEnroll();

    //Author: JackyZhou at 2006-07-04             //Effect: 停止登记指纹
    procedure CancelEnroll();

    //Author: JackyZhou at 2008-02-20             //Effect: 启动、禁用该设备
    function EnableBiokey(): Boolean;
    function DisableBiokey(): Boolean;

    procedure reset();

  published
    property FMCount: integer read FFMCount default 0;

    property OnCapture: TZKFPEngXOnCapture read FOnCapture write FOnCapture;
  end;

implementation
uses
  kuControlDevice;

var
  ControlDevice : TKControlDevice;

{**************************************** TBiokey ****************************************}

//============================== protected ==============================//

function TBiokey.FillFPID(fpID: String): String;
var
  id: String;
  i,len : integer;
begin
  len := Length(fpID);
  id := fpID;
  for I := 5 Downto len+1 do    // Iterate
  begin
    id := '0' +id;
  end;
  Result := id;
end;

function TBiokey.DoIdentify(ATemplate: OleVariant): String;
var
  score, proNum, fpIndex : integer;
  tempS, fpID : string;
  atemp:WideString;
begin
  //ZKEngine.EncodeTemplate(ATemplate, atemp);
  //ZKEngine.ModifyTemplateStr(atemp, True); 
  //fpIndex := ZKEngine.IdentificationFromStrInFPCacheDB(FfpcHandle, ZKEngine.GetTemplateAsString, score ,proNum);
  fpIndex := ZKEngine.IdentificationInFPCacheDB(FfpcHandle, ATemplate, score ,proNum);
  if fpIndex > 0 then
  begin
    tempS := IntToStr(fpIndex);
    fpID := Copy(tempS, 1, Length(tempS) -1);
    fpID := FillFPID(fpID);
  end
  else
    fpID := '';
  Result := fpID;
end;

//============================== Public ==============================//

procedure TBiokey.ZKEngineCapture(ASender: TObject; ActionResult: WordBool;  ATemplate: OleVariant);
begin

end;

constructor TBiokey.Create(AOwner: TComponent; ZKEngine: TZKFPEngX);
begin
  //ZKEngine := TZKFPEngX.Create(Self);
  Self.ZKEngine := ZKEngine;
  ControlDevice := TKControlDevice.Create;
end;

destructor TBiokey.Destroy;
begin
  CloseFP;
  //DisableBiokey;
  inherited;
end;

function TBiokey.OpenFP: Boolean;
begin
  if ZKEngine.InitEngine = 0 then
  begin
    FfpcHandle := ZKEngine.CreateFPCacheDB;
    Result := true;
  end
  else
  begin
    FfpcHandle := -1;
    Result := false;
  end;
end;

procedure TBiokey.reset;
begin
  ZKEngine.FreeFPCacheDB(FfpcHandle);
end;

procedure TBiokey.CloseFP;
begin
  if FfpcHandle <> -1 then
    ZKEngine.FreeFPCacheDB(FfpcHandle);
  FfpcHandle := -1;
  ZKEngine.EndEngine;
end;

function TBiokey.Connect: Boolean;
begin
  try
    CloseFP;
    OpenFP;
  finally
    Result := ZKEngine.Active;
  end
end;

procedure TBiokey.LoadAllFMData(ADataSet: TDataSet);
var
  fpID : String;
  fmData : WideString;
begin
  with ADataSet do
  begin
    First;
    while not(EOF) do
    begin
      fpID := FieldByName('FPID').AsString + FieldByName('FingerNo').AsString ;
      fmData := ADataSet.FieldByName('MarkData').AsString;
      ZKEngine.ModifyTemplateStr(fmData, True);
      ZKEngine.AddRegTemplateStrToFPCacheDB(FfpcHandle, StrToInt(fpID), fmData);
      Next;
    end;
  end;
  FFMCount := ADataSet.RecordCount;
end;

procedure TBiokey.StartIdentify;
begin
  FMatchType := IDENTIFY;
end;

function TBiokey.Capture(ATemplate: OleVariant): String;
var
  fpID : String;
begin
  case FMatchType of    //
    NULL: ;
    ENROLL: ;
    VERIFY: ;
    IDENTIFY: fpID := DoIdentify(ATemplate);
  end;    // case
  Result := fpID;
end;

function TBiokey.FeatureInfo(AQuality: Integer): Integer;
var
  enrollIndex : integer;
begin
  enrollIndex := 0;
  if ZKEngine.IsRegister then
  begin
    enrollIndex := ZKEngine.EnrollIndex;
  end;
  Result := enrollIndex;
end;

procedure TBiokey.StartEnroll;
begin
  ZKEngine.BeginEnroll;
  FMatchType := Enroll;
end;

procedure TBiokey.CancelEnroll;
begin
  if ZKEngine.IsRegister then
    ZKEngine.CancelEnroll;
  FMatchType := NULL;
end;

function TBiokey.EnableBiokey: Boolean;
begin
  ControlDevice.EnableDevice(DN_URU4000);
end;

function TBiokey.DisableBiokey: Boolean;
begin
  ControlDevice.DisableDevice(DN_URU4000);
end;


end.
