echo ""
echo ""
echo "=== ETAPA 1 ==="
echo "    programas educação"
cmd /C "./bat_1__instalar_pro-edu.bat"

echo ""
echo ""
echo "=== ETAPA 2 ==="
echo "    programas essenciais estacão tech"
powershell -ExecutionPolicy Bypass -File "./2__instalar_pro.ps1"

echo ""
echo ""
echo "=== ETAPA 3 ==="
echo "    programas extras estacão tech"
powershell -ExecutionPolicy Bypass -File "./3__instalar_pro-extras.ps1"

echo ""
echo ""
echo "=== ETAPA 4 ==="
echo "    papel de parede e desativando desligamento da tela"
cmd /C "papel_de_parede/z__ativar_papel_de_parede.bat"
cmd /C "papel_de_parede/z__configura_para_nao_desligar_monitor.bat"

pause