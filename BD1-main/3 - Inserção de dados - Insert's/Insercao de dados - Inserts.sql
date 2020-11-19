DROP DATABASE IF EXISTS base;
CREATE DATABASE base;
USE base;

CREATE TABLE POSTO_DE_SAUDE(
    id_posto INTEGER,
    nome_posto VARCHAR(70),
    telefone VARCHAR(14),
    PRIMARY KEY (id_posto)
);

CREATE TABLE ENDERECO(
    uf VARCHAR(2),
    cidade VARCHAR(15),
    bairro VARCHAR(40),
    logradouro VARCHAR(50),
    numero INTEGER,
    id_posto INTEGER,
    FOREIGN KEY (id_posto) REFERENCES POSTO_DE_SAUDE (id_posto)
);

CREATE TABLE PROFISSAO(
    id_profissao INTEGER,
    nome_profissao VARCHAR(30),
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
    tipo_sanguineo VARCHAR(3),
	intolerancia VARCHAR(50),
    PRIMARY KEY (id_carteira)
);

CREATE TABLE PESSOA(
    cpf_pessoa VARCHAR(15),
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
    cpf_pessoa VARCHAR(15),
    FOREIGN KEY (id_profissao) REFERENCES PROFISSAO (id_profissao),
    FOREIGN KEY (cpf_pessoa) REFERENCES PESSOA (cpf_pessoa),
    PRIMARY KEY (id_profissao, cpf_pessoa)
);

CREATE TABLE ENFERMEIRO(
	coren INTEGER UNIQUE,
	especialidade_enfermeiro VARCHAR(20),
    cpf_pessoa VARCHAR(15),
	horario_enfermeiro TIME,
	salario_enfermeiro DECIMAL(10,2),
	telefone_enfermeiro VARCHAR(14),
	PRIMARY KEY (cpf_pessoa),
	FOREIGN KEY (cpf_pessoa) REFERENCES PESSOA (cpf_pessoa)
);

CREATE TABLE PACIENTE(
    id_paciente INTEGER UNIQUE,
    telefone_paciente VARCHAR(14),
	pessoa_paciente VARCHAR(15),
    data_aplicacao DATE,
    PRIMARY KEY (pessoa_paciente),
	FOREIGN KEY (pessoa_paciente) REFERENCES PESSOA (cpf_pessoa)
);

