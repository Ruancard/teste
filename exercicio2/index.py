# importando bibliotecas
import tabula
import pandas as pd
from zipfile import ZipFile

# importando tabela do exercicio1
lista_tabelas = tabula.read_pdf('./exercicio1/anexos/AnexoI.pdf', pages='all')
df = pd.concat(lista_tabelas)

# tratando tabela
tabela = (df[['PROCEDIMENTO', 'RN\r(alteração)', 'VIGÊNCIA', 'OD', 'AMB', 'HCO', 'HSO', 'REF', 'PAC',  'DUT', 'SUBGRUPO', 'GRUPO', 'CAPÍTULO']])
tabela = tabela.rename(columns={'OD':'Seg. Odontológica', 'AMB':'Seg. Ambulatorial'})
tabela.dropna(subset=['PROCEDIMENTO'], inplace=True)

# fazendo download da tabela em csv
tabela.to_csv('./exercicio2/tabela.csv', index=False)

# compactando arquivo da tabela
with ZipFile("./exercicio2/Teste_Ruan_Cardoso.zip", 'w') as zip:
     zip.write("./exercicio2/tabela.csv", arcname='tabela.csv')