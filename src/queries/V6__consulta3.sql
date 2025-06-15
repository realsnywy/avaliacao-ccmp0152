-- V6__consulta3.sql
-- Consultas SQL: Projeção de Despesas
USE avaliacao;
-- Garante que as consultas sejam feitas no banco de dados correto
-- a) Valor das despesas no próximo trimestre.
SELECT SUM(cp.ValorParcela) AS DespesasProximoTrimestre
FROM ContasAPagar cp
WHERE cp.Status IN ('em aberto', 'atrasada')
  AND cp.DataVencimentoParcela BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 3 MONTH);
-- b) Valor das despesas no próximo bimestre.
SELECT SUM(cp.ValorParcela) AS DespesasProximoBimestre
FROM ContasAPagar cp
WHERE cp.Status IN ('em aberto', 'atrasada')
  AND cp.DataVencimentoParcela BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 2 MONTH);
-- c) Valor das despesas no próximo semestre.
SELECT SUM(cp.ValorParcela) AS DespesasProximoSemestre
FROM ContasAPagar cp
WHERE cp.Status IN ('em aberto', 'atrasada')
  AND cp.DataVencimentoParcela BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 6 MONTH);
