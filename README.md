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

```text

---
### **1. Fonte de Dados — Yahoo Finance**

Os dados de preços das commodities são coletados utilizando a biblioteca **yfinance**, que fornece acesso à API do Yahoo Finance.

Exemplos de commodities utilizadas no projeto:

- **CL=F** → Crude Oil  
- **GC=F** → Gold  
- **SI=F** → Silver  

---

### **2. Ingestão de Dados — Python ETL (Extract & Load)**

A ingestão dos dados é realizada pelo script:


src/extract_load.py


Responsabilidades do script:

- Coletar preços das commodities utilizando **yfinance**
- Estruturar os dados com **pandas**
- Conectar ao banco utilizando **SQLAlchemy**
- Carregar os dados na tabela **commodities** no PostgreSQL

Essa etapa representa a camada **EL (Extract & Load)** da pipeline.

---

### **3. Armazenamento de Dados — PostgreSQL**

Os dados coletados são armazenados em um banco **PostgreSQL**, que serve como base para as transformações analíticas realizadas pelo **dbt**.

Tabela principal gerada pela ingestão:


public.commodities


---

### **4. Transformação de Dados — dbt**

O **dbt (Data Build Tool)** é responsável pela transformação e modelagem analítica dos dados.

A modelagem segue a arquitetura:


Sources → Staging → Data Mart


---

### **Sources**

Fontes de dados definidas no dbt:

- `commodities`
- `movimentacao_commodities`

Essas tabelas representam os dados **brutos carregados no PostgreSQL**.

---

### **Staging Layer**

A camada de **staging** padroniza e prepara os dados para análise.

Modelos utilizados:


stg_commodities
stg_movimentacao_commodities


Principais transformações realizadas:

- Padronização de nomes de colunas
- Conversão de tipos de dados
- Organização da estrutura dos datasets

Essa camada garante que os dados estejam **consistentes e preparados para análise**.

---

### **Data Mart**

O modelo analítico final do projeto é:


dm_commodities


Esse modelo:

- Combina dados de **preços de commodities** com **movimentações**
- Calcula o **valor financeiro das operações**
- Calcula **ganho ou perda das transações**
- Filtra os dados da **data mais recente**

Essa tabela representa a **camada final analítica utilizada para consumo**.

---

### **5. Visualização de Dados — Streamlit**

O dashboard é construído utilizando **Streamlit**, permitindo a visualização interativa dos dados.

Arquivo responsável:


app/app.py


O Streamlit consulta diretamente o modelo analítico gerado pelo dbt:

```sql
SELECT * FROM public.dm_commodities

E exibe os resultados em um dashboard interativo para análise dos dados.

