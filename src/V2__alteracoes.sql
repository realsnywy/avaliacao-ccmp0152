-- Adicionar coluna observações na tabela de solicitações de pagamento
ALTER TABLE SolicitacaoPagamento
ADD COLUMN observacoes TEXT;
-- Alterar tipo da coluna numero da tabela de contas correntes
ALTER TABLE ContaCorrente
MODIFY COLUMN numero VARCHAR(20);
