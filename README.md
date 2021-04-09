# Machine Learning Platform Engineer

O projeto consiste em implementar uma arquitetura completa que consome a Punk Api no
[endpoint](https://api.punkapi.com/v2/beers/random) e ingere em um Kinesis Stream que terá 2 consumidores.
Com os dados processados, treinar um modelo de machine learning e integrar à arquitetura.



Tabela de conteúdos
=================
<!--ts-->
   * [Sobre](#sobre)
   * [Arquitetura](#arquitetura)
   * [Pré-Requisitos](#pre-requisitos)
   * [Instalação](#instalacao)
   * [Como executar o projeto](#executar-terraform)
   * [Tecnologias](#tecnologias)
   * [Execução do Desafio](#execucao_desafio)
   * [Autor](#autor)
   * [Licença](#licenca)
   * [Referências](#referencias)
<!--te-->

<h4 align="center"> 
	🚧 🚀 Em construção...  🚧
</h4>


# <a name="sobre"><a/> Sobre

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
  <img alt="Arquitetura" title="Arquitetura" src="./images/arquitetura_original.png" />
</h1>


# <a name="pre-requisitos"><a/> ☑️ Pré-Requisitos


#### Criar conta na AWS
   * Antes de começar, você vai precisar ter uma conta na AWS, para isso acesse [AWS Console](https://aws.amazon.com/).

#### Criação de usuário/grupo no AWS IAM

   1. Entre no console da AWS e pesquise pelo serviço **IAM**;
   2. No menu à esquerda clique em "users";
   3. Clique no botão "add user";
      * Insira um nome para o usuário, no meu caso foi `admin`;
      * Em `Select AWS access type` marque a primeira caixa `Programmatic access Enables an access key ID and secret access key for the AWS API, CLI, SDK, and other development tools.`;
      * Clique em `Next:Permissions`;
      * Caso não tenha nenhum grupo já criado, clique em `create group`;
      * Na janela que abrir, insira um nome para o grupo, no meu caso foi `admin_group`;
      * Em `Filter Policies` marque a opção `AdministratorAccess` e clique em `Create group`;
      * Clique em `Next: Tags`;
      * Em `Add tags (optional)` não é necessário nenhum procedimento, apenas clique em `Next: Review`;
      * Será apresentado um sumário do usuário e grupo que serão criados, confira as informações e se estiverem de acordo com o desejado clique em `Create user`.


#### Criação de Acess key

Após criado o usuário no passo anterior, realize as seguintes etapas para criar as `acess_key`:

   1. Entre no console da AWS e pesquise pelo serviço **IAM**;
   2. No menu à esquerda clique em "users";
   3. Clique no usuário que você criou;
   4. Na janela que abrir, clique em `Security credentials`;
      * Clique em `Create acess key`;
      * As chaves de acesso serão geradas e deverá clicar para salvar o arquivo, pois a secret não será apresentada novamente.



# <a name="instalacao"><a/> 👨‍💻 Instalação

#### Instalação e Configuração do AWS CLI

   1. Neste projeto, estou utilizando o sistema operacional Linux. Utilize o seguinte roteiro para a instalação [instalação AWS CLI](https://linuxhint.com/install_aws_cli_ubuntu/)
   2. Com o AWS CLI instalado, você deverá configurar suas credenciais:
   ```bash
   # Execute o comando abaixo para iniciar a configuração
   $ aws configure
   ```
    * Insira a `Acess Key` e tecle Enter;
    * Insira a `Secret Key` e tecle Enter;
    * Insira o código da região, no meu caso é `sa-east-1`;
    * No valor formato de saída, pode deixar `None` e tecle Enter.

#### Instalação e Configuração do Terraform

   1. Clique no link para baixar o Terraform de acordo com seu sistema operacional [download Terraform](https://www.terraform.io/downloads.html):
      * No meu caso, estou utilizando Linux 64-bit, após clicar no link um arquivo será baixado.
   2. Descompacte o arquivo e execute os comandos abaixo: 
      * [Roteiro de Instalação](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started)
   ```bash
    $ echo $PATH

   # Mova o arquivo terraform para o resultado do echo $PATH no comando anterior
   $ mv ~/Downloads/terraform /usr/local/bin/

   # Verifique a instalação do Terraform
   $ terraform -help
   ```

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
- [AWS Glue](https://aws.amazon.com/en/glue/)

#### Plataforma de Machine Learning

- [Amazon SageMaker](https://aws.amazon.com/en/sagemaker/)

#### Scheduler e monitoramento de serviços

- [Amazon Cloudwatch](https://aws.amazon.com/en/cloudwatch/)


#### API REST

 - [Amazon API Gateway](https://aws.amazon.com/en/api-gateway/)


# <a name="execucao_desafio"><a/> ❕Execução do Desafio

Siga os passos abaixo para a entrega do desafio:

   1. Criar uma conta gratuita na `AWS`.

   2. Você deve utilizar `Terraform` para construir a arquitetura de uma maneira reproduzível em outras contas.

   3. Todas as funções `Lambdas` devem ser desenvolvidas em `Python` assim como o modelo de machine learning.

   4. O modelo de machine learning deve ser apresentado em um Jupyter Notebook, local ou remoto. O arquivo do notebook estar no repositório do github.

   5. Bônus: Integre o modelo de machine learning em sua arquitetura.


## Entendimento dos dados da Punk API

É de suma importância passar um bom tempo analisando os dados que queremos consumir, tratar e treinar modelos. Deste modo, irei apresentar alguns pontos importantes sobre a Punk API antes do projeto implementado.

Para acessar a página principal da Punk API (Versão 2) clique [aqui](https://punkapi.com/documentation/v2).

Basicamente, essa API possui dados de cervejas e podem consumir esses dados de diversas formas. Para este desafio iremos utilizar o endpoint `https://api.punkapi.com/v2/beers/random` que busca uma cerveja aleatória.

Realizei uma análise para verificar quantas cervejas únicas existem nessa API e encontrei o valor de 325. Portanto, independente da quantidade de vezes que busquemos uma cerveja aleatória, a quantidade de cervejas únicas serão de 325. Este é um valor baixo de amostras para se obter um resultado bom em uma modelagem de machine learning.

Ao buscar uma cerveja aleatória, é possível observar que existem muitas features, entretanto, o que iremos utilizar para o treinamento do modelo são as seguintes:

- **`abv` (Alcohol By Volume)**: indica o percentual em volume da quantidade de álcool em uma bebida.
- **`ibu` (International Bitterness Unit)**: uma sigla para a frase International Bitter Unit e representa uma escala, de 0 a 100, que mede o potencial de amargor conferido pelos lúpulos à cerveja.
- **`target_fg` (Final Gravity)**: quantidade de substâncias (açúcares, em geral) fermentáveis e não fermentáveis após a fermentação.
- **`target_og` (Original Gravity)**: quantidade de substâncias (açúcares, em geral) fermentáveis e não fermentáveis após a fervura, antes do início da fermentação.
- **`ebc` (European Brewing Convention)**: classifica como cerveja clara a cor com menos de 20 unidades EBC, e como cerveja escura a bebida com 20 ou mais unidades EBC.
- **`srm` (Standard Reference Method)**: utilizada para medir as cores da cerveja. A EBC, da Europa e a SRM dos EUA. No Brasil a escala usada é a EBC.
- **`ph`**: em química, pH é uma escala numérica adimensional utilizada para especificar a acidez ou basicidade de uma solução aquosa.


Pois bem, apresentado uma breve explicação sobre o funcionamento da Punk API e seus dados, a seguir será exposto o trabalho implementado.



## Arquitetura da implementação

<h1 align="center">
  <img alt="Arquitetura" title="Arquitetura" src="./images/arquitetura_final.png" />
</h1>

### **Legenda**

<h1 align="left">
  <img alt="Arquitetura" title="Arquitetura" src="./images/legenda_arquitetura_final.png" />
</h1>

### Detalhes da implementação

**Item 1**. A criação da conta gratuita e todos os pré-requisitos para o funcionamento deste projeto foram apresentados no tópico `Pré-Requisitos`, clique [aqui](#pre-requisitos) para acessar.


**Item 2**. Para acessar o diretório onde estão os scripts `Terraform` clique [aqui](https://github.com/ldynczuki/MLPlatformEngineer/tree/main/code/terraform)


**Item 3**. Para acessar o diretório onde estão as funções `Lambdas` desenvolvidas em `Python` clique [aqui](https://github.com/ldynczuki/MLPlatformEngineer/tree/main/code/terraform):
* Para a implementação do desafio, as funções `Lambda` foram compactadas em formato .zip e possuem os seguintes nomes: `lambda_data_processing.zip`, `lambda_data_processing.zip` e `lambda_call_endpoint.zip`.


**Item 4**. Treinamento do modelo de machine learning (local):
* Esta etapa faz parte do **Fluxo de Treinamento de modelo de machine learning localmente com Jupyter Notebook** apresentado na imagem da arquitetura da implementação.
* Conforme apresentado o item 4., foi realizado o treinamento de um modelo de machine learning (local), o qual foi utilizado o Jupyter Notebook, onde é possível acessá-lo clicando [aqui](https://github.com/ldynczuki/MLPlatformEngineer/blob/main/code/models/local-notebook/model-ml-platform.ipynb). 
* Nesta etapa, criei um objeto client do `AWS Glue` para encontrar a tabela `cleaned` e a localização da fonte de dados transformados no `bucket S3`. 
* Após encontrar a localização dos dados, criei um DataFrame dos dados do `bucket S3` e iniciei a análise exploratório dos dados, onde foi possível verificar que a feature `abv` é a que possui maior correlação com a nossa coluna target `ibu`. Deste modo, irei realizar 2 treinamentos, o primeiro utilizando todas as features e outro treinamento apenas com a feature `abv` e irei comparar os resultados finais.
* Antes do treinamento do modelo é essencial realizar o pré-processamento dos dados, onde foram eliminadas as colunas não utilizadas para o treinamento, tais como `id` e `name`, apliquei também uma conversão destes dados para **numpy array** com o tipo de dados float32 e, por fim, a divisão da base de dados em treinamento e teste, em uma proporção de 80% e 20%, respectivamente.
* Com os dados pré-processados, realizei o treinamento do modelo utilizando o algoritmo de regressão linear múltipla e simples.
* Posteriormente o treino dos modelos, foi realizada a avaliação dos modelos utilizando as seguintes métricas: **MAE** (_Mean Absolute Error_), **MSE** (_Mean Squared Error_), **RMSE** (_Root Mean Squared Error_) e	**R2 Square**.
* Foi possível observar no DataFrame final dos resultados no [notebook](https://github.com/ldynczuki/MLPlatformEngineer/blob/main/code/models/local-notebook/model-ml-platform.ipynb) que o modelo de regressão linear múltipla obteve um melhor resultado.
* É importante salientar que, com a baixa quantidade de amostras distintas não foi possível obter um bom resultado durante o treinamento e que também existem outros algoritmos de machine learning que podem alcançar melhores resultados. Todavia, o objetivo deste treinamento foi acessar os metadados do `AWS Glue`, obter a localização e os dados no `bucket S3` e realizar o treinamento.


**Item 5**. Integre o modelo de machine learning em sua arquitetura:
* Esta etapa faz parte do **Fluxo de Treinamento de modelo de machine learning com SageMaker até o consumo do mesmo via API** apresentado na imagem da arquitetura da implementação.
* Escolhi o serviço `SageMaker` da Amazon para o treinamento do modelo por possuir algoritmos que contêm métodos que facilitam a implantação e criação de endpoints para o consumo do serviço, o que facilita na integração do modelo na arquitetura do projeto.
* Desenvolvi um script `Terraform` que realiza a criação de uma instância notebook no SageMaker clonando o repositório do meu projeto do Github. Uma vez criado a instância denominada `sagemaker-model` clique nela para acessar seus recursos e depois clique em **`iniciar`** para para que seja possível acessar o Jupyter Notebook/Jupyter Lab. Uma vez dentro do Jupyter acesse o diretório `MLPlatformEngineer/code/models/sagemaker-notebook/` para encontrar o [notebook](https://github.com/ldynczuki/MLPlatformEngineer/blob/main/code/models/sagemaker-notebook/model-sagemaker.ipynb) SageMaker. Caso apareça a opção para escolher o Kernel, escolha (**conda_python3**).
* As etapas iniciais do treinamento do modelo são similares ao treinamento local, onde criei o objeto client do `AWS Glue` para encontrar a tabela `cleaned` e a localização da fonte de dados transformados no `bucket S3`. Após encontrar a localização dos dados, criei um DataFrame dos dados do `bucket S3` e iniciei a análise exploratório dos dados, a mesma análise feita no notebook local.
* Na etapa de pré-processamento, utilizei os mesmos tratamentos do treinamento local, a fim de comparar os resultados finais entre o modelo treinado com o `Linear Regression` (scikit-learn) e `Linear Learner` (SageMaker).
* O algoritmo escolhido para o treinamento foi o `Linear Learner` que é comparado ao `Linear Regression` do scikit-learn. Para o treinamento, é necessário criar um container de uma imagem pré-existente no SageMaker do modelo `linear-learner`, o qual vai ser referenciado no momento de criar o objeto de treinamento utilizando a biblioteca `Estimator` do `SageMaker`. Neste objeto, devemos passar as configurações da instância de treinamento como também hiperâmetros e métricas de avaliação.
* Como dito acima, o interessante dos algoritmos do SageMaker é a facilidade da implantação do mesmo, após realizar o treinamento basta executar o método `deploy()` passando os parâmetros `initial_instance_count` e `instance_type` (que são parâmetros para configurar da quantidade e o tipo da instância no Amazon EC2). Após essa execução é criado um endpoint para o consumo do modelo recém treinado. **Observação**: Antes da criação do endpoint do modelo atualizado, é feita uma verificação se existe algum endpoint antigo e faz a exclusão para conter apenas o do modelo mais atual.
* Uma vez que o modelo tenha sido treinado e implantado em uma instância da Amazon EC2, criei uma função `Lambda` que enviará dados para o endpoint. Nessa função criei um verificador que irá procurar por endpoints existentes em minha conta AWS que comecem por `linear-learner`, pois o endpoint criado possui a data e hora do treinamento e, para automatizar a utilização do endpoint atualizado, realizei essa procura, ao invés de ir na função e inserir o nome do endpoint manualmente. Para acessar o diretório dessa função `Lambda` clique [aqui](https://github.com/ldynczuki/MLPlatformEngineer/tree/main/code/terraform), ela está compactada no formato .zip com a nomenclatura `lambda_call_endpoint.zip`.
* Com a função `Lambda` criada na etapa anterior, implementei uma API REST (script `Terraform`) utilizando o serviço `Amazon API Gateway` que possibilita enviar requisições `post` com os dados para a predição do modelo para a função `Lambda` que por fim envia para o endpoint do modelo e retorna o `score` da inferência, informando o valor o `ibu` de acordo com os valores informados na requisição.
* É possível utilizar a API Gateway pela interface do serviço `Amazon API Gateway` quando por uma ferramenta externa, por exemplo o `Postman` que utilizei nesse projeto. Segue abaixo imagens da requisição e o retorno do resultado da inferência (predição). Para utilizar o `Postman` basta copiar a **url** com o endpoint criado pela API Gateway, configurar para a requisição ser `post` e criar um `json` com chave `data` e os valores das features de treinamento (na mesma ordem).
* Posteriormente a criação da API Gateway ter sido criada, clique nela para acessar suas propriedades. Conforme pode ser visto na imagem abaixo, clique na opção "Stage" e depois no método "POST" e será apresentado a URL que poderá ser utilizada em uma ferramenta externa, tais como o Postman.
<h1 align="center">
  <img alt="Arquitetura" title="Arquitetura" src="./images/amazon_api_gateway_url.png" />
</h1>

* Podemos testar a inferência do modelo pela interface da Amazon API Gateway, para isso clique em `Resources`, depois no método `POST`, depois clique em `Test`. Por fim, será apresentada a imagem abaixo, veja que no campo `Request Body` foi inserido o json de requisição com os dados para a inferência do valor do `ibu`. Já no campo `Response Body` é apresentado o resultado do score retornado pelo modelo treinado e implantado.

<h1 align="center">
  <img alt="Arquitetura" title="Arquitetura" src="./images/amazon_api_gateway.png" />
</h1>



**INSERIR IMAGEM DA REQUISIÇÃO VIA API GATEWAY E VIA POSTMAN**
* No final do [notebook](https://github.com/ldynczuki/MLPlatformEngineer/blob/main/code/models/sagemaker-notebook/model-sagemaker.ipynb) SageMaker é realizado a exclusão do endpoint, para evitar a cobrança do serviço ativo.




# <a name="autor"><a/> 🤓 Autor

Lucas Dynczuki

Entre em contato! 💚

[![Linkedin Badge](https://img.shields.io/badge/-Lucas-blue?style=flat-square&logo=Linkedin&logoColor=white&link=https://www.linkedin.com/in/lucasdynczuki/)](https://www.linkedin.com/in/lucasdynczuki/) 
[![Outlook Badge](https://img.shields.io/badge/-lucas.dynczuki@outlook.com-blue?style=flat-square&logo=Outlook&logoColor=white&link=mailto:lucas.dynczuki@outlook.com)](mailto:lucas.dynczuki@outlook.com)


# <a name="licenca"><a/>  📝 Licença

[![GitHub license](https://img.shields.io/github/license/ldynczuki/MLPlatformEngineer)](https://github.com/ldynczuki/MLPlatformEngineer/blob/main/LICENSE)


Este projeto esta sobe a licença [MIT](./LICENSE).


# <a name="referencias"><a/>  📚 Referências

https://aws.amazon.com/en/
https://aws.amazon.com/en/cli/
https://aws.amazon.com/en/lambda/
https://aws.amazon.com/en/kinesis/data-streams/
https://aws.amazon.com/en/kinesis/data-firehose/
https://aws.amazon.com/en/glue/
https://aws.amazon.com/pt/cloudwatch/
https://aws.amazon.com/en/sagemaker/
https://www.terraform.io/downloads.html
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
https://linuxhint.com/install_aws_cli_ubuntu/
https://docs.aws.amazon.com/sagemaker/latest/dg/linear-learner.html
https://michael-timbs.medium.com/linear-regression-with-aws-sagemaker-15feefb19342
https://towardsdatascience.com/using-aws-sagemakers-linear-learner-to-solve-regression-problems-36732d802ba6
https://aws.amazon.com/pt/blogs/machine-learning/creating-a-machine-learning-powered-rest-api-with-amazon-api-gateway-mapping-templates-and-amazon-sagemaker/
https://aws.amazon.com/pt/blogs/machine-learning/call-an-amazon-sagemaker-model-endpoint-using-amazon-api-gateway-and-aws-lambda/
https://medium.com/analytics-vidhya/invoke-an-amazon-sagemaker-endpoint-using-aws-lambda-83ff1a9f5443
https://medium.com/@gisely.alves/visualiza%C3%A7%C3%A3o-de-dados-com-seaborn-2fd0defd9adb
https://docs.aws.amazon.com/sagemaker/latest/dg/xgboost.html
http://blog.cervejarialeopoldina.com.br/entenda-como-funciona-a-coloracao-das-cervejas/#:~:text=Standard%20Reference%20Method%20(SRM)&text=Esse%20%C3%A9%20um%20nome%20complicado,equivalem%20a%2010%20unidades%20EBC.
https://www.cervejaemalte.com.br/blog/como-fazer-a-correcao-da-densidade/#:~:text=FG%20%3D%20Final%20Gravity%20%3D%20Densidade%20Final,e%20a%20densidade%20da%20%C3%A1gua.