# Projeto - Processo ETL Para Database Analytics com Docker e DuckDB
# ETL

# Imports
import os
import sys
import duckdb
import pandas as pd
from pathlib import Path

# Diretórios
database_directory = os.path.join("dados", "database")
source_directory = os.path.join("dados", "fonte")

# Função de extração de dados
def dsa_extrai_dados(dataset_path):
    try:
        covid = pd.read_csv(dataset_path)
        return covid
    except FileNotFoundError:
        print("Arquivo Não Encontrado.")
    except pd.errors.EmptyDataError:
        print("Dados Não Encontrados")
    except pd.errors.ParserError:
        print("Erro de Parse")
    return None

# Função de transformação de dados
def dsa_transforma_dados(df_list, statename):

    covid = pd.concat(df_list, ignore_index=True)

    if 'state' in covid.columns:
        covid = covid[covid['state'] == statename].copy()
    else:
        print(f"Coluna com nome do estado não encontrada no dataset.")
        return pd.DataFrame()

    if 'cases' not in covid.columns or 'deaths' not in covid.columns:
        print(f"Coluna 'cases' ou 'deaths' não encontrada nos dados.")
        return pd.DataFrame()  

    # Seleciona somente as colunas necessárias e filtra por casos acima de 1000
    covid = covid[['date', 'county', 'state', 'cases', 'deaths']]
    covid = covid[covid['cases'] > 1000]

    return covid

# Função de carga de dados
def dsa_carrega_dados(data, name, duckdb_con):
    
    # Remove espaços do nome que será usado para criar a tabela
    name = name.replace(" ", "")
    
    # Conecta ao banco de dados e deleta a tabela, se existir
    duckdb_con.execute(f"DROP TABLE IF EXISTS {name}")
    
    # Cria a tabela a partir do dataframe
    duckdb_con.from_df(data).create(name)

# Função para executar o processo ETL
def dsa_executa_etl(statename):
    try:
        print(f"\nExecutando ETL Para o Estado ::: {statename}")
        
        # Extraindo os dados
        covid2020 = dsa_extrai_dados(os.path.join(source_directory, "us-2020.csv"))
        covid2021 = dsa_extrai_dados(os.path.join(source_directory, "us-2021.csv"))
        covid2022 = dsa_extrai_dados(os.path.join(source_directory, "us-2022.csv"))
        covid2023 = dsa_extrai_dados(os.path.join(source_directory, "us-2023.csv"))
        print("Extração Concluída.")
        
        if any(df is None for df in [covid2020, covid2021, covid2022, covid2023]):
            print("Pelo menos um dataset não pode ser encontrado. Encerrando o processamento.")
            return

        # Transformando os dados
        covid = dsa_transforma_dados([covid2020, covid2021, covid2022, covid2023], statename)
        print("Transformação Concluída.")
        
        if covid.empty:
            print(f"Dataframe resultante está vazio para o estado {statename}.")
            return
        
        # Carregando o dataset
        Path(database_directory).mkdir(parents = True, exist_ok = True)
        duckdb_file_path = os.path.join(database_directory, "dbcovid.duckdb")
        duckdb_con = duckdb.connect(duckdb_file_path)
        
        dsa_carrega_dados(covid, statename, duckdb_con)
        print(f"Carga de Dados Concluída.")

    except Exception as e:
        print(e, file = sys.stderr)

# Bloco principal
if __name__ == "__main__":

    print(f"\nIniciando o Processo ETL...")

    # Listas de estados dos EUA
    state_names = [
        "Alaska", "Alabama", "Arkansas", "American Samoa", "Arizona", "California", 
        "Colorado", "Connecticut", "District of Columbia", "Delaware", "Florida", 
        "Georgia", "Guam", "Hawaii", "Iowa", "Idaho", "Illinois", "Indiana", "Kansas", 
        "Kentucky", "Louisiana", "Massachusetts", "Maryland", "Maine", "Michigan", 
        "Minnesota", "Missouri", "Mississippi", "Montana", "North Carolina", 
        "North Dakota", "Nebraska", "New Hampshire", "New Jersey", "New Mexico", 
        "Nevada", "New York", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", 
        "Puerto Rico", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", 
        "Texas", "Utah", "Virginia", "Virgin Islands", "Vermont", "Washington", 
        "Wisconsin", "West Virginia", "Wyoming"]

    # Loop para executar o processo ETL para cada estado
    for state in state_names:
        dsa_executa_etl(state)

    print(f"\nProcesso ETL Concluído com Sucesso!\n")

