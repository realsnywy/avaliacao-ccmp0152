-- Usa o banco de dados
USE avaliacao;
SELECT o.nome AS obra,
  SUM(r.valor) AS total_receita
FROM Receita r
  LEFT JOIN Obra o ON r.id_obra = o.id_obra
GROUP BY o.nome;
