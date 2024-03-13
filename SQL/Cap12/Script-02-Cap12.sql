# SQL Para Análise de Dados e Data Science - Capítulo 12


-- Verifica os dados
SELECT * 
FROM cap12.vendas;

SELECT * FROM cap12.vendas 
WHERE funcionario = 'Agatha Christie';

SELECT * FROM cap12.vendas 
WHERE funcionario = 'Agatha Christie'
ORDER BY ano, mes;

SELECT * FROM cap12.vendas 
WHERE funcionario = 'Agatha Christie'
ORDER BY mes, ano;

SELECT * FROM cap12.vendas 
WHERE funcionario = 'Agatha Christie'
ORDER BY unidades_vendidas;

SELECT funcionario, ano, mes, CASE
        WHEN mes = 'Janeiro' THEN 1
        WHEN mes = 'Fevereiro' THEN 2
        WHEN mes = 'Março' THEN 3
        WHEN mes = 'Abril' THEN 4
        WHEN mes = 'Maio' THEN 5
        WHEN mes = 'Junho' THEN 6
        WHEN mes = 'Julho' THEN 7
        WHEN mes = 'Agosto' THEN 8
        WHEN mes = 'Setembro' THEN 9
        WHEN mes = 'Outubro' THEN 10
        WHEN mes = 'Novembro' THEN 11
        WHEN mes = 'Dezembro' THEN 12
    END as venda_numero,
    unidades_vendidas
    FROM cap12.vendas 
WHERE funcionario = 'Agatha Christie'
ORDER BY ano, mes;

SELECT funcionario, ano, mes, CASE
        WHEN mes = 'Janeiro' THEN 1
        WHEN mes = 'Fevereiro' THEN 2
        WHEN mes = 'Março' THEN 3
        WHEN mes = 'Abril' THEN 4
        WHEN mes = 'Maio' THEN 5
        WHEN mes = 'Junho' THEN 6
        WHEN mes = 'Julho' THEN 7
        WHEN mes = 'Agosto' THEN 8
        WHEN mes = 'Setembro' THEN 9
        WHEN mes = 'Outubro' THEN 10
        WHEN mes = 'Novembro' THEN 11
        WHEN mes = 'Dezembro' THEN 12
    END as venda_numero,
    unidades_vendidas
FROM cap12.vendas 
WHERE funcionario = 'Agatha Christie'
ORDER BY ano, venda_numero;


-- Numerar as transações de cada funcionário por ano e mês
SELECT
    funcionario,
    ano,
    mes,
    unidades_vendidas,
    ROW_NUMBER() OVER (PARTITION BY funcionario ORDER BY ano, mes) as numero_transacao
FROM cap12.vendas
WHERE funcionario = 'Agatha Christie';

SELECT
    funcionario,
    ano,
    mes,
    unidades_vendidas,
    ROW_NUMBER() OVER (PARTITION BY funcionario ORDER BY ano, CASE
        WHEN mes = 'Janeiro' THEN 1
        WHEN mes = 'Fevereiro' THEN 2
        WHEN mes = 'Março' THEN 3
        WHEN mes = 'Abril' THEN 4
        WHEN mes = 'Maio' THEN 5
        WHEN mes = 'Junho' THEN 6
        WHEN mes = 'Julho' THEN 7
        WHEN mes = 'Agosto' THEN 8
        WHEN mes = 'Setembro' THEN 9
        WHEN mes = 'Outubro' THEN 10
        WHEN mes = 'Novembro' THEN 11
        WHEN mes = 'Dezembro' THEN 12
    END) as numero_transacao
FROM cap12.vendas
WHERE funcionario = 'Agatha Christie';

SELECT
    funcionario,
    ano,
    mes,
    unidades_vendidas,
    ROW_NUMBER() OVER (PARTITION BY funcionario ORDER BY ano, CASE
        WHEN mes = 'Janeiro' THEN 1
        WHEN mes = 'Fevereiro' THEN 2
        WHEN mes = 'Março' THEN 3
        WHEN mes = 'Abril' THEN 4
        WHEN mes = 'Maio' THEN 5
        WHEN mes = 'Junho' THEN 6
        WHEN mes = 'Julho' THEN 7
        WHEN mes = 'Agosto' THEN 8
        WHEN mes = 'Setembro' THEN 9
        WHEN mes = 'Outubro' THEN 10
        WHEN mes = 'Novembro' THEN 11
        WHEN mes = 'Dezembro' THEN 12
    END) as numero_transacao
