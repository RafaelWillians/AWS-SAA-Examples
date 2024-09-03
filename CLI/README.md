# AWS CLI - Comandos para S3

Listar as variáveis de ambiente
```
env
```

Criar arquivo de texto localmente
```
touch test.txt
```

Escrever texto em arquivo local (irá criar o arquivo caso não exista com o nome especificado)
```
echo "Insira seu texto aqui" >> test.txt
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

Upload de arquivo para o bucket
```
aws s3 cp test.txt s3://mybucket
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

