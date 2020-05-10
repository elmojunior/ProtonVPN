{
Este arquivo é parte do programa ProtonVPN

ProtonVPN é um software livre; você pode redistribuí-lo e/ou
modificá-lo dentro dos termos da Licença Pública Geral GNU como
publicada pela Free Software Foundation (FSF); na versão 3 da
Licença, ou (a seu critério) qualquer versão posterior.

Este programa é distribuído na esperança de que possa ser útil,
mas SEM NENHUMA GARANTIA; sem uma garantia implícita de ADEQUAÇÃO
a qualquer MERCADO ou APLICAÇÃO EM PARTICULAR. Veja a
Licença Pública Geral GNU para maiores detalhes.

Você deve ter recebido uma cópia da Licença Pública Geral GNU junto
com este programa, Se não, veja <http://www.gnu.org/licenses/>.
}
unit untPrincipal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ComCtrls, Menus, Process, StrUtils, untSobre;

type

  { TfrmPrincipal }

  TfrmPrincipal = class(TForm)
    cbxServidor: TComboBox;
    ckbReconectarAutomatico: TCheckBox;
    gbxInformacoes: TGroupBox;
    gbxOpcoes: TGroupBox;
    imlConexao: TImageList;
    imlTray: TImageList;
    imgTitle: TImage;
    lblServidorSelecionar: TLabel;
    lblCarregamento: TLabel;
    lblCarregamentoResposta: TLabel;
    lblCidade: TLabel;
    lblCidadeResposta: TLabel;
    lblEnviado: TLabel;
    lblEnviadoResposta: TLabel;
    lblFuncionalidades: TLabel;
    lblFuncionalidadesResposta: TLabel;
    lblIp: TLabel;
    lblIpResposta: TLabel;
    lblKillSwitch: TLabel;
    lblKillSwitchResposta: TLabel;
    lblPais: TLabel;
    lblPaisResposta: TLabel;
    lblProtocolo: TLabel;
    lblProtocoloResposta: TLabel;
    lblRecebido: TLabel;
    lblRecebidoResposta: TLabel;
    lblServidor: TLabel;
    lblServidorResposta: TLabel;
    lblStatus: TLabel;
    lblStatusResposta: TLabel;
    lblTempo: TLabel;
    lblTempoResposta: TLabel;
    mniSobre: TMenuItem;
    mniEsconder: TMenuItem;
    mniExibir: TMenuItem;
    mniConectar: TMenuItem;
    mniReconectar: TMenuItem;
    mniDesconectar: TMenuItem;
    mniTerminal: TMenuItem;
    mniConfigurar: TMenuItem;
    mniSair: TMenuItem;
    N3: TMenuItem;
    N2: TMenuItem;
    N1: TMenuItem;
    pnlCabecalho: TPanel;
    pnlConexao: TPanel;
    ppmTrayIcon: TPopupMenu;
    rbnTcp: TRadioButton;
    rbnUdp: TRadioButton;
    rdgProtocolo: TRadioGroup;
    tmrInformacoes: TTimer;
    tobConexao: TToolBar;
    tbnConectar: TToolButton;
    tbnReconectar: TToolButton;
    tbnDesconectar: TToolButton;
    tbnTerminal: TToolButton;
    tbnConfigurar: TToolButton;
    tryPrincipal: TTrayIcon;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure mniConectarClick(Sender: TObject);
    procedure mniConfigurarClick(Sender: TObject);
    procedure mniDesconectarClick(Sender: TObject);
    procedure mniEsconderClick(Sender: TObject);
    procedure mniExibirClick(Sender: TObject);
    procedure mniReconectarClick(Sender: TObject);
    procedure mniSairClick(Sender: TObject);
    procedure mniSobreClick(Sender: TObject);
    procedure mniTerminalClick(Sender: TObject);
    procedure tbnConectarClick(Sender: TObject);
    procedure tbnConfigurarClick(Sender: TObject);
    procedure tbnDesconectarClick(Sender: TObject);
    procedure tbnReconectarClick(Sender: TObject);
    procedure tbnTerminalClick(Sender: TObject);
    procedure tmrInformacoesTimer(Sender: TObject);
    procedure tryPrincipalClick(Sender: TObject);
  private

  public

  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.lfm}


{ Procedures e Functions }

function Executar(Comando:String;Administrador:Boolean;Erro:Boolean;Mostrar:Boolean):String;
var
  Resposta: String;
begin
  frmPrincipal.tmrInformacoes.Enabled:= false;
  Resposta:= '';
  if Administrador then Comando:= '/usr/lib/kde4/libexec/kdesu-distrib/kdesu ' + Comando;

  if (Mostrar) and (MessageDlg('Executar','ProtonVPN irá executar o seguinte comando:' + sLineBreak + Comando, mtInformation,[mbOK, mbCancel],0) = mrCancel) then
  begin
    MessageDlg('Executar','Comando cancelado', mtInformation,[mbOK],0)
  end
  else
  begin
    if not RunCommand(Comando,Resposta) and (Erro) then MessageDlg('Executar','Erro ao executar o comando:' + sLineBreak + Comando, mtError,[mbOK],0);
  end;

  result:= Resposta;
  frmPrincipal.tmrInformacoes.Enabled:= true;
