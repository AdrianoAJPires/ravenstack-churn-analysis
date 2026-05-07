# RavenStack | Análise de Churn SaaS

Projeto completo de análise de churn desenvolvido com foco em engenharia de dados, modelagem analítica e visualização estratégica.

O projeto simula o cenário de uma empresa SaaS fictícia chamada RavenStack, utilizando um dataset público para analisar padrões de cancelamento, engajamento de usuários e fatores associados ao churn.

Todo o pipeline foi estruturado utilizando arquitetura medalhão no BigQuery, com transformação dos dados via SQL e construção de dashboard analítico no Power BI.

## Objetivo de Negócio

O principal objetivo do projeto foi identificar padrões e comportamentos associados ao churn de clientes em um ambiente SaaS.

A análise busca responder perguntas como:

- Contas em período de trial apresentam maior churn?
- Existem diferenças de churn entre planos?
- Quais motivos aparecem com maior frequência nos cancelamentos?
- Engajamento e satisfação impactam retenção?
- Existem segmentos com maior risco de cancelamento?

Além da análise visual, o projeto também teve como objetivo praticar conceitos de:
- Arquitetura medalhão
- ETL em BigQuery
- Modelagem analítica
- Storytelling com dados
- Construção de dashboards executivos

  ## Arquitetura do Projeto

O pipeline foi estruturado utilizando arquitetura medalhão, separando os dados em diferentes camadas de tratamento e consumo analítico.

### Fluxo do pipeline

1. Ingestão dos dados públicos no BigQuery
2. Armazenamento dos dados brutos na camada Bronze
3. Limpeza, padronização e tratamento na camada Silver
4. Consolidação analítica e criação de métricas na camada Gold
5. Construção do dashboard analítico no Power BI

### Arquitetura visual

![Arquitetura Medalhão](docs/arquitetura_medalhao.png)

## Stack Utilizada

| Ferramenta | Finalidade |
|---|---|
| BigQuery | Armazenamento e processamento dos dados |
| SQL | Transformações e modelagem analítica |
| Power BI | Visualização e construção do dashboard |
| Google Sheets | Apoio na ingestão inicial dos dados |
| Figma | Documentação visual da arquitetura |
