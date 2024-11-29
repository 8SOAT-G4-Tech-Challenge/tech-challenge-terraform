#!/bin/bash

# Criar a Secret e ConfigMap
kubectl apply -f config/secret-config.yaml
kubectl apply -f config/env-config.yaml

# Aplicar os Volumes
kubectl apply -f volume/volume-pv.yaml
kubectl apply -f volume/volume-pvc.yaml

# Rodar o Service e Deployment do Banco de Dados PostgresSQL
kubectl apply -f database/postgres-service.yaml
kubectl apply -f database/postgres-deployment.yaml

# Rodar o Job para criação do banco e tabelas da aplicação
kubectl apply -f migration/migration-job.yaml

# Rodar a API (Service, Deployment, e HPA)
kubectl apply -f api/api-service.yaml
kubectl apply -f api/api-deployment.yaml
# kubectl apply -f deploy/kubernetes/api/api-hpa.yaml

# Rodar o Prisma Studio (opcional)
kubectl apply -f prisma-studio/prisma-service.yaml
kubectl apply -f prisma-studio/prisma-deployment.yaml

echo "Deployment completo!"
