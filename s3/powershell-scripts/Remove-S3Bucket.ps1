# Definindo nome do bucket para receber como parametro
param(
    [Parameter(Mandatory)]    
    [string]$BucketName
)

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

# Checar se o bucket existe
$bucket = Get-S3Bucket | Where-Object { $_.BucketName -eq $BucketName}

# Solicita confirmacao ao usuario e entao exclui
if ($bucket) {
    $confirmation = Read-Host "Tem certeza que deseja remover o bucket '$BucketName'?`nDigite 'sim' para confirmar: "

    # Remove o bucket
    if ($confirmation -eq 'sim') {
        try {
            # -Force serve para prosseguir sem pedir mais nenhuma confirmacao. Porem nao ira excluir bucket se nao estiver vazio.
            Remove-S3Bucket -BucketName $BucketName -Force
            Write-Output "Bucket '$BucketName' removido com sucesso."            
        }
        catch {
            Write-Output "Erro ao remover o bucket: $_"
        }
    }
    else {
        Write-Output "Operacao cancelada."
    }
}
else {
    Write-Output "Bucket '$BucketName' nao encontrado."
}