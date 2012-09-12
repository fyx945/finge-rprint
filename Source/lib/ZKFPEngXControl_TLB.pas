unit ZKFPEngXControl_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// $Rev: 8291 $
// File generated on 2008-4-15 16:10:02 from Type Library described below.

// ************************************************************************  //
// Type Lib: F:\Fingerprint\Bin\Biokey.ocx (1)
// LIBID: {D95CB779-00CB-4B49-97B9-9F0B61CAB3C1}
// LCID: 0
// Helpfile: 
// HelpString: ZKSoftware Biokey Engine 3.5 For 1:N
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\stdole2.tlb)
// ************************************************************************ //
// *************************************************************************//
// NOTE:                                                                      
// Items guarded by $IFDEF_LIVE_SERVER_AT_DESIGN_TIME are used by properties  
// which return objects that may need to be explicitly created via a function 
// call prior to any access via the property. These items have been disabled  
// in order to prevent accidental use from within the object inspector. You   
// may enable them by defining LIVE_SERVER_AT_DESIGN_TIME or by selectively   
// removing them from the $IFDEF blocks. However, such items must still be    
// programmatically created via a method of the appropriate CoClass before    
// they can be used.                                                          
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, OleCtrls, OleServer, StdVCL, Variants;
  


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  ZKFPEngXControlMajorVersion = 3;
  ZKFPEngXControlMinorVersion = 5;

  LIBID_ZKFPEngXControl: TGUID = '{D95CB779-00CB-4B49-97B9-9F0B61CAB3C1}';

  IID_IZKFPEngX: TGUID = '{161A8D2D-3DDE-4744-BA38-08F900D10D6D}';
  DIID_IZKFPEngXEvents: TGUID = '{8AEE2E53-7EBE-4B51-A964-009ADC68D107}';
  CLASS_ZKFPEngX: TGUID = '{CA69969C-2F27-41D3-954D-A48B941C3BA7}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IZKFPEngX = interface;
  IZKFPEngXDisp = dispinterface;
  IZKFPEngXEvents = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  ZKFPEngX = IZKFPEngX;


