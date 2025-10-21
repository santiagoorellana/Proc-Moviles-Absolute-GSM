
///////////////////////////////////////////////////////////////////////////////
// Autor:  Santiago Alejandro Orellana Pérez
//
// Fecha: 27/10/2013
///////////////////////////////////////////////////////////////////////////////

unit UBase;

interface

uses Graphics, GisDefs;

const CMaxCampoDeEntrada = 100;

type TRegistroUbicacion = record
                          DATE: TDateTime;
                          MSISDN: String[CMaxCampoDeEntrada];
                          CGI: String[CMaxCampoDeEntrada];
                          CELLID: String[CMaxCampoDeEntrada];
                          CELL: String[CMaxCampoDeEntrada];
                          ERROR: String[CMaxCampoDeEntrada];
                          AGE: String[CMaxCampoDeEntrada];
                          Probabilidad: Double;
                          TiempoDeVinculo: TDateTime;
                          end;

type TDatosDeCeldas = record
                      ID: String[10];
                      Latitud: Double;
                      Longitud: Double;
                      Descripcion: String[50];
                      end;

type TCoordenadas = Array of TGIS_Point;
type TArrayDeBytes = Array of Byte;
                          
const CTipoDeFicheroDeLaBD = 'CSV';
const Sep = ';';

const CColorDeTitulos = clNavy;

function FiltrarNumeros(Numero: String): String;
function FiltrarNumerosYLetras(Alfanumerico: String): String;
procedure IniciarRegistro(var Registro: TRegistroUbicacion);
procedure IniciarDatosDeRadiobase(var Datos: TDatosDeCeldas);

//-----------------------------------------------------------------------------
const CarpetaDeMapas          = 'Mapas';
const FicheroMapaBase         = 'MapaBase.ttkgp';
const NombreFicheroCeldas     = 'coordenadas.csv';
const C_CAPA_MARCAS           = 'Marcas';
const C_CAPA_ENLACES          = 'Enlaces';

implementation

//-----------------------------------------------------------------------------
// Filtra una cadena dejando solo los números.
//-----------------------------------------------------------------------------
function FiltrarNumeros(Numero: String): String;
var n: Integer;
begin
Result := '';
if Length(Numero) > 0 then
   for n := 1 to Length(Numero) do
       if Numero[n] in ['0'..'9'] then
          Result := Result + Numero[n];
end;

//-----------------------------------------------------------------------------
// Filtra una cadena dejando solo los números y las letras.
//-----------------------------------------------------------------------------
function FiltrarNumerosYLetras(Alfanumerico: String): String;
var n: Integer;
begin
Result := '';
if Length(Alfanumerico) > 0 then
   for n := 1 to Length(Alfanumerico) do
       if Alfanumerico[n] in ['0'..'9', 'A'..'Z', 'a'..'z'] then
          Result := Result + Alfanumerico[n];
end;

//-----------------------------------------------------------------------------
// Inicia los datos de un registro.
//-----------------------------------------------------------------------------
procedure IniciarRegistro(var Registro: TRegistroUbicacion);
begin
Registro.DATE := 0;                      //Inicia el registro.
Registro.MSISDN := '';
Registro.CGI := '';
Registro.CELLID := '';
Registro.CELL := '';
Registro.ERROR := '';
Registro.AGE := '';
Registro.Probabilidad := 0;
Registro.TiempoDeVinculo := 0;
end;

//-----------------------------------------------------------------------------
// Inicia el dato de radiobase.
//-----------------------------------------------------------------------------
procedure IniciarDatosDeRadiobase(var Datos: TDatosDeCeldas);
begin
Datos.ID := ''; 
Datos.Latitud := 0;
Datos.Longitud := 0;
Datos.Descripcion := '';
end;

end.
