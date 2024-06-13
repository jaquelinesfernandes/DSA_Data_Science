# SQL Para Análise de Dados e Data Science - Capítulo 07


-- Estrutura básica de junções

SELECT * FROM cap07.clientes
SELECT * FROM cap07.pedidos

SELECT nome, quantidade
FROM cap07.clientes, cap07.pedidos
WHERE cap07.clientes.id_cliente = cap07.pedidos.id_cliente;

SELECT nome, quantidade
FROM cap07.clientes
INNER JOIN cap07.pedidos ON cap07.clientes.id_cliente = cap07.pedidos.id_cliente;

SELECT id_cliente, id_cliente
FROM cap07.clientes
INNER JOIN cap07.pedidos ON cap07.clientes.id_cliente = cap07.pedidos.id_cliente;

SELECT c.nome, c.id_cliente, p.quantidade, p.id_cliente
FROM cap07.clientes c
INNER JOIN cap07.pedidos p ON c.id_cliente = p.id_cliente;


-- Retorne id, nome e estado do cliente, id e quantidade do pedido de todos os clientes que fizeram pedido
-- Orderne pelo id do cliente
-- Por que usamos INNER JOIN?
SELECT c.id_cliente, c.nome, c.estado, p.quantidade, p.id_pedido
FROM cap07.clientes c
INNER JOIN cap07.pedidos p ON c.id_cliente = p.id_cliente
ORDER BY c.id_cliente;


-- Retorne id, nome e estado do cliente, id e quantidade do pedido de todos os clientes, 
-- independente de ter feito ou não pedido
-- Orderne pelo id do cliente
-- Por que usamos LEFT JOIN?
SELECT c.id_cliente, c.nome, c.estado, p.quantidade, p.id_pedido
FROM cap07.clientes c
LEFT JOIN cap07.pedidos p ON c.id_cliente = p.id_cliente
ORDER BY c.id_cliente;


-- Preenchendo o campo nulo na query anterior
SELECT 
    c.id_cliente, 
    c.nome, 
    c.estado, 
    CASE 
        WHEN p.quantidade IS NULL THEN 'sem pedido' 
        ELSE CAST(p.quantidade AS VARCHAR) 
    END AS quantidade,
    CASE 
        WHEN p.id_pedido IS NULL THEN 'sem pedido' 
        ELSE CAST(p.id_pedido AS VARCHAR) 
    END AS id_pedido
FROM cap07.clientes c
LEFT JOIN cap07.pedidos p ON c.id_cliente = p.id_cliente
ORDER BY c.id_cliente;


-- O que aconteceu aqui?
SELECT c.id_cliente, c.nome, c.estado, p.quantidade, p.id_pedido
FROM cap07.pedidos p 
LEFT JOIN cap07.clientes c ON c.id_cliente = p.id_cliente
ORDER BY c.id_cliente;