// *********************************************************************//
// Interface: IZKFPEngX
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {161A8D2D-3DDE-4744-BA38-08F900D10D6D}
// *********************************************************************//
  IZKFPEngX = interface(IDispatch)
    ['{161A8D2D-3DDE-4744-BA38-08F900D10D6D}']
    function Get_EnrollCount: Integer; safecall;
    procedure Set_EnrollCount(Value: Integer); safecall;
    function VerFinger(var regTemplate: OleVariant; verTemplate: OleVariant; ADoLearning: WordBool; 
                       var ARegFeatureChanged: WordBool): WordBool; safecall;
    function VerRegFingerFile(const regTemplateFile: WideString; verTemplate: OleVariant; 
                              ADoLearning: WordBool; var ARegFeatureChanged: WordBool): WordBool; safecall;
    procedure PrintImageAt(hdc: OLE_HANDLE; x: Integer; y: Integer; aWidth: Integer; 
                           aHeight: Integer); safecall;
    procedure PrintImageEllipseAt(hdc: OLE_HANDLE; x: Integer; y: Integer; aWidth: Integer; 
                                  aHeight: Integer; bkColor: OLE_COLOR); safecall;
    procedure BeginEnroll; safecall;
    function SaveTemplate(const FileName: WideString; ATemplate: OleVariant): WordBool; safecall;
    procedure SaveBitmap(const FileName: WideString); safecall;
    procedure SaveJPG(const FileName: WideString); safecall;
    function InitEngine: Integer; safecall;
    function Get_SensorIndex: Integer; safecall;
    procedure Set_SensorIndex(Value: Integer); safecall;
    procedure CancelEnroll; safecall;
    function CreateFPCacheDB: Integer; safecall;
    procedure FreeFPCacheDB(fpcHandle: Integer); safecall;
    function AddRegTemplateToFPCacheDB(fpcHandle: Integer; FPID: Integer; pRegTemplate: OleVariant): Integer; safecall;
    function RemoveRegTemplateFromFPCacheDB(fpcHandle: Integer; FPID: Integer): Integer; safecall;
    function AddRegTemplateFileToFPCacheDB(fpcHandle: Integer; FPID: Integer; 
                                           const pRegTemplateFile: WideString): Integer; safecall;
    function Get_Threshold: Integer; safecall;
    procedure Set_Threshold(Value: Integer); safecall;
    function DongleIsExist: WordBool; safecall;
    function DongleUserID: Integer; safecall;
    function DongleSeed(var lp2: Integer; var p1: Integer; var p2: Integer; var p3: Integer; 
                        var p4: Integer): WordBool; safecall;
    function DongleMemRead(var p1: Integer; var p2: Integer; var buf: OleVariant): WordBool; safecall;
    function DongleMemWrite(var p1: Integer; var p2: Integer; var buf: OleVariant): WordBool; safecall;
    function VerFingerFromFile(const regTemplateFile: WideString; 
                               const verTemplateFile: WideString; ADoLearning: WordBool; 
                               var ARegFeatureChanged: WordBool): WordBool; safecall;
    function Get_VerTplFileName: WideString; safecall;
    procedure Set_VerTplFileName(const Value: WideString); safecall;
    function Get_RegTplFileName: WideString; safecall;
    procedure Set_RegTplFileName(const Value: WideString); safecall;
    function GetTemplate: OleVariant; safecall;
    function GetFingerImage(var AFingerImage: OleVariant): WordBool; safecall;
    function Get_OneToOneThreshold: Integer; safecall;
    procedure Set_OneToOneThreshold(Value: Integer); safecall;
    function IsOneToOneTemplate(ATemplate: OleVariant): WordBool; safecall;
    procedure ModifyTemplate(var ATemplate: OleVariant; AOneToOne: WordBool); safecall;
    procedure FlushFPImages; safecall;
    function Get_Active: WordBool; safecall;
    procedure Set_Active(Value: WordBool); safecall;
    function Get_IsRegister: WordBool; safecall;
    procedure Set_IsRegister(Value: WordBool); safecall;
    function Get_EnrollIndex: Integer; safecall;
    procedure Set_EnrollIndex(Value: Integer); safecall;
    function Get_SensorSN: WideString; safecall;
    procedure Set_SensorSN(const Value: WideString); safecall;
    function Get_FPEngineVersion: WideString; safecall;
    procedure Set_FPEngineVersion(const Value: WideString); safecall;
    function Get_ImageWidth: Integer; safecall;
    procedure Set_ImageWidth(Value: Integer); safecall;
    function Get_ImageHeight: Integer; safecall;
    procedure Set_ImageHeight(Value: Integer); safecall;
    function Get_SensorCount: Integer; safecall;
    procedure Set_SensorCount(Value: Integer); safecall;
    function Get_TemplateLen: Integer; safecall;
    procedure Set_TemplateLen(Value: Integer); safecall;
    function Get_EngineValid: WordBool; safecall;
    procedure Set_EngineValid(Value: WordBool); safecall;
    function DecodeTemplate(const ASour: WideString; var ADest: OleVariant): WordBool; safecall;
    function EncodeTemplate(ASour: OleVariant; var ADest: WideString): WordBool; safecall;
    procedure BeginCapture; safecall;
    procedure CancelCapture; safecall;
    procedure EndEngine; safecall;
    function DecodeTemplate1(const ASour: WideString): OleVariant; safecall;
    function EncodeTemplate1(ASour: OleVariant): WideString; safecall;
    function AddRegTemplateStrToFPCacheDB(fpcHandle: Integer; FPID: Integer; 
                                          const ARegTemplateStr: WideString): Integer; safecall;
    function VerFingerFromStr(var regTemplateStr: WideString; const verTemplateStr: WideString; 
                              ADoLearning: WordBool; var ARegFeatureChanged: WordBool): WordBool; safecall;
    function GetTemplateAsString: WideString; safecall;
    function IsOneToOneTemplateStr(const ATemplate: WideString): WordBool; safecall;
    procedure ModifyTemplateStr(var ATemplate: WideString; AOneToOne: WordBool); safecall;
    procedure SaveTemplateStr(const FileName: WideString; const ATemplateStr: WideString); safecall;
    procedure GetTemplateCount(AFPHandle: Integer; var AOneToOneCnt: Integer; var ATotalCnt: Integer); safecall;
    function IdentificationInFPCacheDB(fpcHandle: Integer; pVerTemplate: OleVariant; 
                                       var Score: Integer; var ProcessedFPNumber: Integer): Integer; safecall;
    function IdentificationFromFileInFPCacheDB(fpcHandle: Integer; 
                                               const pVerTemplateFile: WideString; 
                                               var Score: Integer; var ProcessedFPNumber: Integer): Integer; safecall;
    function IdentificationFromStrInFPCacheDB(fpcHandle: Integer; 
                                              const AVerTemplateStr: WideString; 
                                              var Score: Integer; var ProcessedFPNumber: Integer): Integer; safecall;
    procedure SetAutoIdentifyPara(AAutoIdentify: WordBool; ACacheDBHandle: Integer; AScore: Integer); safecall;
    procedure SetImageDirection(AIsImageChange: WordBool); safecall;
    function IsOneToOneTemplateFile(const ATemplateFileName: WideString): WordBool; safecall;
    procedure ModifyTemplateFile(const ATemplateFileName: WideString; AOneToOne: WordBool); safecall;
    function GetVerTemplate: OleVariant; safecall;
    function GetVerScore: Integer; safecall;
    function AddImageFile(const AFileName: WideString; ADPI: Integer): WordBool; safecall;
    procedure SetOneToOnePara(ADoLearning: Integer; AMatchSecurity: Integer); safecall;
    function CompressTemplate(const ATemplate: WideString): OleVariant; safecall;
    function ExtractImageFromURU4000(AOriImageBuf: PChar; Size: Integer; AAutoIdentify: WordBool): Integer; safecall;
    property EnrollCount: Integer read Get_EnrollCount write Set_EnrollCount;
    property SensorIndex: Integer read Get_SensorIndex write Set_SensorIndex;
    property Threshold: Integer read Get_Threshold write Set_Threshold;
    property VerTplFileName: WideString read Get_VerTplFileName write Set_VerTplFileName;
    property RegTplFileName: WideString read Get_RegTplFileName write Set_RegTplFileName;
    property OneToOneThreshold: Integer read Get_OneToOneThreshold write Set_OneToOneThreshold;
    property Active: WordBool read Get_Active write Set_Active;
    property IsRegister: WordBool read Get_IsRegister write Set_IsRegister;
    property EnrollIndex: Integer read Get_EnrollIndex write Set_EnrollIndex;
    property SensorSN: WideString read Get_SensorSN write Set_SensorSN;
    property FPEngineVersion: WideString read Get_FPEngineVersion write Set_FPEngineVersion;
    property ImageWidth: Integer read Get_ImageWidth write Set_ImageWidth;
    property ImageHeight: Integer read Get_ImageHeight write Set_ImageHeight;
    property SensorCount: Integer read Get_SensorCount write Set_SensorCount;
    property TemplateLen: Integer read Get_TemplateLen write Set_TemplateLen;
    property EngineValid: WordBool read Get_EngineValid write Set_EngineValid;
  end;

