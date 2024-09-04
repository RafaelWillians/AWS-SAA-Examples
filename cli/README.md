# AWS CLI - Comandos

## Gerais (com ou sem AWS CLI)

Listar as variáveis de ambiente
```
env
```

Listar as variáveis de ambiente que constem AWS nelas
```
env | grep AWS
```

Criar arquivo de texto localmente
```
touch test.txt
```

Escrever texto em arquivo local (irá criar o arquivo caso não exista com o nome especificado)
```
echo "Insira seu texto aqui" >> test.txt
```

Configurar conexão do CLI
```
aws configure
```

Retorna detalhes sobre a credencial do usuário que executar o comando, para checar se o CLI está autenticado com sucesso
```
aws sts get-caller-identity
```

Lista detalhadamente o conteúdo do diretório, incluindo arquivos/subpastas ocultos
```
ls -la
```

Alterar permissão de todos os arquivos de uma subpasta, para permitir que o proprietário execute-os
```
chmod u+x s3/bash-scripts/*
```

Retirar permissão de execução do proprietário, em todos os arquivos de uma subpasta
```
chmod u-x s3/bash-scripts/*
```


## S3
Listar buckets
```
aws s3 ls
```

Listar buckets (S3 API - resultado em JSON)
```
aws s3api list-buckets
```

Listar conteúdo dentro do bucket "my-bucket"
```
aws s3 ls s3://my-bucket --recursive
```

Criar bucket
```
aws s3api create-bucket --bucket my-bucket
```

Criar diretório no bucket
```
aws s3api put-object --bucket my-bucket --key my-folder/
```

Upload de arquivo para o bucket
```
aws s3 cp test.txt s3://mybucket
```

Upload de arquivo para o bucket (via S3 API)
```
aws s3api put-object --bucket my-bucket --key test.txt --content-type plain/txt --body test.txt
```

Criar bucket em outra região
```
aws s3api create-bucket --bucket my-bucket --region us-west-2 --create-bucket-configuration LocationConstraint=us-west-2
```

Excluir arquivo específico de um bucket
```
aws s3 rm s3://my-bucket/test.txt
```

Excluir um bucket e todo conteúdo dele
```
aws s3 rb s3://my-bucket/ --force
```

Exemplo de query, para listar somente o bucket que tiver o nome "my-bucket"

```
aws s3api list-buckets --query "Buckets[?Name == 'my-bucket'].Name | sort(@) | {NomeBucket: join(', ', @)}"
```

Exemplo de query para listar em tabela apenas os nomes dos buckets
```
aws s3api list-buckets --query "Buckets[].Name" --output table
```

Query para listar os arquivos e pastas do bucket
```
aws s3api list-buckets --query "Contents[].Key"
```

Sincroniza arquivos entre diretório local e bucket
```
aws s3 sync . s3://my-bucket
```

Download de arquivo
```
aws s3api get-object --bucket my-bucket --key test.txt test.txt
```



