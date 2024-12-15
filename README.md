## FIAP Tech-Challenge 8SOAT - Grupo 04 - Terraform infraestrutura recursos da aplicação

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

### Execução

Para a execução de toda a criação e provisionamento da infraestrutura na Cloud AWS, existem duas formas que podem ser utilizadas, local e via pipelines no _Git Hub_. Abaixo estão os links com a descrição dos passo necessários para cada forma. **Para realizar a execução respeite a ordem de execução descrita na documentação, pois existem depências de recursos presentes nesse repositórios, caso o contrário, a execução não será feita com sucesso e poderá apresentar erros**.

- Para realizar a execução local para o provisionamento da infraestrutura na cloud AWS, siga a seguinte [documentação](docs/LOCAL_EXECUTION.md), que possui todos os passos necessários.

- Para realizar a execução via pipeline no _Git Hub_ para o provisionamento da infraestrutura na cloud AWS, siga a seguinte [documentação](docs/PIPELINE_EXECUTION.md), que possui todos os passos necessários.

### Participantes do Projeto

- Amanda Maschio - RM 357734
- Jackson Antunes - RM357311
- Lucas Accurcio - RM 357142
- Vanessa Freitas - RM 357999
- Winderson Santos - RM 357315
