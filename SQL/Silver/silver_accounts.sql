-- Tabela de contas (dimensão principal)
-- Mantém dados essenciais da conta e padroniza alguns campos
CREATE OR REPLACE TABLE ravenstack.ravenstack_silver.ravenstack_accounts_cleaned AS(
  SELECT UPPER(account_id) as account_id,
        signup_date as created_at,
        industry,
        country,
        referral_source,
        plan_tier as plan,
        is_trial,
        CASE WHEN churn_flag = FALSE THEN 'Ativo' ELSE 'Churn' END AS churn
  FROM ravenstack.ravenstack_bronze.ravenstack_accounts
);