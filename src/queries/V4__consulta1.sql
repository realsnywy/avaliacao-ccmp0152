-- Usa o banco de dados
USE avaliacao;
-- a) Total de despesas efetivadas por equipamento
SELECT e.nome,
  SUM(cp.valor) AS total_despesas
FROM Equipamento e
  LEFT JOIN SolicitacaoPagamento sp ON e.id_equipamento = sp.id_equipamento
  LEFT JOIN ContaPagar cp ON sp.id_solicitacao = cp.id_solicitacao
WHERE cp.status = 'paga'
GROUP BY e.nome;
-- b) Total de despesas futuras por equipamento
SELECT e.nome,
  SUM(cp.valor) AS total_despesas_futuras
FROM Equipamento e
  LEFT JOIN SolicitacaoPagamento sp ON e.id_equipamento = sp.id_equipamento
  LEFT JOIN ContaPagar cp ON sp.id_solicitacao = cp.id_solicitacao
WHERE cp.status = 'em aberto'
  AND cp.data_vencimento > CURDATE()
GROUP BY e.nome;
-- c) Total de despesas (incluindo 0 para equipamentos sem despesas)
SELECT e.nome,
  IFNULL(SUM(cp.valor), 0) AS total_despesas
FROM Equipamento e
  LEFT JOIN SolicitacaoPagamento sp ON e.id_equipamento = sp.id_equipamento
  LEFT JOIN ContaPagar cp ON sp.id_solicitacao = cp.id_solicitacao
GROUP BY e.nome;
-- d) Todas as despesas de um determinado equipamento
SELECT e.nome,
  o.nome AS obra,
  cp.valor AS valor_gasto,
  sp.assunto
FROM Equipamento e
  JOIN SolicitacaoPagamento sp ON e.id_equipamento = sp.id_equipamento
  JOIN ContaPagar cp ON sp.id_solicitacao = cp.id_solicitacao
  LEFT JOIN Obra o ON sp.id_obra = o.id_obra
WHERE e.id_equipamento = 1;
-- e) Total gasto por equipamento por obra
SELECT e.nome,
  o.nome AS obra,
  SUM(cp.valor) AS total_gasto
FROM Equipamento e
  JOIN SolicitacaoPagamento sp ON e.id_equipamento = sp.id_equipamento
  JOIN ContaPagar cp ON sp.id_solicitacao = cp.id_solicitacao
  LEFT JOIN Obra o ON sp.id_obra = o.id_obra
GROUP BY e.nome,
  o.nome;