FROM cap12.vendas
WHERE funcionario = 'Agatha Christie'
  AND numero_transacao = 7;

SELECT *
FROM (
    SELECT
        funcionario,
        ano,
        mes,
        unidades_vendidas,
        ROW_NUMBER() OVER (
            PARTITION BY funcionario 
            ORDER BY ano, CASE
                WHEN mes = 'Janeiro' THEN 1
                WHEN mes = 'Fevereiro' THEN 2
                WHEN mes = 'Março' THEN 3
                WHEN mes = 'Abril' THEN 4
                WHEN mes = 'Maio' THEN 5
                WHEN mes = 'Junho' THEN 6
                WHEN mes = 'Julho' THEN 7
                WHEN mes = 'Agosto' THEN 8
                WHEN mes = 'Setembro' THEN 9
                WHEN mes = 'Outubro' THEN 10
                WHEN mes = 'Novembro' THEN 11
                WHEN mes = 'Dezembro' THEN 12
            END
        ) as numero_transacao
    FROM cap12.vendas
) AS subquery
WHERE funcionario = 'Agatha Christie'
  AND numero_transacao = 7;

SELECT *
FROM (
    SELECT
        funcionario,
        ano,
        mes,
        unidades_vendidas,
        ROW_NUMBER() OVER (
            PARTITION BY funcionario 
            ORDER BY ano, CASE
                WHEN mes = 'Janeiro' THEN 1
                WHEN mes = 'Fevereiro' THEN 2
                WHEN mes = 'Março' THEN 3
                WHEN mes = 'Abril' THEN 4
                WHEN mes = 'Maio' THEN 5
                WHEN mes = 'Junho' THEN 6
                WHEN mes = 'Julho' THEN 7
                WHEN mes = 'Agosto' THEN 8
                WHEN mes = 'Setembro' THEN 9
                WHEN mes = 'Outubro' THEN 10
                WHEN mes = 'Novembro' THEN 11
                WHEN mes = 'Dezembro' THEN 12
            END
        ) as numero_transacao
    FROM cap12.vendas
) AS subquery
WHERE numero_transacao = 7;


-- Criar um ranking das unidades vendidas, do maior número para o menor, por ano
-- Por exemplo: Qual funcionário conduziu a transação com maior número de unidades vendidas em cada ano? 
-- No caso de valores empatados, RANK() atribuirá o mesmo ranking a todos os registros empatados
SELECT
    funcionario,
    ano,
    mes,
    unidades_vendidas,
    RANK() OVER (PARTITION BY ano ORDER BY unidades_vendidas DESC) AS rank_vendas
FROM cap12.vendas;

SELECT
    funcionario,
    ano,
    mes,
    unidades_vendidas,
    RANK() OVER (PARTITION BY ano ORDER BY unidades_vendidas DESC) AS rank_vendas
FROM cap12.vendas
WHERE ano = 2024;

SELECT *
FROM (
    SELECT
        funcionario,
        ano,
        mes,
        unidades_vendidas,
        RANK() OVER (
            PARTITION BY ano 
            ORDER BY unidades_vendidas DESC
        ) AS rank_vendas
    FROM cap12.vendas
) AS subquery
WHERE rank_vendas = 1;


-- Criar um ranking das unidades vendidas, do maior número para o menor, por ano
-- Por exemplo: Qual funcionário conduziu a transação com menor número de unidades vendidas em cada ano? 
SELECT *
FROM (
    SELECT
        funcionario,
        ano,
        mes,
        unidades_vendidas,
        RANK() OVER (
            PARTITION BY ano 
            ORDER BY unidades_vendidas DESC
        ) AS rank_vendas
    FROM cap12.vendas
) AS ranked_vendas
WHERE rank_vendas = (
    SELECT MAX(rank_vendas) 
    FROM (
        SELECT
            RANK() OVER (
                PARTITION BY ano 
                ORDER BY unidades_vendidas DESC
            ) AS rank_vendas
        FROM cap12.vendas
    ) AS max_rank
);


