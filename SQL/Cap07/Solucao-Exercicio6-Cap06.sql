# SQL Para Análise de Dados e Data Science - Capítulo 06


-- Solução do Exercício ao Final do Capítulo 6
CREATE TABLE cap06.vendas_loja_online_final
AS
SELECT

    id_cliente,
    
    CASE WHEN pais_cliente = 'Brasil' THEN 1 ELSE 0 END AS pais_brasil,
    
    CASE WHEN pais_cliente = 'Canadá' THEN 1 ELSE 0 END AS pais_canada,
  
    CASE WHEN pais_cliente = 'Inglaterra' THEN 1 ELSE 0 END AS pais_inglaterra,
    
    CASE WHEN visitas_ultimo_mes = 'sim' THEN 1 ELSE 0 END AS visitas_num,
    
    CASE 
        WHEN compras_ultimo_mes = '0-5' THEN 1
        WHEN compras_ultimo_mes = '6-10' THEN 2
        WHEN compras_ultimo_mes = '11-15' THEN 3
        WHEN compras_ultimo_mes = '16-20' THEN 4
        ELSE 0
    END AS compras_num,
    
    CASE WHEN fez_compra_mes_atual = TRUE THEN 1 ELSE 0 END AS fez_compra_num,
    
    total_gasto_ultimo_mes

FROM cap06.vendas_loja_online;








