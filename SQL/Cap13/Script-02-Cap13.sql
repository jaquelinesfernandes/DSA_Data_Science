# SQL Para Análise de Dados e Data Science - Capítulo 13


-- Lab 2 - Sumarização de Dados
-- Crie uma query mostrando diversas métricas por centro de custo
-- A query deve mostrar: contagem_lancamentos, total_valores_lançamentos, media_valores_lançamentos, maior_valor, menor_valor
-- soma_valores_usd, soma_valores_eur, soma_valores_brl, media_taxa_conversao e mediana_valores
-- Dica: Tome cuidado com valores nulos na coluna taxa_conversao

SELECT
    centro_custo,
    COUNT(*) AS contagem_lancamentos,
    SUM(valor) AS total_valores_lançamentos,
    ROUND(AVG(valor), 2) AS media_valores_lançamentos,
    MAX(valor) AS maior_valor,
    MIN(valor) AS menor_valor,
    SUM(CASE WHEN moeda = 'USD' THEN valor ELSE 0 END) AS soma_valores_usd,
    SUM(CASE WHEN moeda = 'EUR' THEN valor ELSE 0 END) AS soma_valores_eur,
    SUM(CASE WHEN moeda = 'BRL' THEN valor ELSE 0 END) AS soma_valores_brl,
    ROUND(AVG(CASE WHEN taxa_conversao IS NOT NULL THEN taxa_conversao ELSE 0 END), 2) AS media_taxa_conversao,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY valor) AS mediana_valores
FROM
    cap13.lancamentosdsacontabeis
GROUP BY
    centro_custo
ORDER BY
    total_valores_lançamentos DESC;


-- Lab 2 - Distribuição de Dados
-- Crie uma query para mostrar a distribuição de dados na tabela. 
-- Estamos interessados na coluna valor.
-- o relatório deve mostrar: quantidade_lancamentos, media_valor, desvio_padrao_valor, menor_valor, 
-- maior_valor e primeiro, segundo e terceiro quartil.
-- Faça tudo isso por centro de custo e por moeda.

SELECT
    centro_custo,
    moeda,
    COUNT(*) AS quantidade_lancamentos,
    ROUND(AVG(valor)::NUMERIC, 2) AS media_valor,
    ROUND(STDDEV(valor)::NUMERIC, 2) AS desvio_padrao_valor,
    MIN(valor) AS menor_valor,
    MAX(valor) AS maior_valor,
    ROUND((PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY valor))::NUMERIC, 2) AS primeiro_quartil,
    ROUND((PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY valor))::NUMERIC, 2) AS mediana,
    ROUND((PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY valor))::NUMERIC, 2) AS terceiro_quartil
FROM
    cap13.lancamentosdsacontabeis
GROUP BY
    centro_custo, moeda
ORDER BY
    centro_custo, moeda;


-- Lab 2 - Análise Multivariada
-- Aqui estão os requisitos do relatório:
-- Calcule valor total dos lançamentos
-- Calcule a média dos lançamentos
-- Calcule a contagem dos lançamentos
-- Calcule a média do valor de taxa de conversão somente se a moeda for diferente de BRL
-- Crie ranking por valor total dos lançamentos, por média do valor dos lançamentos e por média da taxa de conversão
-- Queremos o resultado somente se o centro de custo for Compras ou RH 

SELECT
    A.centro_custo,
    A.moeda,
    SUM(A.valor) AS total_valor_lancamento,
    DENSE_RANK() OVER (ORDER BY SUM(A.valor) DESC) AS rank_total_valor,
    ROUND(AVG(A.valor), 2) AS media_valor_lancamento,
    DENSE_RANK() OVER (ORDER BY AVG(A.valor) DESC) AS rank_media_valor,
    COUNT(A.*) AS numero_de_lancamentos,
    COALESCE(ROUND(AVG(A.taxa_conversao) FILTER (WHERE A.moeda != 'BRL'),2), 0) AS media_taxa_conversao,
    DENSE_RANK() OVER (ORDER BY COALESCE(ROUND(AVG(A.taxa_conversao) FILTER (WHERE A.moeda != 'BRL'),2), 0) DESC) AS rank_media_taxa
