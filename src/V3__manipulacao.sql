-- Inserir formas de pagamento
INSERT INTO FormaPagamento (nome)
VALUES ('PIX'),
  ('Cartão'),
  ('Boleto');
-- Inserir uma solicitação de pagamento com 3 formas de pagamento distintas
INSERT INTO SolicitacaoPagamento (
    data_solicitacao,
    assunto,
    solicitante,
    id_categoria,
    id_subcategoria,
    id_equipamento,
    id_obra,
    nota_fiscal,
    setor,
    data_compra,
    id_fornecedor,
    valor_total
  )
VALUES (
    '2023-11-15',
    'Manutenção preventiva',
    'João Silva',
    1,
    1,
    1,
    1,
    'NF12345',
    'Operações',
    '2023-11-10',
    1,
    1000.00
  );
-- Inserir 5 movimentações de contas a pagar vinculadas à solicitação
INSERT INTO ContaPagar (
    valor,
    id_forma_pagamento,
    data_vencimento,
    id_solicitacao,
    status,
    id_conta
  )
VALUES (250.00, 1, '2023-11-20', 1, 'em aberto', 1),
  (250.00, 2, '2023-11-20', 1, 'em aberto', 1),
  (166.67, 3, '2023-11-20', 1, 'em aberto', 1),
  (166.67, 3, '2023-12-20', 1, 'em aberto', 1),
  (166.66, 3, '2024-01-20', 1, 'em aberto', 1);
-- Inserir 2 receitas diferentes com formas de pagamento distintas
INSERT INTO Receita (
    id_conta,
    id_forma_pagamento,
    id_categoria,
    id_subcategoria,
    id_obra,
    status,
    data_pagamento,
    valor
  )
VALUES (1, 1, 2, 2, 1, 'pago', '2023-11-10', 5000.00),
  (1, 2, 2, 3, 2, 'em aberto', NULL, 3000.00);
-- Atualizar o status de 1 conta a pagar para "pago"
UPDATE ContaPagar
SET status = 'paga'
WHERE id_conta_pagar = 1;
-- Deletar uma receita com o status "em aberto"
DELETE FROM Receita
WHERE status = 'em aberto'
LIMIT 1;
