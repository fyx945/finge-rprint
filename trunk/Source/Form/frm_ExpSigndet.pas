unit frm_ExpSigndet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, GridsEh, DBGridEh, StdCtrls, DB, DBGridEhImpExp, siComp,
  DBGridEhGrouping;

type
  TFormExpSigndet = class(TForm)
    pnlTopButtons: TPanel;
    pnlContent: TPanel;
    btnExp: TButton;
    dbgSigndet: TDBGridEh;
    btnSearch: TButton;
    dsSigndet: TDataSource;
    dlgSaveSigndet: TSaveDialog;
    slngExpSigndet: TsiLang;
    procedure btnSearchClick(Sender: TObject);
    procedure btnExpClick(Sender: TObject);
  private
    { Private declarations }
    dataSetSigndet : TDataSet;
  public
    { Public declarations }
  end;

var
  FormExpSigndet: TFormExpSigndet;

implementation

{$R *.dfm}

uses
  dm_Local_old;

procedure TFormExpSigndet.btnExpClick(Sender: TObject);
var
  fileName : String;
  ExpClass:TDBGridEhExportClass;
begin
  if dataSetSigndet = nil then
  begin
    ShowMessage(slngExpSigndet.GetText('PLEASE_QUERY'));
    Exit;
  end;

  if dataSetSigndet.RecordCount <= 0 then
  begin
    ShowMessage(slngExpSigndet.GetText('HAVENOT_SIGNDET'));
    Exit;
  end;

  dlgSaveSigndet.FileName := 'signdet-' + Formatdatetime('yyyymmddhhnnss',Now());
  if dlgSaveSigndet.Execute then
    fileName := dlgSaveSigndet.FileName;

  if fileName <> '' then
  begin
    try
      self.pnlTopButtons.Enabled := false;
      try
        ExpClass := TDBGridEhExportAsCSV;
        SaveDBGridEhToExportFile(ExpClass,dbgSigndet,fileName,True);
        dmLocal_old.UpdateUploadData(dbgSigndet.DataSource.DataSet,Now());
        ShowMessage(slngExpSigndet.GetText('EXPORT_SUCCESS'));
      except
        ShowMessage(slngExpSigndet.GetText('EXPORT_FAILED'));
      end;
    finally
      self.pnlTopButtons.Enabled := true;
    end;
  end;
end;

procedure TFormExpSigndet.btnSearchClick(Sender: TObject);
begin
  dataSetSigndet := dmLocal_old.GetUploadData;
  dsSigndet.DataSet := dataSetSigndet;
  self.dbgSigndet.DataSource := Self.dsSigndet;
end;

end.
