{
  Calculadora de Resistencias
            v1.0

Calculadora b�sica de resistencias el�ctricas a partir del c�digo de colores.
S�lo se emplearon componentes nativos (FMX). Desarrollado en Delphi 10.2 Tokyo.

Autor: Ing. Francisco J. S�ez S.

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