-- Criar um ranking das unidades vendidas, da maior para a menor, por ano
-- Com DENSE_RANK(), se dois funcionários estiverem empatados em primeiro lugar em vendas, ambos receberão o ranking 1, e o próximo funcionário será o número 2, independentemente de ser o terceiro em termos de vendas.
-- Isso faz com que DENSE_RANK() forneça uma sequência contínua de números inteiros no ranking
SELECT
    funcionario,
    ano,
    mes,
    unidades_vendidas,
    DENSE_RANK() OVER (PARTITION BY ano ORDER BY unidades_vendidas DESC) AS dense_rank_vendas
FROM cap12.vendas;


-- Cria grupos de unidades vendidas por funcionário e por ano
-- Para cada funcionario e ano, a tabela cap12.vendas será dividida em 2 grupos, com base no número de unidades_vendidas. 
-- O grupo 1 conterá as metades superiores das vendas (maiores valores), enquanto o grupo 2 conterá as metades inferiores (menores valores).
-- Essencialmente, essa query está organizando os dados de vendas por funcionario e ano, e depois os dividindo em dois grupos com base 
-- no volume de vendas, de modo que as vendas mais altas e mais baixas para cada funcionário em cada ano são separadas em grupos distintos.
SELECT
    funcionario,
    ano,
    mes,
    unidades_vendidas,
    NTILE(2) OVER (PARTITION BY funcionario, ano ORDER BY unidades_vendidas DESC) AS grupo_vendas
FROM cap12.vendas;


-- Crie um ranking de todas as vendas da maior para a menor
SELECT
    funcionario,
    ano,
    mes,
    unidades_vendidas,
    RANK() OVER (ORDER BY unidades_vendidas DESC) AS rank_vendas
FROM cap12.vendas;


-- Calcular a soma acumulada das vendas para cada funcionário ao longo do tempo (ano e mês)

-- Sem ordem cronológica
SELECT
    funcionario,
    ano,
    mes,
    unidades_vendidas,
    SUM(unidades_vendidas) OVER (PARTITION BY funcionario ORDER BY ano, mes) as soma_acumulada
FROM cap12.vendas;

-- Com ordem cronológica
SELECT
    funcionario,
    ano,
    mes,
    unidades_vendidas,
    SUM(unidades_vendidas) OVER (PARTITION BY funcionario ORDER BY ano, CASE
                WHEN mes = 'Janeiro' THEN 1
                WHEN mes = 'Fevereiro' THEN 2
                WHEN mes = 'Março' THEN 3
                WHEN mes = 'Abril' THEN 4
                WHEN mes = 'Maio' THEN 5
                WHEN mes = 'Junho' THEN 6
                WHEN mes = 'Julho' THEN 7
                WHEN mes = 'Agosto' THEN 8
                WHEN mes = 'Setembro' THEN 9
                WHEN mes = 'Outubro' THEN 10
                WHEN mes = 'Novembro' THEN 11
                WHEN mes = 'Dezembro' THEN 12
            END) as soma_acumulada
FROM cap12.vendas;


-- Calcular a média acumulada das vendas até o ponto atual para cada funcionário 
-- (Esta query calcula média acumulada das vendas até o ponto atual, não uma média móvel com um intervalo específico.)
SELECT
    funcionario,
    ano,
    mes,
    unidades_vendidas,
    ROUND(AVG(unidades_vendidas) OVER (PARTITION BY funcionario ORDER BY ano, CASE
                WHEN mes = 'Janeiro' THEN 1
                WHEN mes = 'Fevereiro' THEN 2
                WHEN mes = 'Março' THEN 3
                WHEN mes = 'Abril' THEN 4
                WHEN mes = 'Maio' THEN 5
                WHEN mes = 'Junho' THEN 6
                WHEN mes = 'Julho' THEN 7
                WHEN mes = 'Agosto' THEN 8
                WHEN mes = 'Setembro' THEN 9
                WHEN mes = 'Outubro' THEN 10
                WHEN mes = 'Novembro' THEN 11
                WHEN mes = 'Dezembro' THEN 12
            END), 2) as media_acumulada_ate_ponto_atual
FROM cap12.vendas;


