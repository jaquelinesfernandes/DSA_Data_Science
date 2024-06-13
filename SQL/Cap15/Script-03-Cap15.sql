# SQL Para Análise de Dados e Data Science - Capítulo 15


-- Verifica os dados

SELECT * FROM cap15.dsa_campanha_marketing;


-- 1. Crie uma query que identifique os valores únicos da coluna publico_alvo.

SELECT DISTINCT publico_alvo
FROM cap15.dsa_campanha_marketing;


-- 2. Crie uma query com update que substitua o caracter "?" na coluna publico_alvo pelo valor "Outros".

UPDATE cap15.dsa_campanha_marketing
SET publico_alvo = 'Outros'
WHERE publico_alvo = '?';


-- 3. Crie uma query que identifique o total de registros de cada valor da coluna canais_divulgacao.

SELECT canais_divulgacao, COUNT(*) as total_registros
FROM cap15.dsa_campanha_marketing
GROUP BY canais_divulgacao;


-- 4. Crie uma query com update que substitua os valores ausentes pela moda da coluna canais_divulgacao.

-- Primeiro encontramos a moda da coluna canais_divulgacao e depois usamos para fazer o update:

SELECT canais_divulgacao
FROM cap15.dsa_campanha_marketing
WHERE canais_divulgacao IS NOT NULL
GROUP BY canais_divulgacao
ORDER BY COUNT(*) DESC
LIMIT 1;

-- Agora o update
UPDATE cap15.dsa_campanha_marketing
SET canais_divulgacao = 'Redes Sociais'
WHERE canais_divulgacao IS NULL;


-- 5. Crie uma query que identifique o total de registros de cada valor da coluna tipo_campanha.

SELECT tipo_campanha, COUNT(*) as total_registros
FROM cap15.dsa_campanha_marketing
GROUP BY tipo_campanha;


-- 6. Considere que os valores ausentes na coluna tipo_campanha sejam erros de coleta de dados. 
-- Crie uma query com delete que remova os registros onde tipo_campanha tiver valor nulo.

DELETE FROM cap15.dsa_campanha_marketing
WHERE tipo_campanha IS NULL;


-- Valores ausentes restantes:

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










