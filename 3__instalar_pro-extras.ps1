# Garante que o script pare em caso de erros não tratados
$ErrorActionPreference = 'Stop'

# Limpa a tela do console
# Clear-Host

# Define o diretório de trabalho como a pasta raiz do projeto
Set-Location -Path $PSScriptRoot


# Instalação dos extras
Write-Host "`n=== Instalando programas extras ==="
$response = Read-Host "Deseja continuar com a instalação dos programas extras? (s/n)"
if ($response -match '^[sS][iI]?[mM]?$') {
    # Busca todos os arquivos executáveis na pasta extras
    $extras = Get-ChildItem -Path "./PRO/extras/*" -Include "*.exe", "*.msi"
    
    foreach ($file in $extras) {
        Write-Host "Encontrado: $($file.Name)"
        
        # Executa cada arquivo
        try {
            Write-Host "    Executando..."
            # & $file.FullName
            Start-Process -FilePath $file.FullName -WorkingDirectory $file.DirectoryName # NÃO AGUARDAR
            # Start-Process -FilePath $file.FullName -WorkingDirectory $file.DirectoryName -Wait # AGUARDAR
        }
        catch {
            Write-Host "    Erro ao executar $($file.Name): $_"
        }
    }
}

Write-Host "`n=== Instalação concluída ==="
Read-Host "Pressione ENTER para continuar..."