import os
import json
from flask import Flask, render_template, abort, url_for, json, jsonify

# App
app = Flask(__name__,template_folder='.')

# Carrega o arquivo
with open('arquivo.json', 'r') as arquivo_json:
    dados = arquivo_json.read()

# Rota
@app.route("/")
def index():
    return render_template('index.html', title = "Lab5", jsonfile = json.dumps(dados))

# Executa o programa
if __name__ == '__main__':
    app.run(debug=True)