--Lab 4 - Analise de Dados Rede Varejo
SELECT * FROM cap17.produtos ORDER BY id_produto ASC;

SELECT * FROM cap17.clientes ORDER BY id_cliente ASC;

SELECT * FROM cap17.vendas ORDER BY id_vendas ASC;
 

--1. Qual o Número Total de Vendas e Média de Quantidade Vendida?
SELECT COUNT(id_vendas) AS Qtd_total_vendas, ROUND(AVG(quantidade),2) AS Vol_Média_Vendida, SUM(quantidade) AS total_volumes FROM cap17.vendas;

--2. Qual o Número Total de Produtos Únicos Vendidos?
SELECT COUNT(DISTINCT(id_produto)) AS Qtd_prod FROM cap17.vendas;

--3. Quantas Vendas Ocorreram Por Produto? Mostre o Resultado em Ordem Decrescente.
SELECT 
	prod.nome as Produto,
	COUNT(ved.id_produto) AS total_vendas_produto
FROM 
	cap17.vendas ved
INNER JOIN
	cap17.produtos prod ON ved.id_produto = prod.id_produto
GROUP BY prod.nome
ORDER BY total_vendas_produto DESC;

--4. Quais os 5 Produtos com Maior Número de Vendas?
SELECT 
	prod.nome AS nome_produto, 
	COUNT(*) AS qtd_vendas
FROM 
	cap17.vendas ved
INNER JOIN
	cap17.produtos prod ON ved.id_produto = prod.id_produto
GROUP BY prod.nome
ORDER BY qtd_vendas DESC
LIMIT 5;

--5. Quais Clientes Fizeram ou Mais Transações de Compra?
SELECT
	cli.nome AS cliente_nome,
	COUNT(*) AS transac_cliente,
	--COUNT(ved.id_cliente),
	--SUM(ved.quantidade) AS total_vendas_clientes
FROM cap17.vendas ved
INNER JOIN
	cap17.clientes cli ON ved.id_cliente = cli.id_cliente
GROUP BY cli.nome
HAVING COUNT(ved.id_cliente) >= 5
ORDER BY transac_cliente DESC;

SELECT c.nome, COUNT(v.Id_Cliente) AS total_compras
FROM cap17.vendas v
JOIN cap17.clientes c ON v.Id_Cliente = c.Id_Cliente
GROUP BY c.nome
HAVING COUNT(v.Id_Cliente) >= 6
ORDER BY total_compras DESC;
	
--6. Qual o Total de Transações Comerciais Por Mês no Ano de 2024? Apresente os Nomes dos Meses no Resultado, Que Deve Ser Ordenado Por Mês.
SELECT 
	CASE
		WHEN EXTRACT(MONTH FROM Data_Venda) = 1 THEN 'Janeiro'
		WHEN EXTRACT(MONTH FROM Data_Venda) = 2 THEN 'Fevereiro'
		WHEN EXTRACT(MONTH FROM Data_Venda) = 3 THEN 'Marco'
		WHEN EXTRACT(MONTH FROM Data_Venda) = 4 THEN 'Abril'
		WHEN EXTRACT(MONTH FROM Data_Venda) = 5 THEN 'Maio'
		WHEN EXTRACT(MONTH FROM Data_Venda) = 6 THEN 'Junho'
		WHEN EXTRACT(MONTH FROM Data_Venda) = 7 THEN 'Julho'
		WHEN EXTRACT(MONTH FROM Data_Venda) = 8 THEN 'Agosto'
		WHEN EXTRACT(MONTH FROM Data_Venda) = 9 THEN 'Setembro'
		WHEN EXTRACT(MONTH FROM Data_Venda) = 10 THEN 'Outubro'
		WHEN EXTRACT(MONTH FROM Data_Venda) = 11 THEN 'Novembro'
		WHEN EXTRACT(MONTH FROM Data_Venda) = 12 THEN 'Dezembro'
	END AS mes,
	COUNT(*) AS total_vendas
FROM cap17.vendas
WHERE EXTRACT(YEAR FROM Data_Venda) = 2024
GROUP BY EXTRACT(MONTH FROM Data_Venda)
ORDER BY EXTRACT(MONTH FROM Data_Venda);


--7. Quantas Vendas de Notebooks Ocorreram em Junho e Julho de 2023?
SELECT 
	prod.nome as produto_nome,
	COUNT(*) AS total_vendas_notebook
FROM cap17.vendas ved
JOIN cap17.produtos prod ON prod.id_produto = ved.id_produto
WHERE prod.nome = 'Notebook'
	AND EXTRACT(YEAR FROM ved.data_venda) = 2023 
	AND EXTRACT(MONTH FROM ved.data_venda) IN (6, 7)
