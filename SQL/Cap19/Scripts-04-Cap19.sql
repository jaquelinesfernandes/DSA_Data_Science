# SQL Para Análise de Dados e Data Science - Capítulo 19


-- Cria a MView
CREATE MATERIALIZED VIEW cap19.mv_ultima_interacao_email AS
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
ORDER BY 
    ultima_interacao DESC;


-- Consulta a MView
SELECT * FROM cap19.mv_ultima_interacao_email;


-- Refresh da MView
REFRESH MATERIALIZED VIEW cap19.mv_ultima_interacao_email;


-- Cria a MView
CREATE MATERIALIZED VIEW cap19.mv_clientes_ativos AS
SELECT * FROM cap19.clientes_ativos;


-- Consulta a MView
SELECT * FROM cap19.mv_clientes_ativos;


-- Refresh da MView
REFRESH MATERIALIZED VIEW cap19.mv_clientes_ativos;





