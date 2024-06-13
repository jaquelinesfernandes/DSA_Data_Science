# SQL Para Análise de Dados e Data Science - Capítulo 12


-- Cria a tabela
CREATE TABLE cap12.vendas_temporais (
    id SERIAL PRIMARY KEY,
    data_venda DATE NOT NULL,
    valor_venda DECIMAL(10,2) NOT NULL,
    funcionario_id INT NOT NULL
);


-- Insere os registros
INSERT INTO cap12.vendas_temporais (data_venda, valor_venda, funcionario_id) VALUES
('2025-01-01', 175.00, 1001),
('2025-01-02', 155.00, 1001),
('2025-01-03', 321.00, 1002),
('2025-01-04', 254.00, 1001),
('2025-01-05', 189.00, 1002),
('2025-01-05', 182.00, 1002),
('2025-01-05', 183.00, 1002),
('2025-01-06', 190.00, 1003),
('2025-01-07', 190.00, 1003),
('2025-01-08', 245.00, 1004),
('2025-01-09', 456.00, 1005),
('2025-01-09', 230.00, 1005),
('2025-01-09', 150.00, 1003),
('2025-01-10', 157.00, 1002),
('2025-01-10', 188.00, 1001);



-- 1. Crie uma query para comparar em um relatório os dados de vendas diárias com a média móvel
-- Considere janela de 3 dias para a média móvel
SELECT
    data_venda,
    valor_venda,
    ROUND(AVG(valor_venda) OVER (ORDER BY data_venda ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING), 2) as media_movel
FROM cap12.vendas_temporais;


-- 2. Crie uma query para comparar em um relatório os dados de vendas diárias com a média móvel
-- Considere janela de 7 dias para a média móvel
SELECT
    data_venda,
    valor_venda,
    ROUND(AVG(valor_venda) OVER (ORDER BY data_venda ROWS BETWEEN 3 PRECEDING AND 3 FOLLOWING), 2) as media_movel_7_dias
FROM cap12.vendas_temporais;


-- 3. Crie uma query que mostre o crescimento das vendas diárias em relação ao dia anterior
-- Por exemplo: De um dia para outro a venda aumentou em 23 ou diminuiu em 57
SELECT
    data_venda,
    valor_venda,
    COALESCE(valor_venda - LAG(valor_venda) OVER (ORDER BY data_venda), 0) as crescimento_dia_anterior
FROM cap12.vendas_temporais;


-- 4. Crie uma query que mostre a soma acumulada de vendas dia a dia
SELECT
    data_venda,
    SUM(valor_venda) OVER (PARTITION BY EXTRACT(DAY FROM data_venda) ORDER BY data_venda) as soma_acumulada
FROM cap12.vendas_temporais;


-- Queremos a soma acumulada dia a dia ao longo do tempo, logo tenho que fazer o partition por mês
SELECT
    data_venda,
    SUM(valor_venda) OVER (PARTITION BY EXTRACT(MONTH FROM data_venda) ORDER BY data_venda) as soma_acumulada
FROM cap12.vendas_temporais;


-- 5. [Desafio] Crie um ranking de vendas por funcionário considerando o valor total de vendas por dia e de cada funcionário
SELECT 
    *,
    DENSE_RANK() OVER (PARTITION BY funcionario_id ORDER BY valor_venda DESC) as rank_vendas
FROM 
    (SELECT data_venda, funcionario_id, SUM(valor_venda) as valor_venda
     FROM cap12.vendas_temporais
     GROUP BY data_venda, funcionario_id) as subquery
ORDER BY 
    funcionario_id, rank_vendas;













