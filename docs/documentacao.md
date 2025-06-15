### Documentação do Banco de Dados

Esta documentação descreve a estrutura e os relacionamentos do banco de dados conforme o script de criação das tabelas.

---

#### **Estrutura das Tabelas**

1. **FormaPagamento**
   - **Descrição:** Tipos de formas de pagamento disponíveis.
   - **Campos:**
     - FormaPagamentoID (PK, autoincremento)
     - Nome (único, obrigatório)

2. **Fornecedor**
   - **Descrição:** Armazena informações dos fornecedores.
   - **Campos:**
     - FornecedorID (PK, autoincremento)
     - CNPJ (único, obrigatório)
     - RazaoSocial (obrigatório)
     - NomeFantasia

3. **Equipamento**
   - **Descrição:** Registra os equipamentos da empresa.
   - **Campos:**
     - EquipamentoID (PK, autoincremento)
     - Nome (obrigatório)
     - Placa (único)
     - Patrimonio (único)
     - Renavam (único)

4. **Obra**
   - **Descrição:** Contém os nomes das obras da empresa.
   - **Campos:**
     - ObraID (PK, autoincremento)
     - Nome (único, obrigatório)

5. **ContaCorrente**
   - **Descrição:** Informações das contas bancárias da empresa.
   - **Campos:**
     - ContaCorrenteID (PK, autoincremento)
     - Banco (obrigatório)
     - Apelido (único, obrigatório)
     - Numero (obrigatório)
     - Agencia (obrigatório)
     - SaldoInicial (obrigatório, padrão 0.00)

6. **SolicitacaoPagamento**
   - **Descrição:** Registra as solicitações de pagamento feitas pelos funcionários.
   - **Campos:**
     - SolicitacaoPagamentoID (PK, autoincremento)
     - DataSolicitacao (obrigatório)
     - Assunto (obrigatório)
     - Solicitante (obrigatório)
     - Categoria
     - Subcategoria
     - EquipamentoID (FK)
     - ObraID (FK)
     - NotaFiscal
     - Setor
     - DataCompra
     - FornecedorID (FK)
     - ValorTotalSolicitado (obrigatório)
     - DataVencimentoOriginal (obrigatório)

7. **SolicitacaoPagamento_FormasPagamento**
   - **Descrição:** Tabela de junção entre Solicitação de Pagamento e Formas de Pagamento (N:N).
   - **Campos:**
     - SolicitacaoPagamentoID (PK, FK)
     - FormaPagamentoID (PK, FK)

8. **ContasAPagar**
   - **Descrição:** Movimentações financeiras (parcelas) geradas a partir das solicitações de pagamento.
   - **Campos:**
     - ContaAPagarID (PK, autoincremento)
     - SolicitacaoPagamentoID (FK, obrigatório)
     - ValorParcela (obrigatório)
     - DataVencimentoParcela (obrigatório)
     - Status (obrigatório: 'em aberto', 'atrasada', 'paga')
     - ContaCorrenteUtilizadaID (FK)
     - DataPagamentoRealizado
     - ValorPago

9. **Receita**
   - **Descrição:** Registra as receitas da empresa.
   - **Campos:**
     - ReceitaID (PK, autoincremento)
     - ContaCorrenteID (FK, obrigatório)
     - FormaPagamentoID (FK, obrigatório)
     - Categoria
     - Subcategoria
     - ObraID (FK)
     - Situacao (obrigatório: 'em aberto', 'pago', 'em atraso')
     - DataRecebimentoPrevista (obrigatório)
     - DataRecebimentoReal
     - Valor (obrigatório)

---

#### **Relacionamentos Entre Tabelas**

- **SolicitacaoPagamento** pode referenciar **Equipamento**, **Obra** e **Fornecedor**.
- **SolicitacaoPagamento** se relaciona com **FormaPagamento** via tabela de junção (**SolicitacaoPagamento_FormasPagamento**), permitindo múltiplas formas de pagamento por solicitação.
- **SolicitacaoPagamento** pode gerar várias **ContasAPagar** (1:N).
- **ContasAPagar** pode referenciar **ContaCorrente** utilizada para pagamento.
- **Receita** referencia **ContaCorrente**, **FormaPagamento** e **Obra**.
- **Categoria** e **Subcategoria** são armazenadas como campos de texto em **SolicitacaoPagamento** e **Receita**.

---

#### **Observações Gerais**

- Todas as tabelas possuem chaves primárias autoincrementadas.
- Chaves estrangeiras garantem a integridade referencial entre as tabelas.
- Tipos de dados foram definidos conforme a natureza de cada campo (datas, valores monetários, textos).
- Restrições de unicidade e obrigatoriedade foram aplicadas conforme necessário.
- As consultas SQL
