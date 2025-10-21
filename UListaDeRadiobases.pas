
///////////////////////////////////////////////////////////////////////////////
//  Autor:  Santiago Alejandro Orellana Pérez
//
//  Fecha: 27/10/2013
//
///////////////////////////////////////////////////////////////////////////////

unit UListaDeRadiobases;

interface

uses Classes, UBase, DateUtils;

type
  TDato = TDatosDeCeldas;

  PDato = ^TDato;                                              //Puntero a un dato to tipo "TDato" creado en la memoria.

  TListaDeCeldas = class                                       //Clase que define la lista que guarda los Datos.
  private
     lista: TList;
  public
     constructor Create;                                       //Inicia la lista.
     procedure Vaciar;                                         //Vacía la lista.
     procedure Insertar(indice: Integer; dato: TDato);         //Inserta un dato en la posición indicada.
     procedure Intercambiar(IndiceA, indiceB: Integer);        //Sustituye al dato de la posición indicada.
     procedure Agregar(dato: TDato);                           //Agrega un dato al final de la lista.
     function Extraer(indice: Integer): TDato;                 //Extrae el dato de la posición indicada.
     function Obtener(indice: Integer): TDato;                 //Devuelve una copia del dato de la posición indicada.
     function Insertados: Integer;                             //Devuelve el número de datos insertados en la lista.
  end;


/////////////////////////////////////////////////////////////////

implementation

//-----------------------------------------------------------
// Inicia la lista vacía.
//-----------------------------------------------------------

constructor TListaDeCeldas.Create;
begin
lista := TList.Create;
end;

//-----------------------------------------------------------
// Agrega un dato al final de la lista.
//-----------------------------------------------------------
procedure TListaDeCeldas.Agregar(Dato: TDato);
var NuevoDato: PDato;
begin
new(NuevoDato);
NuevoDato^ := Dato;
lista.Add(NuevoDato);
end;

//-----------------------------------------------------------
// Inserta un dato en la posición indicada.
//-----------------------------------------------------------
procedure TListaDeCeldas.Insertar(Indice: Integer; Dato: TDato);
var NuevoDato: PDato;
begin
if (indice <= lista.Count) then
   begin
   new(NuevoDato);
   NuevoDato^ := Dato;
   lista.Insert(Indice, NuevoDato);
   end;
end;

//-----------------------------------------------------------
// Intercambia dos valores de la lista.
//-----------------------------------------------------------
procedure TListaDeCeldas.Intercambiar(IndiceA, IndiceB: Integer);
var NuevoDato: PDato;
begin
if (IndiceA <= lista.Count) and
   (IndiceB <= lista.Count) then
   lista.Exchange(IndiceA, indiceB);
end;

//-----------------------------------------------------------
// Extrae el dato de la posición indicada. Devuelve su
// valor y lo borra de la lista.
//-----------------------------------------------------------
function TListaDeCeldas.Extraer(indice: Integer): TDato;
var Extraido: PDato;
begin
IniciarDatosDeRadiobase(Result);
if (lista.Count > 0) and (lista.Count > indice) then
   begin
   Extraido := PDato(lista.Extract(lista.Items[indice]));
   Result := Extraido^;
   Dispose(Extraido);
   end;
end;

//-----------------------------------------------------------
// Optiene el dato de la posición indicada.
//-----------------------------------------------------------
function TListaDeCeldas.Obtener(indice: Integer): TDato;
begin
IniciarDatosDeRadiobase(Result);
if (lista.Count > 0) and (lista.Count > indice) then
   Result := (PDato(lista.Items[indice]))^;
end;

//-----------------------------------------------------------
// Vacía la lista.
//-----------------------------------------------------------
procedure TListaDeCeldas.Vaciar;
begin
if Assigned(lista) then
   if lista.Count > 0 then
      lista.Clear;
end;

//-----------------------------------------------------------
// Devuelve la cantidad de datos insertados.
//-----------------------------------------------------------
function TListaDeCeldas.Insertados: Integer;
begin
Result := lista.Count;
end;

//-----------------------------------------------------------

end.
