# Projeto - Processo ETL Para Database Analytics com Docker e DuckDB
# Relatório

# Imports
import duckdb
import os
import pandas as pd

# Diretório do banco de dados
database_directory = os.path.join("dados", "database")
duckdb_file_path = os.path.join(database_directory, "dbcovid.duckdb")
output_directory = os.path.join(database_directory)

# Função para gerar o relatório com a média de casos e mortes por mês e por estado
def dsa_gera_relatorio(duckdb_con, state_name):

    try:

        # Query para calcular a média de casos e mortes por mês
        query = f"""
        SELECT 
            strftime(CAST(date AS DATE), '%Y-%m') AS Mes,
            ROUND(AVG(cases),2) AS Media_Casos,
            ROUND(AVG(deaths),2) AS Media_Mortes
        FROM "{state_name.replace(' ', '')}"
        GROUP BY Mes
        ORDER BY Mes
        """

        # Executa a query
        resultado = duckdb_con.execute(query).fetchdf()

        # Salva o resultado em CSV
        csv_path = os.path.join(output_directory, f"{state_name.replace(' ', '_')}_media_casos_mortes.csv")
        resultado.to_csv(csv_path, index=False)
        
        # Retorna o resultado como um DataFrame
        return resultado

    except Exception as e:
        print(f"Erro ao consultar dados para o estado {state_name}: {e}")
        return pd.DataFrame()

# Conecta ao banco de dados DuckDB salvo em disco
duckdb_con = duckdb.connect(duckdb_file_path)

# Estados a serem consultados
state_names = ["California", "Florida"]

# Consulta dados para cada estado na lista e imprime os resultados
for state in state_names:
    print(f"\nMédia de Casos e Mortes Por Mês (entre 2020 e 2023) Para o Estado {state}:\n")
    resultado = dsa_gera_relatorio(duckdb_con, state)
    print(resultado)
    print("\n" + "="*50 + "\n")