CREATE TABLE APLICACAO(
    id_aplicacao INTEGER,
    data_aplicacao DATE,
	hora_aplicacao TIME,
	enfermeiro_aplicacao VARCHAR(15),
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
	data_aplicacao DATE,
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

INSERT INTO POSTO_DE_SAUDE (id_posto, nome_posto, telefone) VALUES ('1', 'UBS Vila Romana', '1136720911');
INSERT INTO POSTO_DE_SAUDE (id_posto, nome_posto, telefone) VALUES ('2', 'UBS Dr. Paulo Mangabeira Albernaz Filho', '1137582329');
INSERT INTO POSTO_DE_SAUDE (id_posto, nome_posto, telefone) VALUES ('3', 'UBS Nossa Senhora do Brasil Doutor Armando DArienzo', '1150817638');
INSERT INTO POSTO_DE_SAUDE (id_posto, nome_posto, telefone) VALUES ('4', 'Posto de Saúde Santa Cruz', '1136720911');
INSERT INTO POSTO_DE_SAUDE (id_posto, nome_posto, telefone) VALUES ('5', 'UBS Jardim Umuarama', '1155639070');
INSERT INTO POSTO_DE_SAUDE (id_posto, nome_posto, telefone) VALUES ('6', 'UBS Sigmund Freud', '1136532329');
INSERT INTO POSTO_DE_SAUDE (id_posto, nome_posto, telefone) VALUES ('7', 'UBS Dr. Victor Araújo Homem de Mello Pinheiros', '1130317763');
INSERT INTO POSTO_DE_SAUDE (id_posto, nome_posto, telefone) VALUES ('8', 'UBS Zumbi dos Palmares', '1137771350');
INSERT INTO POSTO_DE_SAUDE (id_posto, nome_posto, telefone) VALUES ('9', 'UBS Max Perlman', '1138425146');
INSERT INTO POSTO_DE_SAUDE (id_posto, nome_posto, telefone) VALUES ('10', 'UBS Chácara Santo Antônio', '1151836139');

INSERT INTO ENDERECO (uf, cidade, bairro, logradouro, numero, id_posto) VALUES ('SP', 'São Paulo', 'Vila Romana', 'R. Vespasiano', '679', '1');
INSERT INTO ENDERECO (uf, cidade, bairro, logradouro, numero, id_posto) VALUES ('SP', 'São Paulo', 'Real Parque', 'Av. Barão do Melgaço', '339', '2');
INSERT INTO ENDERECO (uf, cidade, bairro, logradouro, numero, id_posto) VALUES ('SP', 'São Paulo', 'Bela Vista', 'R. Alm. Marques de Leão', '684', '3');
INSERT INTO ENDERECO (uf, cidade, bairro, logradouro, numero, id_posto) VALUES ('SP', 'São Paulo', 'Vila Mariana', 'R. Santa Cruz', '1191', '4');
INSERT INTO ENDERECO (uf, cidade, bairro, logradouro, numero, id_posto) VALUES ('SP', 'São Paulo', 'Vila Filomena', 'R. Antônio Gil', '721', '5');
INSERT INTO ENDERECO (uf, cidade, bairro, logradouro, numero, id_posto) VALUES ('SP', 'São Paulo', 'Moema', 'Av. Indianópolis', '650', '6');
INSERT INTO ENDERECO (uf, cidade, bairro, logradouro, numero, id_posto) VALUES ('SP', 'São Paulo', 'Pinheiros', 'R. Ferreira de Araújo', '789', '7');
INSERT INTO ENDERECO (uf, cidade, bairro, logradouro, numero, id_posto) VALUES ('SP', 'São Paulo', 'Jardim Sao Luiz', 'R. Humberto de Almeida', '08', '8');
INSERT INTO ENDERECO (uf, cidade, bairro, logradouro, numero, id_posto) VALUES ('SP', 'São Paulo', 'Vila Nova Conceição', 'R. Jaques Félix', '499', '9');
INSERT INTO ENDERECO (uf, cidade, bairro, logradouro, numero, id_posto) VALUES ('SP', 'São Paulo', 'Chácara Santo Antônio', 'Rua Alexandre Dumas', '719', '10');

INSERT INTO PROFISSAO (id_profissao, nome_profissao, quantidade_profissionais) VALUES ('1', 'Pedreiro', '1');
INSERT INTO PROFISSAO (id_profissao, nome_profissao, quantidade_profissionais) VALUES ('2', 'Enfermeiro', '1');
INSERT INTO PROFISSAO (id_profissao, nome_profissao, quantidade_profissionais) VALUES ('3', 'Padeiro', '1');
INSERT INTO PROFISSAO (id_profissao, nome_profissao, quantidade_profissionais) VALUES ('4', 'Professor', '1');
INSERT INTO PROFISSAO (id_profissao, nome_profissao, quantidade_profissionais) VALUES ('5', 'Médico', '1');
INSERT INTO PROFISSAO (id_profissao, nome_profissao, quantidade_profissionais) VALUES ('6', 'Policial', '1');
INSERT INTO PROFISSAO (id_profissao, nome_profissao, quantidade_profissionais) VALUES ('7', 'Bombeiro', '1');
INSERT INTO PROFISSAO (id_profissao, nome_profissao, quantidade_profissionais) VALUES ('8', 'Lojista', '1');
INSERT INTO PROFISSAO (id_profissao, nome_profissao, quantidade_profissionais) VALUES ('9', 'Samu', '1');
INSERT INTO PROFISSAO (id_profissao, nome_profissao, quantidade_profissionais) VALUES ('10', 'Motorista', '1');

INSERT INTO CAMPANHA (id_campanha, data_campanha, quantidade_vacinados, profissao, local_campanha) VALUES ('1', '2020-09-13', '1', '1', '1');
INSERT INTO CAMPANHA (id_campanha, data_campanha, quantidade_vacinados, profissao, local_campanha) VALUES ('2', '2020-09-27', '1', '2', '2');
INSERT INTO CAMPANHA (id_campanha, data_campanha, quantidade_vacinados, profissao, local_campanha) VALUES ('3', '2020-10-03', '1', '3', '3');
INSERT INTO CAMPANHA (id_campanha, data_campanha, quantidade_vacinados, profissao, local_campanha) VALUES ('4', '2020-10-13', '1', '4', '4');
INSERT INTO CAMPANHA (id_campanha, data_campanha, quantidade_vacinados, profissao, local_campanha) VALUES ('5', '2020-10-25', '1', '5', '5');
INSERT INTO CAMPANHA (id_campanha, data_campanha, quantidade_vacinados, profissao, local_campanha) VALUES ('6', '2020-10-31', '1', '6', '6');
INSERT INTO CAMPANHA (id_campanha, data_campanha, quantidade_vacinados, profissao, local_campanha) VALUES ('7', '2020-11-11', '1', '7', '7');
INSERT INTO CAMPANHA (id_campanha, data_campanha, quantidade_vacinados, profissao, local_campanha) VALUES ('8', '2020-11-22', '1', '8', '8');
INSERT INTO CAMPANHA (id_campanha, data_campanha, quantidade_vacinados, profissao, local_campanha) VALUES ('9', '2020-11-29', '1', '9', '9');
INSERT INTO CAMPANHA (id_campanha, data_campanha, quantidade_vacinados, profissao, local_campanha) VALUES ('10', '2020-12-04', '1', '10', '10');

INSERT INTO LOTE (id_lote, quantidade_vacinas, data_fabricacao, id_campanha) VALUES ('1', '500', '2020-06-18', '1');
INSERT INTO LOTE (id_lote, quantidade_vacinas, data_fabricacao, id_campanha) VALUES ('2', '300', '2020-03-11', '2');
INSERT INTO LOTE (id_lote, quantidade_vacinas, data_fabricacao, id_campanha) VALUES ('3', '250', '2020-05-02', '3');
INSERT INTO LOTE (id_lote, quantidade_vacinas, data_fabricacao, id_campanha) VALUES ('4', '400', '2020-08-27', '4');
INSERT INTO LOTE (id_lote, quantidade_vacinas, data_fabricacao, id_campanha) VALUES ('5', '500', '2020-08-25', '5');
INSERT INTO LOTE (id_lote, quantidade_vacinas, data_fabricacao, id_campanha) VALUES ('6', '500', '2020-05-12', '6');
INSERT INTO LOTE (id_lote, quantidade_vacinas, data_fabricacao, id_campanha) VALUES ('7', '700', '2020-07-01', '7');
INSERT INTO LOTE (id_lote, quantidade_vacinas, data_fabricacao, id_campanha) VALUES ('8', '100', '2020-06-11', '8');
INSERT INTO LOTE (id_lote, quantidade_vacinas, data_fabricacao, id_campanha) VALUES ('9', '100', '2020-06-13', '9');
INSERT INTO LOTE (id_lote, quantidade_vacinas, data_fabricacao, id_campanha) VALUES ('10', '200', '2020-10-03', '10');

INSERT INTO VACINA (id_vacina, nome_vacina, laboratorio, lote) VALUES ('1', 'COVID 19', 'Moderna', '1');
INSERT INTO VACINA (id_vacina, nome_vacina, laboratorio, lote) VALUES ('2', 'COVID 19', 'Pfizer', '2');
INSERT INTO VACINA (id_vacina, nome_vacina, laboratorio, lote) VALUES ('3', 'COVID 19', 'Johnson & Johnson', '3');
INSERT INTO VACINA (id_vacina, nome_vacina, laboratorio, lote) VALUES ('4', 'COVID 19', 'German BioNTech', '4');
INSERT INTO VACINA (id_vacina, nome_vacina, laboratorio, lote) VALUES ('5', 'COVID 19', 'AstraZeneca', '5');
INSERT INTO VACINA (id_vacina, nome_vacina, laboratorio, lote) VALUES ('6', 'COVID 19', 'Merck', '6');
INSERT INTO VACINA (id_vacina, nome_vacina, laboratorio, lote) VALUES ('7', 'COVID 19', 'Oxford', '7');
INSERT INTO VACINA (id_vacina, nome_vacina, laboratorio, lote) VALUES ('8', 'COVID 19', 'Sinovac Biotech', '8');
INSERT INTO VACINA (id_vacina, nome_vacina, laboratorio, lote) VALUES ('9', 'COVID 19', 'Instituto Butantan', '9');
INSERT INTO VACINA (id_vacina, nome_vacina, laboratorio, lote) VALUES ('10', 'COVID 19', 'Lavoisier', '10');

INSERT INTO CARTEIRA_DE_VACINACAO (id_carteira, tipo_sanguineo, intolerancia) VALUES ('1', 'B+', 'Lactose');
INSERT INTO CARTEIRA_DE_VACINACAO (id_carteira, tipo_sanguineo, intolerancia) VALUES ('2', 'A+', 'Nenhuma');
INSERT INTO CARTEIRA_DE_VACINACAO (id_carteira, tipo_sanguineo, intolerancia) VALUES ('3', 'AB+', 'Amoxilina');
INSERT INTO CARTEIRA_DE_VACINACAO (id_carteira, tipo_sanguineo, intolerancia) VALUES ('4', 'AB', 'Nenhuma');
INSERT INTO CARTEIRA_DE_VACINACAO (id_carteira, tipo_sanguineo, intolerancia) VALUES ('5', 'O+', 'Nenhuma');
INSERT INTO CARTEIRA_DE_VACINACAO (id_carteira, tipo_sanguineo, intolerancia) VALUES ('6', 'A+', 'Nenhuma');
INSERT INTO CARTEIRA_DE_VACINACAO (id_carteira, tipo_sanguineo, intolerancia) VALUES ('7', 'B+', 'Lactose');
INSERT INTO CARTEIRA_DE_VACINACAO (id_carteira, tipo_sanguineo, intolerancia) VALUES ('8', 'O-', 'Nenhuma');
INSERT INTO CARTEIRA_DE_VACINACAO (id_carteira, tipo_sanguineo, intolerancia) VALUES ('9', 'B-', 'Nenhuma');
INSERT INTO CARTEIRA_DE_VACINACAO (id_carteira, tipo_sanguineo, intolerancia) VALUES ('10', 'AB-', 'Nenhuma');
INSERT INTO CARTEIRA_DE_VACINACAO (id_carteira, tipo_sanguineo, intolerancia) VALUES ('11', 'B-', 'Lactose');
INSERT INTO CARTEIRA_DE_VACINACAO (id_carteira, tipo_sanguineo, intolerancia) VALUES ('12', 'A+', 'Nenhuma');
INSERT INTO CARTEIRA_DE_VACINACAO (id_carteira, tipo_sanguineo, intolerancia) VALUES ('13', 'AB+', 'Lactose');
INSERT INTO CARTEIRA_DE_VACINACAO (id_carteira, tipo_sanguineo, intolerancia) VALUES ('14', 'AB-', 'Nenhuma');
INSERT INTO CARTEIRA_DE_VACINACAO (id_carteira, tipo_sanguineo, intolerancia) VALUES ('15', 'O-', 'Nenhuma');
INSERT INTO CARTEIRA_DE_VACINACAO (id_carteira, tipo_sanguineo, intolerancia) VALUES ('16', 'A+', 'Nenhuma');
INSERT INTO CARTEIRA_DE_VACINACAO (id_carteira, tipo_sanguineo, intolerancia) VALUES ('17', 'AB+', 'Lactose');
INSERT INTO CARTEIRA_DE_VACINACAO (id_carteira, tipo_sanguineo, intolerancia) VALUES ('18', 'O-', 'Nenhuma');
INSERT INTO CARTEIRA_DE_VACINACAO (id_carteira, tipo_sanguineo, intolerancia) VALUES ('19', 'B-', 'Nenhuma');
INSERT INTO CARTEIRA_DE_VACINACAO (id_carteira, tipo_sanguineo, intolerancia) VALUES ('20', 'B+', 'Nenhuma');

INSERT INTO PESSOA (cpf_pessoa, nome_pessoa, data_nascimento, sexo_pessoa, carteira_de_vacinacao, profissao) VALUES ('77942862801', 'Manuel Vinicius Gomes', '1996-07-17', 'M', '1', '1');
INSERT INTO PESSOA (cpf_pessoa, nome_pessoa, data_nascimento, sexo_pessoa, carteira_de_vacinacao, profissao) VALUES ('75728596827', 'Luiz Severino Caleb Assunção', '1961-03-06', 'M', '2', '3');
INSERT INTO PESSOA (cpf_pessoa, nome_pessoa, data_nascimento, sexo_pessoa, carteira_de_vacinacao, profissao) VALUES ('60893711810', 'Elias José Benedito Aparício', '1999-04-01', 'M', '3', '4');
INSERT INTO PESSOA (cpf_pessoa, nome_pessoa, data_nascimento, sexo_pessoa, carteira_de_vacinacao, profissao) VALUES ('06237662804', 'Vitor Ian Dias', '1991-04-08', 'M', '4', '5');
INSERT INTO PESSOA (cpf_pessoa, nome_pessoa, data_nascimento, sexo_pessoa, carteira_de_vacinacao, profissao) VALUES ('16096805884', 'Vitor Martin Melo', '1961-07-27', 'M', '5', '6');
INSERT INTO PESSOA (cpf_pessoa, nome_pessoa, data_nascimento, sexo_pessoa, carteira_de_vacinacao, profissao) VALUES ('54837066844', 'Ryan Felipe Lorenzo Cavalcanti', '1975-11-02', 'M', '6', '7');
INSERT INTO PESSOA (cpf_pessoa, nome_pessoa, data_nascimento, sexo_pessoa, carteira_de_vacinacao, profissao) VALUES ('77861053873', 'Fabiana Lívia Emilly Caldeira', '1940-10-07', 'F', '7', '8');
INSERT INTO PESSOA (cpf_pessoa, nome_pessoa, data_nascimento, sexo_pessoa, carteira_de_vacinacao, profissao) VALUES ('18397003860', 'Pedro Bruno Peixoto', '1971-01-06', 'M', '8', '9');
INSERT INTO PESSOA (cpf_pessoa, nome_pessoa, data_nascimento, sexo_pessoa, carteira_de_vacinacao, profissao) VALUES ('46163890809', 'Joaquim Leonardo Fogaça', '1945-06-20', 'M', '9', '6');
INSERT INTO PESSOA (cpf_pessoa, nome_pessoa, data_nascimento, sexo_pessoa, carteira_de_vacinacao, profissao) VALUES ('32277825883', 'Leonardo Julio Filipe Alves', '1966-10-01', 'M', '10', '10');

INSERT INTO PESSOA (cpf_pessoa, nome_pessoa, data_nascimento, sexo_pessoa, carteira_de_vacinacao, profissao) VALUES ('54106643880', 'Eliane Luana Andreia Nunes', '1957-10-13', 'F', '11', '2');
INSERT INTO PESSOA (cpf_pessoa, nome_pessoa, data_nascimento, sexo_pessoa, carteira_de_vacinacao, profissao) VALUES ('94448409805', 'Renato Rafael da Costa', '1985-04-24', 'M', '12', '2');
INSERT INTO PESSOA (cpf_pessoa, nome_pessoa, data_nascimento, sexo_pessoa, carteira_de_vacinacao, profissao) VALUES ('01787090850', 'Sarah Sophia Fernandes', '1978-02-21', 'F', '13', '2');
INSERT INTO PESSOA (cpf_pessoa, nome_pessoa, data_nascimento, sexo_pessoa, carteira_de_vacinacao, profissao) VALUES ('26711286812', 'Nathan Enrico Samuel Nascimento', '1996-07-15', 'M', '14', '2');
INSERT INTO PESSOA (cpf_pessoa, nome_pessoa, data_nascimento, sexo_pessoa, carteira_de_vacinacao, profissao) VALUES ('84199890882', 'Augusto Alexandre Fernando Porto', '1943-01-22', 'M', '15', '2');
INSERT INTO PESSOA (cpf_pessoa, nome_pessoa, data_nascimento, sexo_pessoa, carteira_de_vacinacao, profissao) VALUES ('36728954821', 'Caio Enrico Peixoto', '2002-12-11', 'M', '16', '2');
INSERT INTO PESSOA (cpf_pessoa, nome_pessoa, data_nascimento, sexo_pessoa, carteira_de_vacinacao, profissao) VALUES ('62848839864', 'Hadassa Raimunda Brito', '1982-11-08', 'F', '17', '2');
INSERT INTO PESSOA (cpf_pessoa, nome_pessoa, data_nascimento, sexo_pessoa, carteira_de_vacinacao, profissao) VALUES ('03608164871', 'Marina Raimunda Vanessa Gomes', '1976-11-04', 'F', '18', '2');
INSERT INTO PESSOA (cpf_pessoa, nome_pessoa, data_nascimento, sexo_pessoa, carteira_de_vacinacao, profissao) VALUES ('26736942853', 'Leonardo Leandro Pinto', '1991-04-22', 'M', '19', '2');
INSERT INTO PESSOA (cpf_pessoa, nome_pessoa, data_nascimento, sexo_pessoa, carteira_de_vacinacao, profissao) VALUES ('77004963829', 'Renan Otávio Bruno Caldeira', '1960-11-05', 'M', '20', '2');

INSERT INTO PROFISSAO_PESSOA (id_profissao, cpf_pessoa) VALUES ('1', '77942862801');
INSERT INTO PROFISSAO_PESSOA (id_profissao, cpf_pessoa) VALUES ('3', '75728596827');
INSERT INTO PROFISSAO_PESSOA (id_profissao, cpf_pessoa) VALUES ('4', '60893711810');
INSERT INTO PROFISSAO_PESSOA (id_profissao, cpf_pessoa) VALUES ('5', '06237662804');
INSERT INTO PROFISSAO_PESSOA (id_profissao, cpf_pessoa) VALUES ('6', '16096805884');
INSERT INTO PROFISSAO_PESSOA (id_profissao, cpf_pessoa) VALUES ('7', '54837066844');
INSERT INTO PROFISSAO_PESSOA (id_profissao, cpf_pessoa) VALUES ('8', '77861053873');
INSERT INTO PROFISSAO_PESSOA (id_profissao, cpf_pessoa) VALUES ('9', '18397003860');
INSERT INTO PROFISSAO_PESSOA (id_profissao, cpf_pessoa) VALUES ('6', '46163890809');
INSERT INTO PROFISSAO_PESSOA (id_profissao, cpf_pessoa) VALUES ('10', '32277825883');
INSERT INTO PROFISSAO_PESSOA (id_profissao, cpf_pessoa) VALUES ('2', '54106643880');
INSERT INTO PROFISSAO_PESSOA (id_profissao, cpf_pessoa) VALUES ('2', '94448409805');
INSERT INTO PROFISSAO_PESSOA (id_profissao, cpf_pessoa) VALUES ('2', '01787090850');
INSERT INTO PROFISSAO_PESSOA (id_profissao, cpf_pessoa) VALUES ('2', '26711286812');
INSERT INTO PROFISSAO_PESSOA (id_profissao, cpf_pessoa) VALUES ('2', '84199890882');
INSERT INTO PROFISSAO_PESSOA (id_profissao, cpf_pessoa) VALUES ('2', '36728954821');
INSERT INTO PROFISSAO_PESSOA (id_profissao, cpf_pessoa) VALUES ('2', '62848839864');
INSERT INTO PROFISSAO_PESSOA (id_profissao, cpf_pessoa) VALUES ('2', '03608164871');
INSERT INTO PROFISSAO_PESSOA (id_profissao, cpf_pessoa) VALUES ('2', '26736942853');
INSERT INTO PROFISSAO_PESSOA (id_profissao, cpf_pessoa) VALUES ('2', '77004963829');

INSERT INTO ENFERMEIRO (coren, especialidade_enfermeiro, cpf_pessoa, horario_enfermeiro, salario_enfermeiro, telefone_enfermeiro) VALUES ('039.217', 'Injetáveis', '54106643880', '4', '2000.30', '1129674344');
INSERT INTO ENFERMEIRO (coren, especialidade_enfermeiro, cpf_pessoa, horario_enfermeiro, salario_enfermeiro, telefone_enfermeiro) VALUES ('029.374', 'Anestesias', '94448409805', '6', '16570.10', '1126285075');
INSERT INTO ENFERMEIRO (coren, especialidade_enfermeiro, cpf_pessoa, horario_enfermeiro, salario_enfermeiro, telefone_enfermeiro) VALUES ('035.737', 'Curativos', '01787090850', '6', '1780.20', '11986265708');
INSERT INTO ENFERMEIRO (coren, especialidade_enfermeiro, cpf_pessoa, horario_enfermeiro, salario_enfermeiro, telefone_enfermeiro) VALUES ('013.181', 'Injetáveis', '26711286812', '6', '1450.34', '11995370464');
INSERT INTO ENFERMEIRO (coren, especialidade_enfermeiro, cpf_pessoa, horario_enfermeiro, salario_enfermeiro, telefone_enfermeiro) VALUES ('027.828', 'Injetáveis', '84199890882', '4', '1993.80', '11989871765');
INSERT INTO ENFERMEIRO (coren, especialidade_enfermeiro, cpf_pessoa, horario_enfermeiro, salario_enfermeiro, telefone_enfermeiro) VALUES ('059.462', 'Curativos', '36728954821', '4', '2356.16', '11996002506');
INSERT INTO ENFERMEIRO (coren, especialidade_enfermeiro, cpf_pessoa, horario_enfermeiro, salario_enfermeiro, telefone_enfermeiro) VALUES ('072.718', 'Injetáveis', '62848839864', '4', '1789.17', '11991211843');
INSERT INTO ENFERMEIRO (coren, especialidade_enfermeiro, cpf_pessoa, horario_enfermeiro, salario_enfermeiro, telefone_enfermeiro) VALUES ('013.673', 'Curativos', '03608164871', '4', '1679.27', '11998375769');
INSERT INTO ENFERMEIRO (coren, especialidade_enfermeiro, cpf_pessoa, horario_enfermeiro, salario_enfermeiro, telefone_enfermeiro) VALUES ('056.855', 'Injetáveis', '26736942853', '4', '1942.33', '11981632753');
INSERT INTO ENFERMEIRO (coren, especialidade_enfermeiro, cpf_pessoa, horario_enfermeiro, salario_enfermeiro, telefone_enfermeiro) VALUES ('081.935', 'Anestesias', '77004963829', '4', '1567.33', '11981248215');

INSERT INTO PACIENTE (id_paciente, telefone_paciente, pessoa_paciente, data_aplicacao) VALUES ('1', '11988271647', '77942862801', '2020-10-26');
INSERT INTO PACIENTE (id_paciente, telefone_paciente, pessoa_paciente, data_aplicacao) VALUES ('2', '1137444284', '75728596827', '2020-11-11');
INSERT INTO PACIENTE (id_paciente, telefone_paciente, pessoa_paciente, data_aplicacao) VALUES ('3', '11992094089', '60893711810', '2020-11-26');
INSERT INTO PACIENTE (id_paciente, telefone_paciente, pessoa_paciente, data_aplicacao) VALUES ('4', '1127340483', '06237662804', '2020-11-29');
INSERT INTO PACIENTE (id_paciente, telefone_paciente, pessoa_paciente, data_aplicacao) VALUES ('5', '1138177470', '16096805884', '2020-12-01');
INSERT INTO PACIENTE (id_paciente, telefone_paciente, pessoa_paciente, data_aplicacao) VALUES ('6', '1127940047', '54837066844', '2020-12-09');
INSERT INTO PACIENTE (id_paciente, telefone_paciente, pessoa_paciente, data_aplicacao) VALUES ('7', '1125484988', '77861053873', '2020-12-15');
INSERT INTO PACIENTE (id_paciente, telefone_paciente, pessoa_paciente, data_aplicacao) VALUES ('8', '1129442364', '18397003860', '2020-12-18');
INSERT INTO PACIENTE (id_paciente, telefone_paciente, pessoa_paciente, data_aplicacao) VALUES ('9', '1126004696', '46163890809', '2020-12-23');
INSERT INTO PACIENTE (id_paciente, telefone_paciente, pessoa_paciente, data_aplicacao) VALUES ('10', '1127892825', '32277825883', '2020-12-27');

INSERT INTO APLICACAO (id_aplicacao, data_aplicacao, hora_aplicacao, enfermeiro_aplicacao, vacina_aplicacao, paciente_aplicacao) VALUES ('1', '2020-09-13','10:26:33', '54106643880', '1', '1');
INSERT INTO APLICACAO (id_aplicacao, data_aplicacao, hora_aplicacao, enfermeiro_aplicacao, vacina_aplicacao, paciente_aplicacao) VALUES ('2', '2020-09-27','08:21:13', '94448409805', '2', '2');
INSERT INTO APLICACAO (id_aplicacao, data_aplicacao, hora_aplicacao, enfermeiro_aplicacao, vacina_aplicacao, paciente_aplicacao) VALUES ('3', '2020-10-03','11:28:21', '01787090850', '3', '3');
INSERT INTO APLICACAO (id_aplicacao, data_aplicacao, hora_aplicacao, enfermeiro_aplicacao, vacina_aplicacao, paciente_aplicacao) VALUES ('4', '2020-10-13','12:23:47', '26711286812', '4', '4');
INSERT INTO APLICACAO (id_aplicacao, data_aplicacao, hora_aplicacao, enfermeiro_aplicacao, vacina_aplicacao, paciente_aplicacao) VALUES ('5', '2020-10-25','14:47:55', '84199890882', '5', '5');
INSERT INTO APLICACAO (id_aplicacao, data_aplicacao, hora_aplicacao, enfermeiro_aplicacao, vacina_aplicacao, paciente_aplicacao) VALUES ('6', '2020-10-31','16:19:53', '36728954821', '6', '6');
INSERT INTO APLICACAO (id_aplicacao, data_aplicacao, hora_aplicacao, enfermeiro_aplicacao, vacina_aplicacao, paciente_aplicacao) VALUES ('7', '2020-11-11','12:20:25', '62848839864', '7', '7');
INSERT INTO APLICACAO (id_aplicacao, data_aplicacao, hora_aplicacao, enfermeiro_aplicacao, vacina_aplicacao, paciente_aplicacao) VALUES ('8', '2020-11-22','13:21:47', '03608164871', '8', '8');
INSERT INTO APLICACAO (id_aplicacao, data_aplicacao, hora_aplicacao, enfermeiro_aplicacao, vacina_aplicacao, paciente_aplicacao) VALUES ('9', '2020-11-29','10:54:39', '26736942853', '9', '9');
INSERT INTO APLICACAO (id_aplicacao, data_aplicacao, hora_aplicacao, enfermeiro_aplicacao, vacina_aplicacao, paciente_aplicacao) VALUES ('10', '2020-12-04','09:46:10', '77004963829', '10', '10');

INSERT INTO VACINAS_RECEBIDAS (id_vacinas_recebidas, nome_doenca, dose, data_aplicacao, carteira) VALUES ('1', 'Febre Amarela', '1', '2012-09-13', '1');
INSERT INTO VACINAS_RECEBIDAS (id_vacinas_recebidas, nome_doenca, dose, data_aplicacao, carteira) VALUES ('2', 'Varíola', '1', '2008-09-13', '2');
INSERT INTO VACINAS_RECEBIDAS (id_vacinas_recebidas, nome_doenca, dose, data_aplicacao, carteira) VALUES ('3', 'Hepátite', '1', '2014-09-13', '3');
INSERT INTO VACINAS_RECEBIDAS (id_vacinas_recebidas, nome_doenca, dose, data_aplicacao, carteira) VALUES ('4', 'Tetano', '1', '2002-03-13', '4');
INSERT INTO VACINAS_RECEBIDAS (id_vacinas_recebidas, nome_doenca, dose, data_aplicacao, carteira) VALUES ('5', 'HPV', '1', '2001-01-25', '5');
INSERT INTO VACINAS_RECEBIDAS (id_vacinas_recebidas, nome_doenca, dose, data_aplicacao, carteira) VALUES ('6', 'BCG', '1', '2007-09-26', '6');
INSERT INTO VACINAS_RECEBIDAS (id_vacinas_recebidas, nome_doenca, dose, data_aplicacao, carteira) VALUES ('7', 'Rubéola', '1', '2009-03-27', '7');
INSERT INTO VACINAS_RECEBIDAS (id_vacinas_recebidas, nome_doenca, dose, data_aplicacao, carteira) VALUES ('8', 'Catapora', '1', '2010-04-17', '8');
INSERT INTO VACINAS_RECEBIDAS (id_vacinas_recebidas, nome_doenca, dose, data_aplicacao, carteira) VALUES ('9', 'Sarampo', '1', '2007-02-26', '9');
INSERT INTO VACINAS_RECEBIDAS (id_vacinas_recebidas, nome_doenca, dose, data_aplicacao, carteira) VALUES ('10', 'Meningite', '1', '1998-01-23', '10');

INSERT INTO CARTEIRA_DE_VACINACAO_VACINAS_RECEBIDAS (id_vacinas_recebidas, id_carteira) VALUES ('1', '1');
INSERT INTO CARTEIRA_DE_VACINACAO_VACINAS_RECEBIDAS (id_vacinas_recebidas, id_carteira) VALUES ('2', '2');
INSERT INTO CARTEIRA_DE_VACINACAO_VACINAS_RECEBIDAS (id_vacinas_recebidas, id_carteira) VALUES ('3', '3');
INSERT INTO CARTEIRA_DE_VACINACAO_VACINAS_RECEBIDAS (id_vacinas_recebidas, id_carteira) VALUES ('4', '4');
INSERT INTO CARTEIRA_DE_VACINACAO_VACINAS_RECEBIDAS (id_vacinas_recebidas, id_carteira) VALUES ('5', '5');
INSERT INTO CARTEIRA_DE_VACINACAO_VACINAS_RECEBIDAS (id_vacinas_recebidas, id_carteira) VALUES ('6', '6');
INSERT INTO CARTEIRA_DE_VACINACAO_VACINAS_RECEBIDAS (id_vacinas_recebidas, id_carteira) VALUES ('7', '7');
INSERT INTO CARTEIRA_DE_VACINACAO_VACINAS_RECEBIDAS (id_vacinas_recebidas, id_carteira) VALUES ('8', '8');
INSERT INTO CARTEIRA_DE_VACINACAO_VACINAS_RECEBIDAS (id_vacinas_recebidas, id_carteira) VALUES ('9', '9');
INSERT INTO CARTEIRA_DE_VACINACAO_VACINAS_RECEBIDAS (id_vacinas_recebidas, id_carteira) VALUES ('10', '10');