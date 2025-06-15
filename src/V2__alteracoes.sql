-- V2__alteracoes.sql
-- Alterações estruturais (DDL) nas tabelas existentes
USE avaliacao;
-- Garante que as alterações sejam feitas no banco de dados correto
-- 1. Adicione uma nova coluna `observacoes` na tabela de solicitações de pagamento.
ALTER TABLE SolicitacaoPagamento
ADD COLUMN Observacoes TEXT;
-- 2. Altere o tipo da coluna `numero` da tabela de contas correntes para `VARCHAR(20)`.
ALTER TABLE ContaCorrente
MODIFY COLUMN Numero VARCHAR(20) NOT NULL;
-- Nota: Em PostgreSQL, seria: ALTER TABLE ContaCorrente ALTER COLUMN Numero TYPE VARCHAR(20);
-- Nota: Em SQL Server, seria: ALTER TABLE ContaCorrente ALTER COLUMN Numero VARCHAR(20) NOT NULL;
