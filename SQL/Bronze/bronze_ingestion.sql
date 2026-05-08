-- =====================================================
-- Camada Bronze (Raw)
-- Projeto: RavenStack Churn Analysis
-- Objetivo:
-- Armazenar os dados brutos importados para o BigQuery
-- sem transformações analíticas.
-- =====================================================

-- Fonte dos dados:
-- Dataset público simulado de SaaS/churn

-- Processo utilizado:
-- 1. Upload dos CSVs para Google Sheets
-- 2. Conexão das planilhas ao BigQuery
-- 3. Criação das tabelas raw no dataset bronze

-- Tabelas da camada bronze:
-- ravenstack_accounts
-- ravenstack_churn_events
-- ravenstack_feature_usage
-- ravenstack_subscriptions
-- ravenstack_support_tickets