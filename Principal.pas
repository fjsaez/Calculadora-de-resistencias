unit Principal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.ListBox, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit;

type
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
    RB1: TRadioButton;
    Panel2: TPanel;
    RB2: TRadioButton;
    EResistencia: TEdit;
    Label6: TLabel;
    BCalcular: TButton;
    CBTolerancia2: TComboBox;
    Label5: TLabel;
    RectDigit3: TRectangle;
    CBDigito3: TComboBox;
    LDigito3: TLabel;
    ChB4Bandas: TCheckBox;
    ChB5Bandas: TCheckBox;
    SpeedButton1: TSpeedButton;
    SBLimpiar: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure BCalcularClick(Sender: TObject);
    procedure RB1Change(Sender: TObject);
    procedure ChB4BandasChange(Sender: TObject);
    procedure ChB5BandasChange(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SBLimpiarClick(Sender: TObject);
    procedure RB2Change(Sender: TObject);
  private
    { Private declarations }
    procedure LimpiarTodo;
    procedure ColoresResistencia;
  public
    { Public declarations }
  end;

var
  FPrinc: TFPrinc;

implementation

uses Acerca;

{$R *.fmx}

procedure TFPrinc.LimpiarTodo;
begin
  //ChB4BandasChange(Self);
  ChB4Bandas.IsChecked:=true;
  CBDigito1.ItemIndex:=-1;
  CBDigito2.ItemIndex:=-1;
  CBDigito3.ItemIndex:=-1;
  CBMult.ItemIndex:=-1;
  CBTolerancia1.ItemIndex:=-1;
  RectDigit1.Fill.Color:=$FFE0E0E0;
  RectDigit2.Fill.Color:=$FFE0E0E0;
  RectDigit3.Fill.Color:=$FFE0E0E0;
  RectMult.Fill.Color:=$FFE0E0E0;
  RectTolerancia.Fill.Color:=$FFE0E0E0;
  EResistencia.Text:='';
  CBTolerancia2.ItemIndex:=-1;
  LResistencia.Text:='0 Ω / 0 %';
end;

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

procedure TFPrinc.ColoresResistencia;
const
  Cod: array [0..11] of TAlphaColor =
    ($FF000000{negro},$FF612E14{marrón},$FFFF0000{rojo},$FFFF6600{naranja},
     $FFFFFF00{amarillo},$FF00FF00{verde},$FF0000FF{azul},$FF800080{morado},
     $FF9B9B9B{gris},$FFFFFFFF{blanco},$FFEFB810{dorado},$FFC0C0C0{plateado});
var
  sRes,sTol,TercBanda: string;
  Tolerancia: byte;
  Res: integer;
begin
  if RB1.IsChecked then
  begin
    Tolerancia:=CBTolerancia1.ItemIndex;
    if ChB5Bandas.IsChecked then TercBanda:=(CBDigito3.ItemIndex).ToString
    else TercBanda:='';
    sRes:=(CBDigito1.ItemIndex).ToString+(CBDigito2.ItemIndex).ToString+
           TercBanda+RepetirCaracter('0',CBMult.ItemIndex);
    //se elimina el primer cero, en caso de existir:
    while Copy(sRes,1,1)='0' do sRes:=Copy(sRes,2,Length(sRes)-1);
    RectDigit1.Fill.Color:=Cod[CBDigito1.ItemIndex];
    RectDigit2.Fill.Color:=Cod[CBDigito2.ItemIndex];
    if RectDigit3.Visible then RectDigit3.Fill.Color:=Cod[CBDigito3.ItemIndex];
    RectMult.Fill.Color:=Cod[CBMult.ItemIndex];
  end
  else
  begin
    Tolerancia:=CBTolerancia2.ItemIndex;
    sRes:=EResistencia.Text;
    Res:=sRes.ToInteger;
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
      RectMult.Fill.Color:=Cod[Length(sRes)-2];
    end;
    RectDigit3.Visible:=(Copy(sRes,3,1)<>'0') and (sRes.Length>2);
    if (Copy(sRes,3,1)<>'0') and (sRes.Length>2) then
      RectDigit3.Fill.Color:=Cod[StrToInt(Copy(sRes,3,1))];
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
  LResistencia.Text:=sRes+' Ω / '+sTol+' %';
end;

procedure TFPrinc.BCalcularClick(Sender: TObject);
begin
  ColoresResistencia;
end;

procedure TFPrinc.ChB4BandasChange(Sender: TObject);
begin
  ChB5Bandas.IsChecked:=not ChB4Bandas.IsChecked;
  LDigito3.Visible:=ChB5Bandas.IsChecked;
  CBDigito3.Visible:=ChB5Bandas.IsChecked;
  RectDigit3.Visible:=ChB5Bandas.IsChecked;
  RB1Change(Self);
end;

procedure TFPrinc.ChB5BandasChange(Sender: TObject);
begin
  ChB4Bandas.IsChecked:=not ChB5Bandas.IsChecked;
end;

procedure TFPrinc.FormShow(Sender: TObject);
begin
  RB1Change(Self);
  ChB4BandasChange(Self);
end;

procedure TFPrinc.RB1Change(Sender: TObject);
begin
  ChB4Bandas.Enabled:=RB1.IsChecked;
  ChB5Bandas.Enabled:=RB1.IsChecked;
  CBDigito1.Enabled:=RB1.IsChecked;
  CBDigito2.Enabled:=RB1.IsChecked;
  CBDigito3.Visible:=not ChB4Bandas.IsChecked and RB1.IsChecked;
  RectDigit3.Visible:=not ChB4Bandas.IsChecked and RB1.IsChecked;
  CBMult.Enabled:=RB1.IsChecked;
  CBTolerancia1.Enabled:=RB1.IsChecked;
  EResistencia.Enabled:=RB2.IsChecked;
  CBTolerancia2.Enabled:=RB2.IsChecked;
  BCalcular.Enabled:=((CBDigito1.ItemIndex>-1) and (CBDigito2.ItemIndex>-1)
    and (CBMult.ItemIndex>-1) and (CBTolerancia1.ItemIndex>-1)) and
    (ChB4Bandas.IsChecked or (ChB5Bandas.IsChecked and (CBDigito3.ItemIndex>-1)));
end;

procedure TFPrinc.RB2Change(Sender: TObject);
begin
  BCalcular.Enabled:=(EResistencia.Text<>'') and (CBTolerancia2.ItemIndex>-1);
end;

procedure TFPrinc.SBLimpiarClick(Sender: TObject);
begin
  LimpiarTodo;
end;

procedure TFPrinc.SpeedButton1Click(Sender: TObject);
begin
  with TFAcerca.Create(Self) do
    try ShowModal;
    finally Free
  end;
end;

end.
