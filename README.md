## FIAP Tech-Challenge 8SOAT - Grupo 04 - Terraform

### Objetivo do Projeto

Este repositório contém todo o mapeamento utilizando a ferramenta terraform para a criação de todos os recursos de infraestrutura na cloud AWS para a execução da aplicação de sistema de controle de pedidos para uma lanchonete em expansão

### Principais funcionalidades:

- **Criação e configuração do recurso EKS da AWS**: Permite que o terraform realize a criação e configuração do recurso EKS para realizar o deploy da aplicação;
- **Criação e configuração do recurso S3 da AWS**: Permite que o terraform realize a criação e configuração do recurso S3 para armazenar o arquivo de estado do terraform;
- **Execução e aplicação das configurações do Kubernetes(K8s)**: Permite depois de toda a criação dos recursos, criar as configurações do kubernetes para a criação das instâncias e execução da aplicação utilizando os comando kubectl.

### Requerimentos

- CLI terraform
- CLI AWS
- Kubectl

### Execução local

Para realizar a execução local para o provisionamento da infraestrutura na cloud AWS, siga a seguinte [documentação](docs/EXECUCAO_LOCAL.md), que possui todos os passos necessários.

### Participantes do Projeto

- Amanda Maschio - RM 357734
- Jackson Antunes - RM357311
- Lucas Accurcio - RM 357142
- Vanessa Freitas - RM 357999
- Winderson Santos - RM 357315