GROUP BY produto_nome;


--8. Qual o Total de Vendas Por Mês e Por Ano ao Longo do Tempo?
SELECT 
	EXTRACT('MONTH' FROM Data_Venda) as mes,
	COUNT(*) AS total_vendas
FROM cap17.vendas
GROUP BY mes
ORDER BY mes;

--9. Quais Produtos Tiveram Menos de 100 Transações de Venda?
SELECT
	prod.nome as nome_produto,
	COUNT(*) AS transac_venda
FROM cap17.vendas ved
INNER JOIN
	cap17.produtos prod ON ved.id_produto = prod.id_produto
GROUP BY prod.nome
HAVING COUNT(ved.Id_Produto) < 100
ORDER BY transac_venda;

--10. Quais Clientes Compraram Smartphone e Também Compraram Smartwatch?

WITH compraram_smartwatch AS (
	SELECT 
	ved.id_cliente,
	prod.nome AS nome_produto
	--COUNT(ved.id_cliente) AS cliente,
	--SUM(ved.quantidade) AS total_quantidade
FROM cap17.vendas ved
JOIN cap17.produtos prod ON ved.id_produto = prod.id_produto
WHERE prod.nome = 'Smartwatch'
	GROUP BY ved.id_cliente, nome_produto
),
compraram_smartphone AS (
	SELECT 
	ved.id_cliente,
	prod.nome AS nome_produto
	--COUNT(ved.id_cliente) AS cliente,
	--SUM(ved.quantidade) AS total_quantidade
FROM cap17.vendas ved
JOIN cap17.produtos prod ON ved.id_produto = prod.id_produto
WHERE prod.nome = 'Smartphone'
	GROUP BY ved.id_cliente, nome_produto
)
SELECT 
	cli.nome,
	prod.nome AS nome_produto
FROM cap17.clientes cli
--JOIN cap17.vendas ON ved.id_produto = prod.id_produto
WHERE cli.id_cliente IN (
	SELECT id_cliente FROM compraram_smartphone
	INTERSECT
	SELECT id_cliente FROM compraram_smartwatch
)
ORDER BY cli.nome;
	




-- Subconsulta para clientes que compraram Smartphone
WITH compradores_smartphone AS (
    SELECT v.Id_Cliente
    FROM cap17.vendas v
    JOIN cap17.produtos p ON v.Id_Produto = p.Id_Produto
    WHERE p.nome = 'Smartphone'
    GROUP BY v.Id_Cliente
),
-- Subconsulta para clientes que compraram Smartwatch
compradores_smartwatch AS (
    SELECT v.Id_Cliente
    FROM cap17.vendas v
    JOIN cap17.produtos p ON v.Id_Produto = p.Id_Produto
    WHERE p.nome = 'Smartwatch'
    GROUP BY v.Id_Cliente
)
-- Seleciona clientes que estão em ambas as subconsultas
SELECT c.nome
FROM cap17.clientes c
WHERE c.Id_Cliente IN (
    SELECT Id_Cliente FROM compradores_smartphone
    INTERSECT
    SELECT Id_Cliente FROM compradores_smartwatch
)
ORDER BY c.nome;
--11. Quais Clientes Compraram Smartphone e Também Compraram Smartwatch, Mas Não Compraram Notebook?

WITH compraram_smartwatch AS (
	SELECT 
	ved.id_cliente
FROM cap17.vendas ved
JOIN cap17.produtos prod ON ved.id_produto = prod.id_produto
WHERE prod.nome IN ('Smartwatch')
	GROUP BY ved.id_cliente
),
compraram_smartphone AS (
	SELECT 
	ved.id_cliente
FROM cap17.vendas ved
JOIN cap17.produtos prod ON ved.id_produto = prod.id_produto
WHERE prod.nome IN ('Smartphone') 
	GROUP BY ved.id_cliente
),
compraram_notebook AS (
	SELECT 
	ved.id_cliente
FROM cap17.vendas ved
JOIN cap17.produtos prod ON ved.id_produto = prod.id_produto
WHERE prod.nome IN ('Notebook')
	GROUP BY ved.id_cliente
)
SELECT 
	cli.nome
FROM cap17.clientes cli
WHERE cli.id_cliente IN (
	SELECT id_cliente FROM compraram_smartphone
	INTERSECT
	SELECT id_cliente FROM compraram_smartwatch
)
AND id_cliente NOT IN (
	SELECT id_cliente FROM compraram_notebook 
)
ORDER BY cli.nome;


--12. Quais Clientes Compraram Smartphone e Também Compraram Smartwatch, Mas Não Compraram Notebook em Maio/2024?

