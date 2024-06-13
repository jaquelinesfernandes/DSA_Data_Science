# SQL Para Análise de Dados e Data Science - Capítulo 05


-- Criando a tabela 'fornecedores'
CREATE TABLE cap05.fornecedores (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255),
    cidade VARCHAR(255),
    estado VARCHAR(2),
    email VARCHAR(255),
    data_registro DATE
);


-- Inserindo registros na tabela 'funcionarios'
INSERT INTO cap05.fornecedores (nome, cidade, estado, email, data_registro) VALUES
('Fornecedor 1', 'São Paulo', 'SP', 'fornecedor1@exemplo.dsa.com', '2023-09-01'),
('Fornecedor 2', 'Rio de Janeiro', 'RJ', 'fornecedor2@exemplo.dsa.com', '2023-09-02'),
('Fornecedor 3', 'Belo Horizonte', 'MG', 'fornecedor3@exemplo.dsa.com', '2023-09-03'),
('Fornecedor 4', 'Porto Alegre', 'RS', 'fornecedor4@exemplo.dsa.com', '2023-09-04'),
('Fornecedor 5', 'Curitiba', 'PR', 'fornecedor5@exemplo.dsa.com', '2023-09-05'),
('Fornecedor 6', 'Recife', 'PE', 'fornecedor6@exemplo.dsa.com', '2023-09-06'),
('Fornecedor 7', 'Salvador', 'BA', 'fornecedor7@exemplo.dsa.com', '2023-10-07'),
('Fornecedor 8', 'Fortaleza', 'CE', 'fornecedor8@exemplo.dsa.com', '2023-10-08'),
('Fornecedor 9', 'Goiânia', 'GO', 'fornecedor9@exemplo.dsa.com', '2023-10-09'),
('Fornecedor 10', 'Manaus', 'AM', 'fornecedor10@exemplo.dsa.com', '2023-10-10');


-- Use SQL para responder às perguntas abaixo:


-- Dica: SEMPRE VERIFIQUE OS DADOS!
SELECT * FROM cap05.fornecedores;


-- Pergunta 1: Qual é a quantidade de fornecedores por estado?

SELECT estado, COUNT(*) AS quantidade_fornecedores
FROM cap05.fornecedores
GROUP BY estado;

SELECT estado, (SELECT COUNT(*) FROM cap05.fornecedores WHERE estado = f.estado) AS quantidade_fornecedores
FROM cap05.fornecedores f
GROUP BY estado;


-- Pergunta 2: Qual é o estado com o maior número de fornecedores?

SELECT estado
FROM cap05.fornecedores
GROUP BY estado
ORDER BY COUNT(*) DESC
LIMIT 1;


-- Pergunta 3: Quantos fornecedores foram registrados no mês de Setembro de 2023?

SELECT COUNT(*) AS fornecedores_registrados_apos_jan
FROM cap05.fornecedores
WHERE data_registro >= '2023-09-01' 
  AND data_registro <= '2023-09-30';


-- Pergunta 4: Qual é a média de registros de fornecedores por mês?

SELECT EXTRACT(MONTH FROM data_registro) AS mes, COUNT(*) AS qtd
FROM cap05.fornecedores
GROUP BY EXTRACT(MONTH FROM data_registro);
    
SELECT ROUND(AVG(qtd), 0) AS media_registros_por_mes
FROM (
    SELECT EXTRACT(MONTH FROM data_registro) AS mes, COUNT(*) AS qtd
    FROM cap05.fornecedores
    GROUP BY EXTRACT(MONTH FROM data_registro)
) AS subquery;


-- Pergunta 5: Qual é o fornecedor mais recente registrado?

SELECT nome, data_registro
FROM cap05.fornecedores
WHERE data_registro = (SELECT MAX(data_registro) FROM cap05.fornecedores);















