# SQL Para Análise de Dados e Data Science - Capítulo 05


-- Query SQL para retornar a média de Valor_Unitario_Venda.
SELECT AVG(Valor_Unitario_Venda) AS Media_Valor_Unitario
FROM cap05.dsa_vendas;


-- Query SQL para retornar a média de Valor_Unitario_Venda com duas casas decimais.
SELECT ROUND(AVG(Valor_Unitario_Venda), 2) AS Media_Valor_Unitario
FROM cap05.dsa_vendas;


-- Query SQL para retornar a contagem, valor mínimo, valor máximo e soma (total) de Valor_Unitario_Venda.
SELECT 
    COUNT(Valor_Unitario_Venda) AS Contagem,
    MIN(Valor_Unitario_Venda) AS Valor_Minimo,
    MAX(Valor_Unitario_Venda) AS Valor_Maximo,
    SUM(Valor_Unitario_Venda) AS Soma_Total
FROM cap05.dsa_vendas;


-- Query SQL para retornar a média (com duas casas decimais) de Valor_Unitario_Venda por categoria de produto.
SELECT 
    Categoria_Produto,
    ROUND(AVG(Valor_Unitario_Venda), 2) AS Media_Valor_Unitario
FROM cap05.dsa_vendas
GROUP BY Categoria_Produto;

SELECT 
    ROUND(AVG(Valor_Unitario_Venda), 2) AS Media_Valor_Unitario
FROM cap05.dsa_vendas
GROUP BY Categoria_Produto;

SELECT 
    Nome_Produto,
    ROUND(AVG(Valor_Unitario_Venda), 2) AS Media_Valor_Unitario
FROM cap05.dsa_vendas
GROUP BY Categoria_Produto;


-- Query SQL para retornar a média (com duas casas decimais) de Valor_Unitario_Venda por categoria de produto, 
-- ordenado pela média em ordem decrescente.
SELECT 
    Categoria_Produto,
    ROUND(AVG(Valor_Unitario_Venda), 2) AS Media_Valor_Unitario
FROM cap05.dsa_vendas
GROUP BY Categoria_Produto
ORDER BY Media_Valor_Unitario DESC;


-- Query SQL para retornar a soma de Valor_Unitario_Venda por produto. 
SELECT 
    Nome_Produto,
    SUM(Valor_Unitario_Venda) AS Soma_Valor_Unitario
FROM cap05.dsa_vendas
GROUP BY Nome_Produto;


-- Query SQL para retornar a soma de Valor_Unitario_Venda por produto e categoria. (Leia a mensagem de erro ao executar)
SELECT 
    Nome_Produto,
    Categoria_Produto,
    SUM(Valor_Unitario_Venda) AS Soma_Valor_Unitario
FROM cap05.dsa_vendas
GROUP BY Nome_Produto;


-- Query SQL para retornar a soma de Valor_Unitario_Venda por produto e categoria, ordenado por produto e categoria.
SELECT 
    Nome_Produto,
    Categoria_Produto,
    SUM(Valor_Unitario_Venda) AS Soma_Valor_Unitario
FROM cap05.dsa_vendas
GROUP BY Nome_Produto, Categoria_Produto
ORDER BY Nome_Produto, Categoria_Produto;


-- Query SQL para retornar a soma de Valor_Unitario_Venda por categoria e produto, ordenado por categoria e produto.
SELECT 
    Categoria_Produto,
    Nome_Produto,
    SUM(Valor_Unitario_Venda) AS Soma_Valor_Unitario
FROM cap05.dsa_vendas
GROUP BY Categoria_Produto, Nome_Produto
ORDER BY Categoria_Produto, Nome_Produto;


-- Query SQL para retornar a média (com duas casas decimais) de Valor_Unitario_Venda por produto, 
-- somente se a média for maior ou igual a 16. 

-- Errado:
SELECT 
    Nome_Produto,
    ROUND(AVG(Valor_Unitario_Venda), 2) AS Media_Valor_Unitario
FROM cap05.dsa_vendas
WHERE Media_Valor_Unitario >= 16
GROUP BY Nome_Produto;

-- Correto:
SELECT 
    Nome_Produto,
    ROUND(AVG(Valor_Unitario_Venda), 2) AS Media_Valor_Unitario
FROM cap05.dsa_vendas
GROUP BY Nome_Produto
HAVING AVG(Valor_Unitario_Venda) >= 16;


-- Query SQL para retornar a média (com duas casas decimais) de Valor_Unitario_Venda por produto e categoria, 
-- somente se a média for maior ou igual a 16 e unidades vendidas maior do que 4, ordenado por nome de produto.

SELECT * FROM cap05.dsa_vendas;

SELECT 
    Nome_Produto, 
    Categoria_Produto,
    ROUND(AVG(Valor_Unitario_Venda), 2) AS Media_Valor_Unitario
FROM cap05.dsa_vendas
WHERE unidades_vendidas > 4
GROUP BY Nome_Produto, Categoria_Produto
HAVING AVG(Valor_Unitario_Venda) >= 16
ORDER BY Nome_Produto;


-- Query SQL para retornar a média (com duas casas decimais) de Valor_Unitario_Venda por produto e categoria, 
-- somente se a média for maior ou igual a 16 e o produto for B ou C, ordenado por categoria.
SELECT 
    Nome_Produto, 
    Categoria_Produto,
    ROUND(AVG(Valor_Unitario_Venda), 2) AS Media_Valor_Unitario
FROM cap05.dsa_vendas
WHERE Nome_Produto IN ('Produto B', 'Produto C')
GROUP BY Nome_Produto, Categoria_Produto
HAVING AVG(Valor_Unitario_Venda) >= 16
ORDER BY Categoria_Produto;



