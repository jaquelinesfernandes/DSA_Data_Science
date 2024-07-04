# DSA - Database Analytics com DuckDB 

# Imports
import duckdb
import pandas as pd

# DataFrame de clientes
dados_dsa_clientes = {
    'ClienteID': [1, 2, 3, 4, 5],
    'Nome': ['Aline', 'Bruno', 'Carlos', 'Diana', 'Eduardo'],
    'Email': ['alice@teste.com', 'bruno@teste.com', 'carlos@teste.com', 'diana@teste.com', 'eduardo@teste.com']
}

df_clientes = pd.DataFrame(dados_dsa_clientes)

# DataFrame de pedidos
dados_dsa_pedidos = {
    'PedidoID': [101, 102, 103, 104, 105, 106],
    'ClienteID': [1, 1, 5, 4, 5, 4],
    'Produto': ['Produto A', 'Produto B', 'Produto C', 'Produto D', 'Produto E', 'Produto F'],
    'Valor': [150.00, 200.00, 250.00, 150.00, 300.00, 350.00]
}

df_pedidos = pd.DataFrame(dados_dsa_pedidos)

# Query com DuckDB
query = '''
    SELECT 
        c.Nome,
        MAX(p.Valor) AS Valor_Maximo,
        MIN(p.Valor) AS Valor_Minimo,
        AVG(p.Valor) AS Valor_Medio
    FROM df_clientes c 
    JOIN df_pedidos p 
    ON c.ClienteID = p.ClienteID
    GROUP BY c.Nome
'''

# Resultado
resultado = duckdb.sql(query).df()

print(resultado)
