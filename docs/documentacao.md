### Documentação do Banco de Dados

**Estrutura do Banco de Dados:**

1. **Fornecedor**: Armazena informações dos fornecedores (CNPJ, razão social, nome fantasia).
2. **Equipamento**: Registra os equipamentos da empresa (nome, placa, patrimônio, renavam).
3. **Obra**: Contém os nomes das obras da empresa.
4. **Categoria**: Classifica despesas e receitas em categorias.
5. **Subcategoria**: Subdivisões das categorias.
6. **ContaCorrente**: Informações das contas bancárias da empresa.
7. **FormaPagamento**: Tipos de formas de pagamento disponíveis.
8. **SolicitacaoPagamento**: Registra as solicitações de pagamento feitas pelos funcionários.
9. **ContaPagar**: Movimentações financeiras geradas a partir das solicitações de pagamento.
10. **Receita**: Registra as receitas da empresa.

**Relacionamentos:**

- Uma solicitação de pagamento pode gerar várias contas a pagar.
- Cada conta a pagar está vinculada a uma única solicitação de pagamento.
- Receitas e despesas estão associadas a categorias e subcategorias.
- Equipamentos e obras podem estar vinculados a solicitações de pagamento.

**Observações:**

- Todas as tabelas possuem chaves primárias autoincrementadas.
- Foram utilizados tipos de dados apropriados para cada campo.
- As consultas foram organizadas de acordo com os requisitos da avaliação.
