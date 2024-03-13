# SQL Para Análise de Dados e Data Science - Capítulo 21


-- Exemplo de query SQL muito ruim
SELECT a.*, l.*, al.*
FROM cap21.autores a
CROSS JOIN cap21.livros l
LEFT JOIN cap21.autoreslivros al ON a.AutorID = al.AutorID AND l.LivroID = al.LivroID
WHERE a.AutorID IN (SELECT AutorID FROM cap21.autores)
AND l.LivroID IN (SELECT LivroID FROM cap21.livros)
ORDER BY a.Nome, l.Titulo, al.DataLancamento;


# Por que essa query é ruim?
# Veja os detalhes no videobook no Capítulo 21 do curso.

# Como Melhorar a query acima?
# Veja os detalhes no videobook no Capítulo 21 do curso.


-- Versão melhorada da query anterior
SELECT a.Nome AS AutorNome, l.Titulo AS LivroTitulo, l.Genero AS LivroGenero, al.Preco, al.DataLancamento
FROM cap21.autores a
JOIN cap21.autoreslivros al ON a.AutorID = al.AutorID
JOIN cap21.livros l ON al.LivroID = l.LivroID
ORDER BY a.Nome, l.Titulo, al.DataLancamento;


