unit uFRMInit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,ExtCtrls,StdCtrlS, Vcl.Buttons,
  System.ImageList, Vcl.ImgList;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    btnAtivaDesativa: TSpeedButton;
    TimerProgressivo: TTimer;
    SpeedButton1: TSpeedButton;
    Label2: TLabel;
    ImageList1: TImageList;
    contagem: TLabel;
    TimerRetroceder: TTimer;
    Label3: TLabel;
    contaReg: TLabel;
    procedure TimerProgressivoTimer(Sender: TObject);
    procedure btnAtivaDesativaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TimerRetrocederTimer(Sender: TObject);
  private
    { Private declarations }
    TimeOld:TDateTime;
    Click1: boolean;
    cont: integer;
    tempo: String;
    function GerarTimer(Data: TDateTime):  String;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  validador: Boolean;
implementation

{$R *.dfm}

function TForm1.GerarTimer(Data: TDateTime):  String;
var
  iData1, iData2:  String;
begin
  iData1 := TimeToStr(Data);
  iData2 := TimeToStr( (StrToTime(iData1) - 0.0000115741) );
  iData1 := iData2;

  Result := iData1;
end;

procedure TForm1.btnAtivaDesativaClick(Sender: TObject);

  begin
  with TButton(Sender) do
  begin

  case TButton(Sender).Tag of 0:
  begin
  tempo:='00:05:00';
  validador:=false;
  Click1:=true;
  TimeOld := Now;
  Label1.Caption := '00:00:00' ;
  TimerProgressivo.Enabled := True;
  Caption := '';
  btnAtivaDesativa.Glyph:=nil;
  ImageList1.GetBitmap(0,btnAtivaDesativa.Glyph);
  Tag := 1;
  end;

1:begin
  validador:=true;
  contaReg.Enabled:=true;
  TimerProgressivo.Enabled := False;
  Caption := '';
  TimeOld := Now;
  Label1.Caption := '00:00:00' ;
  btnAtivaDesativa.Glyph:=nil;
  ImageList1.GetBitmap(1,btnAtivaDesativa.Glyph);
  Tag := 0;
      if Click1=true then begin
      cont:=cont+1;
      contagem.Caption:=intToStr(cont);
      contagem.Visible:=true;


    end;
end;

end;//case

end;//with
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Label1.Caption:='00:00:00';
  TimerProgressivo.Enabled := False;
  TimeOld:=Now;
  cont:=0;
  tempo:= '00:05:00';
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=(VK_Escape) then
close;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  TimeOld := Now;
  Label1.Caption := '00:00:00' ;
  cont:=0;
  contagem.Caption:='0';
  contaReg.Caption:='00:00:00';
end;

procedure TForm1.TimerProgressivoTimer(Sender: TObject);
begin
  Label1.Caption:=FormatDateTime('HH:MM:SS',TimeOld - NOW);
  Application.ProcessMessages;
  if (Label1.Caption>='00:25:00') then begin
    Beep;

  end;
end;
procedure TForm1.TimerRetrocederTimer(Sender: TObject);

begin

  if (validador=true) and (tempo <>'00:00:00') then begin

       tempo  :=  GerarTimer(StrToTime(tempo));
       contaReg.Caption:=(tempo);
  end;

  if tempo = '00:00:00' then begin
    validador:=false;
    Beep;

  end;

end;


end.
