-- Criar tabela silver de eventos de churn
CREATE OR REPLACE TABLE ravenstack.ravenstack_silver.ravenstack_churn_events_cleaned AS(
  SELECT UPPER(account_id) as account_id,
      UPPER(churn_event_id) as churn_event_id,
      churn_date as churn_date,
      COALESCE(reason_code, "unknown") as reason,
      SUM(refund_amount_usd) as refund_amount_usd,
      MAX(CASE WHEN preceding_upgrade_flag = TRUE THEN 1 ELSE 0 END) as preceding_upgrade,
      MAX(CASE WHEN preceding_downgrade_flag = TRUE THEN 1 ELSE 0 END) as preceding_downgrade,
      is_reactivation,
      feedback_text
  FROM ravenstack.ravenstack_bronze.ravenstack_churn_events
  GROUP BY 1, 2, 3, 4, 8, 9
);