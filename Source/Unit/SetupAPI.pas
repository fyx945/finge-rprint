unit SetupAPI;

interface

uses
  Windows;

const
  DIGCF_PRESENT = $0002;
  DIGCF_ALLCLASSES = $0004;
  SPDRP_DEVICEDESC = 0;

  DIF_PROPERTYCHANGE = 18;

  DICS_ENABLE = 1;
  DICS_FLAG_GLOBAL = 1;
  DICS_DISABLE = 2;

type
  HDEVINFO = type Cardinal;
  DI_FUNCTION = type Cardinal;
  
  PSP_DEVINFO_DATA = ^SP_DEVINFO_DATA;
  SP_DEVINFO_DATA = record
    cbSize: DWORD;
    ClassGuid: TGUID;
    DevInst: DWORD;
    Reserved: Longint;
  end;

  PSP_CLASSINSTALL_HEADER = ^SP_CLASSINSTALL_HEADER;
  SP_CLASSINSTALL_HEADER = record
    cbSize: DWORD;
    InstallFunction: DI_FUNCTION; 
  end;

  PSP_PROPCHANGE_PARAMS = ^SP_PROPCHANGE_PARAMS;
  SP_PROPCHANGE_PARAMS = record
    ClassInstallHeader: SP_CLASSINSTALL_HEADER;
    StateChange: DWORD;
    Scope: DWORD;
    HwProfile: DWORD;
  end;

  PSP_CLASSIMAGELIST_DATA = ^SP_CLASSIMAGELIST_DATA;
  SP_CLASSIMAGELIST_DATA = record
    cbSize: DWORD;
    ImageList: HWND;
    Reserved: DWORD;
  end;

function SetupDiGetClassDevs(const ClassGuid: PGUID; Enumerator: PChar;
  hwndParent: HWND; Flags: DWORD): HDEVINFO; stdcall;
  external 'Setupapi.dll' name 'SetupDiGetClassDevsA';

function SetupDiEnumDeviceInfo(DeviceInfoSet: HDEVINFO; MemberIndex: DWORD;
  DeviceInfoData: PSP_DEVINFO_DATA): BOOL; stdcall;
  external 'Setupapi.dll' name 'SetupDiEnumDeviceInfo';

function SetupDiGetDeviceRegistryProperty(DeviceInfoSet: HDEVINFO;
  DeviceInfoData: PSP_DEVINFO_DATA; Propertys: DWORD; PropertyRegDataType: PWORD;
  PropertyBuffer: PByte; PropertyBufferSize: DWORD; RequiredSize: PWORD): BOOL; stdcall;
  external 'Setupapi.dll' name 'SetupDiGetDeviceRegistryPropertyA';

function SetupDiDestroyDeviceInfoList(DeviceInfoSet: HDEVINFO): BOOL; stdcall;
  external 'Setupapi.dll' name 'SetupDiDestroyDeviceInfoList';

function SetupDiClassNameFromGuid(ClassGuid: PGUID; ClassName: PChar;
  ClassNameSize: DWORD; RequiredSize: PDWORD): BOOL; stdcall;
  external 'Setupapi.dll' name 'SetupDiClassNameFromGuidA';

function SetupDiSetClassInstallParams(DeviceInfoSet: HDEVINFO ;
  DeviceInfoData: PSP_DEVINFO_DATA; ClassInstallParams: PSP_CLASSINSTALL_HEADER;
  ClassInstallParamsSize: DWORD): BOOL stdcall;
  external 'Setupapi.dll' name 'SetupDiSetClassInstallParamsA';

function SetupDiCallClassInstaller(InstallFunction: DI_FUNCTION;
  DeviceInfoSet: HDEVINFO; DeviceInfoData: PSP_DEVINFO_DATA): BOOL; stdcall;
  external 'Setupapi.dll' name 'SetupDiCallClassInstaller';

function SetupDiGetClassImageList(ClassImageListData: PSP_CLASSIMAGELIST_DATA): BOOL;
  stdcall; external 'Setupapi.dll' name 'SetupDiGetClassImageList';

function SetupDiDestroyClassImageList(ClassImageListData: PSP_CLASSIMAGELIST_DATA):
  BOOL; stdcall; external 'Setupapi.dll' name 'SetupDiDestroyClassImageList';

function SetupDiGetClassImageIndex(ClassImageListData: PSP_CLASSIMAGELIST_DATA;
  ClassGuid: PGUID; ImageIndex: PINT): BOOL; stdcall;
  external 'Setupapi.dll' name 'SetupDiGetClassImageIndex';

implementation

end.
