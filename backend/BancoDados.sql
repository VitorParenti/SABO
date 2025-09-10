drop table if exists Usuario cascade;
drop table if exists Cargo cascade;
drop table if exists obra cascade;
drop table if exists edicao cascade;
drop table if exists Exemplar cascade;
drop type if exists estadosDeDisponibilidade;





-- Inicio de coisas de usuario ###################################################################



CREATE TABLE Usuario (
    cpf CHAR(11) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    tipo_usuario VARCHAR(20) NOT NULL CHECK (tipo_usuario IN ('usuario', 'professor', 'bibliotecario'))
);

INSERT INTO Usuario (cpf, nome, email, senha, tipo_usuario) VALUES
('11111111101', 'Ana Silva', 'ana.silva@email.com', 'senha123', 'usuario'),
('11111111102', 'Bruno Souza', 'bruno.souza@email.com', 'senha123', 'usuario'),
('11111111103', 'Carla Mendes', 'carla.mendes@email.com', 'senha123', 'usuario'),
('11111111104', 'Diego Lima', 'diego.lima@email.com', 'senha123', 'usuario'),
('11111111105', 'Elisa Rocha', 'elisa.rocha@email.com', 'senha123', 'usuario'),
('11111111106', 'Fabio Costa', 'fabio.costa@email.com', 'senha123', 'professor'),
('11111111107', 'Gabriela Alves', 'gabriela.alves@email.com', 'senha123', 'professor'),
('11111111108', 'Hugo Martins', 'hugo.martins@email.com', 'senha123', 'professor'),
('11111111109', 'Isabela Nunes', 'isabela.nunes@email.com', 'senha123', 'professor'),
('11111111110', 'João Pedro', 'joao.pedro@email.com', 'senha123', 'professor'),
('11111111111', 'Karen Vieira', 'karen.vieira@email.com', 'senha123', 'bibliotecario'),
('11111111112', 'Lucas Fernandes', 'lucas.fernandes@email.com', 'senha123', 'bibliotecario'),
('11111111113', 'Mariana Pinto', 'mariana.pinto@email.com', 'senha123', 'bibliotecario'),
('11111111114', 'Nicolas Araújo', 'nicolas.araujo@email.com', 'senha123', 'bibliotecario'),
('11111111115', 'Olivia Souza', 'olivia.souza@email.com', 'senha123', 'bibliotecario'),
('11111111116', 'Paulo Henrique', 'paulo.henrique@email.com', 'senha123', 'usuario'),
('11111111117', 'Quenia Dias', 'quenia.dias@email.com', 'senha123', 'usuario'),
('11111111118', 'Rafael Teixeira', 'rafael.teixeira@email.com', 'senha123', 'usuario'),
('11111111119', 'Sofia Carvalho', 'sofia.carvalho@email.com', 'senha123', 'usuario'),
('11111111120', 'Tiago Ramos', 'tiago.ramos@email.com', 'senha123', 'usuario'),
('11111111121', 'Úrsula Gomes', 'ursula.gomes@email.com', 'senha123', 'professor'),
('11111111122', 'Vitor Almeida', 'vitor.almeida@email.com', 'senha123', 'professor'),
('11111111123', 'Wellington Lopes', 'wellington.lopes@email.com', 'senha123', 'professor'),
('11111111124', 'Ximena Rocha', 'ximena.rocha@email.com', 'senha123', 'professor'),
('11111111125', 'Yuri Batista', 'yuri.batista@email.com', 'senha123', 'professor'),
('11111111126', 'Zara Martins', 'zara.martins@email.com', 'senha123', 'bibliotecario'),
('11111111127', 'Arthur Cardoso', 'arthur.cardoso@email.com', 'senha123', 'bibliotecario'),
('11111111128', 'Beatriz Santos', 'beatriz.santos@email.com', 'senha123', 'bibliotecario'),
('11111111129', 'Caio Moreira', 'caio.moreira@email.com', 'senha123', 'bibliotecario'),
('11111111130', 'Daniela Ribeiro', 'daniela.ribeiro@email.com', 'senha123', 'bibliotecario');

