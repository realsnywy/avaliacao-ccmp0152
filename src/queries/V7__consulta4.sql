-- V7__consulta4.sql
-- Consultas SQL: Outras Consultas
USE avaliacao;
-- Garante que as consultas sejam feitas no banco de dados correto
-- 4. Liste todas as contas em atraso da empresa.
SELECT cp.ContaAPagarID,
  sp.Assunto AS AssuntoSolicitacao,
  cp.ValorParcela,
  cp.DataVencimentoParcela,
  DATEDIFF(CURDATE(), cp.DataVencimentoParcela) AS DiasEmAtraso,
  f.NomeFantasia AS Fornecedor
FROM ContasAPagar cp
  JOIN SolicitacaoPagamento sp ON cp.SolicitacaoPagamentoID = sp.SolicitacaoPagamentoID
  LEFT JOIN Fornecedor f ON sp.FornecedorID = f.FornecedorID
WHERE cp.Status = 'atrasada'
  OR (
    cp.Status = 'em aberto'
    AND cp.DataVencimentoParcela < CURDATE()
  )
ORDER BY cp.DataVencimentoParcela;
-- UPDATE para marcar contas como 'atrasada' (comentado para não executar automaticamente)
-- UPDATE ContasAPagar
-- SET Status = 'atrasada'
-- WHERE Status = 'em aberto' AND DataVencimentoParcela < CURDATE();
