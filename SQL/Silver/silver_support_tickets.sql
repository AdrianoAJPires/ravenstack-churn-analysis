-- Criar tabela silver de tickets abertos pelas contas
CREATE OR REPLACE TABLE ravenstack.ravenstack_silver.ravenstack_support_tickets_cleaned AS(
  SELECT UPPER(ticket_id) as ticket_id,
        UPPER(account_id) as account_id,
        submitted_at as submitted_at,
        closed_at as closed_at,
        priority,
        first_response_time_minutes,
        satisfaction_score as satisfaction
  FROM ravenstack.ravenstack_bronze.ravenstack_support_tickets
);