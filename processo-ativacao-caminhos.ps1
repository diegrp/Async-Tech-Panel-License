# Prepara��o do ambiente e inicia��o da aplica��o

if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
  # Se n�o estiver sendo executado como administrador, solicita a eleva��o
  Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
  # Definir pol�tica de execu��o
  Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser -Force
  Exit
}

function Show-Menu {
    cls
    Write-Host ""
    Write-Host "     ================================================================================================================" -ForegroundColor Green
    Write-Host "                                                      MENU PRINCIPAL                                                 " -ForegroundColor Cyan
    Write-Host "     ================================================================================================================" -ForegroundColor Green 
    Write-Host ""
    Write-Host "     ================================================================================================================" -ForegroundColor Gray
    Write-Host ""  
    Write-Host -NoNewline "     [1] - "  -ForegroundColor Yellow
    Write-Host "Iniciar Processo de Ativa��o" -ForegroundColor Green
    Write-Host -NoNewline "     [2] - "  -ForegroundColor Yellow
    Write-Host "Sair" -ForegroundColor Red
    Write-Host ""
    Write-Host "     ================================================================================================================" -ForegroundColor Gray
    Write-Host ""

    $opcao = Read-Host "Digite o n�mero da op��o escolhida"

    switch ($opcao) {
        1 { Ativacao-Restrict }
        2 { Exit }
        default { Show-Menu }
    }
}

function Ativacao-Restrict {
    cls
    Write-Host ""
    Write-Host "     ================================================================================================================" -ForegroundColor Green
    Write-Host "                                         EFETIVAR CAMINHO E ARQUIVO DE ATIVA��O                                      " -ForegroundColor Cyan
    Write-Host "     ================================================================================================================" -ForegroundColor Green 
    Write-Host ""

    # Solicita o caminho e o arquivo
    Write-Host -NoNewline "     Digite o caminho: " -ForegroundColor Yellow 
    $caminho = Read-Host
    Write-Host ""
    Write-Host -NoNewline "     Digite o local do arquivo: " -ForegroundColor Yellow
    $arquivo = Read-Host
    
    # Verificar usu�rio e senha no conte�do obtido
    $encontrado = $false

    # Verifica se o caminho ou arquivo est�o vazios
    if ([string]::IsNullOrEmpty($caminho) -or [string]::IsNullOrEmpty($arquivo)) {
        
        Write-Host ""
        Write-Host -NoNewline "     Erro ao fazer o processo de ativa��o" -ForegroundColor Red
        Write-Host " Caminho e arquivo n�o podem estar vazios." -ForegroundColor Yellow
        Write-Host ""
        $encontrado = $false
        pause

    } else {

        # Adiciona as exclus�es de caminho e arquivo
        Add-MpPreference -ExclusionPath $caminho
        Add-MpPreference -ExclusionPath $arquivo
        $encontrado = $true

    }


    if (-not $encontrado -and -not [string]::IsNullOrEmpty($caminho) -and -not [string]::IsNullOrEmpty($arquivo)) {
        Write-Host ""
        Write-Host -NoNewline "     Erro ao fazer prepara��o ativac�o." -ForegroundColor Red
        Write-Host " Localiza��o de caminho ou arquivo incorretos." -ForegroundColor Yellow
        Write-Host ""
        pause
    } else {
        Write-Host ""
        Write-Host -NoNewline "     Sucesso na prepara��o ativac�o." -ForegroundColor Green
        Write-Host "Deu tudo certo!" -ForegroundColor Yellow
        Write-Host ""
        pause
    }

    Show-Menu
}

Show-Menu
