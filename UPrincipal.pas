
///////////////////////////////////////////////////////////////////////////////
// Autor:  Santiago Alejandro Orellana Pérez
//
// Fecha: 27/10/2013
///////////////////////////////////////////////////////////////////////////////

unit UPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB, Grids, DBGrids, DBClient, ComCtrls, Menus,
  ToolWin, ActnList, ImgList, UBase, GisBaseObject, GisViewer, GisViewerWnd,
  GisCsSystems, ExtCtrls, GisDefs, GisLayerVector, UListaDeRadiobases, Math;

type
  TFPrincipal = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TablaBD: TStringGrid;
    ToolBar1: TToolBar;
    MainMenu1: TMainMenu;
    Datos1: TMenuItem;
    Operaciones1: TMenuItem;
    Ayuda1: TMenuItem;
    ActionList1: TActionList;
    ImageList1: TImageList;
    ActionCargarBD: TAction;
    ActionGuardarBD: TAction;
    ActionGuardarBDComo: TAction;
    ActionCerrar: TAction;
    CargarunaBasedeDatos1: TMenuItem;
    GuardarlaBasedeDatos1: TMenuItem;
    GuardarlaBasedeDatoscomo1: TMenuItem;
    Cerrarelprograma1: TMenuItem;
    ActionAgregarDatos: TAction;
    N1: TMenuItem;
    AgregarDatos1: TMenuItem;
    N2: TMenuItem;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ActionMostrarMoviles: TAction;
    ActionBuscar: TAction;
    ActionVinculosDeUno: TAction;
    Filtrar1: TMenuItem;
    Buscar1: TMenuItem;
    Relacionaruno1: TMenuItem;
    N3: TMenuItem;
    TabSheet3: TTabSheet;
    ActionUtilizacion: TAction;
    ActionProcedencia: TAction;
    Resultados: TRichEdit;
    ActionMostrarCeldas: TAction;
    N4: TMenuItem;
    Mostrarceldas1: TMenuItem;
    ToolButton8: TToolButton;
    ActionRecorrido: TAction;
    ToolButton9: TToolButton;
    Recorrido1: TMenuItem;
    ActionGuardarR: TAction;
    ActionCopiarR: TAction;
    ActionBorrarR: TAction;
    ActionSeleccionarTodoR: TAction;
    Resultado1: TMenuItem;
    ActionGuardarR1: TMenuItem;
    Copiaralportapapeles1: TMenuItem;
    Borrarresultados1: TMenuItem;
    Seleccionartodoelresultado1: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    AgregarDatos2: TMenuItem;
    Procedencia1: TMenuItem;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton16: TToolButton;
    ToolButton17: TToolButton;
    ToolButton18: TToolButton;
    ToolButton19: TToolButton;
    ToolButton15: TToolButton;
    ToolButton20: TToolButton;
    ToolButton21: TToolButton;
    ActionVinculosEntreDos: TAction;
    ToolButton22: TToolButton;
    Vinculosentredosmviles1: TMenuItem;
    TabSheet2: TTabSheet;
    ActionVinculosEntreGrupos: TAction;
    Mapa: TGIS_ViewerWnd;
    ActionMover: TAction;
    ActionAmpliar: TAction;
    Mapa1: TMenuItem;
    Mover1: TMenuItem;
    Ampliar1: TMenuItem;
    ToolButton23: TToolButton;
    ToolButton24: TToolButton;
    ToolButton25: TToolButton;
    ToolButton26: TToolButton;
    PopupMenu1: TPopupMenu;
    Mover2: TMenuItem;
    Ampliar2: TMenuItem;
    N7: TMenuItem;
    ActionExportarImagen: TAction;
    Exportarimagen1: TMenuItem;
    ToolButton27: TToolButton;
    ActionBorrarMarcasYRutas: TAction;
    ToolButton28: TToolButton;
    Borrarmarcasyrutas1: TMenuItem;
    Exportarimagen2: TMenuItem;
    Borrarmarcasyrutas2: TMenuItem;
    ActionVerCompleto: TAction;
    Vermapacompleto1: TMenuItem;
    ToolButton29: TToolButton;
    Vinculosentregruposdemviles1: TMenuItem;
    ToolButton30: TToolButton;
    ActionNuevaBase: TAction;
    Nueva1: TMenuItem;
    ToolButton31: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure ActionCargarBDExecute(Sender: TObject);
    procedure ActionCerrarExecute(Sender: TObject);
    procedure ActionGuardarBDExecute(Sender: TObject);
    procedure ActionGuardarBDComoExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ActionAgregarDatosExecute(Sender: TObject);
    procedure ActionMostrarMovilesExecute(Sender: TObject);
    procedure ActionBuscarExecute(Sender: TObject);
    procedure ActionVinculosDeUnoExecute(Sender: TObject);
    procedure ActionUtilizacionExecute(Sender: TObject);
    procedure ActionProcedenciaExecute(Sender: TObject);
    procedure ActionMostrarCeldasExecute(Sender: TObject);
    procedure ActionRecorridoExecute(Sender: TObject);
    procedure ActionGuardarRExecute(Sender: TObject);
    procedure ActionCopiarRExecute(Sender: TObject);
    procedure ActionBorrarRExecute(Sender: TObject);
    procedure ActionSeleccionarTodoRExecute(Sender: TObject);
    procedure ActionVinculosEntreDosExecute(Sender: TObject);
    procedure ActionVinculosEntreGruposExecute(Sender: TObject);
    procedure ActionMoverExecute(Sender: TObject);
    procedure ActionAmpliarExecute(Sender: TObject);
    procedure ActionMoverUpdate(Sender: TObject);
    procedure ActionAmpliarUpdate(Sender: TObject);
    procedure ActionExportarImagenExecute(Sender: TObject);
    procedure ActionVerCompletoExecute(Sender: TObject);
    procedure ActionBorrarMarcasYRutasExecute(Sender: TObject);
    procedure ActionNuevaBaseExecute(Sender: TObject);
  private
    BaseDeDatosActual: String;                     //Nombre de la base de datos actualmente en uso.
    FicherosDeBaseDeDatosCargados: Integer;        //Cantidad de ficheros de Bases de datos cargados.

    GuardarCambiosDeBD: Boolean;

    MouseDownPoint: TPoint;                              //Guarda la posición del lugar donde se presiona el mouse.

    procedure IndicarFicheroParaGuardarBD;               //Permite al usuario indicar una ruta para guardar la Base de Datos.
    procedure GuardarBDEnTodoCaso;                       //Guarda los cambios de la Base de Datos en el fichero actual o en uno nuevo.
    function ConfirmarGuardarBD: Boolean;                //Pregunta al usuario si desea guardar los datos.
    procedure CargarBDDesde(Ruta: String);               //Carga la Base de Datos desde el fichero indicado.
    procedure GuardarBD;                                 //Guarda la base de datos en el fichero actualmente en uso.
    procedure BorrarTablaDeBaseDeDatos;
    procedure CargarMapaBase(Mapa: TGIS_ViewerWnd; RutaNombre: String);
    procedure ExportarImagen(Ruta: String);
    procedure CrearCapaDinamicaDeMarcas;
    procedure CrearCapaDinamicaDeEnlaces;
    function AsignarDatosALaMarca(var Marca: TGIS_Shape; Color: TColor; Etiqueta: String): Boolean;
    procedure CargarCoordenadasDeCelda;
    function ExtrearDatosDeRadiobase(Fila: String): TDatosDeCeldas;
    procedure InsertarEnLaListaDeRadiobases(DatosDeRadiobase: TDatosDeCeldas);
    function DistanciaDamerauLevenshtein(Arreglo1: TArrayDeBytes;       //Arreglo que contiene los datos de una de la cadena 1.
                                         Arreglo2: TArrayDeBytes;       //Arreglo con los datos de la otra cadena 2.
                                         LongitudArreglo1: Integer;     //Longitud de la candena 1.
                                         LongitudArreglo2: Integer      //Longitud de la candena 2.
                                         ): Integer;
    function SimilitudDamerauLevenshtein(Arreglo1: TArrayDeBytes;       //Arreglo que contiene los datos de una de la cadena 1.
                                         Arreglo2: TArrayDeBytes;       //Arreglo con los datos de la otra cadena 2.
                                         LongitudArreglo1: Integer;     //Longitud de la candena 1.
                                         LongitudArreglo2: Integer      //Longitud de la candena 2.
                                         ): Double;
  public
    RutaParaLasBasesDeDatos: String;                   //Aquí se guardan las rutas de las bases de datos.
    RutaParaLosResultados: String;                     //Aquí se guardan las rutas de los resultados.
    ListaDeMoviles: TListBox;                          //Esta es la lista de los móviles mensionados en la Base de Datos.
    ListaDeCeldas: TListaDeCeldas;
