unit khProgressFrom;
//����cnPack��cnProgressFrm

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
{* ��ʾ���������壬����Ϊ��������Լ����ֵ��Ĭ�� 100���ٷֱ���ʽ�������Զ��������ֵ}
procedure HideProgress;
{* �رս���������}
procedure UpdateProgress(Value: Integer);
{* ���µ�ǰ���ȣ�����Ϊ����ֵ���� Max Ϊ 100 ʱ�ɽ��ܷ�ΧΪ 0..100����ʱ Value ����ٷֱ�}
procedure UpdateProgressTitle(const Title: string);
{* ���½�����������⣬����Ϊ����}
procedure UpdateProgressMax(Value: Integer);
{* ���½��������ֵ������Ϊ�µ����ֵ}

implementation

{$R *.DFM}

var
  ProgressForm: TProgressForm = nil;  // ����������ʵ��
  FormList: Pointer;   // �����õĴ����б�ָ��

// ��ʾ����
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

  // xierenxixi �޸�
  FormList := DisableTaskWindows(ProgressForm.Handle);
  ProgressForm.Update;
end;

// �رմ���
procedure HideProgress;
begin
  if not Assigned(ProgressForm) then Exit;

  // xierenxixi �޸�
  EnableTaskWindows(FormList);
  
  ProgressForm.Hide;
  Application.ProcessMessages;
  ProgressForm.Free;
  ProgressForm := nil;
end;

// ���½���
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

// ���±���
procedure UpdateProgressTitle(const Title: string);
begin
  if Assigned(ProgressForm) then
  begin
    ProgressForm.lblTitle.Caption := Title;
    ProgressForm.Update;
    Application.ProcessMessages;
  end;
end;

// ���½��������ֵ
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
