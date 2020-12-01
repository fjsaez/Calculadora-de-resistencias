unit Principal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.ListBox, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit, FMX.ImgList;

type
  TResistencia = record
    Resistencia: Int64;
    Tolerancia: single;
    CadResistencia,
    CadTolerancia: string;
  end;

  TFPrinc = class(TForm)
    RndResistencia: TRoundRect;
    RectConductor: TRectangle;
    RectDigit1: TRectangle;
    RectDigit2: TRectangle;
    RectMult: TRectangle;
    RectTolerancia: TRectangle;
    LResistencia: TLabel;
    Panel1: TPanel;
    CBDigito1: TComboBox;
    CBDigito2: TComboBox;
    CBMult: TComboBox;
    CBTolerancia1: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Panel2: TPanel;
    EResistencia: TEdit;
    Label6: TLabel;
    CBTolerancia2: TComboBox;
    Label5: TLabel;
    RectDigit3: TRectangle;
    CBDigito3: TComboBox;
    LDigito3: TLabel;
    ChB4Bandas: TCheckBox;
    ChB5Bandas: TCheckBox;
    SBLimpiar: TSpeedButton;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    LMinMax: TLabel;
    LTolerancia: TLabel;
    ChB1: TCheckBox;
    ChB2: TCheckBox;
    BAcerca: TButton;
    ImgAcerca: TImage;
    procedure FormShow(Sender: TObject);
    procedure ChB4BandasChange(Sender: TObject);
    procedure ChB5BandasChange(Sender: TObject);
    procedure SBLimpiarClick(Sender: TObject);
    procedure ChB1Change(Sender: TObject);
    procedure ChB2Change(Sender: TObject);
    procedure BAcercaClick(Sender: TObject);
  private
    { Private declarations }
    procedure LimpiarTodo;
    procedure ActivarControles(Activo1,Activo2: boolean);
    procedure ColoresResistencia;
  public
    { Public declarations }
  end;

const
  Cod: array [0..11] of TAlphaColor =   //los colores de las resistencias:
    ($FF000000{negro},$FF612E14{marrón},$FFFF0000{rojo},$FFFF6600{naranja},
     $FFFFFF00{amarillo},$FF00FF00{verde},$FF0000FF{azul},$FF800080{morado},
     $FF9B9B9B{gris},$FFFFFFFF{blanco},$FFEFB810{dorado},$FFC0C0C0{plateado});

var
  FPrinc: TFPrinc;
  Resistencia: TResistencia;

implementation

uses Acerca;

{$R *.fmx}

function RepetirCaracter(Car: char; Veces: word): string;
var
  I: word;
  Cadena: string;
begin
  Cadena:='';
  if Veces>0 then
    for I:=1 to Veces do Cadena:=Cadena+Car;
  result:=Cadena;
end;

function MinMaxOhm(Res: Int64; Tolrc: single): string;
begin
  result:='Min: '+FormatFloat('#,##0.##',Res-Tolrc)+' Ω / '+
          'Máx: '+FormatFloat('#,##0.##',Res+Tolrc)+' Ω';
end;

procedure CalculoResistencia(sRes,sTol: string);
begin
  Resistencia.Resistencia:=sRes.ToInt64;
  Resistencia.CadResistencia:=FormatFloat('#,##0.##',Resistencia.Resistencia.ToExtended);
  Resistencia.Tolerancia:=Resistencia.Resistencia*sTol.ToInteger/100;
  Resistencia.CadTolerancia:=FormatFloat('#,##0.##',Resistencia.Tolerancia);
end;

procedure TFPrinc.LimpiarTodo;
begin
  //el registro:
  CalculoResistencia('0','0');
  //panel izquierdo:
  ChB4Bandas.IsChecked:=true;
  CBDigito1.ItemIndex:=-1;
  CBDigito2.ItemIndex:=-1;
  CBDigito3.ItemIndex:=-1;
  CBMult.ItemIndex:=-1;
  CBTolerancia1.ItemIndex:=-1;
  //panel derecho:
  EResistencia.Text:='';
  CBTolerancia2.ItemIndex:=-1;
  //las bandas:
  RectDigit1.Fill.Color:=$FFE0E0E0;
  RectDigit2.Fill.Color:=$FFE0E0E0;
  RectDigit3.Fill.Color:=$FFE0E0E0;
  RectMult.Fill.Color:=$FFE0E0E0;
  RectTolerancia.Fill.Color:=$FFE0E0E0;
  //el resumen:
  LResistencia.Text:='Resistencia: 0 Ω';
  LTolerancia.Text:='Tolerancia: 0 % (0 Ω)';
  LMinMax.Text:='Min: 0 Ω / Máx: 0 Ω';
end;

procedure TFPrinc.ActivarControles(Activo1,Activo2: boolean);
begin
  ChB4Bandas.Enabled:=Activo1;
  ChB5Bandas.Enabled:=Activo1;
  CBDigito1.Enabled:=Activo1;
  CBDigito2.Enabled:=Activo1;
  CBDigito3.Visible:=not ChB4Bandas.IsChecked and Activo1;
  RectDigit3.Visible:=not ChB4Bandas.IsChecked and Activo1;
  CBMult.Enabled:=Activo1;
  CBTolerancia1.Enabled:=Activo1;
  EResistencia.Enabled:=Activo2;
  CBTolerancia2.Enabled:=Activo2;
end;

