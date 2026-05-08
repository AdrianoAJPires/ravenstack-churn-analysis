-- Criar tabela silver de uso da plataforma
CREATE OR REPLACE TABLE ravenstack.ravenstack_silver.ravenstack_feature_usage_cleaned AS(
  SELECT UPPER(usage_id) as usage_id,
        UPPER(subscription_id) as subscription_id,
        usage_date as usage_date,
        feature_name as feature,
        usage_count,
        ROUND(usage_duration_secs / 60.0, 2) AS usage_duration_min,
        error_count
  FROM ravenstack.ravenstack_bronze.ravenstack_feature_usage
);