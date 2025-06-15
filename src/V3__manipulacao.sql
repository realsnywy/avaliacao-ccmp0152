-- V3__manipulacao.sql
-- Manipulação de dados (DML): Inserções, Atualizações e Deleções
USE avaliacao;
-- Garante que as manipulações sejam feitas no banco de dados correto
-- Dados Iniciais Essenciais
INSERT INTO FormaPagamento (Nome)
VALUES ('Boleto Bancário'),
  ('Cartão de Crédito'),
  ('Transferência PIX'),
  ('Débito Automático');
INSERT INTO Fornecedor (CNPJ, RazaoSocial, NomeFantasia)
VALUES (
    '11.222.333/0001-44',
    'Fornecedor Alpha Ltda',
    'Alpha Suprimentos'
  ),
  (
    '55.666.777/0001-88',
    'Beta Serviços e Peças SA',
    'Beta Peças'
  );
INSERT INTO Equipamento (Nome, Placa, Patrimonio, Renavam)
VALUES (
    'Escavadeira X100',
    'ABC1D23',
    'PAT1001',
    '12345678901'
  ),
  (
    'Caminhão Basculante Z50',
    'DEF4E56',
    'PAT1002',
    '09876543210'
  ),
  ('Notebook Dell Inspiron', NULL, 'PAT2001', NULL);
INSERT INTO Obra (Nome)
VALUES ('Construção Edifício Central'),
  ('Reforma Ponte Sul'),
  ('Manutenção Preventiva Frota');
INSERT INTO ContaCorrente (Banco, Apelido, Numero, Agencia, SaldoInicial)
VALUES (
    'Banco Principal S.A.',
    'Conta Matriz Principal',
    '12345-6',
    '0001',
    10000.00
  ),
  (
    'CreditBank Ltda',
    'Conta Filial ABC',
    '98765-4',
    '0002',
    5000.00
  );
-- 1. Insira uma solicitação de pagamento com 3 formas de pagamento distintas.
INSERT INTO SolicitacaoPagamento (
    DataSolicitacao,
    Assunto,
    Solicitante,
    Categoria,
    Subcategoria,
    EquipamentoID,
    ObraID,
    NotaFiscal,
    Setor,
    DataCompra,
    FornecedorID,
    ValorTotalSolicitado,
    DataVencimentoOriginal,
    Observacoes
  )
VALUES (
    '2024-05-10',
    'Aquisição de Peças para Escavadeira',
    'João Silva',
    'Manutenção',
    'Peças de Reposição',
    1,
    3,
    'NF12345',
    'Manutenção',
    '2024-05-08',
    2,
    1500.00,
    '2024-06-10',
    'Compra urgente para reparo da Escavadeira X100.'
  );
-- Assumindo que a solicitação acima teve SolicitacaoPagamentoID = 1
INSERT INTO SolicitacaoPagamento_FormasPagamento (SolicitacaoPagamentoID, FormaPagamentoID)
VALUES (1, 1),
  -- Boleto Bancário
  (1, 2),
  -- Cartão de Crédito
  (1, 3);
-- Transferência PIX
-- 2. Insira 5 movimentações de contas a pagar vinculadas à solicitação acima.
-- (Assumindo SolicitacaoPagamentoID = 1 para a solicitação de R$1500,00)
INSERT INTO ContasAPagar (
    SolicitacaoPagamentoID,
    ValorParcela,
    DataVencimentoParcela,
    Status
  )
VALUES (1, 300.00, '2024-06-10', 'em aberto'),
  (1, 300.00, '2024-07-10', 'em aberto'),
  (1, 300.00, '2024-08-10', 'em aberto'),
  (1, 300.00, '2024-09-10', 'em aberto'),
  (1, 300.00, '2024-10-10', 'em aberto');
-- 3. Insira pelo menos 2 receitas diferentes com formas de pagamento distintas.
INSERT INTO Receita (
    ContaCorrenteID,
    FormaPagamentoID,
    Categoria,
    Subcategoria,
    ObraID,
    Situacao,
    DataRecebimentoPrevista,
    DataRecebimentoReal,
    Valor
  )
VALUES (
    1,
    3,
    'Serviços Prestados',
    'Consultoria',
    1,
    'pago',
    '2024-05-15',
    '2024-05-14',
    5000.00
  ),
  (
    2,
    1,
    'Venda de Ativo',
    'Equipamento Usado',
    NULL,
    'em aberto',
    '2024-06-20',
    NULL,
    2500.00
  );
-- 4. Atualize o status de 1 conta a pagar para “pago”.
-- Assumindo que a primeira parcela (ContaAPagarID = 1) da solicitação 1 foi paga.
UPDATE ContasAPagar
SET Status = 'paga',
  ContaCorrenteUtilizadaID = 1,
  DataPagamentoRealizado = '2024-06-08',
  ValorPago = 300.00
WHERE ContaAPagarID = 1;
-- 5. Delete uma receita com o status “em aberto”.
-- Assumindo que a receita com ID 2 (Venda de Ativo) está 'em aberto'.
DELETE FROM Receita
WHERE Situacao = 'em aberto'
  AND ReceitaID = 2;
