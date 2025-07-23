import psycopg2
from .config import config
from psycopg2.extras import RealDictCursor

def connect(commands=None, query_params=None):
    """Conecta com o banco de dados PostgreSQL"""
    conn = None
    record = []
    try:
        # Lê os parâmetros de configuração em database.ini
        params = config()

        print('Conectando ao PostgreSQL...')
        conn = psycopg2.connect(**params)

        with conn.cursor(cursor_factory=RealDictCursor) as cur:
            print('Versão do PostgreSQL:')
            cur.execute("SELECT version();")

            db_version = cur.fetchone()
            print(db_version)

            if commands:
                cur.execute(commands, query_params)
                print(f'Executando comando: {commands}, {query_params}')
                record = cur.fetchall()
                print(f'Resultado: {record}')

    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.commit()
            print('Transação concluída com sucesso.')
            conn.close()
            print('Conexão com o PostgreSQL fechada.')

    return record

if __name__ == '__main__':
    connect()