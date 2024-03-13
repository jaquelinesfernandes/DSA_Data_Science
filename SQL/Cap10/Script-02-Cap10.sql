# SQL Para Análise de Dados e Data Science - Capítulo 10


-- Lista os pedidos
SELECT * FROM cap10.dsa_pedidos;


-- Soma (total) do valor dos pedidos
SELECT SUM(valor_pedido) AS total
FROM cap10.dsa_pedidos;


-- Soma (total) do valor dos pedidos por cidade
SELECT cidade_cliente, SUM(valor_pedido) AS total
FROM cap10.dsa_pedidos P, cap10.dsa_clientes C
WHERE P.id_cliente = C.id_cli
GROUP BY cidade_cliente
ORDER BY 2;


-- Soma (total) do valor dos pedidos por estado e cidade (com cláusula WHERE)
SELECT estado_cliente, cidade_cliente, SUM(valor_pedido) AS total
FROM cap10.dsa_pedidos P, cap10.dsa_clientes C
WHERE P.id_cliente = C.id_cli
GROUP BY cidade_cliente, estado_cliente
ORDER BY total DESC;


-- Soma (total) do valor dos pedidos por estado e cidade (com cláusula JOIN)
SELECT estado_cliente, cidade_cliente, SUM(valor_pedido) AS total
FROM cap10.dsa_pedidos P
INNER JOIN cap10.dsa_clientes C
ON P.id_cliente = C.id_cli
GROUP BY cidade_cliente, estado_cliente
ORDER BY total DESC;


-- Soma (total) do valor dos pedidos por estado e cidade. Retornar cidades sem pedidos.
SELECT estado_cliente, cidade_cliente, SUM(valor_pedido) AS total
FROM cap10.dsa_pedidos P
RIGHT JOIN cap10.dsa_clientes C
ON P.id_cliente = C.id_cli
GROUP BY cidade_cliente, estado_cliente
ORDER BY total DESC;


-- Soma (total) do valor dos pedidos por estado e cidade. Mostrar zero se não houve pedido.
SELECT 
    estado_cliente,
    cidade_cliente,
    CASE 
        WHEN FLOOR(SUM(valor_pedido)) IS NULL THEN 0
        ELSE FLOOR(SUM(valor_pedido))
    end AS total
FROM cap10.dsa_pedidos P 
RIGHT JOIN cap10.dsa_clientes C
ON P.id_cliente = C.id_cli
GROUP BY cidade_cliente, estado_cliente
ORDER BY total DESC;

