# SQL Para Análise de Dados e Data Science - Capítulo 19


-- Isso aqui não funciona:
SELECT * FROM cap19.inserir_vendas_exemplo;
SELECT * FROM cap19.inserir_vendas_exemplo();


-- Vamos criar um relatório que calcula o valor total de vendas para um cliente específico. 
-- Se não houve venda, o relatório deve retornar zero.
CREATE OR REPLACE FUNCTION cap19.calcular_total_vendas_cliente(cliente_id_param INT)
RETURNS DECIMAL(10, 2) AS $$
DECLARE
    total_vendas DECIMAL(10, 2);
BEGIN
    SELECT SUM(valor_venda) INTO total_vendas
    FROM cap19.vendas
    WHERE cliente_id = cliente_id_param;

    IF total_vendas IS NULL THEN
        RETURN 0;
    ELSE
        RETURN total_vendas;
    END IF;
END;
$$ LANGUAGE plpgsql;


-- Substitua 10 pelo cliente_id desejado
SELECT cap19.calcular_total_vendas_cliente(10); 


-- Retorna o cliente de id 10
SELECT 
    c.cliente_id,
    c.nome,
    c.cidade
FROM 
    cap19.clientes c
WHERE 
    c.cliente_id = 10;


-- Retorna o cliente de id 10 com o total de vendas
SELECT 
    c.cliente_id,
    c.nome,
    c.cidade,
    cap19.calcular_total_vendas_cliente(10) AS total_vendas
FROM 
    cap19.clientes c
WHERE 
    c.cliente_id = 10;


-- Cria a View
CREATE VIEW cap19.retorna_vendas_cliente_10 AS
SELECT 
    c.cliente_id,
    c.nome,
    c.cidade,
    cap19.calcular_total_vendas_cliente(10) AS total_vendas
FROM 
    cap19.clientes c
WHERE 
    c.cliente_id = 10;


-- Executa a View
SELECT * FROM cap19.retorna_vendas_cliente_10


-- O uso de funções é ainda mais interessante quando associamos com triggers.

-- Altera a tabela e insere mais um campo
ALTER TABLE cap19.clientes
ADD COLUMN ultima_compra DATE;


-- Esta function será chamada quando uma nova venda for inserida na tabela vendas. 
-- Ela atualizará a coluna ultima_compra na tabela clientes.
CREATE OR REPLACE FUNCTION cap19.atualizar_ultima_compra()
RETURNS TRIGGER AS $$
BEGIN
    -- Atualiza a coluna 'ultima_compra' na tabela 'clientes'
    UPDATE cap19.clientes
    SET ultima_compra = NEW.data_venda
    WHERE cliente_id = NEW.cliente_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


-- Cria a trigger
CREATE TRIGGER atualiza_data_venda
AFTER INSERT ON cap19.vendas
FOR EACH ROW
EXECUTE FUNCTION cap19.atualizar_ultima_compra();


-- Transação no banco de dados para inserir uma venda

BEGIN; -- Inicia a transação

-- Insere uma nova venda para o cliente de id 10
INSERT INTO cap19.vendas (cliente_id, quantidade, valor_venda, data_venda)
VALUES (10, 1, 120.00, CURRENT_DATE);

-- Se tudo ocorreu bem, confirma as alterações
COMMIT;


-- Transação no banco de dados para inserir uma venda

BEGIN; -- Inicia a transação

-- Insere uma nova venda para o cliente de id 10
INSERT INTO cap19.vendas (cliente_id, quantidade, valor_venda, data_venda)
VALUES (10, 3, 439.00, CURRENT_DATE);

-- Se tudo ocorreu bem, confirma as alterações
COMMIT;


-- Transação no banco de dados para inserir uma transação completa em todas as tabelas

BEGIN; -- Inicia a transação

-- Insere um novo cliente e captura o cliente_id gerado
WITH novo_cliente AS (
    INSERT INTO cap19.clientes (nome, endereco, cidade) 
    VALUES ('Novo Cliente DSA', '123 Rua Principal', 'São Paulo') 
    RETURNING cliente_id
)
-- Insere uma nova interação com o cliente_id obtido
, nova_interacao AS (
    INSERT INTO cap19.interacoes (cliente_id, tipo_interacao, descricao, data_hora)
    SELECT cliente_id, 'Email', 'Email de boas-vindas enviado', CURRENT_DATE
    FROM novo_cliente
    RETURNING interacao_id
)
-- Insere uma nova venda com o cliente_id obtido
INSERT INTO cap19.vendas (cliente_id, quantidade, valor_venda, data_venda)
SELECT cliente_id, 1, 100.00, CURRENT_DATE
FROM novo_cliente;

