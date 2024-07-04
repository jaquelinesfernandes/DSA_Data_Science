# DSA - Database Analytics com DuckDB 

# Imports
import duckdb
import os

# Nome do arquivo do banco de dados
db_file = 'universidade.db'

# Deleta o banco de dados existente, se existir
if os.path.exists(db_file):
    os.remove(db_file)

# Cria um banco de dados DuckDB 
con = duckdb.connect(database='universidade.db')

# Cria tabelas de estudantes, cursos e matrículas

con.execute('''
    CREATE TABLE IF NOT EXISTS estudantes (
        estudante_id INTEGER PRIMARY KEY,
        nome VARCHAR,
        idade INTEGER
    );
''')

con.execute('''
    CREATE TABLE IF NOT EXISTS cursos (
        curso_id INTEGER PRIMARY KEY,
        nome VARCHAR,
        departamento VARCHAR
    );
''')

con.execute('''
    CREATE TABLE IF NOT EXISTS matriculas (
        matricula_id INTEGER PRIMARY KEY,
        estudante_id INTEGER,
        curso_id INTEGER,
        nota FLOAT,
        FOREIGN KEY (estudante_id) REFERENCES estudantes(estudante_id),
        FOREIGN KEY (curso_id) REFERENCES cursos(curso_id)
    );
''')

# Insere dados nas tabelas
con.execute("INSERT INTO estudantes VALUES (1, 'Teresa', 22), (2, 'Josias', 23), (3, 'Carolina', 21);")
con.execute("INSERT INTO cursos VALUES (1, 'Matemática', 'Ciências Exatas'), (2, 'História', 'Ciências Humanas');")
con.execute("INSERT INTO matriculas VALUES (1, 1, 1, 8.5), (2, 1, 2, 9.0), (3, 2, 1, 7.0), (4, 3, 2, 6.5);")

# Cria índice na tabela de matrículas para otimizar consultas por estudante_id
con.execute("CREATE INDEX IF NOT EXISTS idx_estudante_id ON matriculas(estudante_id);")

# Calcula a média e o desvio padrão das notas por curso
query = '''
    SELECT 
        c.nome AS Curso,
        AVG(m.nota) AS Media_Notas, 
        ROUND(STDDEV(m.nota),2) AS Desvio_Padrao_Notas
    FROM matriculas m
    JOIN cursos c ON m.curso_id = c.curso_id
    GROUP BY c.nome
'''

# Executa a query e armazena o resultado
resultado = con.execute(query).fetchall()

# Imprime o resultado
for row in resultado:
    print(f"\nCurso: {row[0]}, Média das Notas: {row[1]}, Desvio Padrão das Notas: {row[2]}")

# Calcula a média e o desvio padrão das notas por estudante
query = '''
    SELECT 
        e.nome AS Estudante,
        AVG(m.nota) AS Media_Notas, 
        ROUND(STDDEV(m.nota),2) AS Desvio_Padrao_Notas
    FROM matriculas m
    JOIN estudantes e ON m.estudante_id = e.estudante_id
    GROUP BY e.nome
'''

# Executa a query e armazena o resultado
resultado = con.execute(query).fetchall()

# Imprime o resultado
for row in resultado:
    print(f"\nEstudante: {row[0]}, Média das Notas: {row[1]}, Desvio Padrão das Notas: {row[2]}")

print("\n")


