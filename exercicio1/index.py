# importando bibliotecas
import requests
from bs4 import BeautifulSoup
import wget
from zipfile import ZipFile, ZIP_DEFLATED
import pathlib
import os

# variaveis globais
caminho = "./exercicio1/anexos/"
anexos = []
link = "https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos"

# excluindo arquivos defasados
arquivos = os.listdir(caminho)
for arquivo in arquivos:
     file_path = os.path.join(caminho, arquivo)
     if os.path.isfile(file_path):
          os.remove(file_path)

# acessando site
requisicao = requests.get(link)
site = BeautifulSoup(requisicao.text, "html.parser")

# encontrando os links dos arquivos e armazenando
a1 = site.find_all("a", class_="internal-link")
for i in a1:
     if (i['href'][-4:]) == '.pdf' and (i.text[:5]) == 'Anexo':
          anexos.append(i)

# baixando os arquivos
for i in anexos:
     filename = (i.text.replace(" ", ""))
     filename = (filename.replace(".", ""))
     filename = (filename + ".pdf")
     filename = (caminho+filename)
     wget.download(i['href'], filename)

# compactando arquivos
folder = pathlib.Path(caminho)
with ZipFile('./exercicio1/anexos.zip', "w", ZIP_DEFLATED) as zip:
     for file in folder.iterdir():
          zip.write(file, arcname=file.name)