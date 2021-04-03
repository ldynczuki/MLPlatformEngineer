# Machine Learning Platform Engineer

O projeto consiste em implementar uma arquitetura completa que consome a Punk Api no
[endpoint](https://api.punkapi.com/v2/beers/random) e ingere em um Kinesis Stream que terá 2 consumidores.

[![GitHub license](https://img.shields.io/github/license/ldynczuki/MLPlatformEngineer)](https://github.com/ldynczuki/MLPlatformEngineer/blob/main/LICENSE)


Tabela de conteúdos
=================
<!--ts-->
   * [Sobre](#sobre)
   * [Instalação](#instalacao)
   * [Pré-Requisitos](#pre-requisitos)
   * [Local files](#local-files)
   * [Remote files](#remote-files)
   * [Multiple files](#multiple-files)
   * [Combo](#combo)
   * [Tests](#testes)
   * [Tecnologias](#tecnologias)
   * [Referências](#referencias)
<!--te-->

<h4 align="center"> 
	🚧 🚀 Em construção...  🚧
</h4>


### Features

- [ ] Criação dos scripts Terraform 
- [x] Levantamento da arquitetura


# <a name="instalacao"><a/> Instalação
============

- Instalação/Configuração AWS CLI
- Instalação/Configuração Terraform

# <a name="pre-requisitos"><a/> Pré-Requisitos
============

- Criar conta na AWS
- Criação de usuário/grupo no AWS IAM
- Gerar Key e Secret para o usuário

Antes de começar, você vai precisar ter uma conta na AWS, para isso acesse [AWS Console](https://aws.amazon.com/).

Após criar a conta, será necessário a criação de um usuário e grupo, para realizar a geração da *acess_key* e *secret_key*,
necessárias para o credenciamento nos serviços AWS.

- Descrever como criar usuário e grupo e gerar chaves.

### 🚀 Como executar o projeto (Terraform)

Navegue até o diretório onde os scripts terraform estão para executar os passos abaixo:

```bash
# Inicialize o projeto, que baixa um plug-in que permite ao Terraform interagir com o Docker.
$ terraform init

# O subcomando plan procura no diretório de trabalho atual para a configuração do módulo raiz. Exibe os serviços que serão criados
$ terraform plan

# Realiza a criação dos serviços nos scripts `.tf`. Quando o Terraform solicitar que você confirme, digite `yes` e pressione Enter
$ terraform apply

# Para excluir os serviços, execute terraform `destroy`.
$ terraform destroy
```


🛠 Tecnologias
============

As seguintes ferramentas foram usadas na construção do projeto:

- [Python](https://www.python.org/)
- [Terraform](https://www.terraform.io/)
- [AWS](https://aws.amazon.com/)


Autor
============

Lucas Dynczuki

Entre em contato! 💚

[![Linkedin Badge](https://img.shields.io/badge/-Lucas-blue?style=flat-square&logo=Linkedin&logoColor=white&link=https://www.linkedin.com/in/lucasdynczuki/)](https://www.linkedin.com/in/lucasdynczuki/) 
[![Outlook Badge](https://img.shields.io/badge/-lucas.dynczuki@outlook.com-blue?style=flat-square&logo=Outlook&logoColor=white&link=mailto:lucas.dynczuki@outlook.com)](mailto:lucas.dynczuki@outlook.com)


Referências
============

https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started
https://learn.hashicorp.com/tutorials/terraform/aws-build?in=terraform/aws-get-started


📝 Licença
============

Este projeto esta sobe a licença [MIT](./LICENSE).