end;

function Rede:Boolean;
var
  Conexoes: TStrings;
  Conexao : String;
begin
  result:= true;

  Conexoes:= TStringList.Create;
  try
    ExtractStrings([LineEnding], [], PChar(Executar('nmcli g',false,false,false)),Conexoes);
    for Conexao in Conexoes do if Trim(ExtractWord(3,Conexao,[' '])) = 'local)' then result:= false;
  finally
    Conexoes.Free;
  end;
end;

function Internet:Boolean;
var
  Requests: TStrings;
  Request : String;
begin
  result:= false;

  if Rede then
  begin
    Requests:= TStringList.Create;
    try
      ExtractStrings([LineEnding], [], PChar(Executar('curl -I --max-time 1 www.google.com',false,false,false)),Requests);
      for Request in Requests do if Trim(ExtractWord(2,Request,[' '])) = '200' then result:= true;
    finally
      Requests.Free;
    end;
  end;
end;

function Conectado:Boolean;
begin
  result:= false;
  if frmPrincipal.lblStatusResposta.Caption = 'Connected' then result:= true;
end;

procedure LimparInformcacoes;
begin
  frmPrincipal.lblStatusResposta.Caption         := '';
  frmPrincipal.lblTempoResposta.Caption          := '';
  frmPrincipal.lblIpResposta.Caption             := '';
  frmPrincipal.lblServidorResposta.Caption       := '';
  frmPrincipal.lblFuncionalidadesResposta.Caption:= '';
  frmPrincipal.lblProtocoloResposta.Caption      := '';
  frmPrincipal.lblKillSwitchResposta.Caption     := '';
  frmPrincipal.lblPaisResposta.Caption           := '';
  frmPrincipal.lblCidadeResposta.Caption         := '';
  frmPrincipal.lblCarregamentoResposta.Caption   := '';
  frmPrincipal.lblEnviadoResposta.Caption        := '';
  frmPrincipal.lblRecebidoResposta.Caption       := '';
end;

procedure InserirInformacao(Informacoes:String);
begin
  case Trim(ExtractWord(1,Informacoes,[':'])) of
    'Status'     : frmPrincipal.lblStatusResposta.Caption         := Trim(ExtractWord(2,Informacoes,[':']));
    'ISP'        : frmPrincipal.lblTempoResposta.Caption          := Trim(ExtractWord(2,Informacoes,[':']));
    'Time'       : frmPrincipal.lblTempoResposta.Caption          := Trim(ExtractWord(2,Informacoes,[':']) +':'+ ExtractWord(3,Informacoes,[':']) +':'+ ExtractWord(4,Informacoes,[':']));
    'IP'         : frmPrincipal.lblIpResposta.Caption             := Trim(ExtractWord(2,Informacoes,[':']));
    'Server'     : frmPrincipal.lblServidorResposta.Caption       := Trim(ExtractWord(2,Informacoes,[':']));
    'Features'   : frmPrincipal.lblFuncionalidadesResposta.Caption:= Trim(ExtractWord(2,Informacoes,[':']));
    'Protocol'   : frmPrincipal.lblProtocoloResposta.Caption      := Trim(ExtractWord(2,Informacoes,[':']));
    'Kill Switch': frmPrincipal.lblKillSwitchResposta.Caption     := Trim(ExtractWord(2,Informacoes,[':']));
    'Country'    : frmPrincipal.lblPaisResposta.Caption           := Trim(ExtractWord(2,Informacoes,[':']));
    'City'       : frmPrincipal.lblCidadeResposta.Caption         := Trim(ExtractWord(2,Informacoes,[':']));
    'Load'       : frmPrincipal.lblCarregamentoResposta.Caption   := Trim(ExtractWord(2,Informacoes,[':']));
    'Sent'       : frmPrincipal.lblEnviadoResposta.Caption        := Trim(ExtractWord(2,Informacoes,[':']));
    'Received'   : frmPrincipal.lblRecebidoResposta.Caption       := Trim(ExtractWord(2,Informacoes,[':']));
  end;

  case Conectado of
    true : frmPrincipal.lblTempo.Caption:= 'Tempo';
    false: frmPrincipal.lblTempo.Caption:= 'ISP';
  end;
end;

procedure Estado;
var
  Respostas: TStrings;
  Resposta : String;
begin
  Respostas:= TStringList.Create;

  try
    ExtractStrings([LineEnding], [], PChar(Executar('protonvpn status',false,false,false)), Respostas);
    LimparInformcacoes;

    for Resposta in Respostas do
    begin
      case Trim(ExtractWord(1,Resposta,[' '])) of
        '[!]': {if Trim(ExtractWord(6,Resposta,[' '])) = 'reconnect' then} frmPrincipal.lblStatusResposta.Caption:= 'Reconnect';
        else InserirInformacao(Resposta);
      end;
    end;
  finally
    Respostas.Free;
  end;
