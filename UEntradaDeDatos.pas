
///////////////////////////////////////////////////////////////////////////////
// Autor:  Santiago Alejandro Orellana P�rez
//
// Fecha: 27/10/2013
///////////////////////////////////////////////////////////////////////////////

unit UEntradaDeDatos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ComCtrls, ValEdit, ActnList, StdCtrls, Buttons, ImgList, UBase;

type
  TFEntradaDeDatos = class(TForm)
    ActionList1: TActionList;
    ActionPegar: TAction;
    ActionAgregar: TAction;
    ActionCancelar: TAction;
    ActionBorrar: TAction;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    ActionAyuda: TAction;
    BitBtn5: TBitBtn;
    Tabla: TStringGrid;
    procedure ActionPegarExecute(Sender: TObject);
    procedure ActionAgregarExecute(Sender: TObject);
    procedure ActionCancelarExecute(Sender: TObject);
    procedure ActionBorrarExecute(Sender: TObject);
    procedure ActionAyudaExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public
    procedure BorrarTabla;
  end;

var
  FEntradaDeDatos: TFEntradaDeDatos;

implementation

uses UPrincipal, UBuscar;


{$R *.dfm}

//-----------------------------------------------------------------------------
// Este m�todo inicia la tabla de inserci�n de datos.
//-----------------------------------------------------------------------------
procedure TFEntradaDeDatos.FormCreate(Sender: TObject);
begin
Tabla.RowCount := 2;                 //Crea dos filas en la tabla.
Tabla.Cells[0, 0] := 'DATE';         //Utiliza la primera fila para poner
Tabla.Cells[1, 0] := 'MSISDN';       //los t�tulos de los campos de la tabla.
Tabla.Cells[2, 0] := 'CGI';
Tabla.Cells[3, 0] := 'CELLID';
Tabla.Cells[4, 0] := 'CELL';
Tabla.Cells[5, 0] := 'ERROR';
Tabla.Cells[6, 0] := 'AGE';
end;

//-----------------------------------------------------------------------------
// Esta funci�n busca dentro de una cadena y sustituye todas las
// ocurrencias de una subcadena determinada por otra.
//-----------------------------------------------------------------------------
function Sustituir(Entrada, LoqueSeBusca, Sustituto: String): String;
var aPos: Integer;
begin
aPos := Pos(LoqueSeBusca, Entrada);
Result:= '';
while aPos <> 0 do
      begin
      Result := Result + Copy(Entrada, 1, aPos-1) + Sustituto;
      Delete(Entrada, 1, aPos + Length(LoqueSeBusca)-1);
      aPos := Pos(LoqueSeBusca, Entrada);
      end;
Result := Result + Entrada;
end;

//-----------------------------------------------------------------------------
// Borra la informaci�n de la tabla y la llena con los datos
// que se encuentran en el ClipBoard.
// 
// Esta funci�n transfiere una tabla copiada en el ClipBoard
// de Windows a un String Grid. La tabla puede ser copiada
// desde Exel, Word e Internet Explorer.
//-----------------------------------------------------------------------------
procedure TFEntradaDeDatos.ActionPegarExecute(Sender: TObject);
const FinDeColumna = #09;
const FinDeFila = #10;
var Actual, Longitud, X, Y: Integer;
    Cadena: String;
    Memo: TMemo;
begin
Memo := TMemo.CreateParented(Handle);
Memo.Clear;
try
   Memo.PasteFromClipboard;                                     //Copia la cadena de texto que se encuentra en el ClipBoard.
