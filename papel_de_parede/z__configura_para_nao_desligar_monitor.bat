
REM Configura o plano de energia para nao desligar o monitor
REM GUID do plano de energia ativo
@REM for /f "tokens=2 delims=:(" %%i in ('powercfg /getactivescheme') do set "activeSchemeGUID=%%i"
@REM set "activeSchemeGUID=%activeSchemeGUID:~1,36%"

REM Subgroup Display (0012ee47-984d-449c-9537-a5ec13304270)
REM Turn off display after edu=(3c0bc021-c8a8-4e07-a973-6b14cbcb2b7e) gemini=(3c0bc021-c8a8-4e07-a973-6b14ecc26be4)

echo.
echo Configurando o plano de energia para nao desligar o monitor...

REM Configura para nunca desligar o monitor (AC - corrente alternada)
@REM powercfg /change %activeSchemeGUID% 3c0bc021-c8a8-4e07-a973-6b14cbcb2b7e 0


powercfg /change monitor-timeout-ac 0 REM tempo de tela até desligar o monitor
@REM powercfg /change standby-timeout-ac 0 REM tempo té a suspensão

echo Configuracao de energia aplicada. O monitor nao desligara automaticamente.
@REM echo Esta configuração sera revertida apos a reinicialização do pc
echo Esta configuração não sera revertida apos a reinicialização do pc