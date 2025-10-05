@echo off

REM ============================================================================
REM  Verifica se o script está sendo executado com privilégios de administrador
REM  e, se não estiver, solicita a elevação.
REM ============================================================================
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Solicitando privilegios de administrador...
    powershell Start-Process -FilePath "%~f0" -Verb RunAs
    exit
)

REM ============================================================================
REM  Define o diretório de trabalho como o diretório do script.
REM  Isso garante que os caminhos relativos (.\pro) funcionem corretamente,
REM  mesmo quando o script é elevado para administrador.
REM ============================================================================
cd /d "%~dp0"

cls

REM # Instalação principal

echo "=== Iniciando instalacao do Veyon ==="

REM Procura pelo instalador do Veyon e pelo arquivo de configuracao
for /f "delims=" %%i in ('dir /b /s ".\pro\veyon-*.exe"') do set "INSTALADOR=%%i"
for /f "delims=" %%i in ('dir /b /s ".\config*.json"') do set "CONFIG=%%i"

echo Instalador encontrado: %INSTALADOR%
if not defined INSTALADOR (
    echo "Erro: Nao foi encontrado o instalador do Veyon em .\pro\"
    pause
    exit /b 1
)

echo "Executando instalador..."
REM Executa o instalador em modo silencioso, sem o master e aplicando a configuracao.
REM As aspas garantem que caminhos com espacos funcionem.
rem "%INSTALADOR%" /S /NoMaster /ApplyConfig="%CONFIG%"

echo "Instalando chave de autenticacao..."
REM Procura pela chave publica
for /f "delims=" %%i in ('dir /b /s ".\chaves\*public_key.pem"') do set "CHAVE=%%i"

REM Garante que a pasta de destino exista antes de copiar
mkdir "%ProgramData%\Veyon\keys\public\estech" >nul 2>nul

REM Copia o arquivo da chave, substituindo o destino se ele ja existir (/y)
copy /y "%CHAVE%" "%ProgramData%\Veyon\keys\public\estech\key"

echo Chave instalada com sucesso!

@REM ocultando atalho de CONFIG
set "at_CONFIGURATOR=%ProgramData%\Microsoft\Windows\Start Menu\Programs\Veyon\Veyon Configurator.lnk"
set "AT_UNINSTALL=%ProgramData%\Microsoft\Windows\Start Menu\Programs\Veyon\Uninstall Veyon.lnk"
if not exist "%at_CONFIGURATOR%" (
    echo "atalho não encontrado"
)
if exist "%at_CONFIGURATOR%" (
    echo "Ocultando atalho de config"
    move "%at_CONFIGURATOR%" "%at_CONFIGURATOR%.hide"
)
if exist "%AT_UNINSTALL%" (
    echo "Ocultando atalho de uninstall"
    move "%AT_UNINSTALL%" "%AT_UNINSTALL%.hide"
)


echo.
echo "=== Instalacao concluida ==="
pause