-- Se tudo ocorreu bem, confirma as alterações
COMMIT;


-- Verifica os clientes que fizeram as compras mais recentes
SELECT * FROM cap19.clientes
WHERE ultima_compra IS NOT NULL;


-- Função para inserir clientes no banco de dados fazendo validações
CREATE OR REPLACE FUNCTION cap19.inserir_novo_cliente(nome_cliente VARCHAR, endereco_cliente VARCHAR, cidade_cliente VARCHAR)
RETURNS VOID AS $$
BEGIN
    -- Tenta inserir um novo cliente
    INSERT INTO cap19.clientes (nome, endereco, cidade)
    VALUES (nome_cliente, endereco_cliente, cidade_cliente);

    -- Se tudo ocorrer bem, a função termina aqui

    -- Se der erro, retorna conforme abaixo
    EXCEPTION
        WHEN unique_violation THEN
            RAISE NOTICE 'Erro: o cliente já existe.';
        WHEN check_violation THEN
            RAISE NOTICE 'Erro: violação de restrição de verificação.';
        WHEN others THEN
            RAISE NOTICE 'Erro inesperado: %', SQLERRM;
            -- Reverte as alterações feitas na transação atual
            ROLLBACK;
END;
$$ LANGUAGE plpgsql;


-- Executa a função
SELECT cap19.inserir_novo_cliente('DSA Novo Cliente 1', '80 Rua Z', 'Blumenau');
SELECT cap19.inserir_novo_cliente('DSA Novo Cliente 2', '90 Rua Y', 'Natal');
SELECT cap19.inserir_novo_cliente('DSA Novo Cliente 3', '100 Rua X', 'Palmas');


-- Vamos cadastrar vendas para os clientes

BEGIN; -- Inicia a transação

-- Insere uma nova venda para o cliente de id 1001
INSERT INTO cap19.vendas (cliente_id, quantidade, valor_venda, data_venda)
VALUES (1002, 2, 453.00, CURRENT_DATE);

-- Se tudo ocorreu bem, confirma as alterações
COMMIT;


BEGIN; -- Inicia a transação

-- Insere uma nova venda para o cliente de id 1001
INSERT INTO cap19.vendas (cliente_id, quantidade, valor_venda, data_venda)
VALUES (1003, 2, 670.00, CURRENT_DATE);

-- Se tudo ocorreu bem, confirma as alterações
COMMIT;


BEGIN; -- Inicia a transação

-- Insere uma nova venda para o cliente de id 1001
INSERT INTO cap19.vendas (cliente_id, quantidade, valor_venda, data_venda)
VALUES (1004, 2, 345.00, CURRENT_DATE);

-- Se tudo ocorreu bem, confirma as alterações
COMMIT;


-- Cria function para gerar relatório de vendas
CREATE OR REPLACE FUNCTION cap19.relatorio_vendas_clientes()
RETURNS TABLE (nome_cliente VARCHAR, valor_total_vendas DECIMAL, data_ultima_compra DATE) AS $$
DECLARE

    -- Variáveis
    cliente_record RECORD;
    cursor_clientes CURSOR FOR SELECT * FROM cap19.clientes WHERE ultima_compra IS NOT NULL;
BEGIN

    -- Abre o cursor
    OPEN cursor_clientes;

    -- Loop em cada registro do cursor para gerar os valores de saída
    LOOP
        FETCH cursor_clientes INTO cliente_record;
        EXIT WHEN NOT FOUND;

        -- Nome vem do cursor
        nome_cliente := cliente_record.nome; 
        
        -- Total de vendas vem da outra função
        SELECT INTO valor_total_vendas cap19.calcular_total_vendas_cliente(cliente_record.cliente_id); 

        -- Data vem do cursor
        data_ultima_compra := cliente_record.ultima_compra; 

        RETURN NEXT; 

    END LOOP;
    CLOSE cursor_clientes;
END;
$$ LANGUAGE plpgsql;


-- Executa a function
SELECT * FROM cap19.relatorio_vendas_clientes();











