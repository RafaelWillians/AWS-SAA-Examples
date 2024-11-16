#!/bin/bash

# Ativa depuração, para mostrar cada comando do script sendo executado.
set -x

# Obtém a região padrão da conta, para funcionar tanto em cloudshell quanto via AWS CLI
REGION=${AWS_REGION:-$(aws configure get region)}

# Obtém o id da primeira subrede da query
SUBNET_ID=$(aws ec2 describe-subnets \
    --query "Subnets[0].SubnetId" \
    --output text \
    --region $REGION)

# Obtém o ID da AMI Amazon Linux 2023
AMI_ID=$(aws ssm get-parameters \
    --names /aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64 \
    --query "Parameters[0].Value" \
    --output text \
    --region $REGION)

# Cria a instância t2.nano com 35GB de volume EBS
aws ec2 run-instances \
    --image-id $AMI_ID \
    --instance-type t2.nano \
    --subnet-id $SUBNET_ID \
    --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=ec2-instance-script}]' \
    --block-device-mappings "DeviceName=/dev/xvda,Ebs={VolumeSize=35}" \
    --region $REGION

# Pausa o console
echo "Pressione qualquer tecla para continuar..."
read -n 1 -s