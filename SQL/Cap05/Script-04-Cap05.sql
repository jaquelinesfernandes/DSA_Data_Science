# SQL Para Análise de Dados e Data Science - Capítulo 05


-- Query SQL para retornar o valor total final de vendas por dia.

SELECT * FROM cap05.dsa_vendas;

SELECT 
    Data_Venda,
    SUM(Valor_Unitario_Venda * Unidades_Vendidas) AS Valor_Total_Final_Venda
FROM cap05.dsa_vendas
GROUP BY Data_Venda
ORDER BY Data_Venda;


-- Query SQL para retornar a média do valor total final de vendas por mês.
SELECT 
    EXTRACT(YEAR FROM Data_Venda) AS Ano,
    EXTRACT(MONTH FROM Data_Venda) AS Mes,
    ROUND(AVG(Valor_Unitario_Venda * Unidades_Vendidas), 2) AS Media_Valor_Final_Venda
FROM cap05.dsa_vendas
GROUP BY EXTRACT(YEAR FROM Data_Venda), EXTRACT(MONTH FROM Data_Venda)
ORDER BY Ano, Mes;

SELECT 
    EXTRACT(YEAR FROM Data_Venda) AS Ano,
    EXTRACT(MONTH FROM Data_Venda) AS Mes,
    ROUND(AVG(Valor_Unitario_Venda * Unidades_Vendidas), 2) AS Media_Valor_Final_Venda
FROM cap05.dsa_vendas
GROUP BY Ano, Mes
ORDER BY Ano, Mes;


-- Query SQL para retornar a média do valor total final de venda no dia 1 de cada mês.
SELECT 
    EXTRACT(YEAR FROM Data_Venda) AS Ano,
    EXTRACT(MONTH FROM Data_Venda) AS Mes,
    ROUND(AVG(Valor_Unitario_Venda * Unidades_Vendidas), 2) AS Media_Valor_Final_Venda
FROM cap05.dsa_vendas
WHERE EXTRACT(DAY FROM Data_Venda) = 1
GROUP BY Ano, Mes
ORDER BY Ano, Mes;


-- Query SQL para retornar a média do valor total final de venda entre os dias 10 e 20 de cada mês.
SELECT 
    EXTRACT(YEAR FROM Data_Venda) AS Ano,
    EXTRACT(MONTH FROM Data_Venda) AS Mes,
    ROUND(AVG(Valor_Unitario_Venda * Unidades_Vendidas), 2) AS Media_Valor_Final_Venda
FROM cap05.dsa_vendas
WHERE EXTRACT(DAY FROM Data_Venda) BETWEEN 10 AND 20
GROUP BY Ano, Mes
ORDER BY Ano, Mes;