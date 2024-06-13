# SQL Para Análise de Dados e Data Science - Capítulo 13


-- Lab 2 - Análise de Séries Temporais
-- Crie uma query que mostre o centro de custo, a conta crédito, a data de lançamento, o valor, a média móvel de 3 dias
-- (considerando 2 dias anteriores e a data atual) e o ranking por média móvel em ordem decrescente.
-- O cálculo da média móvel deve ser particionado por centro de custo, considerando a ordem da data de lançamento
-- O ranking deve ser particionado por data e ordenado pela média móvel em ordem decrescente

-- Identifique o erro de lógica na query abaixo:
WITH LancamentosOrdenados AS (
    SELECT
        data_lancamento,
        centro_custo,
        conta_credito,
        valor,
        ROW_NUMBER() OVER (PARTITION BY centro_custo ORDER BY data_lancamento) AS ordem
    FROM
        cap13.lancamentosdsacontabeis
),
MediaMovel AS (
    SELECT
        L1.centro_custo,
        L1.data_lancamento,
        L1.conta_credito,
        L1.valor,
        ROUND(AVG(L2.valor) OVER (PARTITION BY L1.centro_custo ORDER BY L1.ordem RANGE BETWEEN 2 PRECEDING AND CURRENT ROW),2) AS media_movel_3dias
    FROM
        LancamentosOrdenados L1
    JOIN
        LancamentosOrdenados L2 ON L1.centro_custo = L2.centro_custo AND L1.ordem BETWEEN L2.ordem - 2 AND L2.ordem
)
SELECT
    M.centro_custo,
    M.conta_credito,
    M.data_lancamento,
    M.valor,
    M.media_movel_3dias,
    DENSE_RANK() OVER (PARTITION BY M.data_lancamento ORDER BY M.media_movel_3dias DESC) AS rank_media_movel
FROM
    MediaMovel M
ORDER BY
    M.data_lancamento, rank_media_movel;


-- Abaixo está o resultado que esperamos
WITH LancamentosOrdenados AS (
    SELECT
        data_lancamento,
        centro_custo,
        conta_credito,
        valor,
        ROW_NUMBER() OVER (PARTITION BY centro_custo ORDER BY data_lancamento) AS ordem
    FROM
        cap13.lancamentosdsacontabeis
),
MediaMovel AS (
    SELECT
        L.centro_custo,
        L.data_lancamento,
        L.conta_credito,
        L.valor,
        ROUND(AVG(L.valor) OVER (PARTITION BY L.centro_custo ORDER BY L.ordem ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),2) AS media_movel_3dias
    FROM
        LancamentosOrdenados L
)
SELECT
    M.centro_custo,
    M.conta_credito,
    M.data_lancamento,
    M.valor,
    M.media_movel_3dias,
    DENSE_RANK() OVER (PARTITION BY M.data_lancamento ORDER BY M.media_movel_3dias DESC) AS rank_media_movel
FROM
    MediaMovel M
ORDER BY
    M.data_lancamento, rank_media_movel;