procedure TFPrinc.ColoresResistencia;
var
  sRes,sTol,TercBanda: string;
  Tolerancia: byte;
  Res: Int64;
begin
  sRes:='0';
  sTol:='0';
  TercBanda:='';
  Res:=0;
  if ChB1.IsChecked then   //selección de bandas de colores:
  begin
    Tolerancia:=CBTolerancia1.ItemIndex;
    if ChB5Bandas.IsChecked then TercBanda:=(CBDigito3.ItemIndex).ToString;
    sRes:=(CBDigito1.ItemIndex).ToString+(CBDigito2.ItemIndex).ToString+
           TercBanda+RepetirCaracter('0',CBMult.ItemIndex);
    Res:=sRes.ToInt64;
    RectDigit1.Fill.Color:=Cod[CBDigito1.ItemIndex];
    RectDigit2.Fill.Color:=Cod[CBDigito2.ItemIndex];
    if RectDigit3.Visible then RectDigit3.Fill.Color:=Cod[CBDigito3.ItemIndex];
    RectMult.Fill.Color:=Cod[CBMult.ItemIndex];
  end
  else   //valor literal de resistencia en ohmios:
  begin
    Tolerancia:=CBTolerancia2.ItemIndex;
    if EResistencia.Text<>'' then sRes:=EResistencia.Text;
    Res:=sRes.ToInt64;
    if Res<10 then
    begin
      RectDigit1.Fill.Color:=Cod[0];
      RectDigit2.Fill.Color:=Cod[Res];
      RectMult.Fill.Color:=Cod[0];
    end
    else
    begin
      RectDigit1.Fill.Color:=Cod[StrToInt(Copy(sRes,1,1))];
      RectDigit2.Fill.Color:=Cod[StrToInt(Copy(sRes,2,1))];
    end;
    RectDigit3.Visible:=(Copy(sRes,3,1)<>'0') and (sRes.Length>2);
    if RectDigit3.Visible then
    begin
      RectMult.Fill.Color:=Cod[Length(sRes)-3];
      RectDigit3.Fill.Color:=Cod[StrToInt(Copy(sRes,3,1))];
    end
    else RectMult.Fill.Color:=Cod[Length(sRes)-2];
  end;
  case Tolerancia of
    0: begin
         RectTolerancia.Fill.Color:=Cod[1];   //marrón
         sTol:='1';
       end;
    1: begin
         RectTolerancia.Fill.Color:=Cod[2];   //rojo
         sTol:='2';
       end;
    2: begin
         RectTolerancia.Fill.Color:=Cod[10];  //dorado
         sTol:='5';
       end;
    3: begin
         RectTolerancia.Fill.Color:=Cod[11];  //plateado;
         sTol:='10';
       end;
  end;
  CalculoResistencia(sRes,sTol);
  LResistencia.Text:='Resistencia: '+Resistencia.CadResistencia+' Ω';
  LTolerancia.Text:='Tolerancia: '+sTol+' % ('+Resistencia.CadTolerancia+' Ω)';
  LMinMax.Text:=MinMaxOhm(Res,Resistencia.Tolerancia);
end;

procedure TFPrinc.ChB1Change(Sender: TObject);
begin
  ChB2.IsChecked:=not ChB1.IsChecked;
  CBDigito1.SetFocus;
  ActivarControles(ChB1.IsChecked,ChB2.IsChecked);
  if ((CBDigito1.ItemIndex>-1) and (CBDigito2.ItemIndex>-1) and (CBMult.ItemIndex>-1)
    and (CBTolerancia1.ItemIndex>-1)) and (ChB4Bandas.IsChecked
    or (ChB5Bandas.IsChecked and (CBDigito3.ItemIndex>-1))) then
    ColoresResistencia;
end;

procedure TFPrinc.ChB2Change(Sender: TObject);
begin
  ChB1.IsChecked:=not ChB2.IsChecked;
  EResistencia.SetFocus;
  ActivarControles(ChB1.IsChecked,ChB2.IsChecked);
  if (EResistencia.Text<>'') and (CBTolerancia2.ItemIndex>-1) then
    ColoresResistencia
  else
  begin
    RectDigit1.Fill.Color:=$FFE0E0E0;
    RectDigit2.Fill.Color:=$FFE0E0E0;
    RectDigit3.Fill.Color:=$FFE0E0E0;
    RectMult.Fill.Color:=$FFE0E0E0;
    RectTolerancia.Fill.Color:=$FFE0E0E0;
  end;
end;

procedure TFPrinc.ChB4BandasChange(Sender: TObject);
begin
  ChB5Bandas.IsChecked:=not ChB4Bandas.IsChecked;
  LDigito3.Visible:=ChB5Bandas.IsChecked;
  CBDigito3.Visible:=ChB5Bandas.IsChecked;
  RectDigit3.Visible:=ChB5Bandas.IsChecked;
  ChB1Change(Self);
end;

procedure TFPrinc.ChB5BandasChange(Sender: TObject);
begin
  ChB4Bandas.IsChecked:=not ChB5Bandas.IsChecked;
end;

procedure TFPrinc.FormShow(Sender: TObject);
begin
  ChB1Change(Self);
  ChB4BandasChange(Self);
end;

procedure TFPrinc.SBLimpiarClick(Sender: TObject);
begin
  LimpiarTodo;
end;

procedure TFPrinc.BAcercaClick(Sender: TObject);
begin
  with TFAcerca.Create(Self) do
    try ShowModal;
    finally Free
  end;
end;

end.