end;

procedure Conectar;
var
  Protocolo: String;
  Servidor : String;
begin
  if Rede then
  begin
    case frmPrincipal.cbxServidor.Text of
      'Mais rápido': Servidor:= '--fastest';
      'Brasil #1'  : Servidor:= 'BR#1';
    end;

    case frmPrincipal.rbnTcp.Checked of
      true : Protocolo:= 'TCP';
      false: Protocolo:= 'UDP';
    end;

    Executar('protonvpn connect ' + Servidor + ' -p ' + Protocolo,true,true,true);
  end
  else
  begin
    ShowMessage('Sem rede');
  end;
end;

procedure Reconectar;
begin
  if Rede then
  begin
    Executar('protonvpn reconnect',true,true,true);
  end
  else
  begin
    ShowMessage('Sem rede');
  end;
end;

procedure Desconectar;
begin
  Executar('protonvpn disconnect',true,true,true);
end;

procedure Configurar;
begin
  Executar('konsole -e "sudo protonvpn configure"',true,true,true);
end;

procedure Terminal;
begin
  Executar('konsole',true,true,true);
end;

procedure Sair;
begin
  frmPrincipal.Close;
end;

procedure Exibir;
begin
  frmPrincipal.WindowState:= wsNormal;
  frmPrincipal.Visible    := true;
end;

procedure Esconder;
begin
  frmPrincipal.WindowState:= wsMinimized;
  frmPrincipal.Visible    := false;
end;

procedure AlterarExibicao;
begin
  if (frmPrincipal.WindowState = wsNormal) then
  begin
    Esconder;
  end
  else
  begin
    Exibir;
  end;
end;

procedure SelecionarIconeDaBandeja;
var
  Icone: TBitmap;
begin
  Icone:= TBitmap.Create;

  case Conectado of
    true : frmPrincipal.imlTray.GetBitmap(0, Icone);
    false: frmPrincipal.imlTray.GetBitmap(1, Icone);
  end;

  try
    frmPrincipal.tryPrincipal.Icon.Assign(Icone);
    frmPrincipal.tryPrincipal.Show;
  finally
    Icone.Free;
  end;
end;

procedure LoopEstado;
begin
  Estado;
  SelecionarIconeDaBandeja;

  if not (Rede) then
  begin
    LimparInformcacoes;
    frmPrincipal.lblStatusResposta.Caption:= 'Sem rede';
  end
  else if (Rede) and (frmPrincipal.lblStatusResposta.Caption <> 'Connected') and (frmPrincipal.ckbReconectarAutomatico.Checked) then
  begin
    Reconectar;
  end;
end;

{ TfrmPrincipal }

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  LimparInformcacoes;
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  tmrInformacoes.Enabled:= false;
  if (MessageDlg('Sair','Tem certeza que deseja sair do ProtonVPN?', mtInformation,[mbYes, mbNo],0) = mrYes) then
  begin
    Application.Terminate;
  end
  else
  begin
    tmrInformacoes.Enabled:= true;
    abort
  end;
end;

procedure TfrmPrincipal.FormActivate(Sender: TObject);
begin
  Esconder;
end;

procedure TfrmPrincipal.mniConectarClick(Sender: TObject);
begin
  Conectar;
end;

procedure TfrmPrincipal.mniConfigurarClick(Sender: TObject);
begin
  Configurar
end;

procedure TfrmPrincipal.mniDesconectarClick(Sender: TObject);
begin
  Desconectar;
end;

procedure TfrmPrincipal.mniEsconderClick(Sender: TObject);
begin
  Esconder;
end;

procedure TfrmPrincipal.mniExibirClick(Sender: TObject);
begin
  Exibir;
end;

procedure TfrmPrincipal.mniReconectarClick(Sender: TObject);
begin
  Reconectar
end;

procedure TfrmPrincipal.mniSairClick(Sender: TObject);
begin
  Sair;
end;

procedure TfrmPrincipal.mniSobreClick(Sender: TObject);
begin
  tmrInformacoes.Enabled:= false;
  frmSobre.ShowModal;
  tmrInformacoes.Enabled:= true;
end;

procedure TfrmPrincipal.mniTerminalClick(Sender: TObject);
begin
  Terminal;
end;

procedure TfrmPrincipal.tbnConectarClick(Sender: TObject);
begin
  Conectar;
end;

procedure TfrmPrincipal.tbnConfigurarClick(Sender: TObject);
begin
  Configurar;
end;

procedure TfrmPrincipal.tbnDesconectarClick(Sender: TObject);
begin
  Desconectar;
end;

procedure TfrmPrincipal.tbnReconectarClick(Sender: TObject);
begin
  Reconectar;
end;

procedure TfrmPrincipal.tbnTerminalClick(Sender: TObject);
begin
  Terminal;
end;

procedure TfrmPrincipal.tmrInformacoesTimer(Sender: TObject);
begin
  LoopEstado; // TODO executar em thread.
end;

procedure TfrmPrincipal.tryPrincipalClick(Sender: TObject);
begin
  AlterarExibicao;
end;


end.