-- Função para inserir um novo usuário
CREATE OR REPLACE FUNCTION inserir_usuario(
    p_cpf CHAR(11),
    p_nome VARCHAR,
    p_email VARCHAR,
    p_senha VARCHAR,
    p_tipo_usuario VARCHAR
)
RETURNS VOID AS $$
BEGIN
    INSERT INTO Usuario (cpf, nome, email, senha, tipo_usuario)
    VALUES (p_cpf, p_nome, p_email, p_senha, p_tipo_usuario);
END;
$$ LANGUAGE plpgsql;

-- Função para atualizar um usuário existente
CREATE OR REPLACE FUNCTION atualizar_usuario(
    p_cpf CHAR(11),
    p_nome VARCHAR,
    p_email VARCHAR,
    p_senha VARCHAR,
    p_tipo_usuario VARCHAR
)
RETURNS VOID AS $$
BEGIN
    UPDATE Usuario
    SET nome = p_nome,
        email = p_email,
        senha = p_senha,
        tipo_usuario = p_tipo_usuario
    WHERE cpf = p_cpf;
END;
$$ LANGUAGE plpgsql;

-- Função para excluir um usuário
CREATE OR REPLACE FUNCTION excluir_usuario(p_cpf CHAR(11))
RETURNS VOID AS $$
BEGIN
    DELETE FROM Usuario
    WHERE cpf = p_cpf;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION retornar_usuario(p_cpf CHAR(11))
RETURNS TABLE (
    cpf CHAR(11),
    nome VARCHAR,
    email VARCHAR,
    senha VARCHAR,
    tipo_usuario VARCHAR
) AS $$
BEGIN
    RETURN QUERY
    SELECT u.cpf, u.nome, u.email, u.senha, u.tipo_usuario
    FROM Usuario u
    WHERE u.cpf = p_cpf;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM USUARIO;




-- Fim de coisas de usuario ###################################################################







create table Cargo (
    codCargo smallint not null,
    nomCargo  varchar(30) not null,
    primary key (codCargo)
);

-- Função para obter o próximo valor da sequência para cargo
-- #########################################################################
CREATE OR REPLACE FUNCTION public.get_next_cargo_codCargo()
RETURNS smallint AS $$
DECLARE
    next_id smallint;
BEGIN
    SELECT COALESCE(max(codCargo), 0) + 1
    INTO next_id
    FROM Cargo;
       
    RETURN next_id;
END;
$$ LANGUAGE plpgsql;

-- Trigger para gerar o ID automaticamente
CREATE OR REPLACE FUNCTION public.generate_Cargo_codCargo()
RETURNS TRIGGER AS $$
BEGIN
    NEW.codCargo := public.get_next_Cargo_codCargo();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER tr_generate_Cargo_codCargo
BEFORE INSERT ON cargo
FOR EACH ROW
EXECUTE PROCEDURE public.generate_Cargo_codCargo();

-- Tabela Obra
CREATE TABLE Obra (
    id_obra SERIAL PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    autor VARCHAR(150) NOT NULL,
    sinopse VARCHAR(255),
    genero VARCHAR(100)
);

-- Tabela Edição
CREATE TABLE Edicao (
    isbnEdicao VARCHAR(20) PRIMARY KEY,
    ano_publicacao INT,
    editora VARCHAR(150),
    cdd VARCHAR(10),  
    cutter VARCHAR(10), 
	id_obra SERIAL,
	FOREIGN KEY (id_obra) REFERENCES Obra (id_obra)
);

-- Tabela Exemplar
CREATE TYPE estadosDeDisponibilidade AS ENUM ('Disponível', 'Emprestado', 'Manutenção', 'Indisponível', 'Perdido', 'Danificado');
CREATE TABLE Exemplar (
    id_exemplar SERIAL PRIMARY KEY,
    codigo_exemplar VARCHAR(50) UNIQUE NOT NULL,
    estado_conservacao VARCHAR(50),
    disponibilidade estadosDeDisponibilidade ,
	isbnExemplar VARCHAR(20),
    FOREIGN KEY (isbnExemplar) REFERENCES Edicao (isbnEdicao)
);

-- FIM #################################################################################
