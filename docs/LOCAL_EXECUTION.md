## Como provisionar os recursos na AWS localmente

### Pré-requisitos

- Instalação e configuração do [CLI Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- Instalação e configuração do [CLI AWS](https://docs.aws.amazon.com/pt_br/cli/latest/userguide/getting-started-install.html)
- Acesso ao [AWS Academy](https://awsacademy.instructure.com/)

### Passo a passo

1.  Clone o repositório:

```sh
  git clone https://github.com/Winderson/tech-challenge-terraform.git
  cd tech-challenger-terraform
```

2. Instale e configure a CLI do Terraform, pois ela será utilizada para realizar a execução dos comandos do terraform, por exemplo, terraform init e terraform apply

3. Instale e configure a CLI da AWS, pois ela será utilizada para realizar a execução dos comandos para acessar os recursos da AWS depois de conectada.

4. Acesse o portal da [AWS Academy](https://docs.aws.amazon.com/pt_br/cli/latest/userguide/getting-started-install.html)

5. Ao acessar o menu Painel de Controle, deve aparecer um ou mais cursos habilitados para que você possa fazer e utilizar o laboratório. Selecione um dos cursos disponíveis

6. No menu lateral esquerda aparece 3 opções e uma delas é respectiva aos _Módulos_. Clique nela;

7. Aparecerão todos os módulos respectivos ao curso. Navegue até o módulo _Laboratório de aprendizagem da AWS Academy_ e selecione a opção _Iniciar os laboratórios de aprendizagem da AWS Academy_

8. A tela com as informações respectivas a AWS estarão disponíveis, você poderá consultar e realizar açõe de iniciar laboratório e finalizar laboratório. Nesse passo clique na opção de iniciar laboratório

9. Espere até iniciar o laboratório(O ícone na tela fica verde)

10. Depois de iniciado, acesse o menu AWS details e em seguida clique em show _AWS CLI_

11. Aparecerão as informações necessárias para a configuração da AWS CLI. Em sessões normais é utilizado o comando `aws configure` via linha de comando local, porém nesse caso como trata-se de um laboratório, precisamos fornecer a informção de token de sessão, pois o laboratório renova esse token a cada 4 horas. Fique ligado para realizar esses mesmos passos quando acontecer uma atualização.

12. Copie todo conteúdo destacado contendo as credencias de configuração e cole no arquivo ~/.aws/credentials. Caso já exista uma configuração [default], substitua. Pronto, seu AWS CLI esta configurado para executar comandos dentro da AWS presente no laboratório.

13. Depois dos passos anteriores, acesse o diretório do projeto /tech-challenge-terraform. Preencha as variáveis mapeadas dentro do arquivo terraform-tfvars-example com o valores corretos. **OBS:** Algumas das variáveis já estão devidamente preenchidas.

14. Execute os comandos abaixo no terminal da sua maquina ou IDE e faça as devidas confirmações de criação dos recursos na AWS. Os comando abaixo serão executados com os valores das variáveis preenchidas no passo anterior.

```sh
terraform init
```

15. Execute agora o comando abaixo, fazendo as devidas confirmações também

```sh
terraform plan
```

16. Execute o camando para alicar e realizar a criação do bucket na AWS

```sh
  terraform apply
```
