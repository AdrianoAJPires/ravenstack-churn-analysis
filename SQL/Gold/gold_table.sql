-- Criar tabela de contas consolidada
CREATE OR REPLACE TABLE ravenstack.ravenstack_gold.ravenstack_account_gold AS (
  WITH
  -- CTE com as métricas de uso, tempo de uso e média de uso da plataforma por conta
    account AS (
      SELECT
        account_id,
        created_at,
        churn,
        industry,
        country,
        plan,
        is_trial
      FROM ravenstack.ravenstack_silver.ravenstack_accounts_cleaned
    ),

  -- CTE com as métricas de uso, tempo de uso e média de uso da plataforma por conta
  uso_metrics AS (
    SELECT 
      a.account_id,
      SUM(b.usage_count) as total_uso,
      SUM(b.usage_duration_min) as total_duration
    FROM ravenstack.ravenstack_silver.ravenstack_subscriptions_cleaned a
    JOIN ravenstack.ravenstack_silver.ravenstack_feature_usage_cleaned b
    ON a.subscription_id = b.subscription_id
    GROUP BY 1
  ),

  -- CTE com as métricas de tickets por conta
  ticket_metrics AS (
    SELECT 
      account_id,
      COUNT(ticket_id) as total_tickets,
      AVG(satisfaction) as avg_satisfaction
    FROM ravenstack.ravenstack_silver.ravenstack_support_tickets_cleaned
    GROUP BY 1
  ),

  -- CTE com o ciclo de vida da conta
  churn_metrics AS (
    SELECT
      account_id,
      SUM(refund_amount_usd) as refund_amount_usd,
      MAX(preceding_upgrade) as preceding_upgrade,
      MAX(preceding_downgrade) as preceding_downgrade,
      MAX(churn_date) as last_churn,
      DATE_DIFF(MAX(CAST(churn_date AS DATE)), MIN(CAST(created_at AS DATE)), DAY) as ciclo,
      MAX(reason) as reason
    FROM (
      SELECT 
        a.account_id, 
        a.created_at, 
        b.churn_date,
        b.refund_amount_usd,
        b.preceding_upgrade,
        b.preceding_downgrade,
        b.feedback_text,
        b.reason
      FROM ravenstack.ravenstack_silver.ravenstack_accounts_cleaned a
      LEFT JOIN ravenstack.ravenstack_silver.ravenstack_churn_events_cleaned b
      ON a.account_id = b.account_id
    )
    GROUP BY 1
  )

  -- Tabela consolidada final
  SELECT
    a.account_id,
    a.created_at,
    a.churn,
    a.industry,
    a.country,
    a.plan,
    a.is_trial,
    COALESCE(u.total_uso, 0) as total_uso,
    ROUND(COALESCE(u.total_duration, 0), 2) as total_duration_usage_min,
    COALESCE(t.total_tickets, 0) as total_tickets,
    ROUND(COALESCE(t.avg_satisfaction, 0), 2) as avg_satisfaction,
    COALESCE(d.ciclo, DATE_DIFF(CURRENT_DATE(), a.created_at, DAY)) as days_active,
    COALESCE(d.reason,'unknown') as reason,
    d.refund_amount_usd,
    d.preceding_upgrade,
    d.preceding_downgrade
  FROM ravenstack.ravenstack_silver.ravenstack_accounts_cleaned a
  LEFT JOIN uso_metrics u
  ON a.account_id = u.account_id
  LEFT JOIN ticket_metrics t
  ON a.account_id = t.account_id
  LEFT JOIN churn_metrics d
  ON a.account_id = d.account_id
);