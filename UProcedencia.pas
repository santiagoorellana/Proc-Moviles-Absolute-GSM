unit UProcedencia;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ActnList, jpeg, ExtCtrls, ImgList;

type
  TFProcedencia = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ActionList1: TActionList;
    ActionSalir: TAction;
    Label6: TLabel;
    Label7: TLabel;
    procedure ActionSalirExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FProcedencia: TFProcedencia;

implementation

{$R *.dfm}

procedure TFProcedencia.ActionSalirExecute(Sender: TObject);
begin
Close;
end;

end.
