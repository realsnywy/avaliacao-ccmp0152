-- V1__modelagem.sql
-- Criação do banco de dados e das tabelas de gestão financeira
CREATE DATABASE IF NOT EXISTS avaliacao;
USE avaliacao;
-- Tabela de Formas de Pagamento
CREATE TABLE FormaPagamento (
  FormaPagamentoID INT PRIMARY KEY AUTO_INCREMENT,
  Nome VARCHAR(100) NOT NULL UNIQUE
);
-- Tabela de Fornecedores
CREATE TABLE Fornecedor (
  FornecedorID INT PRIMARY KEY AUTO_INCREMENT,
  CNPJ VARCHAR(18) NOT NULL UNIQUE,
  -- Formato: XX.XXX.XXX/XXXX-XX
  RazaoSocial VARCHAR(255) NOT NULL,
  NomeFantasia VARCHAR(255)
);
-- Tabela de Equipamentos
CREATE TABLE Equipamento (
  EquipamentoID INT PRIMARY KEY AUTO_INCREMENT,
  Nome VARCHAR(255) NOT NULL,
  Placa VARCHAR(10) UNIQUE,
  Patrimonio VARCHAR(50) UNIQUE,
  Renavam VARCHAR(20) UNIQUE
);
-- Tabela de Obras
CREATE TABLE Obra (
  ObraID INT PRIMARY KEY AUTO_INCREMENT,
  Nome VARCHAR(255) NOT NULL UNIQUE
);
-- Tabela de Contas Correntes
CREATE TABLE ContaCorrente (
  ContaCorrenteID INT PRIMARY KEY AUTO_INCREMENT,
  Banco VARCHAR(100) NOT NULL,
  Apelido VARCHAR(100) NOT NULL UNIQUE,
  Numero VARCHAR(10) NOT NULL,
  -- Será alterado para VARCHAR(20) em V2
  Agencia VARCHAR(20) NOT NULL,
  SaldoInicial DECIMAL(15, 2) NOT NULL DEFAULT 0.00
);
-- Tabela de Solicitações de Pagamento
CREATE TABLE SolicitacaoPagamento (
  SolicitacaoPagamentoID INT PRIMARY KEY AUTO_INCREMENT,
  DataSolicitacao DATE NOT NULL,
  Assunto VARCHAR(255) NOT NULL,
  Solicitante VARCHAR(100) NOT NULL,
  Categoria VARCHAR(100),
  Subcategoria VARCHAR(100),
  EquipamentoID INT,
  ObraID INT,
  NotaFiscal VARCHAR(50),
  Setor VARCHAR(100),
  DataCompra DATE,
  FornecedorID INT,
  ValorTotalSolicitado DECIMAL(15, 2) NOT NULL,
  DataVencimentoOriginal DATE NOT NULL,
  -- Coluna 'Observacoes' será adicionada em V2
  FOREIGN KEY (EquipamentoID) REFERENCES Equipamento(EquipamentoID),
  FOREIGN KEY (ObraID) REFERENCES Obra(ObraID),
  FOREIGN KEY (FornecedorID) REFERENCES Fornecedor(FornecedorID)
);
-- Tabela de Junção: Solicitação de Pagamento e Formas de Pagamento (Muitos para Muitos)
CREATE TABLE SolicitacaoPagamento_FormasPagamento (
  SolicitacaoPagamentoID INT NOT NULL,
  FormaPagamentoID INT NOT NULL,
  PRIMARY KEY (SolicitacaoPagamentoID, FormaPagamentoID),
  FOREIGN KEY (SolicitacaoPagamentoID) REFERENCES SolicitacaoPagamento(SolicitacaoPagamentoID) ON DELETE CASCADE,
  FOREIGN KEY (FormaPagamentoID) REFERENCES FormaPagamento(FormaPagamentoID)
);
-- Tabela de Contas a Pagar (representa as movimentações/parcelas de uma solicitação)
CREATE TABLE ContasAPagar (
  ContaAPagarID INT PRIMARY KEY AUTO_INCREMENT,
  SolicitacaoPagamentoID INT NOT NULL,
  ValorParcela DECIMAL(15, 2) NOT NULL,
  DataVencimentoParcela DATE NOT NULL,
  Status VARCHAR(20) NOT NULL CHECK (Status IN ('em aberto', 'atrasada', 'paga')),
  ContaCorrenteUtilizadaID INT,
  DataPagamentoRealizado DATE,
  ValorPago DECIMAL(15, 2),
  FOREIGN KEY (SolicitacaoPagamentoID) REFERENCES SolicitacaoPagamento(SolicitacaoPagamentoID) ON DELETE CASCADE,
  FOREIGN KEY (ContaCorrenteUtilizadaID) REFERENCES ContaCorrente(ContaCorrenteID)
);
-- Tabela de Receitas
CREATE TABLE Receita (
  ReceitaID INT PRIMARY KEY AUTO_INCREMENT,
  ContaCorrenteID INT NOT NULL,
  FormaPagamentoID INT NOT NULL,
  Categoria VARCHAR(100),
  Subcategoria VARCHAR(100),
  ObraID INT,
  Situacao VARCHAR(20) NOT NULL CHECK (Situacao IN ('em aberto', 'pago', 'em atraso')),
  DataRecebimentoPrevista DATE NOT NULL,
  DataRecebimentoReal DATE,
  Valor DECIMAL(15, 2) NOT NULL,
  FOREIGN KEY (ContaCorrenteID) REFERENCES ContaCorrente(ContaCorrenteID),
  FOREIGN KEY (FormaPagamentoID) REFERENCES FormaPagamento(FormaPagamentoID),
  FOREIGN KEY (ObraID) REFERENCES Obra(ObraID)
);
