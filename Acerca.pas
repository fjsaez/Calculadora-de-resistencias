unit Acerca;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.ExtCtrls, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TFAcerca = class(TForm)
    ImageViewer1: TImageViewer;
    Text1: TText;
    Text2: TText;
    Text3: TText;
    Button1: TButton;
    Text4: TText;
    Text5: TText;
    Text6: TText;
    TxtBits: TText;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FAcerca: TFAcerca;

implementation

{$R *.fmx}

procedure TFAcerca.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TFAcerca.FormCreate(Sender: TObject);
begin
  {$IFDEF 64_BITS}
    TxtBits.Text:='v1.0 (64 bits)';
  {$ELSE}
    TxtBits.Text:='v1.0 (32 bits)';
  {$ENDIF}
end;

end.
