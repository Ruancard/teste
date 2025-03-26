CREATE TABLE financeiro (
    id SERIAL PRIMARY KEY,
	data DATE,
    reg_ans VARCHAR(6),
    cd_conta_contabil VARCHAR(20),
    descricao TEXT,
    vl_saldo_inicial DECIMAL(15, 2),
    vl_saldo_final DECIMAL(15, 2)
);

CREATE TEMPORARY TABLE data_import (
    data TEXT,
    reg_ans TEXT,
    cd_conta_contabil TEXT,
    descricao TEXT,
    vl_saldo_inicial TEXT,
    vl_saldo_final TEXT
);

COPY data_import FROM 'C:\Users\ruanl\Desktop\teste\exercicio3\tabelas\2023\1T2023\1T2023.csv' WITH (FORMAT csv, DELIMITER ';', NULL '', QUOTE '"', ENCODING 'UTF8');
COPY data_import FROM 'C:\Users\ruanl\Desktop\teste\exercicio3\tabelas\2023\2T2023\2t2023.csv' WITH (FORMAT csv, DELIMITER ';', NULL '', QUOTE '"', ENCODING 'UTF8');
COPY data_import FROM 'C:\Users\ruanl\Desktop\teste\exercicio3\tabelas\2023\3T2023\3T2023.csv' WITH (FORMAT csv, DELIMITER ';', NULL '', QUOTE '"', ENCODING 'UTF8');
COPY data_import FROM 'C:\Users\ruanl\Desktop\teste\exercicio3\tabelas\2023\4T2023\4T2023.csv' WITH (FORMAT csv, DELIMITER ';', NULL '', QUOTE '"', ENCODING 'UTF8');
COPY data_import FROM 'C:\Users\ruanl\Desktop\teste\exercicio3\tabelas\2024\1T2024\1T2024.csv' WITH (FORMAT csv, DELIMITER ';', NULL '', QUOTE '"', ENCODING 'UTF8');
COPY data_import FROM 'C:\Users\ruanl\Desktop\teste\exercicio3\tabelas\2024\2T2024\2T2024.csv' WITH (FORMAT csv, DELIMITER ';', NULL '', QUOTE '"', ENCODING 'UTF8');
COPY data_import FROM 'C:\Users\ruanl\Desktop\teste\exercicio3\tabelas\2024\3T2024\3T2024.csv' WITH (FORMAT csv, DELIMITER ';', NULL '', QUOTE '"', ENCODING 'UTF8');
COPY data_import FROM 'C:\Users\ruanl\Desktop\teste\exercicio3\tabelas\2024\4T2024\4T2024.csv' WITH (FORMAT csv, DELIMITER ';', NULL '', QUOTE '"', ENCODING 'UTF8');

DELETE FROM data_import WHERE data = 'DATA';

INSERT INTO financeiro
(data,
    reg_ans,
    cd_conta_contabil,
    descricao,
    vl_saldo_inicial,
    vl_saldo_final)
SELECT 
    data::date,
    reg_ans,
    cd_conta_contabil,
    descricao,
	REPLACE(vl_saldo_inicial, ',', '.')::DECIMAL(15,2),
    REPLACE(vl_saldo_final, ',', '.')::DECIMAL(15,2)
FROM data_import;

DROP TABLE data_import;

CREATE TABLE relatorio (
    registro_ans VARCHAR(20) PRIMARY KEY,
    cnpj VARCHAR(14),
    razao_social VARCHAR(255),
    nome_Fantasia VARCHAR(255),
    modalidade VARCHAR(100),
    logradouro VARCHAR(255),
    numero VARCHAR(20),
    complemento VARCHAR(100),
    bairro VARCHAR(100),
    cidade VARCHAR(100),
    uf VARCHAR(2),
    cep VARCHAR(8),
    ddd VARCHAR(3),
    telefone VARCHAR(20),
    fax VARCHAR(20),
    endereco_eletronico VARCHAR(255),
    representante VARCHAR(255),
    cargo_representante VARCHAR(100),
    regiao_de_comercializacao VARCHAR(255),
    data_registro_ans DATE
);

CREATE TEMPORARY TABLE data_import (
    registro_ans VARCHAR(20) PRIMARY KEY,
    cnpj VARCHAR(14),
    razao_social VARCHAR(255),
    nome_Fantasia VARCHAR(255),
    modalidade VARCHAR(100),
    logradouro VARCHAR(255),
    numero VARCHAR(20),
    complemento VARCHAR(100),
    bairro VARCHAR(100),
    cidade VARCHAR(100),
    uf VARCHAR(2),
    cep VARCHAR(8),
    ddd VARCHAR(3),
    telefone VARCHAR(20),
    fax VARCHAR(20),
    endereco_eletronico VARCHAR(255),
    representante VARCHAR(255),
    cargo_Representante VARCHAR(100),
    regiao_de_Comercializacao VARCHAR(255),
    data_registro_ans TEXT
);

COPY data_import FROM PROGRAM 'curl "https://dadosabertos.ans.gov.br/FTP/PDA/operadoras_de_plano_de_saude_ativas/Relatorio_cadop.csv"' WITH (FORMAT csv, DELIMITER ';', NULL '', QUOTE '"', ENCODING 'UTF8');

DELETE FROM data_import WHERE registro_ans = 'Registro_ANS';

INSERT INTO relatorio
(registro_ans,
	cnpj,
	razao_social,
	nome_fantasia,
	modalidade,
    logradouro,
	numero,
	complemento,
	bairro,
	cidade,
	uf,
	cep,
    ddd,
	telefone,
	fax,
	endereco_eletronico,
	representante,
    cargo_representante,
	regiao_de_comercializacao,
	data_registro_ans)
SELECT 
   	registro_ans,
	cnpj,
	razao_social,
	nome_fantasia,
	modalidade,
    logradouro,
	numero,
	complemento,
	bairro,
	cidade,
	uf,
	cep,
    ddd,
	telefone,
	fax,
	endereco_eletronico,
	representante,
    cargo_representante,
	regiao_de_comercializacao,
	data_registro_ans::date
FROM data_import;

DROP TABLE data_import;