finally
   with Memo do                                                 //Para trabajar con el Memo:
        begin
        Tabla.RowCount := 2;                                    //Limpia la tabla.
        Text := Sustituir(Text, #13#10#32, FinDeColumna);       //Sustituye los caracteres de control por otros
        Text := Sustituir(Text, #13#10, FinDeFila);             //correspondientes a un c�digo de un solo caracter.
        X := 0;                                                 //Empieza desde la primera columna.
        Y := 1;                                                 //La primera fila se recerva para los t�tulos de los campos.
        Cadena := '';
        Longitud := Length(Text);                               //Calcula la longitud de la cadena de texto entrante.
        if Longitud > 0 then                                    //Si la longitud es mayor que cero:
           for Actual := 1 to Longitud do                       //Intenta separar la cadena en filas y columnas.
               if text[Actual] = FinDeColumna then              //Si encuentra el caracter de tabulaci�n:
                  begin
                  Tabla.Cells[X, Y] := Cadena;                  //Guarda la subcadena en la tabla.
                  Cadena := '';                                 //Inicia la subcadena en cero.
                  Inc(X);                                       //Salta a una nueva columna.
                  end
               else                                             //Si no es el caracter de tabulaci�n:
                  if text[Actual] = FinDeFila then              //Si encuentra los caracteres de f�n de linea:
                     begin
                     Tabla.RowCount := Tabla.RowCount + 1;      //Aumenta la cantidad de filas en la tabla.
                     Tabla.Cells[X, Y] := Cadena;               //Guarda la subcadena en la tabla.
                     Cadena := '';                              //Inicia la subcadena en cero.
                     Inc(Y);                                    //Salta a la siguiente fila.
                     X := 0;                                    //Regresa a la primera columna.
                     end
                  else                                          //Si no se han encontrado caracteres de fin de linea o columna:
                     Cadena := Cadena + text[Actual];           //Agrega un nuevo caracter a la cadena.
        if Y > 1 then Tabla.RowCount := Tabla.RowCount - 1;     //Elimina la �ltima fila que est� en blanco.
        end;
end;
end;

//-----------------------------------------------------------------------------
// Esta funci�n cierra el formulario sin guardar los datos
// que se encuentren en la tabla.
//-----------------------------------------------------------------------------
procedure TFEntradaDeDatos.ActionCancelarExecute(Sender: TObject);
begin
Close;
end;

//-----------------------------------------------------------------------------
// Esta funci�n vac�a la tabla y la inicia para que
// se puedan insertar datos en esta.
//-----------------------------------------------------------------------------
procedure TFEntradaDeDatos.BorrarTabla;
var n: Integer;
begin
Tabla.RowCount := 2;                       //Elimina las filas de la tabla y deja solo la primera.
if Tabla.ColCount > 0 then                 //Si la tabla tiene columnas:
   for n := 0 to Tabla.ColCount - 1 do     //Vac�a las celdas de cada una de las columnas.
       Tabla.Cells[n, 1] := '';
end;

//-----------------------------------------------------------------------------
// Esta funci�n borra los datos de la tabla.
//-----------------------------------------------------------------------------
procedure TFEntradaDeDatos.ActionBorrarExecute(Sender: TObject);
begin
BorrarTabla;
end;

//-----------------------------------------------------------------------------
// Esta funci�n agrega los datos de la tabla de entrada
// a la Base de Datos local si no encuentra errores.
//-----------------------------------------------------------------------------
procedure TFEntradaDeDatos.ActionAgregarExecute(Sender: TObject);
var X, Errores: Integer;
    TablaCells0X: Boolean;
    msg: String;
    Fila: TRegistroUbicacion;
begin
Errores := 0;
for X := 1 to Tabla.RowCount - 1 do
    begin
    TablaCells0X := True;                              //Inicia en falso el indicador.
    Fila.DATE    := 0;
    Fila.MSISDN  := Tabla.Cells[1, X];                 //Llena la estructura con los datos
    Fila.CGI     := Tabla.Cells[2, X];                 //de la fila actual.
    Fila.CELLID  := Tabla.Cells[3, X];
    Fila.CELL    := Tabla.Cells[4, X];
    Fila.ERROR   := Tabla.Cells[5, X];
    Fila.AGE     := Tabla.Cells[6, X];
    try
       Fila.DATE := StrToDateTime(Tabla.Cells[0, X]);  //Intenta convertir la cadena en un dato temporal.
    except
       TablaCells0X := False;                          //Indica que la primera celda tiene un valor v�lido.
    end;
    if (TablaCells0X) and                              //Si todos los campos de la fila
       (Fila.MSISDN <> '') and                         //est�n llenos con alguna cadena
       (Fila.CGI <> '') and                            //de texto, se asume que est�n
       (Fila.CELLID <> '') and                         //listos para ser agregados a
       (Fila.CELL <> '') and                           //la base de datos.
       (Fila.ERROR <> '') and
       (Fila.AGE <> '') then                           //Agrega esta fila a la Base de Datos.
       FPrincipal.InsertarEnLaBD(Fila)                 //Guarda la fila en la base de datos.
    else                                               //Informa al usuario de la posibilidad
       Inc(Errores);                                   //Cuenta los errores.
    end;
FPrincipal.CrearListaDeMoviles;                        //Crea la lista de los m�viles de la Base de Datos.
BorrarTabla;                                           //Borra la tabla de entrada.
Visible := False;                                      //Oculta el formulario de di�logo.
if Errores > 0 then
   begin
   if Tabla.RowCount > 2 then                          //Si hay m�s de un registro:
      begin
      msg := 'Se han detectado ' + IntToStr(Errores) + ' registros con problemas.'
             + #13 + 'Estos no se insertar�n en la Base de Datos.';
      MessageBox(0, PChar(msg), 'Dato incorrecto', MB_ICONWARNING);
      end
   else                                                //Si solo hay un registro y las etiquetas de los campos:
      begin
      msg := 'Debe insertar valores v�lidos en la tabla.';
      MessageBox(0, PChar(msg), 'Dato incorrecto', MB_ICONWARNING);
      end;
   end;
FPrincipal.PageControl1.ActivePageIndex := 0;
Close;
end;

//-----------------------------------------------------------------------------
// Esta funci�n muestra la ayuda de esta ventana.
//-----------------------------------------------------------------------------
procedure TFEntradaDeDatos.ActionAyudaExecute(Sender: TObject);
var msg: String;
begin
msg :=       'Utilice este di�logo para insertar datos en la Base de Datos.' + #13#13;
msg := msg + 'Puede insertar los datos uno a uno manualmente, tecle�ndolos' + #13;
msg := msg + 'directamente sobre la casilla. Luego al terminar de teclear' + #13;
msg := msg + 'debe presionar el bot�n "Agregar" para que los datos sean' + #13;
msg := msg + 'agregados a la Base de Datos.' + #13#13;
msg := msg + 'Para agregar los datos con m�s facilidad, puede copiar una' + #13;
msg := msg + 'tabla completa de un documento Exel, Word o una p�gina web' + #13;
msg := msg + 'y pegarla mediante el bot�n "Pegar". Luego debe pulsar el' + #13;
msg := msg + 'bot�n "Agregar".';
Application.MessageBox(PChar(msg), 'Ayuda', MB_OK);
end;

end.


