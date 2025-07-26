# AWS-SAA-Examples
Codebase criado para testes da certificação AWS SAA.

Para logar no AWS CLI, execute no terminal o comando abaixo:

```
aws configure
```

O AWS CLI requer o arquivo ~/.aws/credentials criado para autenticar com a AWS. Com o comando acima, esse arquivo é criado.
Como alternativa, vocês podem executar os scripts ./aws-cli-login.sh para colar as credenciais.
Ou o ./aws-cli-login-paste-credentials.sh caso desejarem colar e usar o arquivo credentials já pronto.

Obs.: recomendo usar um dos scripts caso tiver session_token na credencial que utilizar.

## Conteúdos

### [Planilha com breve resumo de todos os serviços que caem na prova](https://docs.google.com/spreadsheets/d/1mPh3mly7_8WeA3YofX4nUiDU3rXdROojQWtNRDAj2vM/edit?usp=sharing)

### [Mapa Mental Simples](./mapa-mental/simples/aws_saa-mapa-mental-simples.pdf)

### [Mapa Mental Detalhado - com quase todos os assuntos a serem estudados](./mapa-mental/detalhado/aws_saa-mapa-mental-detalhado.pdf)

### [Comandos CLI](./cli/README.md)

### [S3](./s3/README.md)

### [EC2](./ec2/README.md)

### [Exemplos de Arquiteturas](./arquiteturas_exemplos/README.md)

### Extensões para VSCode configuradas no devcontainer
* Git Graph
* GitLG
* GitHub Actions
* GitHub Markdown Preview
* ~~GitHub Copilot~~ retirado para melhor portabilidade do repo
* ~~GitHub Copilot Chat~~ retirado para melhor portabilidade do repo

### Recursos adicionais no Devcontainer/Dockerfile
* AWS CLI
* PowerShell
* AWS Tools for PowerShell


TESTE 