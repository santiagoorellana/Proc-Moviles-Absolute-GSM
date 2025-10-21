unit URelacionesEntreGrupos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, Spin, ComCtrls, ActnList, Buttons, Menus, DateUtils;

type
  TFRelacionesEntreGrupos = class(TForm)
    GroupBox1: TGroupBox;
    Grupo1: TListBox;
    GroupBox2: TGroupBox;
    Grupo2: TListBox;
    BitBtn3: TBitBtn;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ActionList1: TActionList;
    ActionAyuda: TAction;
    ActionCancelar: TAction;
    ActionBuscar: TAction;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    Desde: TDateTimePicker;
    GroupBox5: TGroupBox;
    Hasta: TDateTimePicker;
    GroupBox6: TGroupBox;
    GroupBox7: TGroupBox;
    Dias: TSpinEdit;
    GroupBox8: TGroupBox;
    Horas: TSpinEdit;
    GroupBox9: TGroupBox;
    Minutos: TSpinEdit;
    GroupBox12: TGroupBox;
    MostrarFechaYHora: TCheckBox;
    MostrarIDYNombre: TCheckBox;
    MostrarMoviles: TCheckBox;
    NumeroDelMovil1: TComboBox;
    NumeroDelMovil2: TComboBox;
    Button1: TButton;
    Button2: TButton;
    PopupMenu1: TPopupMenu;
    PopupMenu2: TPopupMenu;
    ActionCargarGrupo1: TAction;
    ActionCargarGrupo2: TAction;
    ActionSalvarGrupo1: TAction;
    ActionSalvarGrupo2: TAction;
    Cargargrupo11: TMenuItem;
    Salvargrupo11: TMenuItem;
    Cargargrupo21: TMenuItem;
    Salvargrupo21: TMenuItem;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    procedure ActionAyudaExecute(Sender: TObject);
    procedure ActionCancelarExecute(Sender: TObject);
    procedure ActionBuscarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DesdeChange(Sender: TObject);
    procedure HastaChange(Sender: TObject);
    procedure ActionCargarGrupo1Execute(Sender: TObject);
    procedure ActionCargarGrupo2Execute(Sender: TObject);
    procedure ActionSalvarGrupo1Execute(Sender: TObject);
    procedure ActionSalvarGrupo2Execute(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure CargarGrupo(Grupo: Integer);
    procedure GuardarGrupo(Grupo: Integer);
    function PerteneceAlSegundoGrupo(NumeroMovil: String): Boolean;
  public
    { Public declarations }
  end;

var
  FRelacionesEntreGrupos: TFRelacionesEntreGrupos;

implementation

uses UPrincipal, UBase, ULista;

{$R *.dfm}

//-----------------------------------------------------------------------------
// Inicia el formulario y sus componentes.
//-----------------------------------------------------------------------------
procedure TFRelacionesEntreGrupos.FormCreate(Sender: TObject);
begin
//Inicia la lista de los m�viles mencionados en la Base de Datos.
NumeroDelMovil1.Items := FPrincipal.ListaDeMoviles.Items;
NumeroDelMovil2.Items := FPrincipal.ListaDeMoviles.Items;

//Inicia el intervalo de tiempo.
Desde.DateTime := IncYear(Now, -5);
Hasta.DateTime := IncYear(Now, +1);
end;

//-----------------------------------------------------------------------------
// Muestra la ayuda de esta herramienta.
//-----------------------------------------------------------------------------
procedure TFRelacionesEntreGrupos.ActionAyudaExecute(Sender: TObject);
var msg: String;
begin
msg :=       'V�nculos entre grupos de m�viles.' + #13#13;
msg := msg + 'Utilice esta herramienta para buscar las coincidencias entre' + #13;
msg := msg + 'dos grupos de dispositivos m�viles en el mismo espacio-tiempo.' + #13;
msg := msg + 'Solo debe introducir los n�meros de los dispositivos de inter�s' + #13;
msg := msg + 'en el grupo correspondiente y establecer la diferencia m�xima de' + #13;
msg := msg + 'tiempo que pueda existir entre las localizaciones de dos m�viles' + #13;
msg := msg + 'para que se asuma la existencia de un contacto.' + #13;
msg := msg + 'Luego pulse el bot�n "Buscar".';
Application.MessageBox(PChar(msg), 'Ayuda', MB_OK);
end;

//-----------------------------------------------------------------------------
// Mantiene el rango de tiempo en orden.
//-----------------------------------------------------------------------------
procedure TFRelacionesEntreGrupos.DesdeChange(Sender: TObject);
begin
if CompareDate(Desde.DateTime, Hasta.DateTime) = 1 then
   Hasta.DateTime := Desde.DateTime;
end;

procedure TFRelacionesEntreGrupos.HastaChange(Sender: TObject);
begin
if CompareDate(Desde.DateTime, Hasta.DateTime) = 1 then
   Desde.DateTime := Hasta.DateTime;
end;

//-----------------------------------------------------------------------------
// Sale de la ventana sin hacer nada.
//-----------------------------------------------------------------------------
procedure TFRelacionesEntreGrupos.ActionCancelarExecute(Sender: TObject);
begin
Close;
end;

//-----------------------------------------------------------------------------
// Carga un grupo de tel�fonos m�viles.
//-----------------------------------------------------------------------------
procedure TFRelacionesEntreGrupos.CargarGrupo(Grupo: Integer);
var dlg: TOpenDialog;
    n: Integer;
begin
dlg := TOpenDialog.Create(Self);
dlg.DefaultExt := 'LIS';
dlg.Filter := 'Ficheros de lista (LIS)|*.LIS|Todos los ficheros|*.*';
dlg.InitialDir := FPrincipal.RutaParaLasBasesDeDatos;
if dlg.Execute then
   if FileExists(dlg.FileName) then
      if Grupo = 1 then
         Grupo1.Items.LoadFromFile(dlg.FileName)
      else
         if Grupo = 2 then
            Grupo2.Items.LoadFromFile(dlg.FileName);
dlg.Free;
end;

//-----------------------------------------------------------------------------
// Guarda un grupo de tel�fonos m�viles.
//-----------------------------------------------------------------------------
procedure TFRelacionesEntreGrupos.GuardarGrupo(Grupo: Integer);
var dlg: TSaveDialog;
    n: Integer;
begin
dlg := TSaveDialog.Create(Self);
dlg.DefaultExt := 'LIS';
dlg.Filter := 'Ficheros de lista (LIS)|*.LIS|Todos los ficheros|*.*';
dlg.InitialDir := FPrincipal.RutaParaLasBasesDeDatos;
if dlg.Execute then
   if Grupo = 1 then
      Grupo1.Items.SaveToFile(dlg.FileName)
   else
      if Grupo = 2 then
         Grupo2.Items.SaveToFile(dlg.FileName);
dlg.Free;
end;

//-----------------------------------------------------------------------------
// Carga el primer grupo de tel�fonos m�viles.
//-----------------------------------------------------------------------------
procedure TFRelacionesEntreGrupos.ActionCargarGrupo1Execute(Sender: TObject);
begin
CargarGrupo(1);
end;

//-----------------------------------------------------------------------------
// Carga el segundo grupo de tel�fonos m�viles.
//-----------------------------------------------------------------------------
procedure TFRelacionesEntreGrupos.ActionCargarGrupo2Execute(Sender: TObject);
begin
CargarGrupo(2);
end;

//-----------------------------------------------------------------------------
// Guarda el primer grupo de tel�fonos m�viles.
//-----------------------------------------------------------------------------
procedure TFRelacionesEntreGrupos.ActionSalvarGrupo1Execute(Sender: TObject);
begin
GuardarGrupo(1);
end;

//-----------------------------------------------------------------------------
// Guarda el segundo grupo de tel�fonos m�viles.
//-----------------------------------------------------------------------------
procedure TFRelacionesEntreGrupos.ActionSalvarGrupo2Execute(Sender: TObject);
begin
GuardarGrupo(2);
end;

//-----------------------------------------------------------------------------
// Inserta el n�mero seleccionado en la lista del grupo #1.
//-----------------------------------------------------------------------------
procedure TFRelacionesEntreGrupos.Button1Click(Sender: TObject);
begin
Grupo1.Items.Add(NumeroDelMovil1.Text);
end;

//-----------------------------------------------------------------------------
// Inserta el n�mero seleccionado en la lista del grupo #2.
//-----------------------------------------------------------------------------
procedure TFRelacionesEntreGrupos.Button2Click(Sender: TObject);
begin
Grupo2.Items.Add(NumeroDelMovil2.Text);
end;

//-----------------------------------------------------------------------------
// Devuelve TRUE si el n�mero de m�vil pasado pertenece al segundo grupo.
//-----------------------------------------------------------------------------
function TFRelacionesEntreGrupos.PerteneceAlSegundoGrupo(NumeroMovil: String): Boolean;
var n: Integer;
begin
NumeroMovil := FiltrarNumeros(NumeroMovil);
Result := False;
if Grupo2.Items.Count > 0 then
   for n := 0 to Grupo2.Items.Count - 1 do
       if NumeroMovil = FiltrarNumeros(Grupo2.Items[n]) then
          begin
          Result := True;
          Break;
          end;
end;

//-----------------------------------------------------------------------------
// Inicia la b�squeda de las relaciones del m�vil especificado.
//-----------------------------------------------------------------------------
procedure TFRelacionesEntreGrupos.ActionBuscarExecute(Sender: TObject);
var n, m, i, j, k: Integer;
    msg, tit, Movil1, Linea, Etiqueta: String;
    Fila, FilaV, ri, rj: TRegistroUbicacion;
    Localizaciones, Vinculos: TLista;
    Diferencia, DiferenciaMaxima: Double;
    Repetir: Boolean;
    ColorSimbolo: TColor;
begin
FPrincipal.Resultados.Enabled := False;
if (Grupo1.Items.Count = 0) or
   (Grupo2.Items.Count = 0) then
   begin
   tit := 'Faltan par�metros...';
   msg := 'Debe insertar n�meros en ambos grupos para iniciar la b�squeda.';
   Application.MessageBox(PChar(msg), PChar(tit), MB_OK);
   Exit;
   end;
if CompareDate(Desde.DateTime, Hasta.DateTime) = 1 then
   begin                                                              //Indica el error en el par�metro.
   tit := 'Par�metro incorrecto...';
   msg := 'Error en el rango de tiempo.';
   Application.MessageBox(PChar(msg), PChar(tit), MB_OK);
   Exit;
   end;

DiferenciaMaxima := Minutos.Value + Horas.Value * 60 + Dias.Value * 24 * 60;

if Grupo1.Items.Count > 0 then
   begin
   FPrincipal.Resultados.Lines.Add('');                                 //Agrega un salto de l�nea.
   msg := '/////////////////////////////////////////////////////////////////////////';
   msg := msg + '///////////////////////////////////////////////////////////////////';
   FPrincipal.Resultados.SelAttributes.Color := CColorDeTitulos;
   FPrincipal.Resultados.Lines.Add(msg);                                //Pone el t�tulo de la lista.
   FPrincipal.Resultados.SelAttributes.Color := CColorDeTitulos;
   FPrincipal.Resultados.Lines.Add(msg);                                //Pone el t�tulo de la lista.
   msg := 'POSIBLES VINCULOS ENTRE DOS GRUPOS DE MOVILES SEGUN LA BASE DE DATOS';
   FPrincipal.Resultados.SelAttributes.Style := [fsBold];
   FPrincipal.Resultados.SelAttributes.Color := CColorDeTitulos;
   FPrincipal.Resultados.Lines.Add(msg);                                //Pone el t�tulo de la lista.
   msg := 'Filtrado por fecha desde ';
   msg := msg + DateToStr(Desde.DateTime) + ' hasta ';
   msg := msg + DateToStr(Hasta.DateTime) + #13#13;
   FPrincipal.Resultados.SelAttributes.Color := clGreen;
   FPrincipal.Resultados.Lines.Add(msg);                                //Pone el t�tulo de la lista.
   msg :=       'Muestran los posibles v�nculos espacio-temporal entre dos grupos de m�viles. ';
   msg := msg + 'Los posibles v�nculos est�n ordenados ascendentemente por fecha y muestran la confiabilidad de la coincidencia. ';
   msg := msg + 'Los m�s significativos est�n resaltados en color y tipo de letra.' + #13#13;
   FPrincipal.Resultados.SelAttributes.Color := clGreen;
   FPrincipal.Resultados.Lines.Add(msg);                                //Pone el t�tulo de la lista.
   for k := 0 to Grupo1.Items.Count - 1 do
       begin
       Movil1 := FiltrarNumeros(Grupo1.Items[k]);                            //Deja s�lo los n�meros.
       Localizaciones := TLista.Create;                                      //Inicia la lista de resultado.
       Vinculos := TLista.Create;
       Localizaciones.Vaciar;
       Vinculos.Vaciar;
       with FPrincipal.TablaBD do                                            //Se busca en la tabla del formulario principal.
            if RowCount > 0 then                                             //La b�squeda contin�a si hay registros.
               begin
               //Primero se buscan todas las localizaciones del m�vil de inter�s,
               //y que se encuentren en el rango de tiempo especificado.
               for n := 1 to RowCount - 1 do                                 //Busca en cada registro a partir de la posici�n primera.
                   begin
                   if Movil1 = FiltrarNumeros(Cells[1, n]) then               //Si encuentra un registro del tel�fono especificado:
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
                   if GetKeyState(VK_Escape) and 128 = 128 then break;       //Si se pulsa la tecla ESC, se termina la b�squeda.
                   end;

               //Por cada uno de los instantes de localizaci�n
               //del m�vil, busca los posibles v�nculos.
               if Localizaciones.Insertados > 0 then
                  begin
                  Localizaciones.OrdenarPorFecha;                                         //Ordena la lista por las fechas de los registros.

                  //Busca los posibles v�nculos en cada una de las localizaciones.
                  for n := 0 to Localizaciones.Insertados - 1 do
                      begin
                      Fila := Localizaciones.Obtener(n);                                  //Busca la fila.
                      for m := 1 to RowCount - 2 do                                       //Busca en cada registro a partir de la posici�n primera.
                          begin
                          if (Fila.CELLID = Cells[3, m]) then                             //Si encuentra un m�vil atendido por la misma
                             if (Movil1 <> FiltrarNumeros(Cells[1, m])) then              //celda y que no sea el m�vil de inter�s pero
                                if PerteneceAlSegundoGrupo(Cells[1, m]) then              //que sea un m�vil del grupo #2:
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
                                      FilaV.TiempoDeVinculo := Fila.DATE;                       //Como tiempo de v�nculo utiliza el tiempo de la localizaci�n del m�vil de inter�s.
                                      Vinculos.Agregar(FilaV);                                  //Agrega el nuevo v�nculo a la lista.
                                      end;
                                   end;
                          Application.ProcessMessages;                                    //Procesa los mensajes de windows.
                          if GetKeyState(VK_Escape) and 128 = 128 then break;             //Si se pulsa la tecla ESC, se termina la b�squeda.
                          end;
                      Application.ProcessMessages;                                        //Procesa los mensajes de windows.
                      if GetKeyState(VK_Escape) and 128 = 128 then Break;                 //Si se pulsa la tecla ESC, se termina la b�squeda.
                      end;
                  end;

               //Muestra al usuario el resultado de la operaci�n de b�squeda de v�nculos.
               if Vinculos.Insertados > 0 then
                  begin
                  //Elimina las repeticiones innecesarias de la lista. Si encuentra
                  //repeticiones de un mismo m�vil, deja el de mayor probabilidad.
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
                                   if FiltrarNumeros(ri.MSISDN) = FiltrarNumeros(rj.MSISDN) then  //Si los n�mero se repiten:
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

                  //Muestra informaci�n sobre el tel�fono de inter�s y sus v�nculos.
                  FPrincipal.Resultados.Lines.Add('');                                 //Agrega un salto de l�nea.
                  msg := '/////////////////////////////////////////////////////';
                  msg := msg + '///////////////////////////////////////////////';
                  FPrincipal.Resultados.SelAttributes.Color := CColorDeTitulos;
                  FPrincipal.Resultados.Lines.Add(msg);                                //Pone el t�tulo de la lista.
                  msg := 'POSIBLES VINCULOS DEL MOVIL ' + Movil1 + ' SEGUN LA BASE DE DATOS:';
                  FPrincipal.Resultados.SelAttributes.Style := [fsBold];
                  FPrincipal.Resultados.SelAttributes.Color := CColorDeTitulos;
                  FPrincipal.Resultados.Lines.Add(msg);                                //Pone el t�tulo de la lista.

                  //Muestra la informaci�n de los v�nculos.
                  for m := 0 to Vinculos.Insertados - 1 do
                      begin
                      //Muestra en el informe de resultados.
                      FilaV := Vinculos.Obtener(m);                                    //Busca la fila.
                      Linea := ' ' + IntToStr(m + 1);                                  //Indice de la lista.
                      Linea := Linea + '- Con el m�vil ' + FilaV.MSISDN;               //Crea una l�nea con la fecha,
                      Linea := Linea + ' el d�a ' + DateToStr(FilaV.TiempoDeVinculo);  //con la hora, y con el
                      Linea := Linea + ' a las ' + TimeToStr(FilaV.TiempoDeVinculo);   //n�mero del v�nculo.
                      Linea := Linea + ' en la celda ' + FilaV.CELLID;
                      Linea := Linea + ' conocida como ' + FilaV.CELL + '.';
                      Linea := Linea + #9 + ' (Confiabilidad: ';
                      Linea := Linea + IntToStr(Round(FilaV.Probabilidad * 100));      //Probabilidad del v�nculo.
                      Linea := Linea + '%)';                                           //n�mero del v�nculo.
                      with FPrincipal.Resultados.SelAttributes do
                           if FilaV.Probabilidad >= 0.75 then                      //Selecciona el color con el que
                              begin                                                //se dibujar� el v�nculo en
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
                         Etiqueta := Etiqueta + #13 + Movil1 + ' y ' + FilaV.MSISDN;
                      FPrincipal.MostrarContacto(FilaV.CELLID,
                                                 FilaV.CELL,
                                                 ColorSimbolo,
                                                 Etiqueta
                                                 );

                      Application.ProcessMessages;                                 //Procesa los mensajes de windows.
                      if GetKeyState(VK_Escape) and 128 = 128 then Break;          //Si se pulsa la tecla ESC, se termina la b�squeda.
                      end;
                  end
               else
                  begin
                  //Muestra informaci�n al usuario sobre la ausencia de v�nculos.
                  FPrincipal.Resultados.Lines.Add('');                             //Agrega un salto de l�nea.
                  msg := '/////////////////////////////////////////////////////';
                  msg := msg + '///////////////////////////////////////////////';
                  FPrincipal.Resultados.SelAttributes.Color := CColorDeTitulos;
                  FPrincipal.Resultados.Lines.Add(msg);                            //Pone el t�tulo de la lista.
                  msg := 'EL MOVIL ' + Movil1 + ' NO TIENE POSIBLES V�NCULOS';
                  FPrincipal.Resultados.SelAttributes.Style := [fsBold];
                  FPrincipal.Resultados.SelAttributes.Color := CColorDeTitulos;
                  FPrincipal.Resultados.Lines.Add(msg);                            //Pone el t�tulo de la lista.
                  end;
               FPrincipal.PageControl1.ActivePageIndex := 1;                       //Muestra la p�gina de resultados.
               end;
       end;
   end;
Localizaciones.Free;                                                        //Libera la lista.
Vinculos.Free;
FPrincipal.Resultados.Enabled := True;
Close;
end;

//-----------------------------------------------------------------------------
procedure TFRelacionesEntreGrupos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Application.ProcessMessages;
end;

end.
