# avaliacao-ccmp0152

Projeto de banco de dados para gestão financeira empresarial - Avaliação II da disciplina Banco de Dados I (CCMP0152).

## 🎯 Objetivo

Desenvolver um banco de dados para controle financeiro empresarial, permitindo o registro detalhado de despesas e receitas, além da geração de relatórios gerenciais via SQL.

## 📁 Estrutura do Projeto

```
docs/
 └── documentacao.md         # Documentação complementar e explicações
src/
 ├── V1__modelagem.sql           # Criação das tabelas e modelagem (DDL)
 ├── V2__alteracoes.sql          # Alterações estruturais (DDL)
 ├── V3__manipulacao.sql         # Manipulação de dados (DML)
 └── queries/
   ├── V4__consulta1.sql      # Consultas: relatórios por equipamentos
   ├── V5__consulta2.sql      # Consultas: receitas por obras
   ├── V6__consulta3.sql      # Consultas: projeção de despesas
   ├── V7__consulta4.sql      # Consultas: contas em atraso
   └── V8__consulta5.sql      # Consultas: saldo atual das contas
README.md
```

## 📜 Scripts

- **V1__modelagem.sql:** Criação das tabelas e definição de chaves primárias e estrangeiras.
- **V2__alteracoes.sql:** Alterações estruturais, como adição de colunas, índices e alteração de tipos.
- **V3__manipulacao.sql:** Inserção, atualização e remoção de dados conforme solicitado.
- **V4__consulta1.sql a V8__consulta5.sql:** Consultas SQL para geração dos relatórios e análises exigidas.

## 🚀 Como Executar

### 1. Pré-requisitos

- SGBD compatível com SQL (ex: PostgreSQL, MySQL, SQLite).
- Ferramenta para execução de scripts SQL (ex: DBeaver, psql, MySQL Workbench).

### 2. Passos

1. Clone este repositório:

   ```sh
   git clone https://github.com/realsnywy/avaliacao-ccmp0152.git
   cd avaliacao-ccmp0152
   ```

2. Execute os scripts na seguinte ordem, dentro de `src/queries/`:

   1. `V1__modelagem.sql`
   2. `V2__alteracoes.sql`
   3. `V3__manipulacao.sql`
   4. `V4__consulta1.sql` até `V8__consulta5.sql` para os relatórios.

   **Dica:** Certifique-se de executar cada script apenas após o anterior ter sido concluído com sucesso.

### 3. Documentação

Consulte o arquivo [`docs/documentacao.md`](docs/documentacao.md) para detalhes sobre o modelo de dados, decisões de projeto e exemplos de uso.

---

> Projeto acadêmico para fins de estudo na disciplina Banco de Dados I (CCMP0152).
