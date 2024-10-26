# Verificar se o módulo AWS.Tools.S3 está instalado e, caso contrário, instala-o
if (-not (Get-Module -ListAvailable -Name AWS.Tools.S3)) {
    Write-Host "O módulo AWS.Tools.S3 não está instalado. Instalando..."
    Install-Module -Name AWS.Tools.S3 -Force -Scope CurrentUser
    Write-Host "Módulo AWS.Tools.S3 instalado com sucesso!"
}

# Certificar-se de que o módulo está carregado após a instalação ou se já estava instalado
if (-not (Get-Module -Name AWS.Tools.S3)) {
    Write-Host "Carregando o módulo AWS.Tools.S3..."
    Import-Module -Name AWS.Tools.S3
    Write-Host "Módulo AWS.Tools.S3 carregado com sucesso!"
}

# Lista os buckets criados
Get-S3Bucket