# Garante que o script pare em caso de erros não tratados
$ErrorActionPreference = 'Stop'
# Limpa a tela do console
Clear-Host

# $OutputEncoding
try {
    $OutputEncoding = [System.Text.Encoding]::UTF8
    [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
    $PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'
    $PSDefaultParameterValues['Get-Content:Encoding'] = 'utf8'
    $OutputEncoding = [console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding
} 
Catch {
    echo erro ao definir encoding: $($_.Exception.Message)
}
# $OutputEncoding

# # Verifica se o script está sendo executado da pasta __etapas.
# # Se estiver, sobe um nível de diretório para que os caminhos relativos (ex: '.\CURA') sejam resolvidos corretamente.
# if ((Split-Path -Leaf (Get-Location).Path) -eq "__etapas") {
#     Set-Location ".."
# }

# Define o diretório de trabalho como a pasta raiz do projeto (um nível acima da pasta do script).
# Isso garante que os caminhos relativos (ex: '.\CURA') funcionem independentemente de onde o script foi chamado.
# A variável $PSScriptRoot contém o caminho da pasta onde o script está localizado.
$projectRoot = Split-Path -Path $PSScriptRoot -Parent
Set-Location -Path $projectRoot


Write-Host "=== Iniciando instalação do CURA ==="

# Procura pelo instalador do Cura de forma mais segura
$instaladorCura = Get-ChildItem -Path ".\CURA" -Filter "UltiMaker-Cura*.exe" -ErrorAction SilentlyContinue

# Verifica se o instalador foi encontrado e encerra o script caso não seja.
if (-not $instaladorCura) {
    Write-Host "Erro: Não foi encontrado o instalador do CURA na pasta '.\CURA'." -ForegroundColor Red
    Read-Host "Pressione ENTER para sair..."
    exit 1
}

Write-Host "Executando instalador CURA..."
# Usar Start-Process é uma maneira mais robusta de executar programas externos.
# O parâmetro -Wait faz com que o script aguarde a conclusão do instalador.
try {
    Start-Process -FilePath $instaladorCura.FullName -Wait
}
catch {
    # Usa Write-Warning para erros não fatais, permitindo que o script continue.
    Write-Warning "Não foi possível instalar o CURA. Erro: $($_.Exception.Message)"
}
Write-Host ""
Write-Host "=== Instalação do aplicativo concluída ==="
Write-Host ""
Write-Host "Copiando atalho para a Área de Trabalho..."

# O PowerShell usa $env:NOME_DA_VARIAVEL para acessar variáveis de ambiente como USERPROFILE.
# Copy-Item é o cmdlet nativo para copiar arquivos, sendo a alternativa moderna ao xcopy.
# O parâmetro -Force combina a funcionalidade dos switches /h (arquivos ocultos), /r (sobrescrever somente leitura) e /y (confirmar sobrescrita).
try {
    $desktopPath = Join-Path -Path $env:USERPROFILE -ChildPath "Desktop"
    Copy-Item -Path ".\CURA\*.lnk" -Destination $desktopPath -Force -ErrorAction Stop
    Write-Host "Atalho copiado com sucesso!"
}
catch {
    # Usa Write-Warning para erros não fatais, permitindo que o script continue.
    Write-Warning "Não foi possível copiar o atalho para a Área de Trabalho. Erro: $($_.Exception.Message)"
}

# Mensagem final e pausa
Write-Host ""
Write-Host "=== Processo finalizado ==="
Read-Host "Pressione ENTER para continuar..."
