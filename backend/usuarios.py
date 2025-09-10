import psycopg2

DB_HOST = "localhost"
DB_PORT = "5432"
DB_NAME = "Sabo"
DB_USER = "postgres"
DB_PASS = "123456"

def conectar():
    return psycopg2.connect(
        host=DB_HOST,
        port=DB_PORT,
        database=DB_NAME,
        user=DB_USER,
        password=DB_PASS
    )



def inserir_usuario(cpf, nome, email, senha, tipo_usuario):
    conn = conectar()
    cur = conn.cursor()
    cur.execute(
        "SELECT inserir_usuario(%s::CHAR(11), %s::VARCHAR, %s::VARCHAR, %s::VARCHAR, %s::VARCHAR);",
        (cpf, nome, email, senha, tipo_usuario)
    )
    conn.commit()
    cur.close()
    conn.close()
    print("Usuario inserido com sucesso!")




def atualizar_usuario(cpf, nome, email, senha, tipo_usuario):
    conn = conectar()
    cur = conn.cursor()
    cur.execute(
        "SELECT atualizar_usuario(%s::CHAR(11), %s::VARCHAR, %s::VARCHAR, %s::VARCHAR, %s::VARCHAR);",
        (cpf, nome, email, senha, tipo_usuario)
    )
    conn.commit()
    cur.close()
    conn.close()
    print("Usuario atualizado com sucesso!")




def excluir_usuario(cpf):
    conn = conectar()
    cur = conn.cursor()
    cur.execute(
        "SELECT excluir_usuario(%s::CHAR(11));",
        (cpf,)
    )
    conn.commit()
    cur.close()
    conn.close()
    print("Usuario excluído com sucesso!")




def pesquisar_por_cpf(cpf):
    conn = conectar()
    cur = conn.cursor()
    cur.execute(
        "SELECT * FROM retornar_usuario(%s::CHAR(11));",
        (cpf,)
    )
    resultado = cur.fetchall()
    cur.close()
    conn.close()
    return resultado

def pesquisar_por_email(email):
    conn = conectar()
    cur = conn.cursor()
    cur.execute(
        "SELECT * FROM Usuario WHERE email = %s::VARCHAR;",
        (email,)
    )
    resultado = cur.fetchall()
    cur.close()
    conn.close()
    return resultado

def pesquisar_por_tipo(tipo_usuario):
    conn = conectar()
    cur = conn.cursor()
    cur.execute(
        "SELECT * FROM Usuario WHERE tipo_usuario = %s::VARCHAR;",
        (tipo_usuario,)
    )
    resultado = cur.fetchall()
    cur.close()
    conn.close()
    return resultado


if __name__ == "__main__":
    # Inserir um usuário
    inserir_usuario("12345678999", "Lucas Lima", "lucas@email.com", "senha123", "usuario")

    # Atualizar o usuário
    atualizar_usuario("12345678999", "Lucas Lima Atualizado", "lucas.novo@email.com", "novaSenha", "professor")

    # Pesquisar por CPF
    print(pesquisar_por_cpf("12345678999"))

    # Pesquisar por email
    print(pesquisar_por_email("lucas.novo@email.com"))

    # Pesquisar por tipo
    print(pesquisar_por_tipo("professor"))

    # Excluir usuário
    excluir_usuario("12345678999")