FROM
    cap13.lancamentosdsacontabeis A
WHERE 
    A.centro_custo IN ('Compras', 'RH')
GROUP BY
    A.centro_custo, A.moeda
ORDER BY 
    rank_total_valor, rank_media_valor, rank_media_taxa
    

-- Lab 2 - Identificação de Outliers
-- Vamos analisar a coluna valor
-- Para melhorar a análise, vamos observar os outliers por centro de custo e moeda
-- Para identificar outliers na tabela podemos usar uma abordagem baseada em Estatística, 
-- como calcular o intervalo interquartil (IQR) e identificar valores que estão significativamente 
-- acima ou abaixo desse intervalo. 
-- O IQR é a diferença entre o primeiro quartil (Q1, o 25º percentil) e o terceiro quartil (Q3, o 75º percentil). 
-- Os valores abaixo de Q1 - 0.5 * IQR ou acima de Q3 + 0.5 * IQR serão considerados outliers.
-- Crie a query que identifique os outliers (se existirem), por centro de custo e moeda.

SELECT COUNT(*) FROM cap13.lancamentosdsacontabeis;

SELECT 
    ROUND(AVG(valor),2) AS media, 
    PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY valor) AS mediana,
    MAX(valor) as maximo,
    MIN(VALOR) as minimo
FROM cap13.lancamentosdsacontabeis;

SELECT 
    centro_custo,
    moeda,
    MIN(VALOR) as minimo_valor,
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY valor) AS q1,
    ROUND(AVG(valor),2) AS media_valor, 
    PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY valor) AS q2,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY valor) AS q3,
    MAX(valor) as maximo_valor
FROM
    cap13.lancamentosdsacontabeis
GROUP BY
    centro_custo, moeda;

SELECT 
    centro_custo,
    moeda,
    MIN(VALOR) as minimo_valor,
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY valor) - 1.5 * (PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY valor) - PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY valor)) AS limite_inferior,
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY valor) AS q1,
    ROUND(AVG(valor),2) AS media_valor, 
    PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY valor) AS q2,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY valor) AS q3,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY valor) + 1.5 * (PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY valor) - PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY valor)) AS limite_superior,
    MAX(valor) as maximo_valor
FROM
    cap13.lancamentosdsacontabeis
GROUP BY
    centro_custo, moeda;

SELECT 
    centro_custo,
    moeda,
    MIN(VALOR) as minimo_valor,
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY valor) - 0.5 * (PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY valor) - PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY valor)) AS limite_inferior,
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY valor) AS q1,
    PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY valor) AS q2,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY valor) AS q3,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY valor) + 0.5 * (PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY valor) - PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY valor)) AS limite_superior,
    MAX(valor) as maximo_valor
FROM
    cap13.lancamentosdsacontabeis
GROUP BY
    centro_custo, moeda;

WITH Estatisticas AS (
    SELECT
        centro_custo,
        moeda,
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY valor) AS q1,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY valor) AS q3
    FROM
        cap13.lancamentosdsacontabeis
    GROUP BY
        centro_custo, moeda
),
LimitesOutliers AS (
    SELECT
        centro_custo,
        moeda,
        q1,
        q3,
        q1 - 0.5 * (q3 - q1) AS limite_inferior,
        q3 + 0.5 * (q3 - q1) AS limite_superior
    FROM
        Estatisticas
)
SELECT
    L.id,
    L.data_lancamento,
    L.centro_custo,
    L.moeda,
    L.valor
FROM
    cap13.lancamentosdsacontabeis L
INNER JOIN
    LimitesOutliers E
ON
    L.centro_custo = E.centro_custo AND L.moeda = E.moeda
WHERE
    L.valor < E.limite_inferior OR L.valor > E.limite_superior
ORDER BY
    L.valor, L.centro_custo, L.moeda;


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

