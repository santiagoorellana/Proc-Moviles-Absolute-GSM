unit URelacionDeDos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ActnList, Buttons, ComCtrls, Spin, DateUtils;

type
  TFRelacionDeDos = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    Dias: TSpinEdit;
    GroupBox7: TGroupBox;
    Horas: TSpinEdit;
    GroupBox8: TGroupBox;
    Minutos: TSpinEdit;
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
    GroupBox9: TGroupBox;
    NumeroDelMovil1: TComboBox;
    NumeroDelMovil2: TComboBox;
    GroupBox10: TGroupBox;
    MostrarFechaYHora: TCheckBox;
    MostrarIDYNombre: TCheckBox;
    MostrarMoviles: TCheckBox;
    procedure ActionAyudaExecute(Sender: TObject);
    procedure ActionCancelarExecute(Sender: TObject);
    procedure ActionBuscarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DesdeChange(Sender: TObject);
    procedure HastaChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FRelacionDeDos: TFRelacionDeDos;

implementation

uses UPrincipal, UBase, ULista, Grids;

{$R *.dfm}

//-----------------------------------------------------------------------------
// Inicia el formulario y sus componentes.
//-----------------------------------------------------------------------------
procedure TFRelacionDeDos.FormCreate(Sender: TObject);
begin
//Inicia la lista de los móviles mencionados en la Base de Datos.
NumeroDelMovil1.Items := FPrincipal.ListaDeMoviles.Items;
NumeroDelMovil2.Items := FPrincipal.ListaDeMoviles.Items;

//Inicia el intervalo de tiempo.
Desde.DateTime := IncYear(Now, -5);
Hasta.DateTime := IncYear(Now, +1);
end;

//-----------------------------------------------------------------------------
// Sale de la ventana sin hacer nada.
//-----------------------------------------------------------------------------
procedure TFRelacionDeDos.ActionCancelarExecute(Sender: TObject);
begin
Close;
end;

//-----------------------------------------------------------------------------
// Muestra la ayuda de esta herramienta.
//-----------------------------------------------------------------------------
procedure TFRelacionDeDos.ActionAyudaExecute(Sender: TObject);
var msg: String;
begin
msg :=       'Vínculos entre dos móviles.' + #13#13;
msg := msg + 'Utilice esta herramienta para buscar las coincidencias de' + #13;
msg := msg + 'dos dispositivos móviles en el mismo espacio-tiempo. Solo' + #13;
msg := msg + 'debe introducir los números de los dispositivos de interés' + #13;
msg := msg + 'y establecer la diferencia máxima de tiempo que pueda existir' + #13;
msg := msg + 'entre las localizaciones de dos móviles para que se asuma la' + #13;
msg := msg + 'existencia de un contacto. Luego pulse el botón "Buscar".';
Application.MessageBox(PChar(msg), 'Ayuda', MB_OK);
end;

//-----------------------------------------------------------------------------
// Inicia la búsqueda de las relaciones del móvil especificado.
//-----------------------------------------------------------------------------
procedure TFRelacionDeDos.ActionBuscarExecute(Sender: TObject);
var n, m, i, j: Integer;
    msg, tit, Movil1, Movil2, Linea, Etiqueta: String;
    Fila, FilaV, ri, rj: TRegistroUbicacion;
    Localizaciones, Vinculos: TLista;
    Diferencia, DiferenciaMaxima: Double;
    Repetir: Boolean;
    ColorSimbolo: TColor;
begin
if NumeroDelMovil1.Focused then
   begin
   NumeroDelMovil2.SetFocus;
   Exit;
   end;
FPrincipal.Resultados.Enabled := False;
if (NumeroDelMovil1.Text = '') or
   (NumeroDelMovil2.Text = '') then
   begin
   tit := 'Faltan parámetros...';
   msg := 'Debe insertar el número de ambos teléfonos para iniciar la búsqueda.';
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

DiferenciaMaxima := Minutos.Value + Horas.Value * 60 + Dias.Value * 24 * 60;

