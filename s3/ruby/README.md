# Exemplo em Ruby

Alguns comandos que utilizei para executar o projeto.

Iniciar o projeto com Bundler. Ele cria o Gemfile, que terá as dependências do projeto.
```
bundle init
```

Instalar as dependências.
```
bundle install
```

Executar o arquivo ruby (neste exemplo abaixo, não irá passar nenhum parâmetro).
```
bundle exec ruby s3.rb
```

Executar o arquivo ruby, passando o nome do bucket como parâmetro.
```
BUCKET_NAME='exemplo-nome-bucket' bundle exec ruby s3.rb
```








