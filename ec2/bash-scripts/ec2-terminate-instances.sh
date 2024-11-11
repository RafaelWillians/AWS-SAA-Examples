#!/bin/bash

# Verifica se foi passado o ID da instância por parâmetro

if [ -z "$1" ]; then
    echo "Por favor, forneca o ID da instancia EC2 como parametro."
    exit 1
fi

# Recebe o ID da instância EC2 como parâmetro
INSTANCE_ID=$1

# Termina a instância
echo "Terminando a instancia EC2 do ID: $INSTANCE_ID"
aws ec2 terminate-instances --instance-ids "$INSTANCE_ID"

# Checa se terminou com sucesso
if [ $? -eq 0 ]; then
    echo "Instancia EC2 $INSTANCE_ID terminada com sucesso."
else
    echo "Erro ao terminar a instancia EC2 $INSTANCE_ID."
    exit 1
fi