-- Calcular a média móvel das vendas para cada funcionário (a query abaixo considera 3 linhas para calcular a média)
SELECT
    funcionario,
    ano,
    mes,
    unidades_vendidas,
    ROUND(AVG(unidades_vendidas) OVER (PARTITION BY funcionario ORDER BY ano, CASE
                WHEN mes = 'Janeiro' THEN 1
                WHEN mes = 'Fevereiro' THEN 2
                WHEN mes = 'Março' THEN 3
                WHEN mes = 'Abril' THEN 4
                WHEN mes = 'Maio' THEN 5
                WHEN mes = 'Junho' THEN 6
                WHEN mes = 'Julho' THEN 7
                WHEN mes = 'Agosto' THEN 8
                WHEN mes = 'Setembro' THEN 9
                WHEN mes = 'Outubro' THEN 10
                WHEN mes = 'Novembro' THEN 11
                WHEN mes = 'Dezembro' THEN 12
            END ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING), 2) as media_movel
FROM cap12.vendas;

-- Na query SQL acima, a expressão ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING é parte da cláusula de janela usada com a função AVG(). 
-- Essa expressão especifica o conjunto de linhas (ou "janela") sobre o qual a função de média (AVG) será aplicada em cada ponto. 
-- Vamos destrinchar o significado dela:

-- ROWS: Indica que a definição da janela se baseia em linhas físicas na tabela, em vez de um intervalo lógico (como poderia ser com RANGE).

-- BETWEEN 1 PRECEDING AND 1 FOLLOWING:

-- 1 PRECEDING: Isso significa "uma linha antes da linha atual".
-- 1 FOLLOWING: Significa "uma linha depois da linha atual".

-- Quando você combina esses elementos, ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING define uma janela deslizante que consiste na linha atual, 
-- na linha imediatamente anterior e na linha imediatamente seguinte.

-- No contexto dessa query, isso significa que a média de unidades_vendidas é calculada para cada linha (para cada combinação de funcionário, ano e mês), 
-- incluindo a linha em questão, a linha anterior e a linha seguinte. Isso é útil para calcular uma média móvel, que é uma técnica comum para suavizar 
-- variações de curto prazo e destacar tendências de longo prazo em conjuntos de dados sequenciais, como vendas ao longo do tempo.


-- Agora com duas linhas antes e duas depois para calcular a média móvel (a query abaixo considera 5 linhas para calcular a média)
SELECT
    funcionario,
    ano,
    mes,
    unidades_vendidas,
    ROUND(AVG(unidades_vendidas) OVER (PARTITION BY funcionario ORDER BY ano, CASE
                WHEN mes = 'Janeiro' THEN 1
                WHEN mes = 'Fevereiro' THEN 2
                WHEN mes = 'Março' THEN 3
                WHEN mes = 'Abril' THEN 4
                WHEN mes = 'Maio' THEN 5
                WHEN mes = 'Junho' THEN 6
                WHEN mes = 'Julho' THEN 7
                WHEN mes = 'Agosto' THEN 8
                WHEN mes = 'Setembro' THEN 9
                WHEN mes = 'Outubro' THEN 10
                WHEN mes = 'Novembro' THEN 11
                WHEN mes = 'Dezembro' THEN 12
            END ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING), 2) as media_movel
FROM cap12.vendas;


-- Para visualizar as unidades vendidas no próximo período (ano e mês)
-- LEAD(): Esta função é usada para acessar dados de uma linha que está à frente da linha atual 
-- dentro de um conjunto de resultados específico
SELECT
    funcionario,
    ano,
    mes,
    unidades_vendidas,
    LEAD(unidades_vendidas) OVER (PARTITION BY funcionario ORDER BY ano, CASE
                WHEN mes = 'Janeiro' THEN 1
                WHEN mes = 'Fevereiro' THEN 2
                WHEN mes = 'Março' THEN 3
                WHEN mes = 'Abril' THEN 4
                WHEN mes = 'Maio' THEN 5
                WHEN mes = 'Junho' THEN 6
                WHEN mes = 'Julho' THEN 7
                WHEN mes = 'Agosto' THEN 8
                WHEN mes = 'Setembro' THEN 9
                WHEN mes = 'Outubro' THEN 10
                WHEN mes = 'Novembro' THEN 11
                WHEN mes = 'Dezembro' THEN 12
            END) as proxima_transacao
FROM cap12.vendas;

