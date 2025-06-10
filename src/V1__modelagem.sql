-- Criação do banco de dados
CREATE DATABASE IF NOT EXISTS avaliacao;
USE avaliacao;
-- Criação das tabelas principais
CREATE TABLE IF NOT EXISTS Fornecedor (
  id_fornecedor INT PRIMARY KEY AUTO_INCREMENT,
  cnpj VARCHAR(14) NOT NULL UNIQUE,
  razao_social VARCHAR(100) NOT NULL,
  nome_fantasia VARCHAR(100)
);
CREATE TABLE IF NOT EXISTS Equipamento (
  id_equipamento INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(100) NOT NULL,
  placa VARCHAR(20),
  patrimonio VARCHAR(50),
  renavam VARCHAR(50)
);
CREATE TABLE IF NOT EXISTS Obra (
  id_obra INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(100) NOT NULL
);
CREATE TABLE IF NOT EXISTS Categoria (
  id_categoria INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(50) NOT NULL,
  tipo ENUM('Despesa', 'Receita') NOT NULL
);
CREATE TABLE IF NOT EXISTS Subcategoria (
  id_subcategoria INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(50) NOT NULL,
  id_categoria INT NOT NULL,
  FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria)
);
CREATE TABLE IF NOT EXISTS ContaCorrente (
  id_conta INT PRIMARY KEY AUTO_INCREMENT,
  banco VARCHAR(50) NOT NULL,
  apelido VARCHAR(50) NOT NULL,
  numero VARCHAR(20) NOT NULL,
  agencia VARCHAR(20) NOT NULL,
  saldo_inicial DECIMAL(10, 2) NOT NULL
);
CREATE TABLE IF NOT EXISTS FormaPagamento (
  id_forma_pagamento INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(50) NOT NULL
);
CREATE TABLE IF NOT EXISTS SolicitacaoPagamento (
  id_solicitacao INT PRIMARY KEY AUTO_INCREMENT,
  data_solicitacao DATE NOT NULL,
  assunto VARCHAR(100) NOT NULL,
  solicitante VARCHAR(100) NOT NULL,
  id_categoria INT NOT NULL,
  id_subcategoria INT NOT NULL,
  id_equipamento INT,
  id_obra INT,
  nota_fiscal VARCHAR(50),
  setor VARCHAR(50),
  data_compra DATE,
  id_fornecedor INT,
  observacoes TEXT,
  FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria),
  FOREIGN KEY (id_subcategoria) REFERENCES Subcategoria(id_subcategoria),
  FOREIGN KEY (id_equipamento) REFERENCES Equipamento(id_equipamento),
  FOREIGN KEY (id_obra) REFERENCES Obra(id_obra),
  FOREIGN KEY (id_fornecedor) REFERENCES Fornecedor(id_fornecedor)
);
CREATE TABLE IF NOT EXISTS ContaPagar (
  id_conta_pagar INT PRIMARY KEY AUTO_INCREMENT,
  valor DECIMAL(10, 2) NOT NULL,
  id_forma_pagamento INT NOT NULL,
  data_vencimento DATE NOT NULL,
  id_solicitacao INT NOT NULL,
  status ENUM('em aberto', 'atrasada', 'paga') NOT NULL,
  id_conta INT NOT NULL,
  FOREIGN KEY (id_forma_pagamento) REFERENCES FormaPagamento(id_forma_pagamento),
  FOREIGN KEY (id_solicitacao) REFERENCES SolicitacaoPagamento(id_solicitacao),
  FOREIGN KEY (id_conta) REFERENCES ContaCorrente(id_conta)
);
CREATE TABLE IF NOT EXISTS Receita (
  id_receita INT PRIMARY KEY AUTO_INCREMENT,
  id_conta INT NOT NULL,
  id_forma_pagamento INT NOT NULL,
  id_categoria INT NOT NULL,
  id_subcategoria INT NOT NULL,
  id_obra INT,
  status ENUM('em aberto', 'pago', 'em atraso') NOT NULL,
  data_pagamento DATE,
  valor DECIMAL(10, 2) NOT NULL,
  FOREIGN KEY (id_conta) REFERENCES ContaCorrente(id_conta),
  FOREIGN KEY (id_forma_pagamento) REFERENCES FormaPagamento(id_forma_pagamento),
  FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria),
  FOREIGN KEY (id_subcategoria) REFERENCES Subcategoria(id_subcategoria),
  FOREIGN KEY (id_obra) REFERENCES Obra(id_obra)
);
