-- Criar tabela silver de informações de incrição das contas
CREATE OR REPLACE TABLE ravenstack.ravenstack_silver.ravenstack_subscriptions_cleaned AS(
  SELECT UPPER(subscription_id) as subscription_id,
        UPPER(account_id) as account_id,
        start_date as start_date,
        end_date as end_date,
        plan_tier as plan,
        seats,
        mrr_amount,
        arr_amount,
        churn_flag as churn,
        billing_frequency
  FROM ravenstack.ravenstack_bronze.ravenstack_subscriptions
);