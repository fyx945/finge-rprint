unit khProgressFrom;
//引用cnPack的cnProgressFrm

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls, ComCtrls;

type

{ TProgressForm }

  TProgressForm = class(TForm)
    SpeedButton1: TSpeedButton;
    lblTitle: TLabel;
    ProgressBar: TProgressBar;
    lab_Msg: TLabel;
  private
    { Private declarations }
    FPerLabel: TLabel;
  public
    { Public declarations }
    procedure DoCreate; override;

  end;

procedure ShowProgress(Title: string; const Msg: string= ''; AMax: Integer = 100);
{* 显示进度条窗体，参数为窗体标题以及最大值，默认 100（百分比形式），可自定义成其他值}
procedure HideProgress;
{* 关闭进度条窗体}
procedure UpdateProgress(Value: Integer);
{* 更新当前进度，参数为进度值：当 Max 为 100 时可接受范围为 0..100，此时 Value 代表百分比}
procedure UpdateProgressTitle(const Title: string);
{* 更新进度条窗体标题，参数为标题}
procedure UpdateProgressMax(Value: Integer);
{* 更新进度条最大值，参数为新的最大值}

implementation

{$R *.DFM}

var
  ProgressForm: TProgressForm = nil;  // 进度条窗体实例
  FormList: Pointer;   // 被禁用的窗体列表指针

// 显示窗体
procedure ShowProgress(Title: string; const Msg: string= ''; AMax: Integer = 100);
begin
  if not Assigned(ProgressForm) then
    ProgressForm := TProgressForm.Create(Application.MainForm)
  else
    ProgressForm.BringToFront;
  ProgressForm.lblTitle.Caption := Title;
  if Msg <> '' then      
    ProgressForm.lab_Msg.Caption := Msg;
  ProgressForm.ProgressBar.Max := AMax;         
  ProgressForm.Show;

  // xierenxixi 修改
  FormList := DisableTaskWindows(ProgressForm.Handle);
  ProgressForm.Update;
end;

// 关闭窗体
procedure HideProgress;
begin
  if not Assigned(ProgressForm) then Exit;

  // xierenxixi 修改
  EnableTaskWindows(FormList);
  
  ProgressForm.Hide;
  Application.ProcessMessages;
  ProgressForm.Free;
  ProgressForm := nil;
end;

// 更新进度
procedure UpdateProgress(Value: Integer);
begin
  if Assigned(ProgressForm) then
  begin
    ProgressForm.ProgressBar.Position := Value;
    ProgressForm.FPerLabel.Caption := Format('%-3d%%', [Round(Value/ProgressForm.ProgressBar.Max * 100)]);
    ProgressForm.Update;
    Application.ProcessMessages;
  end;
end;

// 更新标题
procedure UpdateProgressTitle(const Title: string);
begin
  if Assigned(ProgressForm) then
  begin
    ProgressForm.lblTitle.Caption := Title;
    ProgressForm.Update;
    Application.ProcessMessages;
  end;
end;

// 更新进度条最大值
procedure UpdateProgressMax(Value: Integer);
begin
  if Assigned(ProgressForm) then
  begin
    ProgressForm.ProgressBar.Max:=Value;
    ProgressForm.Update;
    Application.ProcessMessages;
  end;
end;

{ TProgressForm }

procedure TProgressForm.DoCreate;
begin
  inherited;
  FPerLabel := TLabel.Create(Self);
  FPerLabel.Caption := '    '; // 100%
  FPerLabel.Parent := lab_Msg.Parent;
  FPerLabel.Top := lab_Msg.Top;
  FPerLabel.Left := ProgressBar.Left + ProgressBar.Width - FPerLabel.Width;
end;

end.
