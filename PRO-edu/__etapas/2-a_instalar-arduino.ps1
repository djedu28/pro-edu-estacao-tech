# Garante que o script pare em caso de erros não tratados
$ErrorActionPreference = 'Stop'

# # Verifica se o script está sendo executado da pasta __etapas.
# # Se estiver, sobe um nível de diretório para que os caminhos relativos (ex: './CURA') sejam resolvidos corretamente.
# if ((Split-Path -Leaf (Get-Location).Path) -eq "__etapas") {
#     Set-Location ".."
# }

# Define o diretório de trabalho como a pasta raiz do projeto (um nível acima da pasta do script).
# Isso garante que os caminhos relativos (ex: './ARDUINO') funcionem independentemente de onde o script foi chamado.
# A variável $PSScriptRoot contém o caminho da pasta onde o script está localizado.
$projectRoot = Split-Path -Path $PSScriptRoot -Parent
Set-Location -Path $projectRoot

# Limpa a tela do console
Clear-Host

# --- Instalação principal do Arduino IDE ---
Write-Host "=== Iniciando instalação do Arduino IDE ==="

$instaladorArduino = Get-ChildItem -Path "./ARDUINO" -Filter "arduino-ide_*.exe" -ErrorAction SilentlyContinue
if (-not $instaladorArduino) {
    Write-Host "Erro: Não foi encontrado o instalador do Arduino IDE na pasta './ARDUINO'." -ForegroundColor Red
    Read-Host "Pressione ENTER para sair..."
    exit 1
}

Write-Host "Executando instalador do Arduino IDE..."
# O parâmetro -Wait faz com que o script aguarde a conclusão do instalador.
Start-Process -FilePath $instaladorArduino.FullName -Wait
# O parâmetro -ArgumentList "/S" executa a instalação em modo silencioso.
# Start-Process -FilePath $instaladorArduino.FullName -ArgumentList "/S" -Wait


# --- Instalação dos DRIVERS ---
Write-Host ""
Write-Host "=== Iniciando instalação dos DRIVERS CH340/CH341 ==="

$instaladorDriver = Get-ChildItem -Path "./ARDUINO/CH341SER_35" -Filter "SETUP.EXE" -ErrorAction SilentlyContinue
if (-not $instaladorDriver) {
    Write-Host "Erro: Não foi encontrado o instalador do driver CH340/CH341 na pasta './ARDUINO/CH341SER_35'." -ForegroundColor Red
    Read-Host "Pressione ENTER para sair..."
    exit 1
}

Write-Host "Executando instalador do driver..."
# Alguns instaladores de driver precisam ser executados a partir de seu próprio diretório.
# Start-Process tem um parâmetro -WorkingDirectory para lidar com isso de forma limpa.
Start-Process -FilePath $instaladorDriver.FullName -WorkingDirectory $instaladorDriver.DirectoryName -Wait
# Start-Process -FilePath $instaladorDriver.FullName -WorkingDirectory $instaladorDriver.DirectoryName -ArgumentList "/S" -Wait

# --- Conclusão ---
Write-Host ""
Write-Host "=== Instalação concluída ==="
# A pausa aqui pode ser redundante se o script .bat que o chama já tiver um comando 'pause'.
# Read-Host "Pressione ENTER para continuar..."
