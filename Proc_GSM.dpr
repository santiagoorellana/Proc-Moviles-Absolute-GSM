
///////////////////////////////////////////////////////////////////////////////
// Autor:  Santiago Alejandro Orellana Pérez
//
// Fecha: 27/10/2013
///////////////////////////////////////////////////////////////////////////////

program Proc_GSM;

uses
  Forms,
  UEntradaDeDatos in 'UEntradaDeDatos.pas' {FEntradaDeDatos},
  UPrincipal in 'UPrincipal.pas' {FPrincipal},
  UBase in 'UBase.pas',
  URecorrido in 'URecorrido.pas' {FRecorrido},
  UBuscar in 'UBuscar.pas' {FBuscar},
  URelacion in 'URelacion.pas' {FRelacion},
  ULista in 'ULista.pas',
  UProcedencia in 'UProcedencia.pas' {FProcedencia},
  URelacionDeDos in 'URelacionDeDos.pas' {FRelacionDeDos},
  URelacionesEntreGrupos in 'URelacionesEntreGrupos.pas' {FRelacionesEntreGrupos},
  UListaDeRadiobases in 'UListaDeRadiobases.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Proc GSM 1.0';
  Application.CreateForm(TFPrincipal, FPrincipal);
  Application.Run;
end.
