# Machine Learning Platform Engineer

O projeto consiste em implementar uma arquitetura completa que consome a Punk Api no
[endpoint](https://api.punkapi.com/v2/beers/random) e ingere em um Kinesis Stream que terá 2 consumidores.



Tabela de conteúdos
=================
<!--ts-->
   * [Sobre](#sobre)
   * [Arquitetura](#arquitetura)
   * [Instalação](#instalacao)
   * [Pré-Requisitos](#pre-requisitos)
   * [Como executar o projeto](#executar-terraform)
   * [Tecnologias](#tecnologias)
   * [Autor](#autor)
   * [Licença](#licenca)
   * [Referências](#referencias)
<!--te-->

<h4 align="center"> 
	🚧 🚀 Em construção...  🚧
</h4>


### Features

- [ ] Criação dos scripts Terraform 
- [x] Levantamento da arquitetura


# <a name="sobre"><a/> 🏢 Sobre

O presente projeto tem como objetivo implementar uma arquitetura completa que consome a [Punk API](https://punkapi.com/) no endpoint
https://api.punkapi.com/v2/beers/random e ingere em um Kinesis Stream que terá 2 consumidores. 

Para isso você será necessário configurar:

   1. Um CloudWatch Event que dispara a cada 5 minutos uma função Lambda para alimentar o Kinesis Stream que terá como saída:
      * Um Firehose agregando todas as entradas para guardar em um bucket S3 com o nome de `raw`.
      
      * Outro Firehose com um Data Transformation que pega somente os `id`, `name`, `abv`, `ibu`, `target_fg`, `target_og`, `ebc`, `srm` e `ph` das cervejas e guarda em um outro bucket S3 com o nome de `cleaned` em formato **csv**.

   2. Crie uma tabela com os dados do bucket `cleaned`.

   3. Com base nos dados da tabela `cleaned`, treine um modelo de machine learning que classifique as cervejas em seus respectivos ibus.


# <a name="arquitetura"><a/> 🏢 Arquitetura

<h1 align="center">
  <img alt="Arquitetura" title="Arquitetura" src="./imagens/arquitetura.png" />
</h1>

# <a name="instalacao"><a/> 👨‍💻 Instalação

- Instalação/Configuração AWS CLI
- Instalação/Configuração Terraform

# <a name="pre-requisitos"><a/> ☑️ Pré-Requisitos

- Criar conta na AWS
- Criação de usuário/grupo no AWS IAM
- Gerar Key e Secret para o usuário

Antes de começar, você vai precisar ter uma conta na AWS, para isso acesse [AWS Console](https://aws.amazon.com/).

Após criar a conta, será necessário a criação de um usuário e grupo, para realizar a geração da **acess_key** e **secret_key**,
necessárias para o credenciamento nos serviços AWS.

- Descrever como criar usuário e grupo e gerar chaves.

# <a name="executar-terraform"><a/> 🚀 Como executar o projeto (Terraform)

Navegue até o diretório onde os scripts terraform estão para executar os passos abaixo:

```bash
# Inicialize o projeto.
$ terraform init

# Exibe um plano dos serviços que serão criados.
$ terraform plan

# Caso queira salvar o plano de execução dos serviços, substitua "path" por um caminho válido.
$ terraform plan -out=path 

# Realiza a criação dos serviços nos scripts extensão .tf. 
# Quando o Terraform solicitar que você confirme, digite yes e pressione Enter.
$ terraform apply

# Para excluir os serviços, execute terraform destroy.
$ terraform destroy
```


# <a name="tecnologias"><a/> 🛠 Tecnologias

As seguintes linguagens foram usadas na construção do projeto:

- [Python](https://www.python.org/)
- [Terraform](https://www.terraform.io/)

#### Serverless

- [AWS Lambda](https://aws.amazon.com/en/lambda/)
- [Amazon Kinesis](https://aws.amazon.com/en/kinesis/)
- [Amazon Kinesis Data Firehose](https://aws.amazon.com/en/kinesis/data-firehose/)
- [AWS Glue](https://aws.amazon.com/pt/glue/)

#### Plataforma de Machine Learning

- [Amazon SageMaker](https://aws.amazon.com/en/sagemaker/)

#### Scheduler e monitoramento de serviços

- [Amazon Cloudwatch](https://aws.amazon.com/pt/cloudwatch/)


# <a name="autor"><a/> 🤓 Autor

Lucas Dynczuki

Entre em contato! 💚

[![Linkedin Badge](https://img.shields.io/badge/-Lucas-blue?style=flat-square&logo=Linkedin&logoColor=white&link=https://www.linkedin.com/in/lucasdynczuki/)](https://www.linkedin.com/in/lucasdynczuki/) 
[![Outlook Badge](https://img.shields.io/badge/-lucas.dynczuki@outlook.com-blue?style=flat-square&logo=Outlook&logoColor=white&link=mailto:lucas.dynczuki@outlook.com)](mailto:lucas.dynczuki@outlook.com)


# <a name="licenca"><a/>  📝 Licença

Este projeto esta sobe a licença [MIT](./LICENSE).
[![GitHub license](https://img.shields.io/github/license/ldynczuki/MLPlatformEngineer)](https://github.com/ldynczuki/MLPlatformEngineer/blob/main/LICENSE)



# <a name="referencias"><a/>  📚 Referências

https://aws.amazon.com/pt/
https://aws.amazon.com/en/lambda/
https://aws.amazon.com/en/kinesis/data-streams/
https://aws.amazon.com/en/kinesis/data-firehose/
https://aws.amazon.com/en/glue/
https://aws.amazon.com/pt/cloudwatch/
https://aws.amazon.com/en/sagemaker/
https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started
https://learn.hashicorp.com/tutorials/terraform/aws-build?in=terraform/aws-get-started
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kinesis_stream
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kinesis_firehose_delivery_stream
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_catalog_database
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_catalog_table
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment