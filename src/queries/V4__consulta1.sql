-- V4__consulta1.sql
-- Consultas SQL: Relatórios por Equipamentos
USE avaliacao;
-- Garante que as consultas sejam feitas no banco de dados correto
-- a) Mostre o nome dos equipamentos e o total de despesas efetivadas (pagas).
SELECT e.Nome AS NomeEquipamento,
  COALESCE(SUM(cp.ValorPago), 0) AS TotalDespesasEfetivadas
FROM Equipamento e
  LEFT JOIN SolicitacaoPagamento sp ON e.EquipamentoID = sp.EquipamentoID
  LEFT JOIN ContasAPagar cp ON sp.SolicitacaoPagamentoID = cp.SolicitacaoPagamentoID
  AND cp.Status = 'paga'
GROUP BY e.EquipamentoID,
  e.Nome
ORDER BY NomeEquipamento;
-- b) Mostre o nome dos equipamentos e o total de despesas futuras (em aberto ou atrasadas).
SELECT e.Nome AS NomeEquipamento,
  COALESCE(SUM(cp.ValorParcela), 0) AS TotalDespesasFuturas
FROM Equipamento e
  LEFT JOIN SolicitacaoPagamento sp ON e.EquipamentoID = sp.EquipamentoID
  LEFT JOIN ContasAPagar cp ON sp.SolicitacaoPagamentoID = cp.SolicitacaoPagamentoID
  AND cp.Status IN ('em aberto', 'atrasada')
GROUP BY e.EquipamentoID,
  e.Nome
ORDER BY NomeEquipamento;
-- c) Mostre o nome dos equipamentos e o total de despesas (incluindo 0 para equipamentos sem despesas).
SELECT e.Nome AS NomeEquipamento,
  COALESCE(SUM(cp.ValorParcela), 0) AS TotalDespesasGeral
FROM Equipamento e
  LEFT JOIN SolicitacaoPagamento sp ON e.EquipamentoID = sp.EquipamentoID
  LEFT JOIN ContasAPagar cp ON sp.SolicitacaoPagamentoID = cp.SolicitacaoPagamentoID
GROUP BY e.EquipamentoID,
  e.Nome
ORDER BY NomeEquipamento;
-- d) Mostre todas as despesas de um equipamento específico, com nome do equipamento, obra, valor e assunto.
SET @EquipamentoIDEspecifico = 1;
-- Substitua 1 pelo EquipamentoID desejado
SELECT e.Nome AS NomeEquipamento,
  o.Nome AS NomeObra,
  cp.ValorParcela AS ValorDespesa,
  sp.Assunto AS AssuntoSolicitacao,
  cp.DataVencimentoParcela,
  cp.Status
FROM Equipamento e
  JOIN SolicitacaoPagamento sp ON e.EquipamentoID = sp.EquipamentoID
  JOIN ContasAPagar cp ON sp.SolicitacaoPagamentoID = cp.SolicitacaoPagamentoID
  LEFT JOIN Obra o ON sp.ObraID = o.ObraID
WHERE e.EquipamentoID = @EquipamentoIDEspecifico
ORDER BY cp.DataVencimentoParcela;
-- e) Mostre o valor gasto por equipamento por obra (nome do equipamento, obra e valor total pago).
SELECT e.Nome AS NomeEquipamento,
  COALESCE(o.Nome, 'Sem Obra Específica') AS NomeObra,
  COALESCE(SUM(cp.ValorPago), 0) AS ValorTotalGastoNaObra
FROM Equipamento e
  JOIN SolicitacaoPagamento sp ON e.EquipamentoID = sp.EquipamentoID
  JOIN ContasAPagar cp ON sp.SolicitacaoPagamentoID = cp.SolicitacaoPagamentoID
  AND cp.Status = 'paga'
  LEFT JOIN Obra o ON sp.ObraID = o.ObraID
GROUP BY e.EquipamentoID,
  e.Nome,
  o.ObraID,
  o.Nome
ORDER BY NomeEquipamento,
  NomeObra;
