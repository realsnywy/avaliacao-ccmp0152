-- Usa o banco de dados
USE avaliacao;
SELECT cc.apelido,
  (
    cc.saldo_inicial + IFNULL(
      (
        SELECT SUM(r.valor)
        FROM Receita r
        WHERE r.id_conta = cc.id_conta
          AND r.status = 'pago'
      ),
      0
    ) - IFNULL(
      (
        SELECT SUM(cp.valor)
        FROM ContaPagar cp
        WHERE cp.id_conta = cc.id_conta
          AND cp.status = 'paga'
      ),
      0
    )
  ) AS saldo_atual
FROM ContaCorrente cc;