//    ListaDeRadiobases: TListaDeRadiobases;
    procedure CrearListaDeMoviles;
    function ExtrearCampos(Fila: String): TRegistroUbicacion;
    procedure InsertarEnLaBD(Fila: TRegistroUbicacion);          //Agrega a la Base de Datos la fila pasada.
    procedure ResaltarPalabra(Palabra: String; Color: TColor);   //Resalta una palabra en el resultado.
    procedure BorrarMarcasYRutas;
    procedure InsertarMarca(Coordenada: TGIS_Point; Color: TColor; Etiqueta: String);
    procedure InsertarRuta(Coordenadas: TCoordenadas; Color: TColor);
    function CoordenadaDeCelda(IDCelda: String; NombreCelda: String): TGIS_Point;
    procedure MostrarRecorrido(Coordenadas: TCoordenadas; ColorMarcas: TColor; ColorRutas: TColor);
    procedure MostrarContacto(IDCelda, NombreCelda: String; Color: TColor; Etiqueta: String);
    function Semejanza(A, B: String): Double;
  end;

var
  FPrincipal: TFPrincipal;

implementation

uses UEntradaDeDatos, DateUtils, UBuscar, URelacion, URecorrido,
  UProcedencia, URelacionDeDos, URelacionesEntreGrupos;

{$R *.dfm}

//-----------------------------------------------------------------------------
// Devuelve un registro que contiene los datos extraidos de la
// cadena de texto "Fila" luego de ser parseada.
//-----------------------------------------------------------------------------
function TFPrincipal.ExtrearCampos(Fila: String): TRegistroUbicacion;
var n, s: Integer;
    Tiempo: String;
begin
IniciarRegistro(Result);                     //Inicia el registro.

s := Pos(Sep, Fila);                         //Busca la posición del separador.
if s > 0 then                                //Si encuentra el separador:
   begin
   Tiempo := Copy(Fila, 1, s - 1);           //Copia la cadena desde el inicio hasta el separador.
   Delete(Fila, 1, s);                       //Luego borra la cadena incluyendo al separador.
   try
      Result.DATE := StrToDateTime(Tiempo);  //Transforma el dato.
   except
      Result.DATE := 0;                      //Si ocurre un error, se devuelve una fecha 0.
   end;
   end;

s := Pos(Sep, Fila);                         //Busca la posición del separador.
if s > 0 then                                //Si encuentra el separador:
   begin
   Result.MSISDN := Copy(Fila, 1, s - 1);    //Copia la cadena desde el inicio hasta el separador.
   Delete(Fila, 1, s);                       //Luego borra la cadena incluyendo al separador.
   end;

s := Pos(Sep, Fila);                         //Busca la posición del separador.
if s > 0 then                                //Si encuentra el separador:
   begin
   Result.CGI := Copy(Fila, 1, s - 1);       //Copia la cadena desde el inicio hasta el separador.
   Delete(Fila, 1, s);                       //Luego borra la cadena incluyendo al separador.
   end;

s := Pos(Sep, Fila);                         //Busca la posición del separador.
if s > 0 then                                //Si encuentra el separador:
   begin
   Result.CELLID := Copy(Fila, 1, s - 1);    //Copia la cadena desde el inicio hasta el separador.
   Delete(Fila, 1, s);                       //Luego borra la cadena incluyendo al separador.
   end;

s := Pos(Sep, Fila);                         //Busca la posición del separador.
if s > 0 then                                //Si encuentra el separador:
   begin
   Result.CELL := Copy(Fila, 1, s - 1);      //Copia la cadena desde el inicio hasta el separador.
   Delete(Fila, 1, s);                       //Luego borra la cadena incluyendo al separador.
   end;

s := Pos(Sep, Fila);                         //Busca la posición del separador.
if s > 0 then                                //Si encuentra el separador:
   begin
   Result.ERROR := Copy(Fila, 1, s - 1);     //Copia la cadena desde el inicio hasta el separador.
   Delete(Fila, 1, s);                       //Luego borra la cadena incluyendo al separador.
   end;

Result.AGE := Fila;                          //Lo último que queda lo copia aquí.
end;

//-----------------------------------------------------------------------------
// Carga la Base de Datos desde el fichero indicado.
//-----------------------------------------------------------------------------
procedure TFPrincipal.CargarBDDesde(Ruta: String);
var X, Y, Errores: Integer;
    Fila: String;
    Registro: TRegistroUbicacion;
    FicheroBD: TextFile;
    msg: String;
begin
if FileExists(Ruta) then
   begin
   Errores := 0;
   AssignFile(FicheroBD, Ruta);                    //Declara un fichero con el nombre de la Base de Datos actual.
   Reset(FicheroBD);                               //Abre el fichero desde el dispositivo.
   while not Eof(FicheroBD) do                     //Mientras haya datos que leer del fichero:
         begin
         Readln(FicheroBD, Fila);                  //Lee una linea del fichero.
         Registro := ExtrearCampos(Fila);          //Parsea los datos de la String.
         if Registro.DATE <> 0 then
            InsertarEnLaBD(Registro)               //Inserta un nuevo registro en la tabla de la Base de Datos.
         else
            Inc(Errores);
         end;
   CloseFile(FicheroBD);                           //Cerramos el fichero de la base de Datos.
   if Errores > 0 then
      begin
      msg :=       'No se ha podido cargar el fichero correctamente.' + #13;
      msg := msg + 'Se han encontrado errores en ' + IntToStr(Errores) + ' registros.';
      Application.MessageBox(PChar(msg), 'Error en los datos', MB_ICONERROR);
      end;
   BaseDeDatosActual := Ruta;
   GuardarCambiosDeBD := False;
   end;
end;

//-----------------------------------------------------------------------------
// Guarda la Base de Datos en el fichero actualmente en uso.
//-----------------------------------------------------------------------------
procedure TFPrincipal.GuardarBD;
const Sep = ';';
var X, Y: Integer;
    Fila: String;
    FicheroBD: TextFile;
begin
AssignFile(FicheroBD, BaseDeDatosActual);       //Crea el fichero con el nombre de la Base de Datos actual.
Rewrite(FicheroBD);                             //Escribe el fichero en el dispositivo.
for Y := 1 to TablaBD.RowCount - 2 do           //Lee cada una de los registros de la tabla.
    begin
    if Y > 1 then Write(FicheroBD, #13#10);     //Agrega un salto de línea si no es la primera fila.
    Fila := '';                                 //Inicia la fila vacía.
    for X := 0 to TablaBD.ColCount - 1 do       //Lee cada celda del registro actual.
        begin
        if X <> 0 then Fila := Fila + Sep;      //Si no es la primera celda, se añade un separador.
        Fila := Fila + TablaBD.Cells[X, Y];     //Agrega el valor de la celda.
        end;
    Write(FicheroBD, Fila);                     //Copia la fila en el fichero de Base de Datos.
    end;
CloseFile(FicheroBD);                           //Cerramos el fichero de la base de Datos.
GuardarCambiosDeBD := False;
FicherosDeBaseDeDatosCargados := 1;
end;

//-----------------------------------------------------------------------------
// Permite al usuario indicar un fichero para guardar las marcas.
//-----------------------------------------------------------------------------
procedure TFPrincipal.IndicarFicheroParaGuardarBD;
var dlg: TSaveDialog;
    msg: String;
begin
msg := 'Ya existe un fichero con el mismo nombre.' + #13 + '¿Desea sobrescribirlo?';
dlg := TSaveDialog.Create(Self);
dlg.DefaultExt := CTipoDeFicheroDeLaBD;
dlg.Filter := 'Ficheros ' + CTipoDeFicheroDeLaBD + '|*.' + CTipoDeFicheroDeLaBD +
              '|Todos los ficheros|*.*';
dlg.InitialDir := RutaParaLasBasesDeDatos;
while true do                                                      //Solo se sale de este ciclo si el usuario guarda el fichero.
      begin                                                        //Abre un diálogo para guardar el fichero y:
      if dlg.Execute then                                          //Si el fichero ya existe, pide una confirmación para sobrescribirlo.
         begin
         if FileExists(dlg.FileName) then
            case Application.MessageBox(PChar(msg), 'Confirme su acción', MB_YESNOCANCEL) of
                 IDNO: Continue;                                   //Abre nuevamente el diálogo de guardar.
                 IDCANCEL: Break;                                  //Sale de la función sin guardar.
                 end;
         BaseDeDatosActual := dlg.FileName;                        //Guarda el nombre del fichero seleccionado.
         GuardarBD;                                                //Guarda los datos en el fichero actualmente seleccionado.
         break;
         end
      else
         Break;
      end;
dlg.Free;
end;

//-----------------------------------------------------------------------------
// Guarda los cambios de los datos.
//-----------------------------------------------------------------------------
procedure TFPrincipal.GuardarBDEnTodoCaso;
begin
if (BaseDeDatosActual <> '') and                 //Si existe un fichero para guardar la Base de Datos:
   (FicherosDeBaseDeDatosCargados = 1) and       //Si solo se ha cargado un fichero de Base de Datos:
   FileExists(BaseDeDatosActual) then            //Guarda los datos en el fichero de la Base de Datos.
   GuardarBD
else                                             //Si no existe el fichero:
   IndicarFicheroParaGuardarBD;                  //Pide al usuario que indique un fichero.
end;

//-----------------------------------------------------------------------------
// Le pregunta al usuario si desea guardar las marcas
// actuales. Si el usuario desea guardarlas, se guardan
// en el fichero actual o se le pide que indique uno.
//-----------------------------------------------------------------------------
function TFPrincipal.ConfirmarGuardarBD: Boolean;
const msg = '¿Desea guardar las marcas operativas actuales?';
begin
Result := True;
case Application.MessageBox(PChar(msg), 'Confirme su acción', MB_YESNOCANCEL) of
     IDYES: GuardarBDEnTodoCaso;           //Intenta guardar los datos.
     IDCANCEL: Result := False;            //Detiene la operación.
     end;
end;

//-----------------------------------------------------------------------------
// Guarda la fila en la tabla de la Base de Datos.
//-----------------------------------------------------------------------------
procedure TFPrincipal.InsertarEnLaBD(Fila: TRegistroUbicacion);
begin
TablaBD.Cells[0, TablaBD.RowCount - 1] := DateTimeToStr(Fila.DATE);
TablaBD.Cells[1, TablaBD.RowCount - 1] := Fila.MSISDN;
TablaBD.Cells[2, TablaBD.RowCount - 1] := Fila.CGI;
TablaBD.Cells[3, TablaBD.RowCount - 1] := Fila.CELLID;
TablaBD.Cells[4, TablaBD.RowCount - 1] := Fila.CELL;
TablaBD.Cells[5, TablaBD.RowCount - 1] := Fila.ERROR;
TablaBD.Cells[6, TablaBD.RowCount - 1] := Fila.AGE;
TablaBD.RowCount := TablaBD.RowCount + 1;
GuardarCambiosDeBD := True; 
end;

//-----------------------------------------------------------------------------
// Inicia la tabla de datos.
//-----------------------------------------------------------------------------
procedure TFPrincipal.BorrarTablaDeBaseDeDatos;
begin
TablaBD.RowCount := 2;
TablaBD.Cells[0, 0] := 'DATE';
TablaBD.Cells[1, 0] := 'MSISDN';
TablaBD.Cells[2, 0] := 'CGI';
TablaBD.Cells[3, 0] := 'CELLID';
TablaBD.Cells[4, 0] := 'CELL';
TablaBD.Cells[5, 0] := 'ERROR';
TablaBD.Cells[6, 0] := 'AGE';
TablaBD.Rows[1].Clear;
if Assigned(ListaDeMoviles) then
   ListaDeMoviles.Clear;
end;

//-----------------------------------------------------------------------------
// Carga el mapa indicado, que se encuentra guardado con extensión TTKGP.
//-----------------------------------------------------------------------------
procedure TFPrincipal.CargarMapaBase(Mapa: TGIS_ViewerWnd; RutaNombre: String);
begin
RutaNombre := ExtractFilePath(Application.ExeName) + '\' + CarpetaDeMapas + '\' + RutaNombre;
if FileExists(RutaNombre) then
   begin
   Mapa.Open(RutaNombre);                   //Carga el mapa.
   Mapa.CS := CSUnknownCoordinateSystem;    //Establece el sistema de coordenadas (Me funciona bien con este valor en el parámetro).
   Mapa.FullExtent;                         //Muestra el mapa en su máxima extensión.
   end;
end;

//-----------------------------------------------------------------------------
// Inicia el formulario y sus componentes.
//-----------------------------------------------------------------------------
procedure TFPrincipal.FormCreate(Sender: TObject);
begin
//Inicia la tabla de datos.
BorrarTablaDeBaseDeDatos;

RutaParaLasBasesDeDatos := 'c:\';
BaseDeDatosActual := '';

GuardarCambiosDeBD := False;

FicherosDeBaseDeDatosCargados := 0;

//Inicia la lista de los teléfonos mencionados en la Base de Datos.
ListaDeMoviles := TListBox.CreateParented(Handle);

PageControl1.ActivePageIndex := 0;

ListaDeCeldas := TListaDeCeldas.Create;
ListaDeCeldas.Vaciar;

CargarCoordenadasDeCelda;

CargarMapaBase(Mapa, FicheroMapaBase);

//Crea las capas dinámicas.
CrearCapaDinamicaDeMarcas;
CrearCapaDinamicaDeEnlaces;
end;

//-----------------------------------------------------------------------------
// Para cargar la base de datos.
//-----------------------------------------------------------------------------
procedure TFPrincipal.ActionCargarBDExecute(Sender: TObject);
var dlg: TOpenDialog;
    n: Integer;
begin
if GuardarCambiosDeBD then                              //Si se han realizado cambios en la capa de marcas actual:
   if not ConfirmarGuardarBD then Exit;                 //Si el usuario detiene la operación, sale.
dlg := TOpenDialog.Create(Self);
dlg.Options := [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing];
dlg.DefaultExt := CTipoDeFicheroDeLaBD;
dlg.Filter := 'Ficheros ' + CTipoDeFicheroDeLaBD + '|*.' + CTipoDeFicheroDeLaBD +
              '|Todos los ficheros|*.*';
dlg.InitialDir := RutaParaLasBasesDeDatos;
FicherosDeBaseDeDatosCargados := 0;
if dlg.Execute then
   begin
   BorrarTablaDeBaseDeDatos;
   for n := 0 to dlg.Files.Count - 1 do
       if FileExists(dlg.Files[n]) then
          begin
          CargarBDDesde(dlg.Files[n]);
          Inc(FicherosDeBaseDeDatosCargados);
          end;
   end;       
CrearListaDeMoviles;                            //Busca los móviles existentes en la Base de Datos.
dlg.Free;
end;

//-----------------------------------------------------------------------------
// Para guardar la base de datos.
//-----------------------------------------------------------------------------
procedure TFPrincipal.ActionGuardarBDExecute(Sender: TObject);
begin
GuardarBDEnTodoCaso;
end;

//-----------------------------------------------------------------------------
// Para guardar la base de datos en otra dirección.
//-----------------------------------------------------------------------------
procedure TFPrincipal.ActionGuardarBDComoExecute(Sender: TObject);
begin
IndicarFicheroParaGuardarBD;
end;

//-----------------------------------------------------------------------------
// Cierra el programa.
//-----------------------------------------------------------------------------
procedure TFPrincipal.ActionCerrarExecute(Sender: TObject);
begin
Close;
end;

//-----------------------------------------------------------------------------
// Si el usuario intenta cerrar el programa, verifica que todo esté guardado.
// Si hay datos sin guardar, le pregunta al usuario si desea guardarlos.
//-----------------------------------------------------------------------------
procedure TFPrincipal.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
if (GuardarCambiosDeBD) or                              //Si se han realizado cambios en la capa de marcas
   (FicherosDeBaseDeDatosCargados > 1) then             //actual o se han cargado más de un fichero:
   if not ConfirmarGuardarBD then                       //Si el usuario detiene la operación, no sale.
      CanClose := false;
end;

//-----------------------------------------------------------------------------
// Permite agregar datos a la Base de Datos.
//-----------------------------------------------------------------------------
procedure TFPrincipal.ActionAgregarDatosExecute(Sender: TObject);
begin
with TFEntradaDeDatos.Create(Self) do ShowModal;
end;

//-----------------------------------------------------------------------------
// Crea lalista de los móviles de la Base de Datos.
//-----------------------------------------------------------------------------
procedure TFPrincipal.CrearListaDeMoviles;
var n: Integer;
    msg, Movil: String;
begin
ListaDeMoviles.Free;
ListaDeMoviles := TListBox.CreateParented(Handle);
with FPrincipal.TablaBD do                                          //Se busca en la tabla del formulario principal.
     if RowCount > 0 then                                           //La búsqueda continúa si hay registros.
        begin
        for n := 1 to RowCount - 1 do                               //Busca en cada registro desde el primero.
            begin
            Movil := FiltrarNumeros(Cells[1, n]);                   //Filtra la cadena dejando solo los números.
            if Movil <> '' then
               if ListaDeMoviles.Items.IndexOf(Movil) = -1 then     //Si el número no se encuentra en la lista.
                  ListaDeMoviles.Items.Add(Movil);                  //Guarda el número del teléfono.
            Application.ProcessMessages;                            //Procesamos los mensajes de windows.
            if GetKeyState(VK_Escape) and 128 = 128 then            //Se espera a que el usuario presione la tecla Escape.
               begin
               msg := 'Operación cancelada por el usuario.';
               Application.MessageBox(PChar(msg), '', MB_OK);
               Break;                                               //Si se pulsa la tecla ESC, se termina la búsqueda.
               end;
            end;
        end;
end;

//-----------------------------------------------------------------------------
// Muestra los móviles existentes en la Base de datos.
// Busca en la Base de Datos todos los números de teléfonos
// móviles y los muestra en el informe de resultados.
//-----------------------------------------------------------------------------
procedure TFPrincipal.ActionMostrarMovilesExecute(Sender: TObject);
var n: Integer;
    msg, Movil: String;
begin
if ListaDeMoviles.Items.Count > 0 then                 //Si la lista está llena:
   begin                                               //Agrega la lista al informe de resultados.
   Resultados.Lines.Add('');                           //Agrega un salto de línea.
   msg := '/////////////////////////////////////////////////////';
   Resultados.SelAttributes.Color := CColorDeTitulos;
   Resultados.Lines.Add(msg);                          //Pone el título de la lista.
   msg := 'MOVILES MENCIONADOS EN LA BASE DE DATOS';
   Resultados.SelAttributes.Style := [fsBold];
   Resultados.SelAttributes.Color := CColorDeTitulos;
   Resultados.Lines.Add(msg);                          //Pone el título de la lista.
   Resultados.Lines.AddStrings(ListaDeMoviles.Items);  //Copia la lista en el informe de resultados.
   PageControl1.ActivePageIndex := 1;
   end;
end;

//-----------------------------------------------------------------------------
// Muestra las celdas mencionadas en la Base de datos.
// Busca en la Base de Datos todos los ID de las celdas
// y los muestra en el informe de resultados.
//-----------------------------------------------------------------------------
procedure TFPrincipal.ActionMostrarCeldasExecute(Sender: TObject);
var n: Integer;
    msg, Celda: String;
    ListaID: TListBox;
    ListaNombre: TListBox;
begin
ListaID := TListBox.CreateParented(Handle);
ListaNombre := TListBox.CreateParented(Handle);
with FPrincipal.TablaBD do                                     //Se busca en la tabla del formulario principal.
     if RowCount > 0 then                                      //La búsqueda continúa si hay registros.
        begin
        for n := 1 to RowCount - 1 do                          //Busca en cada registro desde el primero.
            begin
            Celda := Cells[3, n];                              //Filtra la cadena dejando solo los ID.
            if Celda <> '' then
               if ListaID.Items.IndexOf(Celda) = -1 then       //Si el ID no se encuentra en la lista.
                  begin
                  ListaID.Items.Add(Celda);                    //Guarda el ID de la celda.
                  ListaNombre.Items.Add(Cells[4, n]);          //Guarda el nombre de la celda.
                  end;
            Application.ProcessMessages;                       //Procesamos los mensajes de windows.
            if GetKeyState(VK_Escape) and 128 = 128 then       //Se espera a que el usuario presione la tecla Escape.
               begin
               msg := 'Operación cancelada por el usuario.';
               Application.MessageBox(PChar(msg), '', MB_OK);
               Break;                                          //Si se pulsa la tecla ESC, se termina la búsqueda.
               end;
            end;
        if ListaID.Items.Count > 0 then                        //Si la lista está llena:
           begin                                               //Agrega la lista al informe de resultados.
           Resultados.Lines.Add('');                           //Agrega un salto de línea.
           msg := '/////////////////////////////////////////////////////';
           Resultados.SelAttributes.Color := CColorDeTitulos;
           Resultados.Lines.Add(msg);                          //Pone el título de la lista.
           msg := 'CELDAS MENCIONADAS EN LA BASE DE DATOS';
           Resultados.SelAttributes.Style := [fsBold];
           Resultados.SelAttributes.Color := CColorDeTitulos;
           Resultados.Lines.Add(msg);                          //Pone el título de la lista.
           with ListaID do
                for n := 0 to Count - 1 do
                    Items[n] := Items[n] + #9 + '(' + ListaNombre.Items[n] + ')';
           Resultados.Lines.AddStrings(ListaID.Items);         //Copia la lista en el informe de resultados.
           ListaID.Free;
           ListaNombre.Free;
           PageControl1.ActivePageIndex := 1;
           end;
        end;
end;

//-----------------------------------------------------------------------------
// Resalta una palabra en el informe de resultados.
//-----------------------------------------------------------------------------
procedure TFPrincipal.ResaltarPalabra(Palabra: String; Color: TColor);
var Texto: string;
    Posicion: integer;
begin
Texto := Resultados.Lines.Text;
repeat
   Posicion := Ansipos(Palabra, Texto);
   Resultados.SelStart := Posicion - 1;
   Resultados.SelLength := Length(Palabra);
   Resultados.SelAttributes.Color := Color;
   Texto[Posicion + 1] := Chr(255);
   Posicion := Ansipos(Palabra, Texto);
until (Posicion = 0);
end;

//-----------------------------------------------------------------------------
// Abre una herramienta que permite buscar una cadena de texto en los datos.
//-----------------------------------------------------------------------------
procedure TFPrincipal.ActionBuscarExecute(Sender: TObject);
begin
with TFBuscar.Create(Self) do Show;
end;

//-----------------------------------------------------------------------------
// Abre una herramienta que permite buscar los móviles que
// han estado en las mismas celdas que el móvil especificado.
// Relaciona un móvil dado con el resto de los que se encuentran
// en la Base de Datos, por medio de las celdas que los han atendido.
//-----------------------------------------------------------------------------
procedure TFPrincipal.ActionVinculosDeUnoExecute(Sender: TObject);
begin
with TFRelacion.Create(Self) do ShowModal;
end;

//-----------------------------------------------------------------------------
// Abre una herramienta que permite obtener el recorrido de un
// móvil por medio de las celdas que le han atendido.
//-----------------------------------------------------------------------------
procedure TFPrincipal.ActionRecorridoExecute(Sender: TObject);
begin
with TFRecorrido.Create(Self) do ShowModal;
end;

//-----------------------------------------------------------------------------
// Borra el contenido del informe de resultados.
//-----------------------------------------------------------------------------
procedure TFPrincipal.ActionBorrarRExecute(Sender: TObject);
begin
Resultados.Clear;
end;

//-----------------------------------------------------------------------------
// Copia el contenido del informe de resultados en el portapapeles.
//-----------------------------------------------------------------------------
procedure TFPrincipal.ActionCopiarRExecute(Sender: TObject);
begin
Resultados.CopyToClipboard;
end;

//-----------------------------------------------------------------------------
// Selecciona todo el contenido del informe de resultados.
//-----------------------------------------------------------------------------
procedure TFPrincipal.ActionSeleccionarTodoRExecute(Sender: TObject);
begin
Resultados.SetFocus;
Resultados.SelectAll;
end;

//-----------------------------------------------------------------------------
// Abre un diálogo para guardar el fichero de resultados.
//-----------------------------------------------------------------------------
procedure TFPrincipal.ActionGuardarRExecute(Sender: TObject);
var dlg: TSaveDialog;
    msg: String;
begin
msg := 'Ya existe un fichero con el mismo nombre.' + #13 + '¿Desea sobrescribirlo?';
dlg := TSaveDialog.Create(Self);
dlg.DefaultExt := 'RTF';
dlg.Filter := 'Ficheros RTF|*.RTF|Todos los ficheros|*.*';
dlg.InitialDir := RutaParaLosResultados;
while true do                                                      //Solo se sale de este ciclo si el usuario guarda el fichero.
      begin                                                        //Abre un diálogo para guardar el fichero y:
      if dlg.Execute then                                          //Si el fichero ya existe, pide una confirmación para sobrescribirlo.
         begin
         if FileExists(dlg.FileName) then
            case Application.MessageBox(PChar(msg), 'Confirme su acción', MB_YESNOCANCEL) of
                 IDNO: Continue;                                   //Abre nuevamente el diálogo de guardar.
                 IDCANCEL: Break;                                  //Sale de la función sin guardar.
                 end;
         RutaParaLosResultados := ExtractFilePath(dlg.FileName);   //Guarda la ruta de los resultados.
         Resultados.Lines.SaveToFile(dlg.FileName);                //Guarda el resultado en un fichero.
         break;
         end
      else
         Break;
      end;
dlg.Free;
end;

//-----------------------------------------------------------------------------
// Muestra la ayuda de utilización del programa.
//-----------------------------------------------------------------------------
procedure TFPrincipal.ActionUtilizacionExecute(Sender: TObject);
var msg: String;
begin
msg :=       'Proc GSM' + #13#13;
msg := msg + 'Es un programa para el procesamiento de la información obtenida a partir' + #13;
msg := msg + 'de la red GSM. Los datos se insertan manualmente por el analista que se' + #13;
msg := msg + 'encarga de procesarlos. El programa facilita el análisis al descubrir' + #13;
msg := msg + 'posibles vínculos sobre la base de las relaciones espacio-temporales' + #13;
msg := msg + 'de los dispositivos móviles.' + #13#13;
msg := msg + 'Para utilizarlo siga los siguientes pasos:' + #13;
msg := msg + '1 - Con el menú "Datos", inserte datos en el programa y guarde la Base de Datos.' + #13;
msg := msg + '2 - Luego puede realizar el análisis mediante el menú "Operaciones".' + #13;
msg := msg + '3 - Los resultados obtenidos se pueden guardar mediante el menú "Resultado"' + #13#13;
msg := msg + 'Notas:' + #13;
msg := msg + 'El fichero de Base de Datos creado por el programa puede ser abierto por' + #13;
msg := msg + 'el programa Excel o ser procesado con cualquier editor de texto.' + #13;
msg := msg + 'El fichero donde se guarda el informe de resultados puede abrirse' + #13;
msg := msg + 'con cualquier editor o procesador de texto sencillo.' + #13;
Application.MessageBox(PChar(msg), 'Ayuda', MB_OK);
end;

//-----------------------------------------------------------------------------
// Muestra la procedencia del programa del programa.
//-----------------------------------------------------------------------------
procedure TFPrincipal.ActionProcedenciaExecute(Sender: TObject);
begin
with TFProcedencia.Create(Self) do ShowModal;
end;

//-----------------------------------------------------------------------------
// Abre una herramienta que permite buscar las relaciones entre
// dos móviles que han estado en las mismas celdas.
// Relaciona dos móviles que se encuentran en la Base de Datos,
// por medio de las celdas que los han atendido.
//-----------------------------------------------------------------------------
procedure TFPrincipal.ActionVinculosEntreDosExecute(Sender: TObject);
begin
with TFRelacionDeDos.Create(Self) do ShowModal;
end;

//-----------------------------------------------------------------------------
// Abre un aherramienta que permite buscar las relaciones entre varias
// parejas de móviles que han estado en el mismo espacio-tiempo.
//-----------------------------------------------------------------------------
procedure TFPrincipal.ActionVinculosEntreGruposExecute(Sender: TObject);
begin
with TFRelacionesEntreGrupos.Create(Self) do ShowModal;
end;

//-----------------------------------------------------------------------------
// Selecciona el tipo de herramienta a utilizar.
//-----------------------------------------------------------------------------
procedure TFPrincipal.ActionMoverExecute(Sender: TObject);
begin
Mapa.Mode := gisDrag;
end;

procedure TFPrincipal.ActionAmpliarExecute(Sender: TObject);
begin
Mapa.Mode := gisZoomEx;
end;

//-----------------------------------------------------------------------------
// Unde el botón correspondiente al tipo de herramienta activa.
//-----------------------------------------------------------------------------
procedure TFPrincipal.ActionMoverUpdate(Sender: TObject);
begin
ActionMover.Checked := Mapa.Mode = gisDrag;
end;

procedure TFPrincipal.ActionAmpliarUpdate(Sender: TObject);
begin
ActionAmpliar.Checked := Mapa.Mode = gisZoomEx;
end;

//-----------------------------------------------------------------------------
// Guarda una imagen de la parte visible del mapa.
//-----------------------------------------------------------------------------
procedure TFPrincipal.ExportarImagen(Ruta: String);
var img: TImage;
begin
img := TImage.Create(Self);                           //Crea un componente de imagen en memoria.
img.Width := Mapa.Width;                              //Le asigna el mismo ancho y la misma
img.Height := Mapa.Height;                            //altura que el componente del mapa.
img.Canvas.CopyRect(img.ClientRect,                   //Copia en toda su area la imagen del mapa.
                    Mapa.DeviceGhost.Canvas,          //La imagen se copia desde aquí.
                    Mapa.ClientRect                   //Se copia la imagen completa del mapa.
                    );                                //Luego guarda la imagen copiada en un fichero
img.Picture.SaveToFile(Ruta);                         //con la ruta, nombre y extensión indicados.
end;

//-----------------------------------------------------------------------------
// Guarda una imagen de la parte visible del mapa.
//-----------------------------------------------------------------------------
procedure TFPrincipal.ActionExportarImagenExecute(Sender: TObject);
var dlg: TSaveDialog;
    msg: String;
begin
msg := 'Ya existe un fichero con el mismo nombre.' + #13 + '¿Desea sobrescribirlo?';
dlg := TSaveDialog.Create(Self);
dlg.DefaultExt := 'BMP';
dlg.Filter := 'Ficheros BMP|*.BMP|Ficheros TIF|*.TIF|Ficheros PNG|*.PNG|FIcheros JPG|*.JPG|Todos los ficheros|*.*';
dlg.InitialDir := RutaParaLosResultados;
while true do                                         //Solo se sale de este ciclo si el usuario guarda el fichero.
      begin                                           //Abre un diálogo para guardar el fichero y:
      if dlg.Execute then                             //Si el fichero ya existe, pide una confirmación para sobrescribirlo.
         begin
         if FileExists(dlg.FileName) then
            case Application.MessageBox(PChar(msg), 'Confirme su acción', MB_YESNOCANCEL) of
                 IDNO: Continue;                      //Abre nuevamente el diálogo de guardar imagen.
                 IDCANCEL: Break;                     //Sale de la función sin guardar la imagen.
                 end;
         ExportarImagen(dlg.FileName);
         RutaParaLosResultados := GetFilePath(dlg.FileName);
         break;
         end
      else
         Break;
      end;
dlg.Free;
Mapa.Invalidate;
end;

//-----------------------------------------------------------------------------
// Crea una capa dinámica para las marcas.
//-----------------------------------------------------------------------------
procedure TFPrincipal.CrearCapaDinamicaDeMarcas;
var Layer : TGIS_LayerVector;
begin
if Mapa.IsEmpty then exit;
if Mapa.Get(C_CAPA_MARCAS) <> nil then Exit;
Layer := TGIS_LayerVector.Create;                 //Crea la capa nueva.
Layer.CS := Mapa.CS;                              //Establece el mismo sistema de coordenadas del mapa.
Layer.Name := C_CAPA_MARCAS;                      //Nombre con que identifica a la capa.
Layer.Caption := 'Marcas';                        //Nombre con que se muestra la capa.
Mapa.Add(Layer);                                  //Agrega la capa al visor.
end;

//-----------------------------------------------------------------------------
// Crea una capa dinámica para los enlaces entre las marcas.
//-----------------------------------------------------------------------------
procedure TFPrincipal.CrearCapaDinamicaDeEnlaces;
var Layer : TGIS_LayerVector;
begin
if Mapa.IsEmpty then exit;
if Mapa.Get(C_CAPA_ENLACES) <> nil then Exit;
Layer := TGIS_LayerVector.Create;                     //Crea la capa nueva.
Layer.CS := Mapa.CS;                                  //Establece el mismo sistema de coordenadas del mapa.
Layer.Name := C_CAPA_ENLACES;                         //Nombre con que identifica a la capa.
Layer.Caption := 'Enlaces';                           //Nombre con que se muestra la capa.
Layer.Params.Labels.Allocator := False;
Mapa.Add(Layer);                                      //Agrega la capa al visor.
end;

//-----------------------------------------------------------------------------
// Dado un objeto (Shape), esta función le asigna al objeto los datos
// pasados como parámetro en la estructura tipo TDatoOperativo.
//-----------------------------------------------------------------------------
function TFPrincipal.AsignarDatosALaMarca(var Marca: TGIS_Shape; Color: TColor; Etiqueta: String): Boolean;
var Longitud: Double;
    Tiempo: TDateTime;
begin
Result := False;
if not Assigned(Marca) then Exit;
try
   with Marca do
        begin
        Params.Marker.Style := gisMarkerStyleCircle;                     //El símbolo será un círculo.
        Params.Marker.Size := -15;                                       //Ancho del símbolo.
        Params.Marker.Color := Color;                                    //Color del objeto.
        Params.Marker.OutlineColor := clBlack;                           //Color del borde del objeto.
        Params.Marker.OutlineWidth := -1;                                //Grozor del borde del objeto.
        Params.Marker.OutlineStyle := psSolid;                           //Estilo de las líneas.

        Params.Labels.Value := Etiqueta;
        Params.Labels.Visible := Etiqueta <> '';
        Params.Labels.Font := FPrincipal.font;
        Params.Labels.Font.Name := 'Arial';
        Params.Labels.Font.Color := clBlack;
        Params.Labels.Alignment := gisLabelAlignmentLeftJustify;
        Params.Labels.Position := [gisLabelPositionUpRight];
        Params.Labels.Rotate := 0;
        Params.Labels.Pattern := bsSolid;
        Params.Labels.Color := clYellow; 
        Params.Labels.Width := -300;
        Params.Labels.Height := -300;
        Params.Labels.OutlineStyle := psSolid;
        Params.Labels.OutlineWidth := -1;
        Params.Labels.OutlineColor := clBlack;
        Params.Labels.Field := '';                                             //Establece los campos que deben mostrar las etiquetas.

        Params.Labels.Allocator := False;                                      //No se previenen los solapamientos.
        Params.Labels.Duplicates := True;                                      //Para que se vean los duplicados.
        Params.Labels.SmartSize := 0;
        end;
   Result := True;                                                                //Retorna Verdadero si se pudieron asignar los datos al objeto.
except
   Result := False;                                                               //Si ocurrió un error, retorna Falso.
end;
end;

//-----------------------------------------------------------------------------
// Inserta una marca en la capa de puntos.
//-----------------------------------------------------------------------------
procedure TFPrincipal.InsertarMarca(Coordenada: TGIS_Point; Color: TColor; Etiqueta: String);
var Marca: TGIS_Shape;
begin
if Mapa.IsEmpty then exit ;                                         //Si el mapa no tiene capas, sale...
if Mapa.Get(C_CAPA_MARCAS) = nil then Exit;                         //Si la capa de las marcas operativas no existe, sale...
Marca := TGIS_ShapePoint(TGIS_LayerVector(Mapa.Get(C_CAPA_MARCAS)).CreateShape(gisShapeTypePoint));
if AsignarDatosALaMarca(Marca, Color, Etiqueta) then                //Le asigna al objeto los datos.
   try                                                              //Agrega el objeto al mapa.
      Marca.Lock(gisLockExtent);                                    //Bloquea la marca en el mapa.
      Marca.AddPart;                                                //Prepara para agregar partes al mapa.
      Marca.AddPoint(Coordenada);                                   //Le asigna una posición al objeto.
      Marca.UnLock;                                                 //Desbloquea el mapa.
      Marca.Invalidate;                                             //Actualiza la vista del mapa mostrando el objeto.
   except
      MessageBox(0, 'Ocurrieron problemas al insertar la marca en el mapa.', 'Error...', MB_ICONERROR);
   end
else
   MessageBox(0, 'Ocurrieron problemas al asignar los datos a la marca.', 'Error...', MB_ICONERROR);
end;

//-----------------------------------------------------------------------------
// Inserta una ruta en la capa de puntos.
//-----------------------------------------------------------------------------
procedure TFPrincipal.InsertarRuta(Coordenadas: TCoordenadas; Color: TColor);
var n: Integer;
    Enlace: TGIS_Shape;
begin
if Length(Coordenadas) > 1 then
   begin
   Enlace := TGIS_ShapePoint(TGIS_LayerVector(Mapa.Get(C_CAPA_ENLACES)).CreateShape(gisShapeTypeArc));
   Enlace.Params.Line.Color := Color;                          //Asigna un color a la marcación.
   Enlace.Params.Line.Style := psSolid;                        //Le asigna estilo a la linea de marcación.
   Enlace.Params.Line.Width := -3;                             //Le asigna ancho a la linea de marcación.
   for n := 0 to Length(Coordenadas) - 2 do
       begin
       Enlace.Lock(gisLockExtent);                             //Bloquea el mapa.
       Enlace.AddPart;                                         //Prepara para agregar partes al mapa.
       Enlace.AddPoint(Coordenadas[n]);                        //Le asigna punto inicial a la linea.
       Enlace.AddPoint(Coordenadas[n + 1]);                    //Le asigna punto final a la linea.
       Enlace.UnLock;                                          //Desbloquea la marca en el mapa.
       Enlace.Invalidate;                                      //Actualiza la vista del mapa mostrando el objeto.
       end;
   end;
end;

//-----------------------------------------------------------------------------
// Muestra en el mapa el recorrido de un móvil.
//-----------------------------------------------------------------------------
procedure TFPrincipal.MostrarRecorrido(Coordenadas: TCoordenadas; ColorMarcas: TColor; ColorRutas: TColor);
var n, Final: Integer;
    Enlace: TGIS_Shape;
    Etiqueta: String;
begin
Final := Length(Coordenadas);
if Final > 0 then
   begin
   Enlace := TGIS_ShapePoint(TGIS_LayerVector(Mapa.Get(C_CAPA_ENLACES)).CreateShape(gisShapeTypeArc));
   Enlace.Params.Line.Color := ColorRutas;                     //Asigna un color a la ruta.
   Enlace.Params.Line.Style := psSolid;                        //Le asigna estilo a la linea de marcación.
   Enlace.Params.Line.Width := -3;                             //Le asigna ancho a la linea de marcación.
   Dec(Final);
   for n := 0 to Final do
       begin
       Etiqueta := '';
       InsertarMarca(Coordenadas[n], ColorMarcas, Etiqueta);
       if n = Final then Continue;
       Enlace.Lock(gisLockExtent);                             //Bloquea el mapa.
       Enlace.AddPart;                                         //Prepara para agregar partes al mapa.
       Enlace.AddPoint(Coordenadas[n]);                        //Le asigna punto inicial a la linea.
       Enlace.AddPoint(Coordenadas[n + 1]);                    //Le asigna punto final a la linea.
       Enlace.UnLock;                                          //Desbloquea la marca en el mapa.
       Enlace.Invalidate;                                      //Actualiza la vista del mapa mostrando el objeto.
       end;
   end;
end;

//-----------------------------------------------------------------------------
// Inserta una marca en la capa de puntos.
//-----------------------------------------------------------------------------
procedure TFPrincipal.MostrarContacto(IDCelda, NombreCelda: String; Color: TColor; Etiqueta: String);
var Marca: TGIS_Shape;
begin
if Mapa.IsEmpty then exit ;                                         //Si el mapa no tiene capas, sale...
if Mapa.Get(C_CAPA_MARCAS) = nil then Exit;                         //Si la capa de las marcas operativas no existe, sale...
Marca := TGIS_ShapePoint(TGIS_LayerVector(Mapa.Get(C_CAPA_MARCAS)).CreateShape(gisShapeTypePoint));
if AsignarDatosALaMarca(Marca, Color, Etiqueta) then                //Le asigna al objeto los datos.
   try                                                              //Agrega el objeto al mapa.
      Marca.Lock(gisLockExtent);                                    //Bloquea la marca en el mapa.
      Marca.AddPart;                                                //Prepara para agregar partes al mapa.
      Marca.AddPoint(CoordenadaDeCelda(IDCelda, NombreCelda));      //Le asigna una posición al objeto.
      Marca.UnLock;                                                 //Desbloquea el mapa.
      Marca.Invalidate;                                             //Actualiza la vista del mapa mostrando el objeto.
   except
      MessageBox(0, 'Ocurrieron problemas al insertar la marca en el mapa.', 'Error...', MB_ICONERROR);
   end
else
   MessageBox(0, 'Ocurrieron problemas al asignar los datos a la marca.', 'Error...', MB_ICONERROR);
end;

//-----------------------------------------------------------------------------
// Borra todas las marcas y rutas del mapa.
//-----------------------------------------------------------------------------
procedure TFPrincipal.BorrarMarcasYRutas;
var Marca, Enlace: TGIS_Shape;
begin
Mapa.RevertAll;
Mapa.Update;
end;

//-----------------------------------------------------------------------------
// Extrae los datos de una radiobase.
// Devuelve un registro que contiene los datos extraidos de la
// cadena de texto "Fila" luego de ser parseada.
//-----------------------------------------------------------------------------
function TFPrincipal.ExtrearDatosDeRadiobase(Fila: String): TDatosDeCeldas;
var n, s: Integer;
    Tiempo: String;
    Valor: String;
begin
IniciarDatosDeRadiobase(Result);             //Inicia los datos.

s := Pos(Sep, Fila);                         //Busca la posición del separador.
if s > 0 then                                //Si encuentra el separador:
   begin
   Result.ID := Copy(Fila, 1, s - 1);      //Transforma el dato.
   Delete(Fila, 1, s);                       //Luego borra la cadena incluyendo al separador.
   end;

s := Pos(Sep, Fila);                         //Busca la posición del separador.
if s > 0 then                                //Si encuentra el separador:
   begin
   Valor := Copy(Fila, 1, s - 1);
   try
      Result.Longitud := StrToFloat(Valor);  //Copia la cadena desde el inicio hasta el separador.
   except
      Result.Longitud := 0;
   end;
   Delete(Fila, 1, s);                       //Luego borra la cadena incluyendo al separador.
   end;

s := Pos(Sep, Fila);                         //Busca la posición del separador.
if s > 0 then                                //Si encuentra el separador:
   begin
   Valor := Copy(Fila, 1, s - 1);
   try
      Result.Latitud := StrToFloat(Valor);   //Copia la cadena desde el inicio hasta el separador.
   except
      Result.Latitud := 0;
   end;
   Delete(Fila, 1, s);                       //Luego borra la cadena incluyendo al separador.
   end;

Result.Descripcion := Fila;                          //Lo último que queda lo copia aquí.
end;

//-----------------------------------------------------------------------------
// Inserta los datos de la radiobase en una lista en memoria.
//-----------------------------------------------------------------------------
procedure TFPrincipal.InsertarEnLaListaDeRadiobases(DatosDeRadiobase: TDatosDeCeldas);
begin
ListaDeCeldas.Agregar(DatosDeRadiobase);
end;

//-----------------------------------------------------------------------------
// Carga la base de datos de las celdas y sus coordenadas.
//-----------------------------------------------------------------------------
procedure TFPrincipal.CargarCoordenadasDeCelda;
var X, Y, Errores: Integer;
    Fila, Ruta: String;
    DatosDeRadiobase: TDatosDeCeldas;
    FicheroRadiobases: TextFile;
    msg: String;
begin
Ruta :=  ExtractFilePath(Application.ExeName) + NombreFicheroCeldas;
if FileExists(Ruta) then
   begin
   Errores := 0;
   AssignFile(FicheroRadiobases, Ruta);                        //Declara un fichero con el nombre de la Base de Datos actual.
   Reset(FicheroRadiobases);                                   //Abre el fichero desde el dispositivo.
   while not Eof(FicheroRadiobases) do                         //Mientras haya datos que leer del fichero:
         begin
         Readln(FicheroRadiobases, Fila);                      //Lee una linea del fichero.
         DatosDeRadiobase := ExtrearDatosDeRadiobase(Fila);    //Parsea los datos de la String.
         if DatosDeRadiobase.ID <> '' then
            InsertarEnLaListaDeRadiobases(DatosDeRadiobase)    //Inserta un nuevo registro en la tabla de la Base de Datos.
         else
            Inc(Errores);
         end;
   CloseFile(FicheroRadiobases);                               //Cerramos el fichero de la base de Datos.
   if Errores > 0 then
      begin
      msg :=       'No se han podido cargar correctamente los datos de las celdas GSM.' + #13;
      msg := msg + 'Se han encontrado errores en ' + IntToStr(Errores) + ' registros.';
      Application.MessageBox(PChar(msg), 'Error en los datos de las radiobases', MB_ICONERROR);
      end;
   end;
end;

//------------------------------------------------------------------------------
// Devuelve la distancia de Damerau-Levenshtein existente entre dos
// cadenas de símbolos.
//------------------------------------------------------------------------------
function TFPrincipal.DistanciaDamerauLevenshtein(Arreglo1: TArrayDeBytes;       //Arreglo que contiene los datos de una de la cadena 1.
                                                 Arreglo2: TArrayDeBytes;       //Arreglo con los datos de la otra cadena 2.
                                                 LongitudArreglo1: Integer;     //Longitud de la candena 1.
                                                 LongitudArreglo2: Integer      //Longitud de la candena 2.
                                                 ): Integer;
var
  I, J, T, Cost, Minimum, n, m: Integer;
  pStr1, pStr2, S1, S2: PChar;
  D, RowPrv2, RowPrv1, RowCur, Temp: PIntegerArray;
begin
//Crea unos apuntadores a los arreglos pasados, teniendo en cuenta la longitud de los mismos.
//Hace que pStr1 apunte a la cadena más larga y pStr2 a la más corta.
if LongitudArreglo1 < LongitudArreglo2 then
   begin
   T := LongitudArreglo1;
   LongitudArreglo1 := LongitudArreglo2;
   LongitudArreglo2 := T;
   pStr1 := PChar(Arreglo2);
   pStr2 := PChar(Arreglo1);
   end
else
   begin
   pStr1 := PChar(Arreglo1);
   pStr2 := PChar(Arreglo2);
   end;
//Chequea si las cadenas son identicas para evitar hacer la comparación completa.
while (LongitudArreglo2 <> 0) and (pStr1^ = pStr2^) do
      begin
      Inc(pStr1);
      Inc(pStr2);
      Dec(LongitudArreglo1);
      Dec(LongitudArreglo2);
      end;
//Cuando una cadena está vacía, la distancia es la longitud de la otra cadena.
//Chequea si la cadena más corta es de longitud cero y de ser así, sale de la función.
if LongitudArreglo2 = 0 then
   begin
   Result := LongitudArreglo1;
   Exit;
   end;
//Calcula la distancia de edición.
T := LongitudArreglo2 + 1;
GetMem(D, 3 * T * SizeOf(Integer));
FillChar(D^, 2 * T * SizeOf(Integer), 0);
RowCur := D;
RowPrv1 := @D[T];
RowPrv2 := @D[2 * T];
S1 := pStr1;
for I := 1 to LongitudArreglo1 do
    begin
    Temp := RowPrv2;
    RowPrv2 := RowPrv1;
    RowPrv1 := RowCur;
    RowCur := Temp;
    RowCur[0] := I;
    S2 := pStr2;
    for J := 1 to LongitudArreglo2 do
        begin
        Cost := Ord(S1^ <> S2^);
        Minimum := RowPrv1[J - 1] + Cost;      //Sustituciones.
        T := RowCur[J - 1] + 1;                //Inserciones.
        if T < Minimum then Minimum := T;
        T := RowPrv1[J] + 1;                   //Borrados.
        if T < Minimum then Minimum := T;
        if (I <> 1) and (J <> 1) and (S1^ = (S2 - 1)^) and (S2^ = (S1 - 1)^) then
           begin
           T := RowPrv2[J - 2] + Cost;         //Transposiciones.
           if T < Minimum then Minimum := T;
           end;
        RowCur[J] := Minimum;
        Inc(S2);
        end;
    Inc(S1);
    end;
Result := RowCur[LongitudArreglo2];
FreeMem(D);
end;

//------------------------------------------------------------------------------
// Calcula la similitud de dos cadenas de símbolos y la divuelve en porciento.
// Utiliza la distancia de Damerau-Levenshtein para calcular la similitud.
//------------------------------------------------------------------------------
function TFPrincipal.SimilitudDamerauLevenshtein(Arreglo1: TArrayDeBytes;       //Arreglo que contiene los datos de una de la cadena 1.
                                                 Arreglo2: TArrayDeBytes;       //Arreglo con los datos de la otra cadena 2.
                                                 LongitudArreglo1: Integer;     //Longitud de la candena 1.
                                                 LongitudArreglo2: Integer      //Longitud de la candena 2.
                                                 ): Double;
var LongitudMaxima, Distancia: Integer;                                                 
begin
Result := 1.0;
LongitudMaxima := Max(LongitudArreglo1, LongitudArreglo2);
if LongitudMaxima <> 0 then
   begin
   Distancia := DistanciaDamerauLevenshtein(Arreglo1,
                                            Arreglo2,
                                            LongitudArreglo1,
                                            LongitudArreglo2
                                            );
   Result := Result - (Distancia / LongitudMaxima);
   end;
end;

//-----------------------------------------------------------------------------
// Compara dos cadenas y devuelve la semejanza.
//-----------------------------------------------------------------------------
function TFPrincipal.Semejanza(A, B: String): Double;
begin
Result := SimilitudDamerauLevenshtein(@A[1],
                                      @B[1],
                                      Length(A),
                                      Length(B)
                                      );
end;

//-----------------------------------------------------------------------------
// Obtiene la coordenada de la celda especificada.
//-----------------------------------------------------------------------------
function TFPrincipal.CoordenadaDeCelda(IDCelda: String; NombreCelda: String): TGIS_Point;
var n, p: Integer;
    Datos: TDatosDeCeldas;
    Anterior, Actual: Double;
begin
IDCelda := FiltrarNumerosYLetras(IDCelda);
Result := GisPoint(0, 0);
if ListaDeCeldas.Insertados > 0 then
   begin
   //Busca por medio de los ID de las celdas.
   for n := 0 to ListaDeCeldas.Insertados - 1 do
       begin
       Datos := ListaDeCeldas.Obtener(n);
       if FiltrarNumerosYLetras(Datos.ID) = IDCelda then
          begin
          Result := GisPoint(Datos.Longitud, Datos.Latitud);
          Break;
          end;
       end;
   //Si no se ha encontrado, busca por la semenjanza de los nombres de celda y radiobases.    
   if (Result.X = 0) and
      (Result.Y = 0) then
       begin
       p := -1;
       Anterior := 0;
       for n := 0 to ListaDeCeldas.Insertados - 1 do
           begin
           Datos := ListaDeCeldas.Obtener(n);
           Actual := Semejanza(Datos.ID, NombreCelda);
           if Anterior < Actual then
              begin
              Anterior := Actual;
              p := n;
              end;
           end;
       if (p <> -1) and (Anterior > 0.85) then
          begin
          Datos := ListaDeCeldas.Obtener(p);
          Result := GisPoint(Datos.Longitud, Datos.Latitud);
          end;
       end;    
   end;
end;

//-----------------------------------------------------------------------------
// Muestra el mapa completo.
//-----------------------------------------------------------------------------
procedure TFPrincipal.ActionVerCompletoExecute(Sender: TObject);
begin
Mapa.FullExtent;
end;

//-----------------------------------------------------------------------------
// Borra todas las marcas y rutas del mapa.
//-----------------------------------------------------------------------------
procedure TFPrincipal.ActionBorrarMarcasYRutasExecute(Sender: TObject);
begin
BorrarMarcasYRutas;
end;

//-----------------------------------------------------------------------------
// inicia un abase de Datos nueva.
//-----------------------------------------------------------------------------
procedure TFPrincipal.ActionNuevaBaseExecute(Sender: TObject);
begin
if GuardarCambiosDeBD then                              //Si se han realizado cambios en la capa de marcas actual:
   if not ConfirmarGuardarBD then Exit;                 //Si el usuario detiene la operación, sale.
BorrarTablaDeBaseDeDatos;
end;

end.




