echo off

cls||clear

# Instalação principal do CURA

powershell -ExecutionPolicy Bypass -File ".\2-c_instalar-cura.ps1"

@REM echo "=== Iniciando instalação do CURA ==="
@REM INSTALADOR_CURA=$(find ./pro/ -maxdepth 1 -type f -name "UltiMaker-Cura*.exe")

@REM if [ -z "$INSTALADOR_CURA" ]; then
@REM     echo "Erro: Não foi encontrado o instalador do CURA"
@REM     pause
@REM     exit 1
@REM fi

@REM echo "Executando instalador do CURA..."
@REM "$INSTALADOR_CURA"

@REM echo "Instalando Atalhos"

@REM xcopy ".\CURA\*.lnk" "%USERPROFILE%\Desktop\" /e /h /r /y /q

@REM echo Atalhos Instalados com sucesso!

@REM @REM # Mensagem final e pausa
@REM echo ""
echo "=== Instalação concluída ==="
pause