-- Usa o banco de dados
USE avaliacao;
-- Adicionar coluna observacoes se não existir
ALTER TABLE SolicitacaoPagamento
ADD COLUMN IF NOT EXISTS observacoes TEXT;
-- Alterar tipo da coluna numero se necessário
ALTER TABLE ContaCorrente
MODIFY COLUMN numero VARCHAR(20);