// *********************************************************************//
// DispIntf:  IZKFPEngXDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {161A8D2D-3DDE-4744-BA38-08F900D10D6D}
// *********************************************************************//
  IZKFPEngXDisp = dispinterface
    ['{161A8D2D-3DDE-4744-BA38-08F900D10D6D}']
    property EnrollCount: Integer dispid 6;
    function VerFinger(var regTemplate: OleVariant; verTemplate: OleVariant; ADoLearning: WordBool; 
                       var ARegFeatureChanged: WordBool): WordBool; dispid 8;
    function VerRegFingerFile(const regTemplateFile: WideString; verTemplate: OleVariant; 
                              ADoLearning: WordBool; var ARegFeatureChanged: WordBool): WordBool; dispid 10;
    procedure PrintImageAt(hdc: OLE_HANDLE; x: Integer; y: Integer; aWidth: Integer; 
                           aHeight: Integer); dispid 12;
    procedure PrintImageEllipseAt(hdc: OLE_HANDLE; x: Integer; y: Integer; aWidth: Integer; 
                                  aHeight: Integer; bkColor: OLE_COLOR); dispid 13;
    procedure BeginEnroll; dispid 14;
    function SaveTemplate(const FileName: WideString; ATemplate: OleVariant): WordBool; dispid 18;
    procedure SaveBitmap(const FileName: WideString); dispid 22;
    procedure SaveJPG(const FileName: WideString); dispid 24;
    function InitEngine: Integer; dispid 26;
    property SensorIndex: Integer dispid 37;
    procedure CancelEnroll; dispid 1;
    function CreateFPCacheDB: Integer; dispid 9;
    procedure FreeFPCacheDB(fpcHandle: Integer); dispid 11;
    function AddRegTemplateToFPCacheDB(fpcHandle: Integer; FPID: Integer; pRegTemplate: OleVariant): Integer; dispid 15;
    function RemoveRegTemplateFromFPCacheDB(fpcHandle: Integer; FPID: Integer): Integer; dispid 16;
    function AddRegTemplateFileToFPCacheDB(fpcHandle: Integer; FPID: Integer; 
                                           const pRegTemplateFile: WideString): Integer; dispid 20;
    property Threshold: Integer dispid 21;
    function DongleIsExist: WordBool; dispid 23;
    function DongleUserID: Integer; dispid 28;
    function DongleSeed(var lp2: Integer; var p1: Integer; var p2: Integer; var p3: Integer; 
                        var p4: Integer): WordBool; dispid 29;
    function DongleMemRead(var p1: Integer; var p2: Integer; var buf: OleVariant): WordBool; dispid 30;
    function DongleMemWrite(var p1: Integer; var p2: Integer; var buf: OleVariant): WordBool; dispid 38;
    function VerFingerFromFile(const regTemplateFile: WideString; 
                               const verTemplateFile: WideString; ADoLearning: WordBool; 
                               var ARegFeatureChanged: WordBool): WordBool; dispid 42;
    property VerTplFileName: WideString dispid 43;
    property RegTplFileName: WideString dispid 44;
    function GetTemplate: OleVariant; dispid 45;
    function GetFingerImage(var AFingerImage: OleVariant): WordBool; dispid 46;
    property OneToOneThreshold: Integer dispid 49;
    function IsOneToOneTemplate(ATemplate: OleVariant): WordBool; dispid 7;
    procedure ModifyTemplate(var ATemplate: OleVariant; AOneToOne: WordBool); dispid 25;
    procedure FlushFPImages; dispid 19;
    property Active: WordBool dispid 32;
    property IsRegister: WordBool dispid 40;
    property EnrollIndex: Integer dispid 47;
    property SensorSN: WideString dispid 50;
    property FPEngineVersion: WideString dispid 51;
    property ImageWidth: Integer dispid 52;
    property ImageHeight: Integer dispid 53;
    property SensorCount: Integer dispid 54;
    property TemplateLen: Integer dispid 55;
    property EngineValid: WordBool dispid 56;
    function DecodeTemplate(const ASour: WideString; var ADest: OleVariant): WordBool; dispid 2;
    function EncodeTemplate(ASour: OleVariant; var ADest: WideString): WordBool; dispid 3;
    procedure BeginCapture; dispid 4;
    procedure CancelCapture; dispid 5;
    procedure EndEngine; dispid 27;
    function DecodeTemplate1(const ASour: WideString): OleVariant; dispid 31;
    function EncodeTemplate1(ASour: OleVariant): WideString; dispid 33;
    function AddRegTemplateStrToFPCacheDB(fpcHandle: Integer; FPID: Integer; 
                                          const ARegTemplateStr: WideString): Integer; dispid 35;
    function VerFingerFromStr(var regTemplateStr: WideString; const verTemplateStr: WideString; 
                              ADoLearning: WordBool; var ARegFeatureChanged: WordBool): WordBool; dispid 36;
    function GetTemplateAsString: WideString; dispid 39;
    function IsOneToOneTemplateStr(const ATemplate: WideString): WordBool; dispid 48;
    procedure ModifyTemplateStr(var ATemplate: WideString; AOneToOne: WordBool); dispid 57;
    procedure SaveTemplateStr(const FileName: WideString; const ATemplateStr: WideString); dispid 61;
    procedure GetTemplateCount(AFPHandle: Integer; var AOneToOneCnt: Integer; var ATotalCnt: Integer); dispid 62;
    function IdentificationInFPCacheDB(fpcHandle: Integer; pVerTemplate: OleVariant; 
                                       var Score: Integer; var ProcessedFPNumber: Integer): Integer; dispid 64;
    function IdentificationFromFileInFPCacheDB(fpcHandle: Integer; 
                                               const pVerTemplateFile: WideString; 
                                               var Score: Integer; var ProcessedFPNumber: Integer): Integer; dispid 65;
    function IdentificationFromStrInFPCacheDB(fpcHandle: Integer; 
                                              const AVerTemplateStr: WideString; 
                                              var Score: Integer; var ProcessedFPNumber: Integer): Integer; dispid 66;
    procedure SetAutoIdentifyPara(AAutoIdentify: WordBool; ACacheDBHandle: Integer; AScore: Integer); dispid 17;
    procedure SetImageDirection(AIsImageChange: WordBool); dispid 41;
    function IsOneToOneTemplateFile(const ATemplateFileName: WideString): WordBool; dispid 34;
    procedure ModifyTemplateFile(const ATemplateFileName: WideString; AOneToOne: WordBool); dispid 58;
    function GetVerTemplate: OleVariant; dispid 59;
    function GetVerScore: Integer; dispid 60;
    function AddImageFile(const AFileName: WideString; ADPI: Integer): WordBool; dispid 63;
    procedure SetOneToOnePara(ADoLearning: Integer; AMatchSecurity: Integer); dispid 67;
    function CompressTemplate(const ATemplate: WideString): OleVariant; dispid 68;
    function ExtractImageFromURU4000(AOriImageBuf: {??PChar}OleVariant; Size: Integer; 
                                     AAutoIdentify: WordBool): Integer; dispid 69;
  end;

