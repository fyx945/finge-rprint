unit FK328KMLib_TLB;

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
// File generated on 2008-4-16 11:40:32 from Type Library described below.

// ************************************************************************  //
// Type Lib: F:\Fingerprint\Bin\FK328KM.ocx (1)
// LIBID: {86594FC3-22ED-42E1-97C9-D2CF501CAE40}
// LCID: 0
// Helpfile: F:\Fingerprint\Bin\FK328KM.hlp
// HelpString: FK328KM ActiveX Control module
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\stdole2.tlb)
// Errors:
//   Error creating palette bitmap of (TFK328KM) : Error reading control bitmap
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
  FK328KMLibMajorVersion = 1;
  FK328KMLibMinorVersion = 0;

  LIBID_FK328KMLib: TGUID = '{86594FC3-22ED-42E1-97C9-D2CF501CAE40}';

  DIID__DFK328KM: TGUID = '{4B9A61F1-ACEE-4370-B433-CFBD6F1594FA}';
  DIID__DFK328KMEvents: TGUID = '{D6850C1A-36EC-4EAC-BF49-5B08AC6840E6}';
  CLASS_FK328KM: TGUID = '{819ECD5B-438B-4822-A526-1984C093CEC8}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  _DFK328KM = dispinterface;
  _DFK328KMEvents = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  FK328KM = _DFK328KM;


// *********************************************************************//
// Declaration of structures, unions and aliases.                         
// *********************************************************************//
  PInteger1 = ^Integer; {*}
  PWideString1 = ^WideString; {*}


