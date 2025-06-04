SELECT cp.*,
  sp.assunto,
  f.nome_fantasia AS fornecedor
FROM ContaPagar cp
  JOIN SolicitacaoPagamento sp ON cp.id_solicitacao = sp.id_solicitacao
  LEFT JOIN Fornecedor f ON sp.id_fornecedor = f.id_fornecedor
WHERE cp.status = 'em aberto'
  AND cp.data_vencimento < CURDATE();
