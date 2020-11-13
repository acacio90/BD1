DROP DATABASE IF EXISTS base;
CREATE DATABASE base;
USE base;

CREATE TABLE POSTO_DE_SAUDE(
    id_posto INTEGER,
    nome_posto VARCHAR(30),
	endereco_posto INTEGER UNIQUE,
    numero INTEGER,
    PRIMARY KEY (id_posto)
);

CREATE TABLE ENDERECO(
    uf VARCHAR(2),
    cidade VARCHAR(15),
    bairro VARCHAR(20),
    logradouro VARCHAR(50),
    numero INTEGER,
    id_posto INTEGER,
    FOREIGN KEY (id_posto) REFERENCES POSTO_DE_SAUDE (id_posto)
);

CREATE TABLE PROFISSAO(
    id_profissao INTEGER,
    nome_profissao DATE,
	quantidade_profissionais INTEGER,
    PRIMARY KEY (id_profissao)
);

CREATE TABLE CAMPANHA(
    id_campanha INTEGER,
    data_campanha DATE,
	quantidade_vacinados INTEGER,
	profissao INTEGER UNIQUE,
    local_campanha INTEGER,
    PRIMARY KEY (id_campanha),
	FOREIGN KEY (profissao) REFERENCES PROFISSAO (id_profissao),
    FOREIGN KEY (local_campanha) REFERENCES POSTO_DE_SAUDE (id_posto)
);

CREATE TABLE LOTE(
    id_lote INTEGER,
    quantidade_vacinas INTEGER,
	data_fabricacao DATE,
    id_campanha INTEGER,
    FOREIGN KEY (id_campanha) REFERENCES CAMPANHA (id_campanha),
    PRIMARY KEY (id_lote)
);

CREATE TABLE VACINA(
    id_vacina INTEGER,
    nome_vacina VARCHAR(30),
	laboratorio VARCHAR(30),
    lote INTEGER NOT NULL,
    PRIMARY KEY (id_vacina),
	FOREIGN KEY (lote) REFERENCES LOTE (id_lote)
);

CREATE TABLE CARTEIRA_DE_VACINACAO(
    id_carteira INTEGER,
    tipo_sanguineo VARCHAR(1),
	intolerancia INTEGER,
    PRIMARY KEY (id_carteira)
);

CREATE TABLE PESSOA(
    cpf_pessoa INTEGER,
    nome_pessoa VARCHAR(50),
	data_nascimento DATE,
    sexo_pessoa VARCHAR(1),
    carteira_de_vacinacao INTEGER,
	profissao INTEGER,
    PRIMARY KEY (cpf_pessoa),
	FOREIGN KEY (profissao) REFERENCES PROFISSAO (id_profissao),
    FOREIGN KEY (carteira_de_vacinacao) REFERENCES CARTEIRA_DE_VACINACAO (id_carteira)
);

CREATE TABLE PROFISSAO_PESSOA(
	id_profissao INTEGER,
    cpf_pessoa INTEGER,
    FOREIGN KEY (id_profissao) REFERENCES PROFISSAO (id_profissao),
    FOREIGN KEY (cpf_pessoa) REFERENCES PESSOA (cpf_pessoa),
    PRIMARY KEY (id_profissao, cpf_pessoa)
);

CREATE TABLE ENFERMEIRO(
	coren INTEGER UNIQUE,
	especialidade_enfermeiro VARCHAR(20),
    cpf_pessoa INTEGER,
	horario_enfermeiro TIME,
	salario_enfermeiro DECIMAL(10,2),
	telefone_enfermeiro VARCHAR(14),
	PRIMARY KEY (cpf_pessoa),
	FOREIGN KEY (cpf_pessoa) REFERENCES PESSOA (cpf_pessoa)
);

CREATE TABLE PACIENTE(
    id_paciente INTEGER UNIQUE,
    telefone_paciente VARCHAR(14),
	pessoa_paciente INTEGER,
    data_aplicacao DATE,
    PRIMARY KEY (pessoa_paciente),
	FOREIGN KEY (pessoa_paciente) REFERENCES PESSOA (cpf_pessoa)
);

CREATE TABLE APLICACAO(
    id_aplicacao INTEGER,
    data_aplicacao DATE,
	hora_aplicacao TIME,
	enfermeiro_aplicacao INTEGER,
	vacina_aplicacao INTEGER UNIQUE,
	paciente_aplicacao INTEGER,
    PRIMARY KEY (id_aplicacao),
	FOREIGN KEY (enfermeiro_aplicacao) REFERENCES ENFERMEIRO (cpf_pessoa),
	FOREIGN KEY (vacina_aplicacao) REFERENCES VACINA (id_vacina),
	FOREIGN KEY (paciente_aplicacao) REFERENCES PACIENTE (id_paciente)
);

CREATE TABLE VACINAS_RECEBIDAS(
    id_vacinas_recebidas INTEGER,
    nome_doenca VARCHAR(30),
	dose INTEGER,
	data_aplicao DATE,
	carteira INTEGER,
    PRIMARY KEY (id_vacinas_recebidas),
	FOREIGN KEY (carteira) REFERENCES CARTEIRA_DE_VACINACAO (id_carteira)
);

CREATE TABLE CARTEIRA_DE_VACINACAO_VACINAS_RECEBIDAS(
	id_vacinas_recebidas INTEGER,
    id_carteira INTEGER,
    FOREIGN KEY (id_vacinas_recebidas) REFERENCES VACINAS_RECEBIDAS (id_vacinas_recebidas),
    FOREIGN KEY (id_carteira) REFERENCES CARTEIRA_DE_VACINACAO (id_carteira),
    PRIMARY KEY (id_vacinas_recebidas, id_carteira)
);