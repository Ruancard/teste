<!-- criando html da pagina -->
<template>
  <div class="app">
    <h1>Consulta de Dados</h1>
    
    <div v-if="loading">Carregando...</div>
    <div v-else-if="error" class="error">{{ error }}</div>
    <div v-else class="principal">
      <div class="lista">
        <div class="filter-container">
          <label for="cnpjFilter">Filtrar por CNPJ:</label>
          <input
            id="cnpjFilter"
            v-model="cnpjFilter"
            type="text"
            placeholder="Digite parte do CNPJ"
            @input="applyFilter"
          />
        </div>
        <h2>Registros</h2>

        <ul>
          <li v-for="item in filteredData" :key="item.CNPJ">
            {{ formatCNPJ(item.CNPJ) }} - {{ item.Razao_Social }}
            <button @click="detalhes(item)">Detalhes</button>
          </li>
        </ul>
      </div>
      
      <div v-if="registroSelecionado" class="detalhes">
        <h2>Detalhes do Registro</h2>
        <p><strong>Registro:</strong> {{ registroSelecionado[0] }}</p>
        <p><strong>CNPJ:</strong> {{ formatCNPJ(registroSelecionado[1]) }}</p>
        <p><strong>Razao Social:</strong> {{ registroSelecionado[2] }}</p>
        <p><strong>Nome Fantasia:</strong> {{ registroSelecionado[3] }}</p>
        <p><strong>Modalidade:</strong> {{ registroSelecionado[4] }}</p>
        <p><strong>Logradouro:</strong> {{ registroSelecionado[5] }}</p>
        <p><strong>Numero:</strong> {{ registroSelecionado[6] }}</p>
        <p><strong>Complemento:</strong> {{ registroSelecionado[7] }}</p>
        <p><strong>Bairro:</strong> {{ registroSelecionado[8] }}</p>
        <p><strong>Cidade:</strong> {{ registroSelecionado[9] }}</p>
        <p><strong>UF:</strong> {{ registroSelecionado[10] }}</p>
        <p><strong>CEP:</strong> {{ registroSelecionado[11] }}</p>
        <p><strong>Telefone:</strong> ({{ registroSelecionado[12] }}) {{ registroSelecionado[13] }}</p>
        <p><strong>Fax:</strong> {{ registroSelecionado[14] }}</p>
        <p><strong>Endereco eletronico:</strong> {{ registroSelecionado[15] }}</p>
        <p><strong>Representante:</strong> {{ registroSelecionado[16] }}</p>
        <p><strong>Cargo Representante:</strong> {{ registroSelecionado[17] }}</p>
        <p><strong>Região de comercialização:</strong> {{ registroSelecionado[18] }}</p>
        <p><strong>Data de registro ANS:</strong> {{ registroSelecionado[19] }}</p>
      </div>
    </div>
  </div>
</template>

<script>
// importando bibliotecas
import axios from 'axios';

export default {
  // declarando variaveis de ambiente
  data() {
    return {
      dados: [],
      filteredData: [],
      loading: true,
      error: null,
      registroSelecionado: null,
      cnpjFilter: '',
      apiUrl: 'http://localhost:5000/api/dados'
    };
  },
  // importando todos os dados da api
  async created() {
    try {
      const response = await axios.get(this.apiUrl);
      this.dados = response.data;
      this.filteredData = [...this.dados];
    } catch (err) {
      this.error = 'Erro ao carregar dados: ' + err.message;
    } finally {
      this.loading = false;
    }
  },
  methods: {
    // função para mostrar detalhes do item
    async detalhes(item) {
      try {
        const response = await axios.get(`${this.apiUrl}/${this.dados.indexOf(item)}`);
        this.registroSelecionado = response.data;
      } catch (err) {
        this.error = 'Erro ao carregar detalhes: ' + err.message;
      }
    },
    // função para filtar por cnpj
    applyFilter() {
      if (!this.cnpjFilter) {
        this.filteredData = [...this.dados];
        return;
      }

      const filterText = this.cnpjFilter.replace(/\D/g, '');
      this.filteredData = this.dados.filter(item => {
        const cnpjClean = String(item.CNPJ).replace(/\D/g, '');
        return cnpjClean.includes(filterText);
      });
    },
    formatCNPJ(cnpj) {
      if (!cnpj) return '';
      const str = String(cnpj).replace(/\D/g, '').padStart(14, '0');
      return `${str.substr(0, 2)}.${str.substr(2, 3)}.${str.substr(5, 3)}/${str.substr(8, 4)}-${str.substr(12, 2)}`;
    }
  }
};
</script>

<!-- adicionando os estilos a pagina -->
<style>
.principal{
  display: flex;
  width: 90vw;
}
.principal div{
  width: 50vw
}
.app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  max-width: 800px;
  margin: 0 auto;
  padding: 20px;
}
ul {
  list-style: none;
  padding: 0;
}
li {
  padding: 10px;
  margin: 5px 0;
  background: #f0f0f0;
  display: flex;
  justify-content: space-between;
  align-items: center;
}
button {
  background: #42b983;
  color: white;
  border: none;
  padding: 5px 10px;
  border-radius: 3px;
  cursor: pointer;
}
button:hover {
  background: #369f6b;
}
.detalhes {
  margin-top: 20px;
  padding: 15px;
  background: #f8f8f8;
  border: 4px solid #42b983;
  height: fit-content;
}
.error {
  color: #ff4444;
}
.filter-container {
  margin-bottom: 20px;
}
.filter-container input {
  padding: 8px;
  margin-left: 10px;
  width: 300px;
}
</style>