Movil1 := FiltrarNumeros(NumeroDelMovil1.Text);                       //Deja sólo los números.
Movil2 := FiltrarNumeros(NumeroDelMovil2.Text);                       //Deja sólo los números.
Localizaciones := TLista.Create;                                      //Inicia la lista de resultado.
Vinculos := TLista.Create;
Localizaciones.Vaciar;
Vinculos.Vaciar;
with FPrincipal.TablaBD do                                            //Se busca en la tabla del formulario principal.
     if RowCount > 0 then                                             //La búsqueda continúa si hay registros.
        begin
        //Primero se buscan todas las localizaciones del móvil de interés,
        //y que se encuentren en el rango de tiempo especificado.
        for n := 1 to RowCount - 1 do                                 //Busca en cada registro a partir de la posición primera.
            begin
            if Movil1 = FiltrarNumeros(Cells[1, n]) then               //Si encuentra un registro del teléfono especificado:
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
                  Localizaciones.Agregar(Fila);                       //Agrega el dato nuevo a la lista.
               end;
            Application.ProcessMessages;                              //Procesamos los mensajes de windows.
            if GetKeyState(VK_Escape) and 128 = 128 then break;       //Si se pulsa la tecla ESC, se termina la búsqueda.
            end;

        //Por cada uno de los instantes de localización
        //del móvil, busca los posibles vínculos.
        if Localizaciones.Insertados > 0 then
           begin
           Localizaciones.OrdenarPorFecha;                                         //Ordena la lista por las fechas de los registros.

           //Busca los posibles vínculos en cada una de las localizaciones.
           for n := 0 to Localizaciones.Insertados - 1 do
               begin
               Fila := Localizaciones.Obtener(n);                                  //Busca la fila.
               for m := 1 to RowCount - 2 do                                       //Busca en cada registro a partir de la posición primera.
                   begin
                   if (Fila.CELLID = Cells[3, m]) and                              //Si encuentra un móvil atendido por la misma
                      (Movil2 = FiltrarNumeros(Cells[1, m])) then                  //celda y que sea el móvil investigado #2:
                      begin
                      FilaV.DATE   := StrToDateTime(Cells[0, m]);
                      Diferencia := MinuteSpan(FilaV.DATE, Fila.DATE);             //Calcula la diferencia en minutos entre los dos horarios.
                      if Diferencia <= DiferenciaMaxima then                       //Si la direfencia no sobrepasa el umbral:
                         begin
                         FilaV.MSISDN := Cells[1, m];                              //Llena la estructura con los datos
                         FilaV.CGI    := Cells[2, m];                              //de la fila actual.
                         FilaV.CELLID := Cells[3, m];
                         FilaV.CELL   := Cells[4, m];
                         FilaV.ERROR  := Cells[5, m];
                         FilaV.AGE    := Cells[6, m];
                         FilaV.Probabilidad := 1 - Diferencia / DiferenciaMaxima;
                         FilaV.TiempoDeVinculo := Fila.DATE;                       //Como tiempo de vínculo utiliza el tiempo de la localización del móvil de interés.
                         Vinculos.Agregar(FilaV);                                  //Agrega el nuevo vínculo a la lista.
                         end;
                      end;
                   Application.ProcessMessages;                                    //Procesa los mensajes de windows.
                   if GetKeyState(VK_Escape) and 128 = 128 then break;             //Si se pulsa la tecla ESC, se termina la búsqueda.
                   end;
               Application.ProcessMessages;                                        //Procesa los mensajes de windows.
               if GetKeyState(VK_Escape) and 128 = 128 then Break;                 //Si se pulsa la tecla ESC, se termina la búsqueda.
               end;
           end;

        //Muestra al usuario el resultado de la operación de búsqueda de vínculos.
        if Vinculos.Insertados > 0 then
           begin
           //Elimina las repeticiones innecesarias de la lista. Si encuentra
           //repeticiones de un mismo móvil, deja el de mayor probabilidad.
           Repetir := True;
           while Repetir do
                 begin
                 Repetir := False;
                 for i := 0 to Vinculos.Insertados - 1 do
                     begin
                     for j := 0 to Vinculos.Insertados - 1 do
                         if i <> j then
                            begin
                            ri := Vinculos.Obtener(i);
                            rj := Vinculos.Obtener(j);
                            if FiltrarNumeros(ri.MSISDN) = FiltrarNumeros(rj.MSISDN) then  //Si los número se repiten:
                               begin
                               if ri.Probabilidad < rj.Probabilidad then                   //Elimina el de menor probabilidad.
                                  Vinculos.Extraer(i)
                               else
                                  Vinculos.Extraer(j);
                               Repetir := True;
                               Break;                                                      //Sale del ciclo.
                               end;
                            end;
                     if Repetir then Break;                                                //Si no se encontraron repeticiones, sale.
                     end;
                 end;

           //Muestra información sobre el teléfono de interés y sus vínculos.
           FPrincipal.Resultados.Lines.Add('');                                 //Agrega un salto de línea.
           msg := '/////////////////////////////////////////////////////';
           msg := msg + '///////////////////////////////////////////////';
           FPrincipal.Resultados.SelAttributes.Color := CColorDeTitulos;
           FPrincipal.Resultados.Lines.Add(msg);                                //Pone el título de la lista.
           msg := 'POSIBLES VINCULOS DEL MOVIL ' + Movil1 + ' CON EL MOVIL ' + Movil2 + ' SEGUN LA BASE DE DATOS';
           FPrincipal.Resultados.SelAttributes.Style := [fsBold];
           FPrincipal.Resultados.SelAttributes.Color := CColorDeTitulos;
           FPrincipal.Resultados.Lines.Add(msg);                                //Pone el título de la lista.
           msg := 'Filtrado por fecha desde ';
           msg := msg + DateToStr(Desde.DateTime) + ' hasta ';
           msg := msg + DateToStr(Hasta.DateTime) + #13#13;
           FPrincipal.Resultados.SelAttributes.Color := clGreen;
           FPrincipal.Resultados.Lines.Add(msg);                                //Pone el título de la lista.
           msg :=       'Muestran los posibles vínculos espacio-temporal entre los dos móviles de interés. ';
           msg := msg + 'Los posibles vínculos están ordenados ascendentemente por fecha y muestran la confiabilidad de la coincidencia. ';
           msg := msg + 'Los más significativos están resaltados en color y tipo de letra.' + #13#13;
           msg := msg + 'Los posibles vínculos entre los dos móviles son:' + #13;
           FPrincipal.Resultados.SelAttributes.Color := clGreen;
           FPrincipal.Resultados.Lines.Add(msg);                                //Pone el título de la lista.

           //Muestra la información de los vínculos.
           for m := 0 to Vinculos.Insertados - 1 do
               begin
               //Muestra en el informe de resultados.
               FilaV := Vinculos.Obtener(m);                                     //Busca la fila.
               Linea := ' ' + IntToStr(m + 1);                                   //Indice de la lista.
               Linea := Linea + '- El día ' + DateToStr(FilaV.TiempoDeVinculo);  //con la hora, y con el
               Linea := Linea + ' a las ' + TimeToStr(FilaV.TiempoDeVinculo);    //número del vínculo.
               Linea := Linea + ' en la celda ' + FilaV.CELLID;
               Linea := Linea + ' conocida como ' + FilaV.CELL + '.';
               Linea := Linea + #9 + ' (Confiabilidad: ';
               Linea := Linea + IntToStr(Round(FilaV.Probabilidad * 100));       //Probabilidad del vínculo.
               Linea := Linea + '%)';                                            //número del vínculo.
               with FPrincipal.Resultados.SelAttributes do
                    if FilaV.Probabilidad >= 0.75 then                      //Selecciona el color con el que
                       begin                                                //se dibujará el vínculo en
                       Color := clRed;                                      //dependencia del porciento
                       Style := [fsBold];                                   //de probabilidad de
                       end                                                  //coincidencia.
                    else
                       if FilaV.Probabilidad >= 0.50 then
                          Color := clRed
                       else
                          if FilaV.Probabilidad >= 0.25 then
                             Color := clMaroon
                          else
                             Color := clBlack;
               ColorSimbolo := FPrincipal.Resultados.SelAttributes.Color;
               FPrincipal.Resultados.Lines.Add(Linea);                      //Copia la fila en el informe de resultados.

               //Muestra en el mapa.
               Etiqueta := '';
               if MostrarFechaYHora.Checked then
                  Etiqueta := Etiqueta + #13 + DateTimeToStr(FilaV.TiempoDeVinculo);
               if MostrarIDYNombre.Checked then
                  Etiqueta := Etiqueta + #13 + FilaV.CELLID + ' (' + FilaV.CELL + ')';
               if MostrarMoviles.Checked then
                  Etiqueta := Etiqueta + #13 + Movil1 + ' y ' + Movil2;
               FPrincipal.MostrarContacto(FilaV.CELLID,
                                          FilaV.CELL,
                                          ColorSimbolo,
                                          Etiqueta
                                          );

               Application.ProcessMessages;                                 //Procesa los mensajes de windows.
               if GetKeyState(VK_Escape) and 128 = 128 then Break;          //Si se pulsa la tecla ESC, se termina la búsqueda.
               end;
           end
        else
           begin
           //Muestra información al usuario sobre la ausencia de vínculos.
           FPrincipal.Resultados.Lines.Add('');                             //Agrega un salto de línea.
           msg := '/////////////////////////////////////////////////////';
           msg := msg + '///////////////////////////////////////////////';
           FPrincipal.Resultados.SelAttributes.Color := CColorDeTitulos;
           FPrincipal.Resultados.Lines.Add(msg);                            //Pone el título de la lista.
           msg := 'EL MOVIL ' + Movil1 + ' Y EL ' + Movil2 + ' NO TIENEN POSIBLES VÍNCULOS';
           FPrincipal.Resultados.SelAttributes.Style := [fsBold];
           FPrincipal.Resultados.SelAttributes.Color := CColorDeTitulos;
           FPrincipal.Resultados.Lines.Add(msg);                            //Pone el título de la lista.
           msg := 'No hay vínculos desde ';
           msg := msg + DateToStr(Desde.DateTime) + ' hasta ';
           msg := msg + DateToStr(Hasta.DateTime) + #13#13;
           FPrincipal.Resultados.SelAttributes.Color := clGreen;
           FPrincipal.Resultados.Lines.Add(msg);                            //Pone el título de la lista.
           end;
        FPrincipal.PageControl1.ActivePageIndex := 1;                       //Muestra la página de resultados.
        end;
Localizaciones.Free;                                                        //Libera la lista.
Vinculos.Free;
FPrincipal.Resultados.Enabled := True;
Close;
end;

//-----------------------------------------------------------------------------
// Mantiene el rango de tiempo en orden.
//-----------------------------------------------------------------------------
procedure TFRelacionDeDos.DesdeChange(Sender: TObject);
begin
if CompareDate(Desde.DateTime, Hasta.DateTime) = 1 then
   Hasta.DateTime := Desde.DateTime;
end;

procedure TFRelacionDeDos.HastaChange(Sender: TObject);
begin
if CompareDate(Desde.DateTime, Hasta.DateTime) = 1 then
   Desde.DateTime := Hasta.DateTime;
end;


end.
