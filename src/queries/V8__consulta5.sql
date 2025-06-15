-- V8__consulta5.sql
-- Consultas SQL: Outras Consultas
USE avaliacao;
-- Garante que as consultas sejam feitas no banco de dados correto
-- 5. Mostre o apelido da conta e o saldo atual, considerando todas as receitas e despesas.
SELECT cc.Apelido AS ApelidoConta,
  cc.SaldoInicial + COALESCE(
    (
      SELECT SUM(r.Valor)
      FROM Receita r
      WHERE r.ContaCorrenteID = cc.ContaCorrenteID
        AND r.Situacao = 'pago'
    ),
    0
  ) - COALESCE(
    (
      SELECT SUM(cp.ValorPago)
      FROM ContasAPagar cp
      WHERE cp.ContaCorrenteUtilizadaID = cc.ContaCorrenteID
        AND cp.Status = 'paga'
    ),
    0
  ) AS SaldoAtual
FROM ContaCorrente cc
ORDER BY ApelidoConta;
