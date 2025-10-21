
///////////////////////////////////////////////////////////////////////////////
// Autor:  Santiago Alejandro Orellana Pérez
//
// Fecha: 27/10/2013
///////////////////////////////////////////////////////////////////////////////

unit URecorrido;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ActnList, DateUtils, UBase,
  ExtCtrls;

type
  TFRecorrido = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Desde: TDateTimePicker;
    GroupBox4: TGroupBox;
    Hasta: TDateTimePicker;
    BitBtn3: TBitBtn;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ActionList1: TActionList;
    ActionAyuda: TAction;
    ActionCancelar: TAction;
    ActionBuscar: TAction;
    NumeroDelMovil: TComboBox;
    GroupBox5: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    ColorBox1: TColorBox;
    ColorBox2: TColorBox;
    procedure ActionAyudaExecute(Sender: TObject);
    procedure ActionCancelarExecute(Sender: TObject);
    procedure ActionBuscarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DesdeChange(Sender: TObject);
    procedure HastaChange(Sender: TObject);
  private
    procedure InsertarOrdenado(Registro: TRegistroUbicacion);
  public
    { Public declarations }
  end;

var
  FRecorrido: TFRecorrido;

implementation

uses UPrincipal, ULista, Grids;

{$R *.dfm}

//-----------------------------------------------------------------------------
// Inicia el formulario y sus controles.
//-----------------------------------------------------------------------------
procedure TFRecorrido.FormCreate(Sender: TObject);
begin
//Inicia la lista de los móviles mencionados en la Base de Datos.
NumeroDelMovil.Items := FPrincipal.ListaDeMoviles.Items;

//Inicia el intervalo de tiempo. 
Desde.DateTime := IncYear(Now, -5);
Hasta.DateTime := IncYear(Now, +1);
end;

//-----------------------------------------------------------------------------
// Muestra la ayuda de esta ventana.
//-----------------------------------------------------------------------------
procedure TFRecorrido.ActionAyudaExecute(Sender: TObject);
var msg: String;
begin
msg :=       'Recorrido de un móvil por las celdas.' + #13#13;
msg := msg + 'Utilice esta herramienta para obtener el recorrido de un móvil' + #13;
msg := msg + 'por cada una de las celdas del sistema celular. Solo se debe' + #13;
msg := msg + 'introducir el número del móvil y especificar el intervalo de' + #13;
msg := msg + 'tiempo de interés. Luego pulsar el botón "Buscar".' + #13#13;
msg := msg + 'El recorrido se mostrará en el informe de resultados como' + #13;
msg := msg + 'una secuencia ordenada por el tiempo de la localización.';
Application.MessageBox(PChar(msg), 'Ayuda', MB_OK);
end;

//-----------------------------------------------------------------------------
// Cancela la búsqueda.
//-----------------------------------------------------------------------------
procedure TFRecorrido.ActionCancelarExecute(Sender: TObject);
begin
Close;
end;

//-----------------------------------------------------------------------------
// Conforma una lista ordenada por fecha y hora.
//-----------------------------------------------------------------------------
procedure TFRecorrido.InsertarOrdenado(Registro: TRegistroUbicacion);
begin
ShowMessage(Registro.CELL);
end;

//-----------------------------------------------------------------------------
// Realiza la búsqueda del recorrido del móvil indicado.
//-----------------------------------------------------------------------------
procedure TFRecorrido.ActionBuscarExecute(Sender: TObject);
var n: Integer;
    msg, tit, Movil, Linea: String;
    Fila: TRegistroUbicacion;
    Lista: TLista;
    Numero: String;
    Ruta: TCoordenadas;
begin
if NumeroDelMovil.ItemIndex >= 0 then
   Numero := NumeroDelMovil.Items[NumeroDelMovil.ItemIndex]
else
   Numero := NumeroDelMovil.Text;
if Numero = '' then
   begin
   tit := 'Faltan parámetros...';
   msg := 'Debe insertar una cadena de texto para iniciar la búsqueda.';
   Application.MessageBox(PChar(msg), PChar(tit), MB_OK);
   Exit;
   end;
if CompareDate(Desde.DateTime, Hasta.DateTime) = 1 then
   begin                                                              //Indica el error en el parámetro.
   tit := 'Parámetro incorrecto...';
   msg := 'Error en el rango de tiempo.';
   Application.MessageBox(PChar(msg), PChar(tit), MB_OK);
   Exit;
   end;