// *********************************************************************//
// DispIntf:  _DFK328KM
// Flags:     (4112) Hidden Dispatchable
// GUID:      {4B9A61F1-ACEE-4370-B433-CFBD6F1594FA}
// *********************************************************************//
  _DFK328KM = dispinterface
    ['{4B9A61F1-ACEE-4370-B433-CFBD6F1594FA}']
    function DeleteEnrollData(dwMachineNumber: Integer; dwEnrollNumber: Integer; 
                              dwEMachineNumber: Integer; dwBackupNumber: Integer): WordBool; dispid 4;
    function ReadGeneralLogData(dwMachineNumber: Integer): WordBool; dispid 7;
    function ReadAllSLogData(dwMachineNumber: Integer): WordBool; dispid 6;
    function IsAllow(dwPrivilege: Integer; dwWhich: Integer): WordBool; dispid 3;
    function EnableDevice(dwMachineNumber: Integer; bFlag: WordBool): WordBool; dispid 10;
    function EnableUser(dwMachineNumber: Integer; dwEnrollNumber: Integer; 
                        dwEMachineNumber: Integer; dwBackupNumber: Integer; bFlag: WordBool): WordBool; dispid 9;
    function GetDeviceTime(dwMachineNumber: Integer; var dwYear: Integer; var dwMonth: Integer; 
                           var dwDay: Integer; var dwHour: Integer; var dwMinute: Integer; 
                           var dwDayOfWeek: Integer): WordBool; dispid 21;
    function GetDeviceStatus(dwMachineNumber: Integer; dwStatus: Integer; var dwValue: Integer): WordBool; dispid 11;
    function ReadAllGLogData(dwMachineNumber: Integer): WordBool; dispid 8;
    function ReadSuperLogData(dwMachineNumber: Integer): WordBool; dispid 5;
    function GetDeviceInfo(dwMachineNumber: Integer; dwInfo: Integer; var dwValue: Integer): WordBool; dispid 12;
    function SetDeviceInfo(dwMachineNumber: Integer; dwInfo: Integer; dwValue: Integer): WordBool; dispid 13;
    function SetDeviceTime(dwMachineNumber: Integer): WordBool; dispid 14;
    procedure PowerOnAllDevice; dispid 15;
    function PowerOffDevice(dwMachineNumber: Integer): WordBool; dispid 16;
    function ModifyPrivilege(dwMachineNumber: Integer; dwEnrollNumber: Integer; 
                             dwEMachineNumber: Integer; dwBackupNumber: Integer; 
                             dwMachinePrivilege: Integer): WordBool; dispid 17;
    procedure GetLastError(var dwErrorCode: Integer); dispid 18;
    function GetEnrollData(dwMachineNumber: Integer; dwEnrollNumber: Integer; 
                           dwEMachineNumber: Integer; dwBackupNumber: Integer; 
                           var dwMachinePrivilege: Integer; var dwEnrollData: Integer; 
                           var dwPassWord: Integer): WordBool; dispid 19;
    function SetEnrollData(dwMachineNumber: Integer; dwEnrollNumber: Integer; 
                           dwEMachineNumber: Integer; dwBackupNumber: Integer; 
                           dwMachinePrivilege: Integer; var dwEnrollData: Integer; 
                           dwPassWord: Integer): WordBool; dispid 20;
    function EmptySuperLogData(dwMachineNumber: Integer): WordBool; dispid 35;
    function GetGeneralLogData(dwMachineNumber: Integer; var dwTMachineNumber: Integer; 
                               var dwEnrollNumber: Integer; var dwEMachineNumber: Integer; 
                               var dwVerifyMode: Integer; var dwYear: Integer; 
                               var dwMonth: Integer; var dwDay: Integer; var dwHour: Integer; 
                               var dwMinute: Integer): WordBool; dispid 22;
    function GetSuperLogData(dwMachineNumber: Integer; var dwTMachineNumber: Integer; 
                             var dwSEnrollNumber: Integer; var dwSMachineNumber: Integer; 
                             var dwGEnrollNumber: Integer; var dwGMachineNumber: Integer; 
                             var dwManipulation: Integer; var dwBackupNumber: Integer; 
                             var dwYear: Integer; var dwMonth: Integer; var dwDay: Integer; 
                             var dwHour: Integer; var dwMinute: Integer): WordBool; dispid 23;
    procedure ConvertPassword(dwSrcPSW: Integer; var dwDestPSW: Integer; dwLength: Integer); dispid 26;
    function GetAllSLogData(dwMachineNumber: Integer; var dwTMachineNumber: Integer; 
                            var dwSEnrollNumber: Integer; var dwSMachineNumber: Integer; 
                            var dwGEnrollNumber: Integer; var dwGMachineNumber: Integer; 
                            var dwManipulation: Integer; var dwBackupNumber: Integer; 
                            var dwYear: Integer; var dwMonth: Integer; var dwDay: Integer; 
                            var dwHour: Integer; var dwMinute: Integer): WordBool; dispid 24;
    function ClearKeeperData(dwMachineNumber: Integer): WordBool; dispid 30;
    function ReadAllUserID(dwMachineNumber: Integer): WordBool; dispid 27;
    function GetAllUserID(dwMachineNumber: Integer; var dwEnrollNumber: Integer; 
                          var dwEMachineNumber: Integer; var dwBackupNumber: Integer; 
                          var dwMachinePrivilege: Integer; var dwEnable: Integer): WordBool; dispid 28;
    function GetBackupNumber(dwMachineNumber: Integer): Integer; dispid 31;
    function GetSerialNumber(dwMachineNumber: Integer; var dwSerialNumber: WideString): WordBool; dispid 29;
    function GetAllGLogData(dwMachineNumber: Integer; var dwTMachineNumber: Integer; 
                            var dwEnrollNumber: Integer; var dwEMachineNumber: Integer; 
                            var dwVerifyMode: Integer; var dwYear: Integer; var dwMonth: Integer; 
                            var dwDay: Integer; var dwHour: Integer; var dwMinute: Integer): WordBool; dispid 25;
    function GetProductCode(dwMachineNumber: Integer; var lpszProductCode: WideString): WordBool; dispid 32;
    function EmptyEnrollData(dwMachineNumber: Integer): WordBool; dispid 33;
    function SetIPAddress(var lpszIPAddress: WideString; dwPortNumber: Integer; dwPassWord: Integer): WordBool; dispid 36;
    function EmptyGeneralLogData(dwMachineNumber: Integer): WordBool; dispid 34;
    function SetBellTime(dwMachineNumber: Integer; dwValue: Integer; var dwBellInfo: Integer): WordBool; dispid 40;
    function OpenCommPort(dwMachineNumber: Integer): WordBool; dispid 37;
    procedure CloseCommPort; dispid 38;
    procedure AboutBox; dispid -552;
    function GetBellTime(dwMachineNumber: Integer; var dwValue: Integer; var dwBellInfo: Integer): WordBool; dispid 39;
    property ReadMark: WordBool dispid 2;
    property CommPort: Integer dispid 1;
  end;

