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
unit untSobre;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  lclintf;

type

  { TfrmSobre }

  TfrmSobre = class(TForm)
    btnVoltar: TButton;
    imgCabebalho: TImage;
    lblProjetoTitulo: TLabel;
    lblSobre: TLabel;
    lblProtonVpnCliGitHub: TLabel;
    lblIconesTitulo: TLabel;
    lblIconesGitHub: TLabel;
    lblProjeto: TLabel;
    lblProtonVpn: TLabel;
    lblProtonVpnCli: TLabel;
    lblIcones: TLabel;
    lblProjetoGitLab: TLabel;
    lblProjetoGitHub: TLabel;
    lblProtonVpnSite: TLabel;
    pnlCreditos: TPanel;
    procedure btnVoltarClick(Sender: TObject);
    procedure lblIconesGitHubClick(Sender: TObject);
    procedure lblProjetoGitHubClick(Sender: TObject);
    procedure lblProjetoGitLabClick(Sender: TObject);
    procedure lblProtonVpnCliGitHubClick(Sender: TObject);
    procedure lblProtonVpnSiteClick(Sender: TObject);
  private

  public

  end;

var
  frmSobre: TfrmSobre;

implementation

{$R *.lfm}

{ TfrmSobre }

procedure TfrmSobre.btnVoltarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmSobre.lblIconesGitHubClick(Sender: TObject);
begin
  OpenURL('https://github.com/KDE/breeze-icons');
end;

procedure TfrmSobre.lblProjetoGitHubClick(Sender: TObject);
begin
  OpenURL('https://github.com/elmojunior/ProtonVPN');
end;

procedure TfrmSobre.lblProjetoGitLabClick(Sender: TObject);
begin
  OpenURL('https://gitlab.com/elmojunior-lazarus/protonvpn');
end;

procedure TfrmSobre.lblProtonVpnCliGitHubClick(Sender: TObject);
begin
  OpenURL('https://github.com/ProtonVPN/linux-cli');
end;

procedure TfrmSobre.lblProtonVpnSiteClick(Sender: TObject);
begin
  OpenURL('https://protonvpn.com');
end;

end.

