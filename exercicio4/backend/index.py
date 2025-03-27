# importando bibliotecas
from flask import Flask, jsonify
from flask_cors import CORS
import pandas as pd

# iniciando servidor
app = Flask(__name__)

app.config.from_object(__name__)

CORS(app, resources={r"/*":{'origins':"*"}})

# importando dataframe
dataFrame = pd.read_csv("https://dadosabertos.ans.gov.br/FTP/PDA/operadoras_de_plano_de_saude_ativas/Relatorio_cadop.csv", sep = ';', encoding= 'utf-8')

# criando rota inicial
@app.route('/api/dados', methods=['GET'])
def all_medicina():
      json_str = dataFrame.to_json(orient='records', indent=1, force_ascii=False)
      return json_str

# criando rota de busca por id
@app.route('/api/dados/<int:id>', methods=['GET'])
def get_dado_por_id(id):
    try:
        # Verificar se o ID existe no DataFrame
        if id < 0 or id >= len(dataFrame):
            return jsonify({'erro': 'Registro não encontrado'}), 404      
        # Pegar o registro específico
        registro = dataFrame.iloc[id]
        json_str = registro.to_json(orient='records', indent=2, force_ascii=False)
        return json_str
    except Exception as e:
        return jsonify({'erro': str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True, port=5000)