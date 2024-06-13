# SQL Para Análise de Dados e Data Science - Capítulo 16


-- Verifica valores ausentes na tabela do schema cap15
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


-- Cria o schema no banco de dados
CREATE SCHEMA cap16 AUTHORIZATION dsa;


-- Copia a tabela de um schema para outro
CREATE TABLE cap16.dsa_campanha_marketing
AS 
SELECT * FROM cap15.dsa_campanha_marketing


-- Verifica valores ausentes no schema cap16
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
    cap16.dsa_campanha_marketing;


-- 1. Crie uma query que identifique valores ausentes na coluna orcamento

SELECT *
FROM cap16.dsa_campanha_marketing
WHERE orcamento IS NULL;


-- 2. Considere que orçamento nulo para público alvo igual "Outros" não seja uma informação relevante.
-- Crie uma query com delete que remova registros se a coluna orcamento tiver valor ausente e a coluna 
-- publico_alvo tiver o valor "Outros".

DELETE FROM cap16.dsa_campanha_marketing
WHERE orcamento IS NULL AND publico_alvo = 'Outros';

SELECT *
FROM cap16.dsa_campanha_marketing
WHERE orcamento IS NULL;


-- 3. Crie uma query que preencha os valores ausentes da coluna orcamento com a média da coluna, 
-- mas segmentado pela coluna canais_divulgacao.

-- Primeiro, vamos calcular a média:

SELECT canais_divulgacao, AVG(orcamento) as media_orcamento
FROM cap16.dsa_campanha_marketing
WHERE orcamento IS NOT NULL
GROUP BY canais_divulgacao;

-- Agora o update:

UPDATE cap16.dsa_campanha_marketing AS c
SET orcamento = d.media_orcamento
FROM (
    SELECT canais_divulgacao, AVG(orcamento) AS media_orcamento
    FROM cap16.dsa_campanha_marketing
    WHERE orcamento IS NOT NULL
    GROUP BY canais_divulgacao
) AS d
WHERE c.canais_divulgacao = d.canais_divulgacao AND c.orcamento IS NULL;


-- Verifica valores ausentes no schema cap16
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
    cap16.dsa_campanha_marketing;


-- Verifica os dados:

SELECT * FROM cap16.dsa_campanha_marketing;


-- 4. Use como estratégia de tratamento de outliers criar uma nova coluna e preenchê-la com True 
-- se houver outlier no registro e False caso contrário.

-- Verificamos outliers novamente:

WITH stats AS (
    SELECT
        AVG(orcamento) AS avg_orcamento,
        STDDEV(orcamento) AS stddev_orcamento,
        AVG(taxa_conversao) AS avg_taxa_conversao,
        STDDEV(taxa_conversao) AS stddev_taxa_conversao,
        AVG(impressoes) AS avg_impressoes,
        STDDEV(impressoes) AS stddev_impressoes
    FROM
        cap16.dsa_campanha_marketing
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
    cap16.dsa_campanha_marketing,
    stats
WHERE
    orcamento < (avg_orcamento - 1.5 * stddev_orcamento) OR 
    orcamento > (avg_orcamento + 1.5 * stddev_orcamento) OR
    taxa_conversao < (avg_taxa_conversao - 1.5 * stddev_taxa_conversao) OR 
    taxa_conversao > (avg_taxa_conversao + 1.5 * stddev_taxa_conversao) OR
    impressoes < (avg_impressoes - 1.5 * stddev_impressoes) OR 
    impressoes > (avg_impressoes + 1.5 * stddev_impressoes);

-- Cria a nova coluna

ALTER TABLE cap16.dsa_campanha_marketing
ADD COLUMN tem_outlier BOOLEAN DEFAULT FALSE;

-- Carrega a nova coluna
WITH stats AS (
    SELECT
        AVG(orcamento) AS avg_orcamento,
        STDDEV(orcamento) AS stddev_orcamento,
        AVG(taxa_conversao) AS avg_taxa_conversao,
        STDDEV(taxa_conversao) AS stddev_taxa_conversao,
        AVG(impressoes) AS avg_impressoes,
        STDDEV(impressoes) AS stddev_impressoes
    FROM
        cap16.dsa_campanha_marketing
)
UPDATE cap16.dsa_campanha_marketing
SET tem_outlier = TRUE
FROM stats
WHERE
    orcamento < (avg_orcamento - 1.5 * stddev_orcamento) OR 
    orcamento > (avg_orcamento + 1.5 * stddev_orcamento) OR
    taxa_conversao < (avg_taxa_conversao - 1.5 * stddev_taxa_conversao) OR 
    taxa_conversao > (avg_taxa_conversao + 1.5 * stddev_taxa_conversao) OR
    impressoes < (avg_impressoes - 1.5 * stddev_impressoes) OR 
    impressoes > (avg_impressoes + 1.5 * stddev_impressoes);


-- Verifica os dados:

SELECT * FROM cap16.dsa_campanha_marketing;

SELECT tem_outlier, COUNT(*) AS contagem
FROM cap16.dsa_campanha_marketing
GROUP BY tem_outlier;


-- 5. Aplique label encoding na coluna publico_alvo e salve o resultado em uma nova coluna 
-- chamada publico_alvo_encoded.

-- Cria a nova coluna
ALTER TABLE cap16.dsa_campanha_marketing
ADD COLUMN publico_alvo_encoded INT;

-- Verifica os valores únicos
SELECT DISTINCT publico_alvo
FROM cap16.dsa_campanha_marketing;

-- Carrega a nova coluna
UPDATE cap16.dsa_campanha_marketing
SET publico_alvo_encoded = 
    CASE publico_alvo
        WHEN 'Publico Alvo 1' THEN 1
        WHEN 'Publico Alvo 2' THEN 2
        WHEN 'Publico Alvo 3' THEN 3
        WHEN 'Publico Alvo 4' THEN 4
        WHEN 'Publico Alvo 5' THEN 5
        WHEN 'Outros' THEN 0
        ELSE NULL
    END;


-- 6. Aplique label encoding na coluna canais_divulgacao e salve o resultado em uma nova coluna chamada 
-- canais_divulgacao_encoded.

-- Cria a nova coluna
ALTER TABLE cap16.dsa_campanha_marketing
ADD COLUMN canais_divulgacao_encoded INT;

-- Verifica os valores únicos
SELECT canais_divulgacao, COUNT(*) as total_registros
FROM cap16.dsa_campanha_marketing
GROUP BY canais_divulgacao;

-- Carrega a nova coluna
UPDATE cap16.dsa_campanha_marketing
SET canais_divulgacao_encoded = 
    CASE canais_divulgacao
        WHEN 'Google' THEN 1
        WHEN 'Redes Sociais' THEN 2
        WHEN 'Sites de Notícias' THEN 3
        ELSE NULL
    END;


-- 7. Aplique label encoding na coluna tipo_campanha e salve o resultado em uma nova coluna 
-- chamada tipo_campanha_encoded.

-- Cria a nova coluna
ALTER TABLE cap16.dsa_campanha_marketing
ADD COLUMN tipo_campanha_encoded INT;

-- Verifica os valores únicos
SELECT tipo_campanha, COUNT(*) as total_registros
FROM cap16.dsa_campanha_marketing
GROUP BY tipo_campanha;

-- Carrega a nova coluna
UPDATE cap16.dsa_campanha_marketing
SET tipo_campanha_encoded = 
    CASE tipo_campanha
        WHEN 'Promocional' THEN 1
        WHEN 'Divulgação' THEN 2
        WHEN 'Mais Seguidores' THEN 3
        ELSE NULL
    END;


-- 8. Faça o drop das 3 colunas originais que foram codificadas nos itens 5, 6 e 7

ALTER TABLE cap16.dsa_campanha_marketing
DROP COLUMN publico_alvo,
DROP COLUMN canais_divulgacao,
DROP COLUMN tipo_campanha;


-- Verifica os dados:

SELECT * FROM cap16.dsa_campanha_marketing;


-- Verifica valores ausentes no schema cap16
SELECT
    COUNT(*) - COUNT(id) AS id_missing,
    COUNT(*) - COUNT(nome_campanha) AS nome_campanha_missing,
    COUNT(*) - COUNT(data_inicio) AS data_inicio_missing,
    COUNT(*) - COUNT(data_fim) AS data_fim_missing,
    COUNT(*) - COUNT(orcamento) AS orcamento_missing,
    COUNT(*) - COUNT(taxa_conversao) AS taxa_conversao_missing,
    COUNT(*) - COUNT(impressoes) AS impressoes_missing,
    COUNT(*) - COUNT(publico_alvo_encoded) AS publico_alvo_encoded_missing,
    COUNT(*) - COUNT(canais_divulgacao_encoded) AS canais_divulgacao_encoded_missing,
    COUNT(*) - COUNT(tipo_campanha_encoded) AS tipo_campanha_encoded_missing
FROM 
    cap16.dsa_campanha_marketing;


