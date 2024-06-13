# SQL Para Análise de Dados e Data Science - Capítulo 17

-- Cria o schema
CREATE SCHEMA cap17 AUTHORIZATION dsa;

-- Cria as tabelas:

CREATE TABLE cap17.clientes (
    Id_Cliente UUID PRIMARY KEY,
    nome VARCHAR(255),
    email VARCHAR(255)
);

CREATE TABLE cap17.produtos (
    Id_Produto UUID PRIMARY KEY,
    nome VARCHAR(255),
    preco DECIMAL
);

CREATE TABLE cap17.vendas (
    Id_Vendas UUID PRIMARY KEY,
    Id_Cliente UUID REFERENCES cap17.clientes(Id_Cliente),
    Id_Produto UUID REFERENCES cap17.produtos(Id_Produto),
    Quantidade INTEGER,
    Data_Venda DATE
);