from flask import Blueprint, request
from db import Db, Mode


cadastrarLivro_bp = Blueprint("livro_bp", __name__)

@cadastrarLivro_bp.route('/adicionarLivro', methods=['GET'])
def add_livro():
    print("Iniciando a rota de adicionar livro")
    sql = """
        INSERT INTO livro
          (isbn, titulo, autor, editora, cdd)
            VALUES (%s, %s, %s, %s, %s)
    """
    params = ("99", "nomMunicipio", "autor", "qtdPopulacaoRural", "102020")
    
    db = Db()
    try: 
        r=db.execSql(sql, params)
        print(db.mensagem[0])
        return r
    except Exception as e:
        print(db.mensagem[0])
        return db.getErro(e)


