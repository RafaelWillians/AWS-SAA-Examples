#!/bin/bash

# Regiao padrao
read -p "AWS Default Region: " AWS_DEFAULT_REGION

# Informa o usuário para colar o texto
echo "Cole o texto que deseja salvar como credenciais da AWS. Pressione CTRL+D para finalizar a entrada."

# Lê a entrada do usuário e salva na variável AWS_CREDENTIALS
AWS_CREDENTIALS=$(cat)

# Salva o conteúdo da variável no arquivo de destino
mkdir -p ~/.aws
cat <<EOL > ~/.aws/credentials
$AWS_CREDENTIALS
EOL

cat <<EOL > ~/.aws/config
[default]
region = $AWS_DEFAULT_REGION
EOL

echo -e "\n\nAs credenciais foram salvas."
