# SQL Para Análise de Dados e Data Science - Capítulo 15


-- 1. Crie uma única query que identifique o total de valores ausentes em todas as colunas.

SELECT
    COUNT(*) - COUNT(id) AS id_missing,
    COUNT(*) - COUNT(nome_campanha) AS nome_campanha_missing,
    COUNT(*) - COUNT(data_inicio) AS data_inicio_missing,
    COUNT(*) - COUNT(data_fim) AS data_fim_missing,
    COUNT(*) - COUNT(orcamento) AS orcamento_missing,
    COUNT(*) - COUNT(publico_alvo) AS publico_alvo_missing,
    COUNT(*) - COUNT(canais_divulgacao) AS canais_divulgacao_missing,
    COUNT(*) - COUNT(tipo_campanha) AS tipo_campanha_missing,
    COUNT(*) - COUNT(taxa_conversao) AS taxa_conversao_missing,
    COUNT(*) - COUNT(impressoes) AS impressoes_missing
FROM 
    cap15.dsa_campanha_marketing;


-- 2. Crie uma query que identifique se em qualquer coluna há o caracter "?". 

SELECT *
FROM cap15.dsa_campanha_marketing
WHERE 
    nome_campanha LIKE '%?%' OR
    CAST(data_inicio AS VARCHAR) LIKE '%?%' OR
    CAST(data_fim AS VARCHAR) LIKE '%?%' OR
    CAST(orcamento AS VARCHAR) LIKE '%?%' OR
    publico_alvo LIKE '%?%' OR
    canais_divulgacao LIKE '%?%' OR
    tipo_campanha LIKE '%?%' OR
    CAST(taxa_conversao AS VARCHAR) LIKE '%?%' OR
    CAST(impressoes AS VARCHAR) LIKE '%?%';


-- 3. Crie uma query que identifique duplicatas (sem considerar a coluna id).

SELECT 
    nome_campanha,
    data_inicio,
    data_fim,
    orcamento,
    publico_alvo,
    canais_divulgacao,
    tipo_campanha,
    taxa_conversao,
    impressoes,
    COUNT(*) as duplicatas
FROM 
    cap15.dsa_campanha_marketing
GROUP BY 
    nome_campanha,
    data_inicio,
    data_fim,
    orcamento,
    publico_alvo,
    canais_divulgacao,
    tipo_campanha,
    taxa_conversao,
    impressoes
HAVING 
    COUNT(*) > 1;


-- 4. Crie uma query que identifique duplicatas considerando as colunas (nome_campanha, data_inicio, publico_alvo, canais_divulgacao).

SELECT *
FROM cap15.dsa_campanha_marketing
WHERE 
    (nome_campanha, data_inicio, publico_alvo, canais_divulgacao) IN (
        SELECT 
            nome_campanha, 
            data_inicio, 
            publico_alvo, 
            canais_divulgacao
        FROM 
            cap15.dsa_campanha_marketing
        GROUP BY 
            nome_campanha, 
            data_inicio, 
            publico_alvo, 
            canais_divulgacao
        HAVING 
            COUNT(*) > 1
    );


-- 5. Crie uma query que identifique outliers nas 3 colunas numéricas.   
-- Considere como outliers valores que estejam acima ou abaixo das seguintes regras: 
-- media + 1.5 * desvio_padrão
-- media - 1.5 * desvio_padrão

WITH stats AS (
    SELECT
        AVG(orcamento) AS avg_orcamento,
        STDDEV(orcamento) AS stddev_orcamento,
        AVG(taxa_conversao) AS avg_taxa_conversao,
        STDDEV(taxa_conversao) AS stddev_taxa_conversao,
        AVG(impressoes) AS avg_impressoes,
        STDDEV(impressoes) AS stddev_impressoes
    FROM
        cap15.dsa_campanha_marketing
)
SELECT
    id,
    nome_campanha,
    data_inicio,
    data_fim,
    orcamento,
    publico_alvo,
    canais_divulgacao,
    taxa_conversao,
    impressoes
FROM
    cap15.dsa_campanha_marketing,
    stats
WHERE
    orcamento < (avg_orcamento - 1.5 * stddev_orcamento) OR 
    orcamento > (avg_orcamento + 1.5 * stddev_orcamento) OR
    taxa_conversao < (avg_taxa_conversao - 1.5 * stddev_taxa_conversao) OR 
    taxa_conversao > (avg_taxa_conversao + 1.5 * stddev_taxa_conversao) OR
    impressoes < (avg_impressoes - 1.5 * stddev_impressoes) OR 
    impressoes > (avg_impressoes + 1.5 * stddev_impressoes);



