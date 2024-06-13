# SQL Para Análise de Dados e Data Science - Capítulo 08


-- Criação da tabela Autores
CREATE TABLE cap08.autores (
    id_autor SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    data_nascimento DATE
);


-- Criação da tabela Livros
CREATE TABLE cap08.livros (
    id_livro SERIAL PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    ano_publicacao INT
);


-- Criação da tabela LivrosAutores
CREATE TABLE cap08.livros_vendidos (
    id_livro INT NOT NULL REFERENCES cap08.livros(id_livro),
    id_autor INT NOT NULL REFERENCES cap08.autores(id_autor),
    PRIMARY KEY (id_livro, id_autor)
);


-- Inserindo registros na tabela de autores
INSERT INTO cap08.autores (nome, data_nascimento) VALUES
('Yuval Noah Harari', '1976-02-24'),
('Leonard Mlodinow', '1954-11-26'),
('Dale Carnegie', '1888-11-24'),
('Stephen R. Covey', '1932-10-24');


-- Inserindo registros na tabela de livros
INSERT INTO cap08.livros (titulo, ano_publicacao) VALUES
('Sapiens - Uma breve história da humanidade', 2020),
('21 lições para o século 21', 2018),
('O andar do bêbado: Como o acaso determina nossas vidas', 2018),
('Uma breve história do tempo', 2015),
('Os 7 Hábitos das Pessoas Altamente Eficazes', 2017);


-- Inserindo registros na tabela de LivrosAutores
INSERT INTO cap08.livros_vendidos (id_livro, id_autor) VALUES
(1, 1), 
(3, 2), 
(5, 4); 


-- Exercício 1: Liste todos os livros vendidos e seus respectivos autores.
SELECT l.titulo AS "Nome do Livro", a.nome AS "Nome do Autor"
FROM cap08.livros AS l
INNER JOIN cap08.livros_vendidos AS la ON l.id_livro = la.id_livro
INNER JOIN cap08.autores AS a ON a.id_autor = la.id_autor;


-- Exercício 2: Liste todos os autores e seus respectivos livros, incluindo autores que não têm livros cadastrados.
SELECT a.nome AS "Nome do Autor", COALESCE(l.titulo, 'Nenhum livro associado') AS "Nome do Livro"
FROM cap08.autores AS a
LEFT JOIN cap08.livros_vendidos AS la ON a.id_autor = la.id_autor
LEFT JOIN cap08.livros AS l ON l.id_livro = la.id_livro;


-- Exercício 3: Liste todos os livros e seus respectivos autores, incluindo livros que não têm autores cadastrados.
SELECT l.titulo AS "Nome do Livro", COALESCE(a.nome, 'Nenhum autor associado') AS "Nome do Autor"
FROM cap08.autores AS a
RIGHT JOIN cap08.livros_vendidos AS la ON a.id_autor = la.id_autor
RIGHT JOIN cap08.livros AS l ON l.id_livro = la.id_livro;


-- Exercício 4: Liste os autores que nasceram antes de 1970 e os livros que eles escreveram.
SELECT a.nome AS "Nome do Autor", l.titulo AS "Nome do Livro"
FROM cap08.autores AS a
INNER JOIN cap08.livros_vendidos AS la ON a.id_autor = la.id_autor
INNER JOIN cap08.livros AS l ON l.id_livro = la.id_livro
WHERE a.data_nascimento < '1970-01-01';


-- Exercício 5: Liste os livros publicados após 2017, incluindo os que não têm autores associados.
SELECT l.titulo AS "Nome do Livro", COALESCE(a.nome, 'Nenhum autor associado') AS "Nome do Autor"
FROM cap08.livros AS l
LEFT JOIN cap08.livros_vendidos AS la ON l.id_livro = la.id_livro
LEFT JOIN cap08.autores AS a ON a.id_autor = la.id_autor
WHERE l.ano_publicacao > 2017;