Movil := FiltrarNumeros(Numero);                                      //Deja sólo los números.
Lista := TLista.Create;                                               //Inicia la lista de resultado.
Lista.Vaciar;
with FPrincipal.TablaBD do                                            //Se busca en la tabla del formulario principal.
     if RowCount > 0 then                                             //La búsqueda continúa si hay registros.
        begin
        for n := 1 to RowCount - 1 do                                 //Busca en cada registro a partir de la posición primera.
            begin
            if Movil = FiltrarNumeros(Cells[1, n])then                //Si encuentra un registro del teléfono especificado:
               begin
               Fila.DATE   := StrToDateTime(Cells[0, n]);
               Fila.MSISDN := Cells[1, n];                            //Llena la estructura con los datos
               Fila.CGI    := Cells[2, n];                            //de la fila actual.
               Fila.CELLID := Cells[3, n];
               Fila.CELL   := Cells[4, n];
               Fila.ERROR  := Cells[5, n];
               Fila.AGE    := Cells[6, n];
               if (CompareDate(Fila.DATE, Desde.DateTime) > -1) and
                  (CompareDate(Fila.DATE, Hasta.DateTime) < 1) then
                  Lista.Agregar(Fila);                                //Agrega el dato nuevo a la lista.
               end;
            Application.ProcessMessages;                              //Procesamos los mensajes de windows.
            if GetKeyState(VK_Escape) and 128 = 128 then break;       //Si se pulsa la tecla ESC, se termina la búsqueda.
            end;
        if Lista.Insertados > 0 then
           begin
           Lista.OrdenarPorFecha;                                     //Ordena la lista por las fechas de los registros.
           FPrincipal.Resultados.Lines.Add('');                       //Agrega un salto de línea.
           msg := '/////////////////////////////////////////////////////';
           msg := msg + '///////////////////////////////////////////////';
           FPrincipal.Resultados.SelAttributes.Color := CColorDeTitulos;
           FPrincipal.Resultados.Lines.Add(msg);                      //Pone el título de la lista.
           msg := 'RECORRIDO DEL MOVIL ' + Movil + ' SEGUN LA BASE DE DATOS';
           FPrincipal.Resultados.SelAttributes.Style := [fsBold];
           FPrincipal.Resultados.SelAttributes.Color := CColorDeTitulos;
           FPrincipal.Resultados.Lines.Add(msg);                      //Pone el título de la lista.
           msg := 'Filtrado por fecha desde ';
           msg := msg + DateToStr(Desde.DateTime) + ' hasta ';
           msg := msg + DateToStr(Hasta.DateTime) + #13#13;
           FPrincipal.Resultados.SelAttributes.Color := clGreen;
           FPrincipal.Resultados.Lines.Add(msg);                      //Pone el título de la lista.
           SetLength(Ruta, Lista.Insertados);
           for n := 0 to Lista.Insertados - 1 do
               begin
               //Muestra en el informe de resultados.
               Fila := Lista.Obtener(n);                              //Busca la fila.
               Linea := DateToStr(Fila.DATE) + #9;                    //Crea una línea con la fecha,
               Linea := Linea + TimeToStr(Fila.DATE) + #9;            //con la hora,
               Linea := Linea + Fila.CELLID + #9;                     //con el ID de la celda y el
               Linea := Linea + '(' + Fila.CELL + ')';                //nombre de la celda.
               FPrincipal.Resultados.Lines.Add(Linea);                //Copia la fila en el informe de resultados.

               //Obtiene las coordenadas.
               Ruta[n] := FPrincipal.CoordenadaDeCelda(Fila.CELLID, Fila.CELL);
               if (Ruta[n].X = 0) and (Ruta[n].Y = 0) and (n > 0) then
                  Ruta[n] := Ruta[n - 1];
               end;
           //Muestra el recorrido en el mapa.
           FPrincipal.MostrarRecorrido(Ruta,
                                       ColorBox1.Selected,
                                       ColorBox2.Selected,
                                       );
           FPrincipal.PageControl1.ActivePageIndex := 1;              //Muestra la página de resultados.
           Lista.Free;                                                //Libera la lista.
           end;
        end;
Close;
end;

//-----------------------------------------------------------------------------
// Mantiene el rango de tiempo en orden.
//-----------------------------------------------------------------------------
procedure TFRecorrido.DesdeChange(Sender: TObject);
begin
if CompareDate(Desde.DateTime, Hasta.DateTime) = 1 then
   Hasta.DateTime := Desde.DateTime;
end;

procedure TFRecorrido.HastaChange(Sender: TObject);
begin
if CompareDate(Desde.DateTime, Hasta.DateTime) = 1 then
   Desde.DateTime := Hasta.DateTime;
end;

end.
