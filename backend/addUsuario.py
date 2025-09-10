import psycopg2

# Configurações do banco
DB_HOST = "localhost"
DB_PORT = "5432"
DB_NAME = "Sabo"
DB_USER = "postgres"
DB_PASS = "123456"

try:
    # Conectar ao banco
    conn = psycopg2.connect(
        host=DB_HOST,
        port=DB_PORT,
        database=DB_NAME,
        user=DB_USER,
        password=DB_PASS
    )
    cur = conn.cursor()

    # Inserir um usuário
    cpf = "12345678999"
    nome = "Lucas Lima"
    email = "lucas@email.com"
    senha = "senha123"
    tipo_usuario = "usuario"
    
    cur.execute(
        """
        SELECT inserir_usuario(%s::CHAR(11), %s::VARCHAR, %s::VARCHAR, %s::VARCHAR, %s::VARCHAR);
        """,
        (cpf, nome, email, senha, tipo_usuario)
    )
    print("Usuário inserido com sucesso!")

    # 2️⃣ Atualizar o usuário
    nome_novo = "Lucas Lima Atualizado"
    email_novo = "lucas.novo@email.com"
    senha_nova = "novaSenha"
    tipo_novo = "professor"

    cur.execute(
        """
        SELECT atualizar_usuario(%s::CHAR(11), %s::VARCHAR, %s::VARCHAR, %s::VARCHAR, %s::VARCHAR);
        """,
        (cpf, nome_novo, email_novo, senha_nova, tipo_novo)
    )
    print("Usuário atualizado com sucesso!")

    # 3️⃣ Consultar o usuário
    cur.execute(
        "SELECT * FROM retornar_usuario(%s::CHAR(11));",
        (cpf,)
    )
    usuario = cur.fetchone()
    print("Dados do usuário:", usuario)

    # 4️⃣ Excluir o usuário
    cur.execute(
        "SELECT excluir_usuario(%s::CHAR(11));",
        (cpf,)
    )
    print("Usuário excluído com sucesso!")

    # Confirmar alterações
    conn.commit()

except Exception as e:
    print("Erro:", e)

finally:
    if cur:
        cur.close()
    if conn:
        conn.close()
