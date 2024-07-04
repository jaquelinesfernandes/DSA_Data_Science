# DSA - Database Analytics com DuckDB 

# Imports
import duckdb

# Conecta ao banco de dados DuckDB salvo em disco
con = duckdb.connect(database='dsa.db')

# Calcula a média e o desvio padrão das notas
query = '''
    SELECT 
        ROUND(AVG(nota),2) AS Media_Notas, 
        ROUND(STDDEV(nota),2) AS Desvio_Padrao_Notas
    FROM dsa_estudantes
'''

# Executa a query e armazena o resultado
resultado = con.execute(query).fetchall()

# Imprime o resultado
print("\nMédia das Notas: ", resultado[0][0])
print("Desvio Padrão das Notas: ", resultado[0][1])
print("\n")
