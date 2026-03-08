# Pipeline de Dados e Data Warehouse para Monitoramento de Commodities

Projeto de engenharia de dados que implementa uma pipeline ETL para coleta de preços de commodities a partir do Yahoo Finance, armazenamento em PostgreSQL, modelagem analítica utilizando dbt e visualização de dados com Streamlit.

O projeto demonstra a construção de uma arquitetura moderna de dados com separação de camadas de ingestão, transformação e consumo analítico.

## Tecnologias Utilizadas

- Python
- PostgreSQL
- dbt-core
- Streamlit
- Pandas
- SQLAlchemy
- Yahoo Finance API

  
## Arquitetura da Pipeline

A pipeline segue uma arquitetura em camadas comum em projetos de engenharia de dados.

```text
Yahoo Finance

Os dados de preços das commodities são coletados através da biblioteca yfinance, que fornece acesso à API do Yahoo Finance.

Exemplos de commodities utilizadas no projeto:

CL=F → Crude Oil

GC=F → Gold

SI=F → Silver

Python ETL (Extract & Load)

A ingestão é realizada pelo script:

src/extract_load.py

Responsabilidades do script:

Coletar preços de commodities usando yfinance

Estruturar os dados com pandas

Conectar ao PostgreSQL com SQLAlchemy

Carregar os dados na tabela commodities

Essa etapa representa a camada EL (Extract & Load) da pipeline. 


PostgreSQL

Os dados coletados são armazenados em um banco PostgreSQL, que serve como base para as transformações analíticas realizadas pelo dbt.

Tabela principal gerada pela ingestão:
dbt (Staging Layer)

O dbt é responsável pela transformação e modelagem analítica dos dados.

A modelagem segue a arquitetura:

Sources → Staging → Data Mart

Sources

Fontes de dados definidas no dbt:

commodities

movimentacao_commodities

Essas tabelas representam os dados brutos carregados no banco.

Staging Layer

A camada de staging padroniza e prepara os dados para análise.

Modelos:

stg_commodities
stg_movimentacao_commodities

Principais transformações:

Padronização de nomes de colunas

Conversão de tipos de dados

Organização da estrutura dos datasets

dbt (Data Mart)

O modelo final do projeto é:

dm_commodities

Esse modelo:

Combina dados de preços com movimentações

Calcula o valor financeiro das operações

Calcula ganho ou perda das transações

Filtra os dados mais recentes

Essa tabela é utilizada para análise e visualização.
      
Streamlit Dashboard

Visualização (Streamlit)

O dashboard é construído utilizando Streamlit.

Arquivo responsável:

app/app.py

O Streamlit consulta diretamente o modelo analítico:

SELECT * FROM public.dm_commodities

E exibe os resultados em um dashboard interativo.
