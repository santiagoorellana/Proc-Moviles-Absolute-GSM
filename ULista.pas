
///////////////////////////////////////////////////////////////////////////////
//  Autor:  Santiago Alejandro Orellana Pérez
//
//  Fecha: 23/09/2011
//  Modificado: 27/10/2013
//
//  Descripción: Implementa una lista de punteros genéricos.
//               Puede almacenar punteros a cualquier objeto.
//               Es responsabilidad del programador recordar
//               el tipo de objeto al que se hace referencia.
//
///////////////////////////////////////////////////////////////////////////////

unit ULista;

interface

uses Classes, UBase, DateUtils;

type
  TDato = TRegistroUbicacion;

  PDato = ^TDato;                                   //Puntero a un dato to tipo "TDato" creado en la memoria.

  TLista = class                                            //Clase que define la lista que guarda los Datos.
  private
     lista: TList;
     procedure OrdenarPorSeleccion;
  public
     constructor Create;                                       //Inicia la lista.
     procedure Vaciar;                                         //Vacía la lista.
     procedure Insertar(indice: Integer; dato: TDato);         //Inserta un dato en la posición indicada.
     procedure Intercambiar(IndiceA, indiceB: Integer);        //Sustituye al dato de la posición indicada.
     procedure Agregar(dato: TDato);                           //Agrega un dato al final de la lista.
     function Extraer(indice: Integer): TDato;                 //Extrae el dato de la posición indicada.
     function Obtener(indice: Integer): TDato;                 //Devuelve una copia del dato de la posición indicada.
     function Insertados: Integer;                             //Devuelve el número de datos insertados en la lista.
     procedure OrdenarPorFecha;                                //Ordena la lista según las fechas.
  end;


/////////////////////////////////////////////////////////////////

implementation

//-----------------------------------------------------------
// Inicia la lista vacía.
//-----------------------------------------------------------

constructor TLista.Create;
begin
lista := TList.Create;
end;

//-----------------------------------------------------------
// Agrega un dato al final de la lista.
//-----------------------------------------------------------
procedure TLista.Agregar(Dato: TDato);
var NuevoDato: PDato;
begin
new(NuevoDato);
NuevoDato^ := Dato;
lista.Add(NuevoDato);
end;

//-----------------------------------------------------------
// Inserta un dato en la posición indicada.
//-----------------------------------------------------------
procedure TLista.Insertar(Indice: Integer; Dato: TDato);
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
procedure TLista.Intercambiar(IndiceA, IndiceB: Integer);
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
function TLista.Extraer(indice: Integer): TDato;
var Extraido: PDato;
begin
IniciarRegistro(Result);
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
function TLista.Obtener(indice: Integer): TDato;
begin
IniciarRegistro(Result);
if (lista.Count > 0) and (lista.Count > indice) then
   Result := (PDato(lista.Items[indice]))^;
end;

//-----------------------------------------------------------
// Ordena los elementos de la lista.
//-----------------------------------------------------------
procedure TLista.OrdenarPorSeleccion;
var I, J: Integer;
    Low, High: Integer;
    CopiaTemporal: TRegistroUbicacion;
begin
Low := 0;
High := lista.Count - 1;
for I := Low to High - 1 do                  //Si Lista[I] > Lista[J] entonces los intercambia.
    for J := High downto I + 1 do
        if CompareDateTime(Obtener(I).DATE, Obtener(J).DATE) > 0 then
           Intercambiar(I, J);
end;

//-----------------------------------------------------------
// Ordena la lista según la fecha y la hora de los elementos.
//-----------------------------------------------------------
procedure TLista.OrdenarPorFecha;                                    //Ordena la lista según las fechas.
begin
if Lista.Count > 0 then OrdenarPorSeleccion;
end;

//-----------------------------------------------------------
// Vacía la lista.
//-----------------------------------------------------------

procedure TLista.Vaciar;
begin
if Assigned(lista) then
   if lista.Count > 0 then
      lista.Clear;
end;

//-----------------------------------------------------------
// Devuelve la cantidad de datos insertados.
//-----------------------------------------------------------

function TLista.Insertados: Integer;
begin
Result := lista.Count;
end;

//-----------------------------------------------------------

end.
