# SQL Para Análise de Dados e Data Science - Capítulo 04

-- Criando a tabela 'funcionarios'
CREATE TABLE cap04.funcionarios (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(50),
    sobrenome VARCHAR(50),
    salario DECIMAL(10, 2),
    departamento VARCHAR(50),
    data_contratacao DATE
);


-- Inserindo registros na tabela 'funcionarios'
INSERT INTO cap04.funcionarios (nome, sobrenome, salario, departamento, data_contratacao) VALUES
('Alice', 'Martins', 6000, 'Engenharia', '2021-06-15'),
('Bob', 'Oliveira', 5500, 'Marketing', '2020-03-21'),
('Carol', 'Ferreira', 7000, 'Engenharia', '2023-01-01'),
('Josias', 'Silva', 5000, 'RH', '2019-11-05'),
('Kevin', 'Santos', 7500, 'Engenharia', '2021-05-20'),
('Frank', 'Oliveira', 4800, 'Marketing', '2022-04-15'),
('Grace', 'Costa', 7200, 'Finanças', '2021-08-10'),
('Helen', 'Rodrigues', 6300, 'Finanças', '2020-07-01'),
('Janaina', 'Oliveira', 5100, 'RH', '2021-09-05'),
('Jack', 'Barbosa', 5800, 'Marketing', '2019-01-10'),
('Karen', 'Nunes', 6100, 'Engenharia', '2023-05-01'),
('Helen', 'Oliveira', 6500, 'Finanças', '2022-02-01'),
('Mallory', 'Almeida', 5200, 'RH', '2019-10-15'),
('Nina', 'Pereira', 6900, 'Engenharia', '2021-12-01'),
('Oscar', 'Oliveira', 5700, 'Marketing', '2020-06-30'),
('Paul', 'Siqueira', 7400, 'Finanças', '2021-04-15'),
('Quincy', 'Teixeira', 5300, 'RH', '2019-09-20'),
('Rita', 'Moreira', 5600, 'Marketing', '2017-10-15'),
('Steve', 'Moraes', 7800, 'Engenharia', '2021-07-25'),
('Keila', 'Sousa', 6400, 'Finanças', '2022-03-01');


# Use SQL para responder às perguntas abaixo:

# 1- Quem são os funcionários do departamento de Engenharia? Retorne nome e sobrenome.
# 2- Quais funcionários foram contratados em 2021 ou depois? Retorne nome, sobrenome e data_contratacao.
# 3- Quais funcionários recebem salário entre 5000 e 6000? Retorne nome, sobrenome, salario e departamento.
# 4- Quais funcionários têm nome começando com a letra J ou com a letra B? Retorne nome, sobrenome e departamento.
# 5- Há algum funcionário cujo sobrenome tenha as letras 've', seja do departamento de Marketing e o salário seja maior do que 5500?







