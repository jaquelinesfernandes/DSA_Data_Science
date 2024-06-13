# SQL Para Análise de Dados e Data Science - Capítulo 16


-- Relatório de Resumo Com Variáveis Quantitativas
-- Totais dos anos 2022, 2023 e 2024 para as colunas orcamento, taxa_conversao e impressoes

SELECT
    TO_CHAR(data_inicio, 'YYYY') AS ano,
    SUM(orcamento) AS total_orcamento,
    SUM(taxa_conversao) AS total_taxa_conversao,
    SUM(impressoes) AS total_impressoes
FROM
    cap16.dsa_campanha_marketing
WHERE 
    EXTRACT(YEAR FROM data_inicio) IN (2022, 2023, 2024)
GROUP BY
    TO_CHAR(data_inicio, 'YYYY')
ORDER BY 
    TO_CHAR(data_inicio, 'YYYY') DESC;


-- Relatório de Resumo Com Variáveis Quantitativas e Pivot da Tabela

SELECT
    'Total' as Total,
    SUM(CASE WHEN EXTRACT(YEAR FROM data_inicio) = 2022 THEN orcamento ELSE 0 END) AS "Orcamento_2022",
    SUM(CASE WHEN EXTRACT(YEAR FROM data_inicio) = 2022 THEN taxa_conversao ELSE 0 END) AS "Taxa_Conversao_2022",
    SUM(CASE WHEN EXTRACT(YEAR FROM data_inicio) = 2022 THEN impressoes ELSE 0 END) AS "Impressoes_2022",
    SUM(CASE WHEN EXTRACT(YEAR FROM data_inicio) = 2023 THEN orcamento ELSE 0 END) AS "Orcamento_2023",
    SUM(CASE WHEN EXTRACT(YEAR FROM data_inicio) = 2023 THEN taxa_conversao ELSE 0 END) AS "Taxa_Conversao_2023",
    SUM(CASE WHEN EXTRACT(YEAR FROM data_inicio) = 2023 THEN impressoes ELSE 0 END) AS "Impressoes_2023",
    SUM(CASE WHEN EXTRACT(YEAR FROM data_inicio) = 2024 THEN orcamento ELSE 0 END) AS "Orcamento_2024",
    SUM(CASE WHEN EXTRACT(YEAR FROM data_inicio) = 2024 THEN taxa_conversao ELSE 0 END) AS "Taxa_Conversao_2024",
    SUM(CASE WHEN EXTRACT(YEAR FROM data_inicio) = 2024 THEN impressoes ELSE 0 END) AS "Impressoes_2024"
FROM
    cap16.dsa_campanha_marketing;


-- Normalização de Dados com SQL
-- A normalização Min-Max é um método utilizado em estatística e aprendizado de máquina 
-- para transformar características (features) de dados para uma escala comum, sem distorcer 
-- as diferenças nos intervalos de valores. Este método é útil para algoritmos de aprendizado 
-- que são sensíveis a variações nas escalas dos dados, como redes neurais e algoritmos 
-- baseados em distância (por exemplo, K-NN).

-- Selecione id, nome_campanha, data_inicio e data_fim, junto com orcamento e taxa_conversao normalizados

-- Sem normalização

SELECT
    id,
    nome_campanha,
    data_inicio,
    data_fim,
    orcamento,
    taxa_conversao
FROM
    cap16.dsa_campanha_marketing;

-- Com normalização

WITH min_max AS (
    SELECT
        MIN(orcamento) as min_orcamento,
        MAX(orcamento) as max_orcamento,
        MIN(taxa_conversao) as min_taxa_conversao,
        MAX(taxa_conversao) as max_taxa_conversao
    FROM
        cap16.dsa_campanha_marketing
)
SELECT
    id,
    nome_campanha,
    data_inicio,
    data_fim,
    ROUND((orcamento - min_orcamento) / (max_orcamento - min_orcamento),5) as orcamento_normalizado,
    ROUND((taxa_conversao - min_taxa_conversao) / (max_taxa_conversao - min_taxa_conversao),5) as taxa_conversao_normalizada
FROM
    cap16.dsa_campanha_marketing, min_max;






