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

# Mesmo procedimento, mas agora com o AWS.Tools.EC2. Verifica se o módulo AWS.Tools.EC2 está instalado e, caso contrário, instala-o
if (-not (Get-Module -ListAvailable -Name AWS.Tools.EC2)) {
    Write-Host "O módulo AWS.Tools.EC2 não está instalado. Instalando..."
    Install-Module -Name AWS.Tools.EC2 -Force -Scope CurrentUser
    Write-Host "Módulo AWS.Tools.EC2 instalado com sucesso!"
}

# Certificar-se de que o módulo EC2 está carregado após a instalação ou se já estava instalado
if (-not (Get-Module -Name AWS.Tools.EC2)) {
    Write-Host "Carregando o módulo AWS.Tools.EC2..."
    Import-Module -Name AWS.Tools.EC2
    Write-Host "Módulo AWS.Tools.EC2 carregado com sucesso!"
}


# Gera uma string aleatória até 20 dígitos
function Generate-RandomName {
    param(
        [int]$length = 20
    )
    $chars = 'abcdefghijklmnopqrstuvwxyz0123456789'
    $name = -join ((1..$length) | ForEach-Object { $chars[(Get-Random -Maximum $chars.Length)] })
    return $name
}

# Gerar o nome do bucket aleatório
$randomName = Generate-RandomName
$bucketName = "bucket-$randomName"

# Define a regiao do bucket
$awsRegion = (Get-EC2AvailabilityZone | Select-Object -First 1).RegionName

# Identifica qual a regiao definida no AWS CLI
$cliRegion = (Get-AWSCredential -ProfileName default).Region

# Verifica se a região definida no CLI é diferente da região definida no script
if ($cliRegion -ne $null -and $awsRegion -ne $cliRegion) {
    $awsRegion = $cliRegion
}

# Criar o bucket S3
Write-Host "Criando bucket S3 com o nome: $bucketName na regiao $awsRegion"
New-S3Bucket -BucketName $bucketName -Region $awsRegion

# Checa se criou com sucesso
if ($?) {
    Write-Host "Bucket '$bucketName' criado com sucesso!"
} else {
    Write-Host "Falha ao criar o bucket '$bucketName'."
}