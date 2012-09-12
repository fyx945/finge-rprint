unit kuControlDevice;

interface

uses
  Windows, SysUtils;

type
  TDeviceName = String;       //定义设备的GUID
  const
    DN_URU4000  = '{53D29EF7-377C-4D14-864B-EB3A85769359}';

type
  TDeviceStatus = Byte;
  const
    DS_ENABLE = 1;
    DS_DISABLE = 2;

type
  TKControlDevice = class
  private

  protected
    function ControlDevice(DeviceName :TDeviceName; DeviceStatus: TDeviceStatus): Boolean;
    function ChangeDeviceState(hDevInfo: Cardinal; NewStatus: DWORD; SelectedItem: DWORD): Boolean;
  public
    function EnableDevice(DeviceName :TDeviceName): Boolean;
    function DisableDevice(DeviceName :TDeviceName): Boolean;
  end;

implementation

uses
  SetupAPI;

{ TKControlDevice }

function TKControlDevice.ControlDevice(DeviceName :TDeviceName; DeviceStatus: TDeviceStatus): Boolean;
var
  Guid: TGUID ;
  GUIDString: string;
  hDevInfo: Cardinal;
  i: DWORD;
  DeviceInfo: SP_DEVINFO_DATA;
begin
  Result := False;
  if (DeviceStatus = -1) then Exit;

  ZeroMemory(@Guid, sizeof(TGUID));
  Guid := StringToGUID(DeviceName);

  hDevInfo := SetupDiGetClassDevs(@Guid, nil, HWND(nil), DIGCF_PRESENT);
  if (hDevInfo = INVALID_HANDLE_VALUE) then Exit;

  ZeroMemory(@DeviceInfo, SizeOf(SP_DEVINFO_DATA));
  DeviceInfo.cbSize := SizeOf(SP_DEVINFO_DATA);

  i := 0;
  while SetupDiEnumDeviceInfo(hDevInfo, i, @DeviceInfo) do
  begin
    Result := ChangeDeviceState(hDevInfo, DeviceStatus, i);
    Inc(i);
  end;

  SetupDiDestroyDeviceInfoList(hDevInfo);
end;

function TKControlDevice.ChangeDeviceState(hDevInfo: Cardinal; NewStatus, SelectedItem: DWORD): Boolean;
var
  PropChangeParams: SP_PROPCHANGE_PARAMS;
  DeviceInfoData: SP_DEVINFO_DATA;
begin
  Result := False;

  DeviceInfoData.cbSize := SizeOf(SP_DEVINFO_DATA);
  if not SetupDiEnumDeviceInfo(hDevInfo, SelectedItem, @DeviceInfoData) then Exit;

  // Set the PropChangeParams structure.
  PropChangeParams.ClassInstallHeader.cbSize := SizeOf(SP_CLASSINSTALL_HEADER);
  PropChangeParams.ClassInstallHeader.InstallFunction := DIF_PROPERTYCHANGE;
  PropChangeParams.Scope := DICS_FLAG_GLOBAL;
  PropChangeParams.StateChange := NewStatus;

  if not SetupDiSetClassInstallParams(hDevInfo, @DeviceInfoData,
    PSP_CLASSINSTALL_HEADER(@PropChangeParams), SizeOf(PropChangeParams)) then
    Exit;

  // Call the ClassInstaller and perform the change.
  if not SetupDiCallClassInstaller(DIF_PROPERTYCHANGE, hDevInfo,
    @DeviceInfoData) then
    Exit;

  Result := True;
end;

//======================================== public ========================================//
function TKControlDevice.EnableDevice(DeviceName :TDeviceName): Boolean;
begin
  Result := ControlDevice(DeviceName, DS_ENABLE);
end;

function TKControlDevice.DisableDevice(DeviceName :TDeviceName): Boolean;
begin
  Result := ControlDevice(DeviceName, DS_DISABLE);
end;         

end.
