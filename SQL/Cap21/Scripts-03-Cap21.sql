# SQL Para Análise de Dados e Data Science - Capítulo 21

-- Versão melhorada da query anterior
SELECT a.Nome AS AutorNome, l.Titulo AS LivroTitulo, l.Genero AS LivroGenero, al.Preco, al.DataLancamento
FROM cap21.autores a
JOIN cap21.autoreslivros al ON a.AutorID = al.AutorID
JOIN cap21.livros l ON al.LivroID = l.LivroID
ORDER BY a.Nome, l.Titulo, al.DataLancamento;

# Estratégia 1 - Indexação

# Para otimizar a performance da query acima, que envolve joins entre as tabelas autores, autoreslivros e livros, 
# além de uma ordenação baseada em múltiplas colunas, os seguintes índices são recomendados:

# Índices nas Chaves Estrangeiras:

# Na tabela autoreslivros, crie índices nas colunas AutorID e LivroID, já que estas colunas são usadas para o 
# join com as tabelas autores e livros, respectivamente. Isso facilita a busca rápida das linhas correspondentes 
# durante a operação de join.

CREATE INDEX idx_autoreslivros_autorid ON cap21.autoreslivros(AutorID);
CREATE INDEX idx_autoreslivros_livroid ON cap21.autoreslivros(LivroID);

# Índice na Coluna Usada para Ordenação:

-- Índice composto para autores baseado no nome
CREATE INDEX idx_autores_nome ON cap21.autores(Nome);

-- Índice composto para livros baseado no título
CREATE INDEX idx_livros_titulo ON cap21.livros(Titulo);

# Para a coluna al.DataLancamento, um índice pode ser útil se você frequentemente realiza consultas filtrando 
# ou ordenando por essa coluna:

CREATE INDEX idx_autoreslivros_datalancamento ON cap21.autoreslivros(DataLancamento);

# Estratégia 2 - Particionamento

# Para otimizar a tabela autoreslivros que contém 1.500.000 de registros, o particionamento é uma 
# estratégia eficaz, pois permite dividir uma grande tabela em partes mais gerenciáveis, baseadas em 
# regras específicas que se alinham com as consultas mais frequentes ou críticas para a aplicação. 
# A escolha da chave de particionamento deve refletir os padrões de acesso aos dados, com o objetivo de 
# melhorar o desempenho das consultas e facilitar a manutenção.

# O problema é que muitos SGBDs só permitem criar tabelas particionadas no momento da criação da tabela.

# Mas podemos resolver isso facilmente!

-- Cria nova tabela ativando o particionamento
CREATE TABLE cap21.autoreslivros_part (
    AutorID INT,
    LivroID INT,
    Preco DECIMAL(10,2),
    DataLancamento DATE
) PARTITION BY RANGE (DataLancamento);

-- Cria as partições
CREATE TABLE cap21.autoreslivros_p1 PARTITION OF cap21.autoreslivros_part
    FOR VALUES FROM ('2010-01-01') TO ('2016-01-01');

CREATE TABLE cap21.autoreslivros_p2 PARTITION OF cap21.autoreslivros_part
    FOR VALUES FROM ('2016-01-01') TO ('2021-01-01');

-- Copia os registros da tabela original para a nova tabela
INSERT INTO cap21.autoreslivros_part (AutorID, LivroID, Preco, DataLancamento)
SELECT AutorID, LivroID, Preco, DataLancamento FROM cap21.autoreslivros;

-- Altera o nome da tabela original
ALTER TABLE IF EXISTS cap21.autoreslivros RENAME TO autoreslivros_old;

-- Altera o nome da nova tabela
ALTER TABLE cap21.autoreslivros_part RENAME TO autoreslivros;

-- Versão melhorada da query
-- Precisamos usar como filtro a chave de partição
SELECT a.Nome AS AutorNome, l.Titulo AS LivroTitulo, l.Genero AS LivroGenero, al.Preco, al.DataLancamento
FROM cap21.autores a
JOIN cap21.autoreslivros al ON a.AutorID = al.AutorID
JOIN cap21.livros l ON al.LivroID = l.LivroID
WHERE al.DataLancamento >= '2016-01-01'
ORDER BY a.Nome, l.Titulo, al.DataLancamento;

EXPLAIN SELECT a.Nome AS AutorNome, l.Titulo AS LivroTitulo, l.Genero AS LivroGenero, al.Preco, al.DataLancamento
FROM cap21.autores a
JOIN cap21.autoreslivros al ON a.AutorID = al.AutorID
JOIN cap21.livros l ON al.LivroID = l.LivroID
WHERE al.DataLancamento >= '2016-01-01'
ORDER BY a.Nome, l.Titulo, al.DataLancamento;

-- Versão melhorada da query
-- Precisamos usar como filtro a chave de partição
SELECT a.Nome AS AutorNome, l.Titulo AS LivroTitulo, l.Genero AS LivroGenero, al.Preco, al.DataLancamento
FROM cap21.autores a
JOIN cap21.autoreslivros al ON a.AutorID = al.AutorID
JOIN cap21.livros l ON al.LivroID = l.LivroID
WHERE al.DataLancamento = '2016-01-01' OR al.DataLancamento <=  '2012-01-01'
ORDER BY a.Nome, l.Titulo, al.DataLancamento;

EXPLAIN SELECT a.Nome AS AutorNome, l.Titulo AS LivroTitulo, l.Genero AS LivroGenero, al.Preco, al.DataLancamento
FROM cap21.autores a
JOIN cap21.autoreslivros al ON a.AutorID = al.AutorID
JOIN cap21.livros l ON al.LivroID = l.LivroID
WHERE al.DataLancamento = '2016-01-01' OR al.DataLancamento <=  '2012-01-01'
ORDER BY a.Nome, l.Titulo, al.DataLancamento;






