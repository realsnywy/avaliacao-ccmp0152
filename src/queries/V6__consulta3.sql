-- a) Próximo trimestre
SELECT SUM(valor) AS despesas_trimestre
FROM ContaPagar
WHERE status = 'em aberto'
  AND data_vencimento BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 3 MONTH);
-- b) Próximo bimestre
SELECT SUM(valor) AS despesas_bimestre
FROM ContaPagar
WHERE status = 'em aberto'
  AND data_vencimento BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 2 MONTH);
-- c) Próximo semestre
SELECT SUM(valor) AS despesas_semestre
FROM ContaPagar
WHERE status = 'em aberto'
  AND data_vencimento BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 6 MONTH);
