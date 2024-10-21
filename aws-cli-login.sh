#!/bin/bash

# Solicita as credenciais (Session Token é opcional)
read -p "AWS Access Key ID: " AWS_ACCESS_KEY_ID
read -p "AWS Secret Access Key: " AWS_SECRET_ACCESS_KEY
read -p "AWS Session Token: " AWS_SESSION_TOKEN
read -p "AWS Default Region: " AWS_DEFAULT_REGION

# Salva (sobrescreve) o arquivo ~/.aws/credentials
mkdir -p ~/.aws
cat <<EOL > ~/.aws/credentials
[default]
aws_access_key_id = $AWS_ACCESS_KEY_ID
aws_secret_access_key = $AWS_SECRET_ACCESS_KEY
aws_session_token = $AWS_SESSION_TOKEN
EOL

# Sobrescrever o arquivo ~/.aws/config com a região padrão
cat <<EOL > ~/.aws/config
[default]
region = $AWS_DEFAULT_REGION
EOL

echo -e "Env Variables for AWS credentials overwritten!\nAWS Credentials ready!"