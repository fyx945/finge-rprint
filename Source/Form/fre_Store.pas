unit fre_Store;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, RzCmboBx, RzPanel, ExtCtrls, StrUtils, siComp;

type
  TfreStroe = class(TFrame)
    RzToolbar1: TRzToolbar;
    Label1: TLabel;
    RzSpacer1: TRzSpacer;
    Label2: TLabel;
    RzSpacer2: TRzSpacer;
    RzSpacer3: TRzSpacer;
    RzSpacer4: TRzSpacer;
    cb_AreaCode: TRzComboBox;
    cb_StoreCode: TRzComboBox;
    slngFreStore: TsiLang;
    procedure cb_AreaCodeChange(Sender: TObject);
    procedure cb_StoreCodeChange(Sender: TObject);
  private
    FAreaCode: String;
    FStroeCode: String;
  public
    //----------------------------------------//Effect: 显示地区信息
    //Author: JackyZhou at 2008-02-28         //Remark:
    procedure ShowAreaMas();
    procedure ShowStoreMas(AreaCode: String);
  published
    property AreaCode: string read FAreaCode;
    property StoreCode: string read FStroeCode;
  end;

implementation
uses
  unt_Control, unt_Staff, dm_Main;

{$R *.dfm}

{ TfreStroe }

procedure TfreStroe.ShowAreaMas;
begin
  cb_AreaCode.Items.Clear;
  cb_AreaCode.Items := Staff.LoadAreaMas(Control.Language);
end;

procedure TfreStroe.ShowStoreMas(AreaCode: String);
begin
  cb_StoreCode.Items.Clear;
  cb_StoreCode.Items := Staff.LoadStoreMas(AreaCode, Control.Language);
end;

procedure TfreStroe.cb_AreaCodeChange(Sender: TObject);
var
  AreaCode: String;
  iPos: Integer;
begin
  AreaCode := TRzComboBox(Sender).Text;
  iPos := Pos('-', AreaCode);
  FAreaCode := LeftStr(AreaCode, iPos -1);
  ShowStoreMas(FAreaCode);
end;

procedure TfreStroe.cb_StoreCodeChange(Sender: TObject);
var
  StoreCode: String;
  iPos: Integer;
begin
  StoreCode := TRzComboBox(Sender).Text;
  iPos := Pos('-', StoreCode);
  FStroeCode := LeftStr(StoreCode, iPos -1);
end;

end.
