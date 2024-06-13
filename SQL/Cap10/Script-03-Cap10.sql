# SQL Para Análise de Dados e Data Science - Capítulo 10


-- Altera a tabela de produtos e acrescenta uma coluna
ALTER TABLE IF EXISTS cap10.dsa_produtos 
ADD COLUMN custo DECIMAL(10, 2) NULL;


-- Atualiza a coluna
UPDATE cap10.dsa_produtos
SET custo = 43 + (id_prod - 1) * 5.1
WHERE id_prod BETWEEN 10101 AND 10108;


-- Visualiza os dados
SELECT *
FROM cap10.dsa_produtos;


-- Custo total dos pedidos por estado
SELECT 
    cli.estado_cliente,
    SUM(prod.custo) AS custo_total
FROM 
    cap10.dsa_pedidos ped
INNER JOIN 
    cap10.dsa_clientes cli ON ped.id_cliente = cli.id_cli
INNER JOIN 
    cap10.dsa_produtos prod ON ped.id_produto = prod.id_prod
GROUP BY 
    cli.estado_cliente
ORDER BY 
    custo_total DESC;


-- Você foi informado que a tabela de dados está desatualizada e os produtos vendidos para os clientes do estado de SP
-- tiveram aumento de custo de 10%.
-- Demonstre isso no relatório sem modificar os dados na tabela.
SELECT 
    cli.estado_cliente,
    SUM(
        CASE 
            WHEN cli.estado_cliente = 'SP' THEN prod.custo * 1.1
            ELSE prod.custo
        END
    ) AS custo_total
FROM 
    cap10.dsa_pedidos ped
INNER JOIN 
    cap10.dsa_clientes cli ON ped.id_cliente = cli.id_cli
INNER JOIN 
    cap10.dsa_produtos prod ON ped.id_produto = prod.id_prod
GROUP BY 
    cli.estado_cliente
ORDER BY 
    custo_total DESC;


-- Custo total dos pedidos por estado com produto cujo título tenha 'Análise' ou 'Apache' no nome
SELECT 
    cli.estado_cliente,
    SUM(prod.custo) AS custo_total
FROM 
    cap10.dsa_pedidos ped
INNER JOIN 
    cap10.dsa_clientes cli ON ped.id_cliente = cli.id_cli
INNER JOIN 
    cap10.dsa_produtos prod ON ped.id_produto = prod.id_prod
WHERE 
    nome_produto LIKE '%Análise%' OR nome_produto LIKE '%Apache%' 
GROUP BY 
    cli.estado_cliente
ORDER BY 
    custo_total DESC;


-- Custo total dos pedidos por estado com produto cujo título tenha 'Análise' ou 'Apache' no nome
-- Somente se o custo total for menor do que 120000
-- Demonstre no relatório, sem modificar os dados na tabela, o aumento de 10% no custo para pedidos de clientes de SP
SELECT 
    cli.estado_cliente,
    SUM(
        CASE 
            WHEN cli.estado_cliente = 'SP' THEN prod.custo * 1.1
            ELSE prod.custo
        END
    ) AS custo_total
FROM 
    cap10.dsa_pedidos ped
INNER JOIN 
    cap10.dsa_clientes cli ON ped.id_cliente = cli.id_cli
INNER JOIN 
    cap10.dsa_produtos prod ON ped.id_produto = prod.id_prod
WHERE 
    nome_produto LIKE '%Análise%' OR nome_produto LIKE '%Apache%' 
GROUP BY 
    cli.estado_cliente
HAVING 
    SUM(prod.custo) < 120000
ORDER BY 
    custo_total DESC;


-- Custo total dos pedidos por estado com produto cujo título tenha 'Análise' ou 'Apache' no nome
-- Somente se o custo total estiver entre 150000 e 250000
-- Demonstre no relatório, sem modificar os dados na tabela, o aumento de 10% no custo para pedidos de clientes de SP
SELECT 
    cli.estado_cliente,
    SUM(
        CASE 
            WHEN cli.estado_cliente = 'SP' THEN prod.custo * 1.1
            ELSE prod.custo
        END
    ) AS custo_total
FROM 
    cap10.dsa_pedidos ped
INNER JOIN 
    cap10.dsa_clientes cli ON ped.id_cliente = cli.id_cli
INNER JOIN 
    cap10.dsa_produtos prod ON ped.id_produto = prod.id_prod
WHERE 
    nome_produto LIKE '%Análise%' OR nome_produto LIKE '%Apache%' 
GROUP BY 
    cli.estado_cliente
HAVING 
    SUM(prod.custo) BETWEEN 150000 AND 250000
ORDER BY 
    custo_total DESC;


-- Custo total dos pedidos por estado com produto cujo título tenha 'Análise' ou 'Apache' no nome
-- Somente se o custo total estiver entre 150000 e 250000
-- Demonstre no relatório, sem modificar os dados na tabela, o aumento de 10% no custo para pedidos de clientes de SP 
-- Inclua no relatório uma coluna chamada status_aumento com o texto 'Com Aumento de Custo' se o estado for SP e o texto
-- 'Sem Aumento de Custo' se for qualquer outro estado
SELECT 
    cli.estado_cliente,
    SUM(
        CASE 
            WHEN cli.estado_cliente = 'SP' THEN prod.custo * 1.1
            ELSE prod.custo
        END
    ) AS custo_total,
    CASE 
        WHEN cli.estado_cliente = 'SP' THEN 'Com Aumento de Custo'
        ELSE 'Sem Aumento de Custo'
    END AS status_aumento
FROM 
    cap10.dsa_pedidos ped
INNER JOIN 
    cap10.dsa_clientes cli ON ped.id_cliente = cli.id_cli
INNER JOIN 
    cap10.dsa_produtos prod ON ped.id_produto = prod.id_prod
WHERE 
    nome_produto LIKE '%Análise%' OR nome_produto LIKE '%Apache%' 
GROUP BY 
    cli.estado_cliente
HAVING 
    SUM(prod.custo) BETWEEN 150000 AND 250000
ORDER BY 
    custo_total DESC;







