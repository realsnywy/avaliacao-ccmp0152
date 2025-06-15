-- V5__consulta2.sql
-- Consultas SQL: Relatórios de Receitas
USE avaliacao;
-- Garante que as consultas sejam feitas no banco de dados correto
-- Apresente o valor da receita separado por obras, com valor total e nome da obra.
SELECT COALESCE(o.Nome, 'Sem Obra Específica') AS NomeObra,
  SUM(r.Valor) AS ValorTotalReceitaPagaNaObra
FROM Receita r
  LEFT JOIN Obra o ON r.ObraID = o.ObraID
WHERE r.Situacao = 'pago'
GROUP BY o.ObraID,
  o.Nome
ORDER BY ValorTotalReceitaPagaNaObra DESC;
-- Alternativa incluindo obras sem receitas pagas ou receitas sem obra específica:
SELECT COALESCE(o.Nome, 'Receitas Sem Obra Específica') AS NomeObra,
  COALESCE(
    SUM(
      CASE
        WHEN r.Situacao = 'pago' THEN r.Valor
        ELSE 0
      END
    ),
    0
  ) AS ValorTotalReceitaPaga
FROM Obra o
  LEFT JOIN Receita r ON o.ObraID = r.ObraID
GROUP BY o.ObraID,
  o.Nome
UNION ALL
SELECT 'Receitas Sem Obra Específica' AS NomeObra,
  COALESCE(
    SUM(
      CASE
        WHEN r.Situacao = 'pago' THEN r.Valor
        ELSE 0
      END
    ),
    0
  ) AS ValorTotalReceitaPaga
FROM Receita r
WHERE r.ObraID IS NULL
ORDER BY ValorTotalReceitaPaga DESC;