SELECT
    funcionario,
    ano,
    mes,
    unidades_vendidas,
    COALESCE(
        CAST(LEAD(unidades_vendidas) OVER (PARTITION BY funcionario ORDER BY ano, CASE
                WHEN mes = 'Janeiro' THEN 1
                WHEN mes = 'Fevereiro' THEN 2
                WHEN mes = 'Março' THEN 3
                WHEN mes = 'Abril' THEN 4
                WHEN mes = 'Maio' THEN 5
                WHEN mes = 'Junho' THEN 6
                WHEN mes = 'Julho' THEN 7
                WHEN mes = 'Agosto' THEN 8
                WHEN mes = 'Setembro' THEN 9
                WHEN mes = 'Outubro' THEN 10
                WHEN mes = 'Novembro' THEN 11
                WHEN mes = 'Dezembro' THEN 12
            END) AS VARCHAR), 
        'Sem dados') AS proxima_transacao
FROM cap12.vendas;


-- Para comparar as vendas atuais com as do período anterior
-- LAG(): Usada para acessar dados de uma linha anterior no conjunto de resultados
SELECT
    funcionario,
    ano,
    mes,
    unidades_vendidas,
    COALESCE(
        CAST(LAG(unidades_vendidas) OVER (PARTITION BY funcionario ORDER BY ano, CASE
                WHEN mes = 'Janeiro' THEN 1
                WHEN mes = 'Fevereiro' THEN 2
                WHEN mes = 'Março' THEN 3
                WHEN mes = 'Abril' THEN 4
                WHEN mes = 'Maio' THEN 5
                WHEN mes = 'Junho' THEN 6
                WHEN mes = 'Julho' THEN 7
                WHEN mes = 'Agosto' THEN 8
                WHEN mes = 'Setembro' THEN 9
                WHEN mes = 'Outubro' THEN 10
                WHEN mes = 'Novembro' THEN 11
                WHEN mes = 'Dezembro' THEN 12
            END) AS VARCHAR),
        'Sem dados'
    ) AS unidades_vendidas_periodo_anterior
FROM cap12.vendas;


-- Crie uma query que selecione os funcionários juntamente com o valor máximo de unidades vendidas de cada um por ano, 
-- comparando com a média de vendas do ano
-- Uma subquery correlata é uma subquery que referencia colunas da tabela externa. 
SELECT 
    v.funcionario,
    v.ano,
    v.unidades_vendidas AS maior_venda_ano,
    (SELECT ROUND(AVG(unidades_vendidas), 2)
     FROM cap12.vendas 
     WHERE ano = v.ano) AS media_vendas_ano
FROM 
    cap12.vendas v
WHERE 
    v.unidades_vendidas = (SELECT MAX(unidades_vendidas) 
                           FROM cap12.vendas 
                           WHERE funcionario = v.funcionario AND ano = v.ano)
ORDER BY 
    v.funcionario, v.ano;


-- Crie uma query com o número de unidades vendidas de cada funcionário e o percentual em relação 
-- ao total geral (todos os anos) de unidades vendidas de cada funcionário 
-- Subqueries com agregação são usadas para realizar cálculos agregados em um conjunto de dados
SELECT 
    v.funcionario,
    ano,
    mes,
    unidades_vendidas,
    ROUND((unidades_vendidas / total_vendas) * 100, 2) AS percentual_do_total
FROM 
    cap12.vendas AS v,
    (SELECT funcionario, SUM(unidades_vendidas) AS total_vendas 
     FROM cap12.vendas 
     GROUP BY funcionario) AS vendas_totais
WHERE 
    v.funcionario = vendas_totais.funcionario
ORDER BY v.funcionario, ano, CASE
                WHEN mes = 'Janeiro' THEN 1
                WHEN mes = 'Fevereiro' THEN 2
                WHEN mes = 'Março' THEN 3
                WHEN mes = 'Abril' THEN 4
                WHEN mes = 'Maio' THEN 5
                WHEN mes = 'Junho' THEN 6
                WHEN mes = 'Julho' THEN 7
                WHEN mes = 'Agosto' THEN 8
                WHEN mes = 'Setembro' THEN 9
                WHEN mes = 'Outubro' THEN 10
                WHEN mes = 'Novembro' THEN 11
                WHEN mes = 'Dezembro' THEN 12
            END;