WITH compraram_smartwatch AS (
	SELECT 
	ved.id_cliente
FROM cap17.vendas ved
JOIN cap17.produtos prod ON ved.id_produto = prod.id_produto
WHERE prod.nome IN ('Smartwatch')
	AND EXTRACT(YEAR FROM ved.data_venda) = 2024 
	AND EXTRACT(MONTH FROM ved.data_venda) IN (5)
	GROUP BY ved.id_cliente
),
compraram_smartphone AS (
	SELECT 
	ved.id_cliente
FROM cap17.vendas ved
JOIN cap17.produtos prod ON ved.id_produto = prod.id_produto
WHERE prod.nome IN ('Smartphone')
	AND EXTRACT(YEAR FROM ved.data_venda) = 2024 
	AND EXTRACT(MONTH FROM ved.data_venda) IN (5)
	GROUP BY ved.id_cliente
),
compraram_notebook AS (
	SELECT 
	ved.id_cliente
FROM cap17.vendas ved
JOIN cap17.produtos prod ON ved.id_produto = prod.id_produto
WHERE prod.nome IN ('Notebook')
	AND EXTRACT(YEAR FROM ved.data_venda) = 2024 
	AND EXTRACT(MONTH FROM ved.data_venda) IN (5)
	GROUP BY ved.id_cliente
)
SELECT 
	cli.nome
FROM cap17.clientes cli
WHERE cli.id_cliente IN (
	SELECT id_cliente FROM compraram_smartphone
	INTERSECT
	SELECT id_cliente FROM compraram_smartwatch
)
AND id_cliente NOT IN (
	SELECT id_cliente FROM compraram_notebook 
)
ORDER BY cli.nome;


--13.  Qual  a  Média  Móvel  de  Quantidade  de  Unidades  Vendidas  ao  Longo  do  Tempo? Considere Janela de 7 Dias.

SELECT
	data_venda,
	quantidade,
	ROUND(AVG(quantidade) OVER (ORDER BY data_venda ROWS BETWEEN 3 PRECEDING AND 3 FOLLOWING), 2) as media_movel_vendidas
FROM cap17.vendas
GROUP BY data_venda, quantidade
ORDER BY data_venda;


--14. Qual a Média Móvel e Desvio Padrão Móvel de Quantidade de Unidades Vendidas ao Longo do Tempo? Considere Janela de 7 Dias.
--ROUND(STDDEV(valor)::NUMERIC, 2) AS desvio_padrao_valor,

SELECT
	data_venda,
	quantidade,
	ROUND(AVG(quantidade) OVER (ORDER BY data_venda ROWS BETWEEN 3 PRECEDING AND 3 FOLLOWING), 2) as media_movel_vendidas,
	ROUND(STDDEV(quantidade) OVER (ORDER BY data_venda ROWS BETWEEN 3 PRECEDING AND 3 FOLLOWING), 2) as desvio_padrao_vendidas
FROM cap17.vendas
GROUP BY data_venda, quantidade
ORDER BY data_venda;

--15. Quais Clientes Estão Cadastrados, Mas Ainda Não Fizeram Transação?
SELECT
	cli.id_cliente as id,
	cli.nome AS cliente_nome,
	COUNT(*) AS transac_cliente
	--COUNT(ved.id_cliente),
	--SUM(ved.quantidade) AS total_vendas_clientes
FROM cap17.clientes cli
LEFT JOIN
	cap17.vendas ved ON cli.id_cliente = ved.id_cliente
WHERE ved.id_cliente IS NULL
GROUP BY id, cliente_nome;


SELECT c.Id_Cliente, c.nome
FROM cap17.clientes c
LEFT JOIN cap17.vendas v ON c.Id_Cliente = v.Id_Cliente
WHERE v.Id_Cliente IS NULL;


--Junção todas tabelas
SELECT * FROM cap17.produtos ORDER BY id_produto ASC;
SELECT * FROM cap17.clientes ORDER BY id_cliente ASC;
SELECT * FROM cap17.vendas ORDER BY id_vendas ASC;


SELECT cli.nome AS nome_cliente, prod.nome AS nome_produto, ven.quantidade AS quantidade, ven.data_venda AS data_venda
FROM cap17.vendas ven
LEFT JOIN cap17.clientes cli ON ven.id_cliente = cli.id_cliente
LEFT JOIN cap17.produtos prod ON ven.id_produto = prod.id_produto
ORDER BY nome_cliente;


SELECT v.id_vendas, c.nome AS nome_cliente, pr.nome AS nome_produto, v.quantidade, v.data_venda
FROM cap17.vendas v
JOIN cap17.clientes c ON v.id_cliente = c.id_cliente
JOIN cap17.produtos pr ON v.id_produto = pr.id_produto;


 