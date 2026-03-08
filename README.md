# Pipeline de Dados e Data Warehouse para Monitoramento de Commodities

Projeto de engenharia de dados que implementa uma pipeline ETL para coleta de preços de commodities a partir do Yahoo Finance, armazenamento em PostgreSQL, modelagem analítica utilizando dbt e visualização de dados com Streamlit.

O projeto demonstra a construção de uma arquitetura moderna de dados com separação de camadas de ingestão, transformação e consumo analítico.

---

# Tecnologias Utilizadas

- Python
- PostgreSQL
- dbt-core
- Streamlit
- Pandas
- SQLAlchemy
- Yahoo Finance API

---

# Arquitetura da Pipeline

A pipeline segue uma arquitetura em camadas comum em projetos de engenharia de dados.

```text
Yahoo Finance
      ↓
Python ETL (Extract & Load)
      ↓
PostgreSQL
      ↓
dbt (Staging Layer)
      ↓
dbt (Data Mart)
      ↓
Streamlit Dashboard

1. Fonte de Dados — Yahoo Finance

Os dados de preços das commodities são coletados utilizando a biblioteca yfinance, que fornece acesso à API do Yahoo Finance.

Exemplos de commodities utilizadas no projeto:

CL=F → Crude Oil

GC=F → Gold

SI=F → Silver


2. Ingestão de Dados — Python ETL (Extract & Load)

A ingestão dos dados é realizada pelo script:

src/extract_load.py

Responsabilidades do script:

Coletar preços das commodities utilizando yfinance

Estruturar os dados com pandas

Conectar ao banco utilizando SQLAlchemy

Carregar os dados na tabela commodities no PostgreSQL

Essa etapa representa a camada EL (Extract & Load) da pipeline.


3. Armazenamento de Dados — PostgreSQL

Os dados coletados são armazenados em um banco PostgreSQL, que serve como base para as transformações analíticas realizadas pelo dbt.

Tabela principal gerada pela ingestão:

public.commodities


4. Transformação de Dados — dbt

O dbt (Data Build Tool) é responsável pela transformação e modelagem analítica dos dados.

A modelagem segue a arquitetura:

Sources → Staging → Data Mart
Sources

Fontes de dados definidas no dbt:

commodities

movimentacao_commodities

Essas tabelas representam os dados brutos carregados no PostgreSQL.

Staging Layer

A camada de staging padroniza e prepara os dados para análise.

Modelos utilizados:

stg_commodities
stg_movimentacao_commodities

Principais transformações realizadas:

Padronização de nomes de colunas

Conversão de tipos de dados

Organização da estrutura dos datasets

Essa camada garante que os dados estejam consistentes e preparados para análise.

Data Mart

O modelo analítico final do projeto é:

dm_commodities

Esse modelo:

Combina dados de preços de commodities com movimentações

Calcula o valor financeiro das operações

Calcula ganho ou perda das transações

Filtra os dados da data mais recente

Essa tabela representa a camada final analítica utilizada para consumo.


5. Visualização de Dados — Streamlit

O dashboard é construído utilizando Streamlit, permitindo a visualização interativa dos dados.

Arquivo responsável:

app/app.py

O Streamlit consulta diretamente o modelo analítico gerado pelo dbt:

SELECT * FROM public.dm_commodities

E exibe os resultados em um dashboard interativo para análise dos dados.

Estrutura do Projeto

A organização do projeto segue uma separação por responsabilidades, facilitando manutenção, entendimento da pipeline e evolução da arquitetura.

Data-Warehouse/
│
├── src/
│   └── extract_load.py
│
├── app/
│   └── app.py
│
├── dbt/
│   ├── models/
│   │   ├── staging/
│   │   │   ├── stg_commodities.sql
│   │   │   └── stg_movimentacao_commodities.sql
│   │   │
│   │   └── datamart/
│   │       └── dm_commodities.sql
│   │
│   ├── seeds/
│   │   ├── commodities.csv
│   │   └── movimentacao_commodities.csv
│   │
│   ├── macros/
│   ├── tests/
│   ├── snapshots/
│   └── dbt_project.yml
│
├── .env
├── .gitignore
└── README.md
src/

Contém os scripts responsáveis pela ingestão de dados da pipeline.

Arquivo principal:

extract_load.py

Responsável por:

Coletar dados de preços das commodities via Yahoo Finance

Processar os dados com Pandas

Conectar ao banco PostgreSQL

Carregar os dados na tabela commodities

app/

Contém a aplicação Streamlit utilizada para visualização dos dados.

Arquivo principal:

app.py

Responsável por:

Conectar ao PostgreSQL

Consultar o modelo analítico dm_commodities

Exibir os dados em um dashboard interativo

dbt/

Contém todo o projeto dbt (Data Build Tool) responsável pela transformação e modelagem dos dados.

models/

Contém os modelos SQL responsáveis pela transformação dos dados.

Organizados em camadas:

staging → preparação e padronização dos dados

datamart → modelos analíticos finais

seeds/

Contém arquivos CSV utilizados como dados de entrada no dbt.

Exemplos:

commodities.csv

movimentacao_commodities.csv

Esses arquivos podem ser carregados no banco com:

dbt seed
dbt_project.yml

Arquivo de configuração principal do projeto dbt.

Define:

nome do projeto

estrutura de pastas

materialização dos modelos

organização das transformações

.env

Arquivo responsável por armazenar variáveis de ambiente, como credenciais do banco de dados.

Exemplos:

DB_HOST_PROD
DB_PORT_PROD
DB_NAME_PROD
DB_USER_PROD
DB_PASS_PROD

Como Executar o Projeto

Com comandos:


git clone
pip install
dbt seed
dbt run
streamlit run
