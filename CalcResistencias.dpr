{
  Calculadora de Resistencias
            v1.0

Calculadora básica de resistencias eléctricas a partir del código de colores.
Sólo se emplearon componentes nativos (FMX). Desarrollado en Delphi 10.2 Tokyo.

Autor: Ing. Francisco J. Sáez S.

Calabozo (Venezuela), 21 de noviembre de 2020.
}

program CalcResistencias;

uses
  System.StartUpCopy,
  FMX.Forms,
  Principal in 'Principal.pas' {FPrinc},
  Acerca in 'Acerca.pas' {FAcerca};

{$R *.res}

begin
  Application.Initialize;
  Application.Title:='Calculadora de Resistencias';
  Application.CreateForm(TFPrinc, FPrinc);
  Application.Run;
end.
