unit UBuscar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ActnList;

type
  TFBuscar = class(TForm)
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ActionList1: TActionList;
    ActionCancelar: TAction;
    ActionBuscar: TAction;
    BitBtn3: TBitBtn;
    ActionAyuda: TAction;
    procedure ActionCancelarExecute(Sender: TObject);
    procedure ActionBuscarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ActionAyudaExecute(Sender: TObject);
  private
    Inicio: Integer;
  public
    { Public declarations }
  end;

var
  FBuscar: TFBuscar;

implementation

uses UPrincipal, Grids;

{$R *.dfm}

//-----------------------------------------------------------------------------
// Inicia el formulario.
//-----------------------------------------------------------------------------
procedure TFBuscar.FormCreate(Sender: TObject);
var Seleccionado: TGridRect;
begin
//Declara el inicio de las búsquedas.
Inicio := 1;

//Desselecciona la tabla haciendo inválida la selección.
Seleccionado.Left := -1;
Seleccionado.Top := -1;
Seleccionado.Right := -1;
Seleccionado.Bottom := -1;
FPrincipal.TablaBD.Selection := Seleccionado;
end;

//-----------------------------------------------------------------------------
// Cancela la búsqueda.
//-----------------------------------------------------------------------------
procedure TFBuscar.ActionCancelarExecute(Sender: TObject);
begin
Close;
end;

//-----------------------------------------------------------------------------
// Muestra la ayuda de esta ventana.
//-----------------------------------------------------------------------------
procedure TFBuscar.ActionAyudaExecute(Sender: TObject);
var msg: String;
begin
msg :=       'Búsqueda de cadenas de texto en la base de Datos.' + #13#13;
msg := msg + 'Utilice esta herramienta para buscar las ocurrencias de una' + #13;
msg := msg + 'cadena de texto en los datos de la Base de Datos. Solo debe' + #13;
msg := msg + 'introducir el texto completo o un fragmento del mismo y ' + #13;
msg := msg + 'pulsar el botón "Buscar".' + #13#13;
msg := msg + 'Si se encuentra una ocurrencia de la cadena en un registro' + #13;
msg := msg + 'de la Base de Datos, este será mostrado en la tabla de la' + #13;
msg := msg + 'ventana principal con un color distinto para resaltarlo.' + #13#13;
msg := msg + 'Para continuar buscando las siguientes coincidencias de' + #13;
msg := msg + 'la misma cadena en el resto de los registros, se debe' + #13;
msg := msg + 'pulsar nuevamente el botón "Buscar".';
Application.MessageBox(PChar(msg), 'Ayuda', MB_OK);
end;

//-----------------------------------------------------------------------------
// Inicia la búsqueda.
//-----------------------------------------------------------------------------
procedure TFBuscar.ActionBuscarExecute(Sender: TObject);
var n: Integer;
    Fila, msg, tit: String;
    Seleccionado: TGridRect;
    Cerrar: Boolean;
begin
if Edit1.Text = '' then
   begin
   tit := 'Faltan parámetros...';
   msg := 'Debe insertar una cadena de texto para iniciar la búsqueda.';
   Application.MessageBox(PChar(msg), PChar(tit), MB_OK);
   Exit;
   end;
Cerrar := False;
Seleccionado.Left := 0;
Seleccionado.Right := 6;
with FPrincipal.TablaBD do                               //Se busca en la tabla del formulario principal.
     if RowCount > 0 then                                //La búsqueda continúa si hay registros.
        for n := Inicio to RowCount - 1 do               //Busca en cada registro a partir de la posición de inicio de la búsqueda.
            begin
            if (Pos(Edit1.Text, Cells[0, n]) > 0) or     //Si encuentra la cadena dentro del registro:
               (Pos(Edit1.Text, Cells[1, n]) > 0) or
               (Pos(Edit1.Text, Cells[2, n]) > 0) or
               (Pos(Edit1.Text, Cells[3, n]) > 0) or
               (Pos(Edit1.Text, Cells[4, n]) > 0) or
               (Pos(Edit1.Text, Cells[5, n]) > 0) or
               (Pos(Edit1.Text, Cells[6, n]) > 0) then
               begin
               Seleccionado.Top := n;                    //Establece el rango de la selección
               Seleccionado.Bottom := n;                 //para seleccionar un solo registro.
               Selection := Seleccionado;                //Selecciona el registro que contiene la cadena.
               TopRow := n;
               Inicio := n + 1;                          //Guarda la posición de partida para la repetición de la búsqueda.
               Break;                                    //Sale de este ciclo de búsqueda.
               end
            else
               if n = RowCount - 1 then
                  begin
                  tit := 'Resultado de búsqueda';
                  if Inicio = 1 then
                     msg := 'No se encontraron coincidencias.'
                  else
                     msg := 'No se encuentran más coincidencias.';
                  Application.MessageBox(PChar(msg), PChar(tit), MB_OK);
                  Cerrar := True;
                  Break;
                  end;

            Application.ProcessMessages;                          //Procesamos los mensajes de windows.
            if GetKeyState(VK_Escape) and 128 = 128 then break;   //Si se pulsa la tecla ESC, se termina la búsqueda.
            end;
if Cerrar then Close;
end;



end.