// *********************************************************************//
// DispIntf:  _DFK328KMEvents
// Flags:     (4096) Dispatchable
// GUID:      {D6850C1A-36EC-4EAC-BF49-5B08AC6840E6}
// *********************************************************************//
  _DFK328KMEvents = dispinterface
    ['{D6850C1A-36EC-4EAC-BF49-5B08AC6840E6}']
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TFK328KM
// Help String      : FK328KM Control
// Default Interface: _DFK328KM
// Def. Intf. DISP? : Yes
// Event   Interface: _DFK328KMEvents
// TypeFlags        : (34) CanCreate Control
// *********************************************************************//
  TFK328KM = class(TOleControl)
  private
    FIntf: _DFK328KM;
    function  GetControlInterface: _DFK328KM;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    function DeleteEnrollData(dwMachineNumber: Integer; dwEnrollNumber: Integer; 
                              dwEMachineNumber: Integer; dwBackupNumber: Integer): WordBool;
    function ReadGeneralLogData(dwMachineNumber: Integer): WordBool;
    function ReadAllSLogData(dwMachineNumber: Integer): WordBool;
    function IsAllow(dwPrivilege: Integer; dwWhich: Integer): WordBool;
    function EnableDevice(dwMachineNumber: Integer; bFlag: WordBool): WordBool;
    function EnableUser(dwMachineNumber: Integer; dwEnrollNumber: Integer; 
                        dwEMachineNumber: Integer; dwBackupNumber: Integer; bFlag: WordBool): WordBool;
    function GetDeviceTime(dwMachineNumber: Integer; var dwYear: Integer; var dwMonth: Integer; 
                           var dwDay: Integer; var dwHour: Integer; var dwMinute: Integer; 
                           var dwDayOfWeek: Integer): WordBool;
    function GetDeviceStatus(dwMachineNumber: Integer; dwStatus: Integer; var dwValue: Integer): WordBool;
    function ReadAllGLogData(dwMachineNumber: Integer): WordBool;
    function ReadSuperLogData(dwMachineNumber: Integer): WordBool;
    function GetDeviceInfo(dwMachineNumber: Integer; dwInfo: Integer; var dwValue: Integer): WordBool;
    function SetDeviceInfo(dwMachineNumber: Integer; dwInfo: Integer; dwValue: Integer): WordBool;
    function SetDeviceTime(dwMachineNumber: Integer): WordBool;
    procedure PowerOnAllDevice;
    function PowerOffDevice(dwMachineNumber: Integer): WordBool;
    function ModifyPrivilege(dwMachineNumber: Integer; dwEnrollNumber: Integer; 
                             dwEMachineNumber: Integer; dwBackupNumber: Integer; 
                             dwMachinePrivilege: Integer): WordBool;
    procedure GetLastError(var dwErrorCode: Integer);
    function GetEnrollData(dwMachineNumber: Integer; dwEnrollNumber: Integer; 
                           dwEMachineNumber: Integer; dwBackupNumber: Integer; 
                           var dwMachinePrivilege: Integer; var dwEnrollData: Integer; 
                           var dwPassWord: Integer): WordBool;
    function SetEnrollData(dwMachineNumber: Integer; dwEnrollNumber: Integer; 
                           dwEMachineNumber: Integer; dwBackupNumber: Integer; 
                           dwMachinePrivilege: Integer; var dwEnrollData: Integer; 
                           dwPassWord: Integer): WordBool;
    function EmptySuperLogData(dwMachineNumber: Integer): WordBool;
    function GetGeneralLogData(dwMachineNumber: Integer; var dwTMachineNumber: Integer; 
                               var dwEnrollNumber: Integer; var dwEMachineNumber: Integer; 
                               var dwVerifyMode: Integer; var dwYear: Integer; 
                               var dwMonth: Integer; var dwDay: Integer; var dwHour: Integer; 
                               var dwMinute: Integer): WordBool;
    function GetSuperLogData(dwMachineNumber: Integer; var dwTMachineNumber: Integer; 
                             var dwSEnrollNumber: Integer; var dwSMachineNumber: Integer; 
                             var dwGEnrollNumber: Integer; var dwGMachineNumber: Integer; 
                             var dwManipulation: Integer; var dwBackupNumber: Integer; 
                             var dwYear: Integer; var dwMonth: Integer; var dwDay: Integer; 
                             var dwHour: Integer; var dwMinute: Integer): WordBool;
    procedure ConvertPassword(dwSrcPSW: Integer; var dwDestPSW: Integer; dwLength: Integer);
    function GetAllSLogData(dwMachineNumber: Integer; var dwTMachineNumber: Integer; 
                            var dwSEnrollNumber: Integer; var dwSMachineNumber: Integer; 
                            var dwGEnrollNumber: Integer; var dwGMachineNumber: Integer; 
                            var dwManipulation: Integer; var dwBackupNumber: Integer; 
                            var dwYear: Integer; var dwMonth: Integer; var dwDay: Integer; 
                            var dwHour: Integer; var dwMinute: Integer): WordBool;
    function ClearKeeperData(dwMachineNumber: Integer): WordBool;
    function ReadAllUserID(dwMachineNumber: Integer): WordBool;
    function GetAllUserID(dwMachineNumber: Integer; var dwEnrollNumber: Integer; 
                          var dwEMachineNumber: Integer; var dwBackupNumber: Integer; 
                          var dwMachinePrivilege: Integer; var dwEnable: Integer): WordBool;
    function GetBackupNumber(dwMachineNumber: Integer): Integer;
    function GetSerialNumber(dwMachineNumber: Integer; var dwSerialNumber: WideString): WordBool;
    function GetAllGLogData(dwMachineNumber: Integer; var dwTMachineNumber: Integer; 
                            var dwEnrollNumber: Integer; var dwEMachineNumber: Integer; 
                            var dwVerifyMode: Integer; var dwYear: Integer; var dwMonth: Integer; 
                            var dwDay: Integer; var dwHour: Integer; var dwMinute: Integer): WordBool;
    function GetProductCode(dwMachineNumber: Integer; var lpszProductCode: WideString): WordBool;
    function EmptyEnrollData(dwMachineNumber: Integer): WordBool;
    function SetIPAddress(var lpszIPAddress: WideString; dwPortNumber: Integer; dwPassWord: Integer): WordBool;
    function EmptyGeneralLogData(dwMachineNumber: Integer): WordBool;
    function SetBellTime(dwMachineNumber: Integer; dwValue: Integer; var dwBellInfo: Integer): WordBool;
    function OpenCommPort(dwMachineNumber: Integer): WordBool;
    procedure CloseCommPort;
    procedure AboutBox;
    function GetBellTime(dwMachineNumber: Integer; var dwValue: Integer; var dwBellInfo: Integer): WordBool;
    property  ControlInterface: _DFK328KM read GetControlInterface;
    property  DefaultInterface: _DFK328KM read GetControlInterface;
  published
    property Anchors;
    property  TabStop;
    property  Align;
    property  DragCursor;
    property  DragMode;
    property  ParentShowHint;
    property  PopupMenu;
    property  ShowHint;
    property  TabOrder;
    property  Visible;
    property  OnDragDrop;
    property  OnDragOver;
    property  OnEndDrag;
    property  OnEnter;
    property  OnExit;
    property  OnStartDrag;
    property ReadMark: WordBool index 2 read GetWordBoolProp write SetWordBoolProp stored False;
    property CommPort: Integer index 1 read GetIntegerProp write SetIntegerProp stored False;
  end;

procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

  dtlOcxPage = 'ActiveX';

implementation

uses ComObj;

procedure TFK328KM.InitControlData;
const
  CControlData: TControlData2 = (
    ClassID: '{819ECD5B-438B-4822-A526-1984C093CEC8}';
    EventIID: '';
    EventCount: 0;
    EventDispIDs: nil;
    LicenseKey: nil (*HR:$80004005*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
end;

procedure TFK328KM.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as _DFK328KM;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TFK328KM.GetControlInterface: _DFK328KM;
begin
  CreateControl;
  Result := FIntf;
end;

function TFK328KM.DeleteEnrollData(dwMachineNumber: Integer; dwEnrollNumber: Integer; 
                                   dwEMachineNumber: Integer; dwBackupNumber: Integer): WordBool;
begin
  Result := DefaultInterface.DeleteEnrollData(dwMachineNumber, dwEnrollNumber, dwEMachineNumber, 
                                              dwBackupNumber);
end;

function TFK328KM.ReadGeneralLogData(dwMachineNumber: Integer): WordBool;
begin
  Result := DefaultInterface.ReadGeneralLogData(dwMachineNumber);
end;

function TFK328KM.ReadAllSLogData(dwMachineNumber: Integer): WordBool;
begin
  Result := DefaultInterface.ReadAllSLogData(dwMachineNumber);
end;

function TFK328KM.IsAllow(dwPrivilege: Integer; dwWhich: Integer): WordBool;
begin
  Result := DefaultInterface.IsAllow(dwPrivilege, dwWhich);
end;

function TFK328KM.EnableDevice(dwMachineNumber: Integer; bFlag: WordBool): WordBool;
begin
  Result := DefaultInterface.EnableDevice(dwMachineNumber, bFlag);
end;

function TFK328KM.EnableUser(dwMachineNumber: Integer; dwEnrollNumber: Integer; 
                             dwEMachineNumber: Integer; dwBackupNumber: Integer; bFlag: WordBool): WordBool;
begin
  Result := DefaultInterface.EnableUser(dwMachineNumber, dwEnrollNumber, dwEMachineNumber, 
                                        dwBackupNumber, bFlag);
end;

function TFK328KM.GetDeviceTime(dwMachineNumber: Integer; var dwYear: Integer; 
                                var dwMonth: Integer; var dwDay: Integer; var dwHour: Integer; 
                                var dwMinute: Integer; var dwDayOfWeek: Integer): WordBool;
begin
  Result := DefaultInterface.GetDeviceTime(dwMachineNumber, dwYear, dwMonth, dwDay, dwHour, 
                                           dwMinute, dwDayOfWeek);
end;

function TFK328KM.GetDeviceStatus(dwMachineNumber: Integer; dwStatus: Integer; var dwValue: Integer): WordBool;
begin
  Result := DefaultInterface.GetDeviceStatus(dwMachineNumber, dwStatus, dwValue);
end;

function TFK328KM.ReadAllGLogData(dwMachineNumber: Integer): WordBool;
begin
  Result := DefaultInterface.ReadAllGLogData(dwMachineNumber);
end;

function TFK328KM.ReadSuperLogData(dwMachineNumber: Integer): WordBool;
begin
  Result := DefaultInterface.ReadSuperLogData(dwMachineNumber);
end;

function TFK328KM.GetDeviceInfo(dwMachineNumber: Integer; dwInfo: Integer; var dwValue: Integer): WordBool;
begin
  Result := DefaultInterface.GetDeviceInfo(dwMachineNumber, dwInfo, dwValue);
end;

function TFK328KM.SetDeviceInfo(dwMachineNumber: Integer; dwInfo: Integer; dwValue: Integer): WordBool;
begin
  Result := DefaultInterface.SetDeviceInfo(dwMachineNumber, dwInfo, dwValue);
end;

function TFK328KM.SetDeviceTime(dwMachineNumber: Integer): WordBool;
begin
  Result := DefaultInterface.SetDeviceTime(dwMachineNumber);
end;

procedure TFK328KM.PowerOnAllDevice;
begin
  DefaultInterface.PowerOnAllDevice;
end;

function TFK328KM.PowerOffDevice(dwMachineNumber: Integer): WordBool;
begin
  Result := DefaultInterface.PowerOffDevice(dwMachineNumber);
end;

function TFK328KM.ModifyPrivilege(dwMachineNumber: Integer; dwEnrollNumber: Integer; 
                                  dwEMachineNumber: Integer; dwBackupNumber: Integer; 
                                  dwMachinePrivilege: Integer): WordBool;
begin
  Result := DefaultInterface.ModifyPrivilege(dwMachineNumber, dwEnrollNumber, dwEMachineNumber, 
                                             dwBackupNumber, dwMachinePrivilege);
end;

procedure TFK328KM.GetLastError(var dwErrorCode: Integer);
begin
  DefaultInterface.GetLastError(dwErrorCode);
end;

function TFK328KM.GetEnrollData(dwMachineNumber: Integer; dwEnrollNumber: Integer; 
                                dwEMachineNumber: Integer; dwBackupNumber: Integer; 
                                var dwMachinePrivilege: Integer; var dwEnrollData: Integer; 
                                var dwPassWord: Integer): WordBool;
begin
  Result := DefaultInterface.GetEnrollData(dwMachineNumber, dwEnrollNumber, dwEMachineNumber, 
                                           dwBackupNumber, dwMachinePrivilege, dwEnrollData, 
                                           dwPassWord);
end;

function TFK328KM.SetEnrollData(dwMachineNumber: Integer; dwEnrollNumber: Integer; 
                                dwEMachineNumber: Integer; dwBackupNumber: Integer; 
                                dwMachinePrivilege: Integer; var dwEnrollData: Integer; 
                                dwPassWord: Integer): WordBool;
begin
  Result := DefaultInterface.SetEnrollData(dwMachineNumber, dwEnrollNumber, dwEMachineNumber, 
                                           dwBackupNumber, dwMachinePrivilege, dwEnrollData, 
                                           dwPassWord);
end;

function TFK328KM.EmptySuperLogData(dwMachineNumber: Integer): WordBool;
begin
  Result := DefaultInterface.EmptySuperLogData(dwMachineNumber);
end;

function TFK328KM.GetGeneralLogData(dwMachineNumber: Integer; var dwTMachineNumber: Integer; 
                                    var dwEnrollNumber: Integer; var dwEMachineNumber: Integer; 
                                    var dwVerifyMode: Integer; var dwYear: Integer; 
                                    var dwMonth: Integer; var dwDay: Integer; var dwHour: Integer; 
                                    var dwMinute: Integer): WordBool;
begin
  Result := DefaultInterface.GetGeneralLogData(dwMachineNumber, dwTMachineNumber, dwEnrollNumber, 
                                               dwEMachineNumber, dwVerifyMode, dwYear, dwMonth, 
                                               dwDay, dwHour, dwMinute);
end;

function TFK328KM.GetSuperLogData(dwMachineNumber: Integer; var dwTMachineNumber: Integer; 
                                  var dwSEnrollNumber: Integer; var dwSMachineNumber: Integer; 
                                  var dwGEnrollNumber: Integer; var dwGMachineNumber: Integer; 
                                  var dwManipulation: Integer; var dwBackupNumber: Integer; 
                                  var dwYear: Integer; var dwMonth: Integer; var dwDay: Integer; 
                                  var dwHour: Integer; var dwMinute: Integer): WordBool;
begin
  Result := DefaultInterface.GetSuperLogData(dwMachineNumber, dwTMachineNumber, dwSEnrollNumber, 
                                             dwSMachineNumber, dwGEnrollNumber, dwGMachineNumber, 
                                             dwManipulation, dwBackupNumber, dwYear, dwMonth, 
                                             dwDay, dwHour, dwMinute);
end;

procedure TFK328KM.ConvertPassword(dwSrcPSW: Integer; var dwDestPSW: Integer; dwLength: Integer);
begin
  DefaultInterface.ConvertPassword(dwSrcPSW, dwDestPSW, dwLength);
end;

function TFK328KM.GetAllSLogData(dwMachineNumber: Integer; var dwTMachineNumber: Integer; 
                                 var dwSEnrollNumber: Integer; var dwSMachineNumber: Integer; 
                                 var dwGEnrollNumber: Integer; var dwGMachineNumber: Integer; 
                                 var dwManipulation: Integer; var dwBackupNumber: Integer; 
                                 var dwYear: Integer; var dwMonth: Integer; var dwDay: Integer; 
                                 var dwHour: Integer; var dwMinute: Integer): WordBool;
begin
  Result := DefaultInterface.GetAllSLogData(dwMachineNumber, dwTMachineNumber, dwSEnrollNumber, 
                                            dwSMachineNumber, dwGEnrollNumber, dwGMachineNumber, 
                                            dwManipulation, dwBackupNumber, dwYear, dwMonth, dwDay, 
                                            dwHour, dwMinute);
end;

function TFK328KM.ClearKeeperData(dwMachineNumber: Integer): WordBool;
begin
  Result := DefaultInterface.ClearKeeperData(dwMachineNumber);
end;

function TFK328KM.ReadAllUserID(dwMachineNumber: Integer): WordBool;
begin
  Result := DefaultInterface.ReadAllUserID(dwMachineNumber);
end;

function TFK328KM.GetAllUserID(dwMachineNumber: Integer; var dwEnrollNumber: Integer; 
                               var dwEMachineNumber: Integer; var dwBackupNumber: Integer; 
                               var dwMachinePrivilege: Integer; var dwEnable: Integer): WordBool;
begin
  Result := DefaultInterface.GetAllUserID(dwMachineNumber, dwEnrollNumber, dwEMachineNumber, 
                                          dwBackupNumber, dwMachinePrivilege, dwEnable);
end;

function TFK328KM.GetBackupNumber(dwMachineNumber: Integer): Integer;
begin
  Result := DefaultInterface.GetBackupNumber(dwMachineNumber);
end;

function TFK328KM.GetSerialNumber(dwMachineNumber: Integer; var dwSerialNumber: WideString): WordBool;
begin
  Result := DefaultInterface.GetSerialNumber(dwMachineNumber, dwSerialNumber);
end;

function TFK328KM.GetAllGLogData(dwMachineNumber: Integer; var dwTMachineNumber: Integer; 
                                 var dwEnrollNumber: Integer; var dwEMachineNumber: Integer; 
                                 var dwVerifyMode: Integer; var dwYear: Integer; 
                                 var dwMonth: Integer; var dwDay: Integer; var dwHour: Integer; 
                                 var dwMinute: Integer): WordBool;
begin
  Result := DefaultInterface.GetAllGLogData(dwMachineNumber, dwTMachineNumber, dwEnrollNumber, 
                                            dwEMachineNumber, dwVerifyMode, dwYear, dwMonth, dwDay, 
                                            dwHour, dwMinute);
end;

function TFK328KM.GetProductCode(dwMachineNumber: Integer; var lpszProductCode: WideString): WordBool;
begin
  Result := DefaultInterface.GetProductCode(dwMachineNumber, lpszProductCode);
end;

function TFK328KM.EmptyEnrollData(dwMachineNumber: Integer): WordBool;
begin
  Result := DefaultInterface.EmptyEnrollData(dwMachineNumber);
end;

function TFK328KM.SetIPAddress(var lpszIPAddress: WideString; dwPortNumber: Integer; 
                               dwPassWord: Integer): WordBool;
begin
  Result := DefaultInterface.SetIPAddress(lpszIPAddress, dwPortNumber, dwPassWord);
end;

function TFK328KM.EmptyGeneralLogData(dwMachineNumber: Integer): WordBool;
begin
  Result := DefaultInterface.EmptyGeneralLogData(dwMachineNumber);
end;

function TFK328KM.SetBellTime(dwMachineNumber: Integer; dwValue: Integer; var dwBellInfo: Integer): WordBool;
begin
  Result := DefaultInterface.SetBellTime(dwMachineNumber, dwValue, dwBellInfo);
end;

function TFK328KM.OpenCommPort(dwMachineNumber: Integer): WordBool;
begin
  Result := DefaultInterface.OpenCommPort(dwMachineNumber);
end;

procedure TFK328KM.CloseCommPort;
begin
  DefaultInterface.CloseCommPort;
end;

procedure TFK328KM.AboutBox;
begin
  DefaultInterface.AboutBox;
end;

function TFK328KM.GetBellTime(dwMachineNumber: Integer; var dwValue: Integer; 
                              var dwBellInfo: Integer): WordBool;
begin
  Result := DefaultInterface.GetBellTime(dwMachineNumber, dwValue, dwBellInfo);
end;

procedure Register;
begin
  RegisterComponents(dtlOcxPage, [TFK328KM]);
end;

end.
