# ProtonVPN

Este é uma aplicação não oficial do ProtonVPN. Trata-se de uma interface gráfica para o software oficial do ProtonVPN Protonvpn-cli no Linux. Foi elaborado apenas para sistemas Linux, pois já existem versões gráficas oficiais para os demais sistemas.

**Atenção:** Este software foi desenvolvido e homologado na distribuição KDE Neon 5.18.5 64-bits. Em breve haverá mais adaptações, porém é possível que ele rode em outras distribuições.

## Dependências

É necessário que o computador tenha instalado as seguintes dependências:

- Protonvpn-cli
- Kdesudo
- NetworkManager
- CURL

### Protonvpn-cli

É a aplicação oficial do ProtonVPN para conectar a VPN. Para instalar, confira o guia oficial no link https://github.com/ProtonVPN/linux-cli.

### Kdesudo

Necessário para executar os comandos como administrador. O KDE Neon já vem com ele instalado.

### NetworkManager

Utilizado para verificar a conexão com a internet. Para instalar o NetworkManager no Ubuntu 18.04, execute o seguinte comando:

```bash
$ sudo apt install -y NetworkManager
```

### CURL

Necessário para verificar a conexão com a internet. Para instalar o CURL no Ubuntu 18.04, execute o seguinte comando:

```bash
$ sudo apt install -y curl
```

## Desenvolvimento

Este projeto foi desenvolvido em Free Pascal com Lazarus 2.0.8. Para instalar o Lazarus, confira o guia oficial no link https://www.lazarus-ide.org/index.php?page=downloads.

## Licença

Este software é distribuído com a licença GPL v3:

>Este programa é um software livre; você pode redistribuí-lo e/ou
modificá-lo sob os termos da Licença Pública Geral GNU como publicada
pela Free Software Foundation; na versão 3 da Licença, ou
(a seu critério) qualquer versão posterior.

>Este programa é distribuído na esperança de que possa ser útil,
mas SEM NENHUMA GARANTIA; sem uma garantia implícita de ADEQUAÇÃO
a qualquer MERCADO ou APLICAÇÃO EM PARTICULAR. Veja a
Licença Pública Geral GNU para mais detalhes.

>Você deve ter recebido uma cópia da Licença Pública Geral GNU junto
com este programa. Se não, veja <http://www.gnu.org/licenses/>.