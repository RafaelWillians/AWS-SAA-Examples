#!/bin/bash

# Lista por ID de instância, tipo, Nome, região e status 
aws ec2 describe-instances \
    --query '
        Reservations[*].Instances[*].{
            InstanceId:InstanceId, 
            Name:Tags[?Key=='Name']|[0].Value, 
            InstanceType:InstanceType,
            Region:Placement.AvailabilityZone,                         
            Status:State.Name
            }' \
    --output table