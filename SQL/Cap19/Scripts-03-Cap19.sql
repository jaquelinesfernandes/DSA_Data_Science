# SQL Para Análise de Dados e Data Science - Capítulo 19


SELECT * 
FROM cap19.clientes
ORDER BY cliente_id ASC;


SELECT * 
FROM cap19.interacoes
ORDER BY interacao_id ASC;


SELECT * 
FROM cap19.vendas
ORDER BY venda_id ASC;


-- Retorne id, nome e cidade dos clientes que tiveram interação por e-mail e que moram na RUA A
SELECT c.cliente_id, c.nome, c.cidade
FROM cap19.clientes c
INNER JOIN cap19.interacoes i ON c.cliente_id = i.cliente_id
WHERE c.endereco LIKE 'Rua A%' AND i.tipo_interacao = 'Email';


-- Armazena a query no banco de dados criando uma View
CREATE VIEW cap19.clientes_interacao_email_rua_a AS
SELECT 
    c.cliente_id,
    c.nome,
    c.cidade
FROM 
    cap19.clientes c
INNER JOIN 
    cap19.interacoes i ON c.cliente_id = i.cliente_id
WHERE 
    c.endereco LIKE 'Rua A%' AND
    i.tipo_interacao = 'Email';


-- Consulta a View
SELECT * FROM cap19.clientes_interacao_email_rua_a;


-- Consulta a View
SELECT * FROM cap19.clientes_interacao_email_rua_a WHERE cliente_id > 280;


-- Nome, rua e cidade do cliente com a data da última interação por e-mail
CREATE VIEW cap19.clientes_interacoes_resumo AS
SELECT 
    c.nome,
    c.endereco,
    c.cidade,
    MAX(i.data_hora) AS ultima_interacao
FROM 
    cap19.clientes c
LEFT JOIN 
    cap19.interacoes i ON c.cliente_id = i.cliente_id
WHERE 
	i.tipo_interacao = 'Email'
GROUP BY 
    c.nome, c.endereco, c.cidade
ORDER BY ultima_interacao DESC;


-- Consulta a View
SELECT * FROM cap19.clientes_interacoes_resumo;


-- Esta View apresentará o total de vendas e o valor total de vendas por cidade.
CREATE VIEW cap19.vendas_por_cidade AS
SELECT 
    c.cidade,
    COUNT(v.venda_id) AS total_unidades_vendidas,
    SUM(v.valor_venda) AS valor_total_vendas
FROM 
    cap19.vendas v
JOIN 
    cap19.clientes c ON v.cliente_id = c.cliente_id
GROUP BY 
    c.cidade;


-- Consulta a View
SELECT * FROM cap19.vendas_por_cidade;


-- Esta View listará clientes que realizaram compras nos últimos 12 meses e tiveram mais de uma interação no mesmo período.
CREATE VIEW cap19.clientes_ativos AS
SELECT 
    c.cliente_id,
    c.nome,
    c.endereco,
    c.cidade
FROM 
    cap19.clientes c
WHERE 
    c.cliente_id IN (SELECT v.cliente_id FROM cap19.vendas v WHERE v.data_venda >= CURRENT_DATE - INTERVAL '1 year')
    AND c.cliente_id IN (SELECT i.cliente_id FROM cap19.interacoes i WHERE i.data_hora >= CURRENT_DATE - INTERVAL '1 year' GROUP BY i.cliente_id HAVING COUNT(i.interacao_id) > 1);


-- Consulta a View
SELECT * FROM cap19.clientes_ativos;





