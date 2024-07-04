# DSA - Database Analytics com DuckDB 

# Imports
import duckdb

# Conecta ao banco de dados DuckDB em memória
con = duckdb.connect(database=':memory:')

# Cria uma tabela chamada 'dsa_estudantes' com colunas 'nome' e 'nota'
con.execute("CREATE TABLE dsa_estudantes (nome VARCHAR, nota FLOAT);")

# Insere registros na tabela 
con.execute("INSERT INTO dsa_estudantes VALUES ('Tadeu', 5.5);")
con.execute("INSERT INTO dsa_estudantes VALUES ('Aline', 9.0);")
con.execute("INSERT INTO dsa_estudantes VALUES ('Maria', 8.0);")
con.execute("INSERT INTO dsa_estudantes VALUES ('Fernando', 9.5);")
con.execute("INSERT INTO dsa_estudantes VALUES ('Laura', 8.5);")
con.execute("INSERT INTO dsa_estudantes VALUES ('Gustavo', 7.0);")

# Executa uma query para selecionar todos os registros da tabela 'dsa_estudantes' e armazena o resultado
resultado = con.execute("SELECT * FROM dsa_estudantes").fetchall()
print(resultado)

# Exporta os dados da tabela 'dsa_estudantes' para um arquivo CSV chamado 'dsa_estudantes.csv'
con.execute("COPY dsa_estudantes TO 'dsa_estudantes1.csv' (HEADER, DELIMITER ',');")

# Lê os dados do arquivo CSV 'dsa_estudantes.csv', armazena e imprime o resultado
resultado = con.execute("SELECT * FROM read_csv_auto('dsa_estudantes1.csv')").fetchall()
print(resultado)