// *********************************************************************//
// DispIntf:  IZKFPEngXEvents
// Flags:     (4096) Dispatchable
// GUID:      {8AEE2E53-7EBE-4B51-A964-009ADC68D107}
// *********************************************************************//
  IZKFPEngXEvents = dispinterface
    ['{8AEE2E53-7EBE-4B51-A964-009ADC68D107}']
    procedure OnFeatureInfo(AQuality: Integer); dispid 5;
    procedure OnImageReceived(var AImageValid: WordBool); dispid 8;
    procedure OnEnroll(ActionResult: WordBool; ATemplate: OleVariant); dispid 9;
    procedure OnCapture(ActionResult: WordBool; ATemplate: OleVariant); dispid 10;
    procedure OnCaptureToFile(ActionResult: WordBool); dispid 2;
    procedure OnEnrollToFile(ActionResult: WordBool); dispid 11;
    procedure OnFingerTouching; dispid 1;
    procedure OnFingerLeaving; dispid 3;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TZKFPEngX
// Help String      : ZKFPEngX Control
// Default Interface: IZKFPEngX
// Def. Intf. DISP? : No
// Event   Interface: IZKFPEngXEvents
// TypeFlags        : (34) CanCreate Control
// *********************************************************************//
  TZKFPEngXOnFeatureInfo = procedure(ASender: TObject; AQuality: Integer) of object;
  TZKFPEngXOnImageReceived = procedure(ASender: TObject; var AImageValid: WordBool) of object;
  TZKFPEngXOnEnroll = procedure(ASender: TObject; ActionResult: WordBool; ATemplate: OleVariant) of object;
  TZKFPEngXOnCapture = procedure(ASender: TObject; ActionResult: WordBool; ATemplate: OleVariant) of object;
  TZKFPEngXOnCaptureToFile = procedure(ASender: TObject; ActionResult: WordBool) of object;
  TZKFPEngXOnEnrollToFile = procedure(ASender: TObject; ActionResult: WordBool) of object;

  TZKFPEngX = class(TOleControl)
  private
    FOnFeatureInfo: TZKFPEngXOnFeatureInfo;
    FOnImageReceived: TZKFPEngXOnImageReceived;
    FOnEnroll: TZKFPEngXOnEnroll;
    FOnCapture: TZKFPEngXOnCapture;
    FOnCaptureToFile: TZKFPEngXOnCaptureToFile;
    FOnEnrollToFile: TZKFPEngXOnEnrollToFile;
    FOnFingerTouching: TNotifyEvent;
    FOnFingerLeaving: TNotifyEvent;
    FIntf: IZKFPEngX;
    function  GetControlInterface: IZKFPEngX;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    function VerFinger(var regTemplate: OleVariant; verTemplate: OleVariant; ADoLearning: WordBool; 
                       var ARegFeatureChanged: WordBool): WordBool;
    function VerRegFingerFile(const regTemplateFile: WideString; verTemplate: OleVariant; 
                              ADoLearning: WordBool; var ARegFeatureChanged: WordBool): WordBool;
    procedure PrintImageAt(hdc: OLE_HANDLE; x: Integer; y: Integer; aWidth: Integer; 
                           aHeight: Integer);
    procedure PrintImageEllipseAt(hdc: OLE_HANDLE; x: Integer; y: Integer; aWidth: Integer; 
                                  aHeight: Integer; bkColor: OLE_COLOR);
    procedure BeginEnroll;
    function SaveTemplate(const FileName: WideString; ATemplate: OleVariant): WordBool;
    procedure SaveBitmap(const FileName: WideString);
    procedure SaveJPG(const FileName: WideString);
    function InitEngine: Integer;
    procedure CancelEnroll;
    function CreateFPCacheDB: Integer;
    procedure FreeFPCacheDB(fpcHandle: Integer);
    function AddRegTemplateToFPCacheDB(fpcHandle: Integer; FPID: Integer; pRegTemplate: OleVariant): Integer;
    function RemoveRegTemplateFromFPCacheDB(fpcHandle: Integer; FPID: Integer): Integer;
    function AddRegTemplateFileToFPCacheDB(fpcHandle: Integer; FPID: Integer; 
                                           const pRegTemplateFile: WideString): Integer;
    function DongleIsExist: WordBool;
    function DongleUserID: Integer;
    function DongleSeed(var lp2: Integer; var p1: Integer; var p2: Integer; var p3: Integer; 
                        var p4: Integer): WordBool;
    function DongleMemRead(var p1: Integer; var p2: Integer; var buf: OleVariant): WordBool;
    function DongleMemWrite(var p1: Integer; var p2: Integer; var buf: OleVariant): WordBool;
    function VerFingerFromFile(const regTemplateFile: WideString; 
                               const verTemplateFile: WideString; ADoLearning: WordBool; 
                               var ARegFeatureChanged: WordBool): WordBool;
    function GetTemplate: OleVariant;
    function GetFingerImage(var AFingerImage: OleVariant): WordBool;
    function IsOneToOneTemplate(ATemplate: OleVariant): WordBool;
    procedure ModifyTemplate(var ATemplate: OleVariant; AOneToOne: WordBool);
    procedure FlushFPImages;
    function DecodeTemplate(const ASour: WideString; var ADest: OleVariant): WordBool;
    function EncodeTemplate(ASour: OleVariant; var ADest: WideString): WordBool;
    procedure BeginCapture;
    procedure CancelCapture;
    procedure EndEngine;
    function DecodeTemplate1(const ASour: WideString): OleVariant;
    function EncodeTemplate1(ASour: OleVariant): WideString;
    function AddRegTemplateStrToFPCacheDB(fpcHandle: Integer; FPID: Integer; 
                                          const ARegTemplateStr: WideString): Integer;
    function VerFingerFromStr(var regTemplateStr: WideString; const verTemplateStr: WideString; 
                              ADoLearning: WordBool; var ARegFeatureChanged: WordBool): WordBool;
    function GetTemplateAsString: WideString;
    function IsOneToOneTemplateStr(const ATemplate: WideString): WordBool;
    procedure ModifyTemplateStr(var ATemplate: WideString; AOneToOne: WordBool);
    procedure SaveTemplateStr(const FileName: WideString; const ATemplateStr: WideString);
    procedure GetTemplateCount(AFPHandle: Integer; var AOneToOneCnt: Integer; var ATotalCnt: Integer);
    function IdentificationInFPCacheDB(fpcHandle: Integer; pVerTemplate: OleVariant; 
                                       var Score: Integer; var ProcessedFPNumber: Integer): Integer;
    function IdentificationFromFileInFPCacheDB(fpcHandle: Integer; 
                                               const pVerTemplateFile: WideString; 
                                               var Score: Integer; var ProcessedFPNumber: Integer): Integer;
    function IdentificationFromStrInFPCacheDB(fpcHandle: Integer; 
                                              const AVerTemplateStr: WideString; 
                                              var Score: Integer; var ProcessedFPNumber: Integer): Integer;
    procedure SetAutoIdentifyPara(AAutoIdentify: WordBool; ACacheDBHandle: Integer; AScore: Integer);
    procedure SetImageDirection(AIsImageChange: WordBool);
    function IsOneToOneTemplateFile(const ATemplateFileName: WideString): WordBool;
    procedure ModifyTemplateFile(const ATemplateFileName: WideString; AOneToOne: WordBool);
    function GetVerTemplate: OleVariant;
    function GetVerScore: Integer;
    function AddImageFile(const AFileName: WideString; ADPI: Integer): WordBool;
    procedure SetOneToOnePara(ADoLearning: Integer; AMatchSecurity: Integer);
    function CompressTemplate(const ATemplate: WideString): OleVariant;
    function ExtractImageFromURU4000(AOriImageBuf: PChar; Size: Integer; AAutoIdentify: WordBool): Integer;
    property  ControlInterface: IZKFPEngX read GetControlInterface;
    property  DefaultInterface: IZKFPEngX read GetControlInterface;
  published
    property Anchors;
    property EnrollCount: Integer index 6 read GetIntegerProp write SetIntegerProp stored False;
    property SensorIndex: Integer index 37 read GetIntegerProp write SetIntegerProp stored False;
    property Threshold: Integer index 21 read GetIntegerProp write SetIntegerProp stored False;
    property VerTplFileName: WideString index 43 read GetWideStringProp write SetWideStringProp stored False;
    property RegTplFileName: WideString index 44 read GetWideStringProp write SetWideStringProp stored False;
    property OneToOneThreshold: Integer index 49 read GetIntegerProp write SetIntegerProp stored False;
    property Active: WordBool index 32 read GetWordBoolProp write SetWordBoolProp stored False;
    property IsRegister: WordBool index 40 read GetWordBoolProp write SetWordBoolProp stored False;
    property EnrollIndex: Integer index 47 read GetIntegerProp write SetIntegerProp stored False;
    property SensorSN: WideString index 50 read GetWideStringProp write SetWideStringProp stored False;
    property FPEngineVersion: WideString index 51 read GetWideStringProp write SetWideStringProp stored False;
    property ImageWidth: Integer index 52 read GetIntegerProp write SetIntegerProp stored False;
    property ImageHeight: Integer index 53 read GetIntegerProp write SetIntegerProp stored False;
    property SensorCount: Integer index 54 read GetIntegerProp write SetIntegerProp stored False;
    property TemplateLen: Integer index 55 read GetIntegerProp write SetIntegerProp stored False;
    property EngineValid: WordBool index 56 read GetWordBoolProp write SetWordBoolProp stored False;
    property OnFeatureInfo: TZKFPEngXOnFeatureInfo read FOnFeatureInfo write FOnFeatureInfo;
    property OnImageReceived: TZKFPEngXOnImageReceived read FOnImageReceived write FOnImageReceived;
    property OnEnroll: TZKFPEngXOnEnroll read FOnEnroll write FOnEnroll;
    property OnCapture: TZKFPEngXOnCapture read FOnCapture write FOnCapture;
    property OnCaptureToFile: TZKFPEngXOnCaptureToFile read FOnCaptureToFile write FOnCaptureToFile;
    property OnEnrollToFile: TZKFPEngXOnEnrollToFile read FOnEnrollToFile write FOnEnrollToFile;
    property OnFingerTouching: TNotifyEvent read FOnFingerTouching write FOnFingerTouching;
    property OnFingerLeaving: TNotifyEvent read FOnFingerLeaving write FOnFingerLeaving;
  end;

procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

  dtlOcxPage = 'ActiveX';

implementation

uses ComObj;

procedure TZKFPEngX.InitControlData;
const
  CEventDispIDs: array [0..7] of DWORD = (
    $00000005, $00000008, $00000009, $0000000A, $00000002, $0000000B,
    $00000001, $00000003);
  CControlData: TControlData2 = (
    ClassID: '{CA69969C-2F27-41D3-954D-A48B941C3BA7}';
    EventIID: '{8AEE2E53-7EBE-4B51-A964-009ADC68D107}';
    EventCount: 8;
    EventDispIDs: @CEventDispIDs;
    LicenseKey: nil (*HR:$00000000*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
  TControlData2(CControlData).FirstEventOfs := Cardinal(@@FOnFeatureInfo) - Cardinal(Self);
end;

procedure TZKFPEngX.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as IZKFPEngX;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TZKFPEngX.GetControlInterface: IZKFPEngX;
begin
  CreateControl;
  Result := FIntf;
end;

function TZKFPEngX.VerFinger(var regTemplate: OleVariant; verTemplate: OleVariant; 
                             ADoLearning: WordBool; var ARegFeatureChanged: WordBool): WordBool;
begin
  Result := DefaultInterface.VerFinger(regTemplate, verTemplate, ADoLearning, ARegFeatureChanged);
end;

function TZKFPEngX.VerRegFingerFile(const regTemplateFile: WideString; verTemplate: OleVariant; 
                                    ADoLearning: WordBool; var ARegFeatureChanged: WordBool): WordBool;
begin
  Result := DefaultInterface.VerRegFingerFile(regTemplateFile, verTemplate, ADoLearning, 
                                              ARegFeatureChanged);
end;

procedure TZKFPEngX.PrintImageAt(hdc: OLE_HANDLE; x: Integer; y: Integer; aWidth: Integer; 
                                 aHeight: Integer);
begin
  DefaultInterface.PrintImageAt(hdc, x, y, aWidth, aHeight);
end;

procedure TZKFPEngX.PrintImageEllipseAt(hdc: OLE_HANDLE; x: Integer; y: Integer; aWidth: Integer; 
                                        aHeight: Integer; bkColor: OLE_COLOR);
begin
  DefaultInterface.PrintImageEllipseAt(hdc, x, y, aWidth, aHeight, bkColor);
end;

procedure TZKFPEngX.BeginEnroll;
begin
  DefaultInterface.BeginEnroll;
end;

function TZKFPEngX.SaveTemplate(const FileName: WideString; ATemplate: OleVariant): WordBool;
begin
  Result := DefaultInterface.SaveTemplate(FileName, ATemplate);
end;

procedure TZKFPEngX.SaveBitmap(const FileName: WideString);
begin
  DefaultInterface.SaveBitmap(FileName);
end;

procedure TZKFPEngX.SaveJPG(const FileName: WideString);
begin
  DefaultInterface.SaveJPG(FileName);
end;

function TZKFPEngX.InitEngine: Integer;
begin
  Result := DefaultInterface.InitEngine;
end;

procedure TZKFPEngX.CancelEnroll;
begin
  DefaultInterface.CancelEnroll;
end;

function TZKFPEngX.CreateFPCacheDB: Integer;
begin
  Result := DefaultInterface.CreateFPCacheDB;
end;

procedure TZKFPEngX.FreeFPCacheDB(fpcHandle: Integer);
begin
  DefaultInterface.FreeFPCacheDB(fpcHandle);
end;

function TZKFPEngX.AddRegTemplateToFPCacheDB(fpcHandle: Integer; FPID: Integer; 
                                             pRegTemplate: OleVariant): Integer;
begin
  Result := DefaultInterface.AddRegTemplateToFPCacheDB(fpcHandle, FPID, pRegTemplate);
end;

function TZKFPEngX.RemoveRegTemplateFromFPCacheDB(fpcHandle: Integer; FPID: Integer): Integer;
begin
  Result := DefaultInterface.RemoveRegTemplateFromFPCacheDB(fpcHandle, FPID);
end;

function TZKFPEngX.AddRegTemplateFileToFPCacheDB(fpcHandle: Integer; FPID: Integer; 
                                                 const pRegTemplateFile: WideString): Integer;
begin
  Result := DefaultInterface.AddRegTemplateFileToFPCacheDB(fpcHandle, FPID, pRegTemplateFile);
end;

function TZKFPEngX.DongleIsExist: WordBool;
begin
  Result := DefaultInterface.DongleIsExist;
end;

function TZKFPEngX.DongleUserID: Integer;
begin
  Result := DefaultInterface.DongleUserID;
end;

function TZKFPEngX.DongleSeed(var lp2: Integer; var p1: Integer; var p2: Integer; var p3: Integer; 
                              var p4: Integer): WordBool;
begin
  Result := DefaultInterface.DongleSeed(lp2, p1, p2, p3, p4);
end;

function TZKFPEngX.DongleMemRead(var p1: Integer; var p2: Integer; var buf: OleVariant): WordBool;
begin
  Result := DefaultInterface.DongleMemRead(p1, p2, buf);
end;

function TZKFPEngX.DongleMemWrite(var p1: Integer; var p2: Integer; var buf: OleVariant): WordBool;
begin
  Result := DefaultInterface.DongleMemWrite(p1, p2, buf);
end;

function TZKFPEngX.VerFingerFromFile(const regTemplateFile: WideString; 
                                     const verTemplateFile: WideString; ADoLearning: WordBool; 
                                     var ARegFeatureChanged: WordBool): WordBool;
begin
  Result := DefaultInterface.VerFingerFromFile(regTemplateFile, verTemplateFile, ADoLearning, 
                                               ARegFeatureChanged);
end;

function TZKFPEngX.GetTemplate: OleVariant;
begin
  Result := DefaultInterface.GetTemplate;
end;

function TZKFPEngX.GetFingerImage(var AFingerImage: OleVariant): WordBool;
begin
  Result := DefaultInterface.GetFingerImage(AFingerImage);
end;

function TZKFPEngX.IsOneToOneTemplate(ATemplate: OleVariant): WordBool;
begin
  Result := DefaultInterface.IsOneToOneTemplate(ATemplate);
end;

procedure TZKFPEngX.ModifyTemplate(var ATemplate: OleVariant; AOneToOne: WordBool);
begin
  DefaultInterface.ModifyTemplate(ATemplate, AOneToOne);
end;

procedure TZKFPEngX.FlushFPImages;
begin
  DefaultInterface.FlushFPImages;
end;

function TZKFPEngX.DecodeTemplate(const ASour: WideString; var ADest: OleVariant): WordBool;
begin
  Result := DefaultInterface.DecodeTemplate(ASour, ADest);
end;

function TZKFPEngX.EncodeTemplate(ASour: OleVariant; var ADest: WideString): WordBool;
begin
  Result := DefaultInterface.EncodeTemplate(ASour, ADest);
end;

procedure TZKFPEngX.BeginCapture;
begin
  DefaultInterface.BeginCapture;
end;

procedure TZKFPEngX.CancelCapture;
begin
  DefaultInterface.CancelCapture;
end;

procedure TZKFPEngX.EndEngine;
begin
  DefaultInterface.EndEngine;
end;

function TZKFPEngX.DecodeTemplate1(const ASour: WideString): OleVariant;
begin
  Result := DefaultInterface.DecodeTemplate1(ASour);
end;

function TZKFPEngX.EncodeTemplate1(ASour: OleVariant): WideString;
begin
  Result := DefaultInterface.EncodeTemplate1(ASour);
end;

function TZKFPEngX.AddRegTemplateStrToFPCacheDB(fpcHandle: Integer; FPID: Integer; 
                                                const ARegTemplateStr: WideString): Integer;
begin
  Result := DefaultInterface.AddRegTemplateStrToFPCacheDB(fpcHandle, FPID, ARegTemplateStr);
end;

function TZKFPEngX.VerFingerFromStr(var regTemplateStr: WideString; 
                                    const verTemplateStr: WideString; ADoLearning: WordBool; 
                                    var ARegFeatureChanged: WordBool): WordBool;
begin
  Result := DefaultInterface.VerFingerFromStr(regTemplateStr, verTemplateStr, ADoLearning, 
                                              ARegFeatureChanged);
end;

function TZKFPEngX.GetTemplateAsString: WideString;
begin
  Result := DefaultInterface.GetTemplateAsString;
end;

function TZKFPEngX.IsOneToOneTemplateStr(const ATemplate: WideString): WordBool;
begin
  Result := DefaultInterface.IsOneToOneTemplateStr(ATemplate);
end;

procedure TZKFPEngX.ModifyTemplateStr(var ATemplate: WideString; AOneToOne: WordBool);
begin
  DefaultInterface.ModifyTemplateStr(ATemplate, AOneToOne);
end;

procedure TZKFPEngX.SaveTemplateStr(const FileName: WideString; const ATemplateStr: WideString);
begin
  DefaultInterface.SaveTemplateStr(FileName, ATemplateStr);
end;

procedure TZKFPEngX.GetTemplateCount(AFPHandle: Integer; var AOneToOneCnt: Integer; 
                                     var ATotalCnt: Integer);
begin
  DefaultInterface.GetTemplateCount(AFPHandle, AOneToOneCnt, ATotalCnt);
end;

function TZKFPEngX.IdentificationInFPCacheDB(fpcHandle: Integer; pVerTemplate: OleVariant; 
                                             var Score: Integer; var ProcessedFPNumber: Integer): Integer;
begin
  Result := DefaultInterface.IdentificationInFPCacheDB(fpcHandle, pVerTemplate, Score, 
                                                       ProcessedFPNumber);
end;

function TZKFPEngX.IdentificationFromFileInFPCacheDB(fpcHandle: Integer; 
                                                     const pVerTemplateFile: WideString; 
                                                     var Score: Integer; 
                                                     var ProcessedFPNumber: Integer): Integer;
begin
  Result := DefaultInterface.IdentificationFromFileInFPCacheDB(fpcHandle, pVerTemplateFile, Score, 
                                                               ProcessedFPNumber);
end;

function TZKFPEngX.IdentificationFromStrInFPCacheDB(fpcHandle: Integer; 
                                                    const AVerTemplateStr: WideString; 
                                                    var Score: Integer; 
                                                    var ProcessedFPNumber: Integer): Integer;
begin
  Result := DefaultInterface.IdentificationFromStrInFPCacheDB(fpcHandle, AVerTemplateStr, Score, 
                                                              ProcessedFPNumber);
end;

procedure TZKFPEngX.SetAutoIdentifyPara(AAutoIdentify: WordBool; ACacheDBHandle: Integer; 
                                        AScore: Integer);
begin
  DefaultInterface.SetAutoIdentifyPara(AAutoIdentify, ACacheDBHandle, AScore);
end;

procedure TZKFPEngX.SetImageDirection(AIsImageChange: WordBool);
begin
  DefaultInterface.SetImageDirection(AIsImageChange);
end;

function TZKFPEngX.IsOneToOneTemplateFile(const ATemplateFileName: WideString): WordBool;
begin
  Result := DefaultInterface.IsOneToOneTemplateFile(ATemplateFileName);
end;

procedure TZKFPEngX.ModifyTemplateFile(const ATemplateFileName: WideString; AOneToOne: WordBool);
begin
  DefaultInterface.ModifyTemplateFile(ATemplateFileName, AOneToOne);
end;

function TZKFPEngX.GetVerTemplate: OleVariant;
begin
  Result := DefaultInterface.GetVerTemplate;
end;

function TZKFPEngX.GetVerScore: Integer;
begin
  Result := DefaultInterface.GetVerScore;
end;

function TZKFPEngX.AddImageFile(const AFileName: WideString; ADPI: Integer): WordBool;
begin
  Result := DefaultInterface.AddImageFile(AFileName, ADPI);
end;

procedure TZKFPEngX.SetOneToOnePara(ADoLearning: Integer; AMatchSecurity: Integer);
begin
  DefaultInterface.SetOneToOnePara(ADoLearning, AMatchSecurity);
end;

function TZKFPEngX.CompressTemplate(const ATemplate: WideString): OleVariant;
begin
  Result := DefaultInterface.CompressTemplate(ATemplate);
end;

function TZKFPEngX.ExtractImageFromURU4000(AOriImageBuf: PChar; Size: Integer; 
                                           AAutoIdentify: WordBool): Integer;
begin
  Result := DefaultInterface.ExtractImageFromURU4000(AOriImageBuf, Size, AAutoIdentify);
end;

procedure Register;
begin
  RegisterComponents(dtlOcxPage, [TZKFPEngX]);
end;

end.
