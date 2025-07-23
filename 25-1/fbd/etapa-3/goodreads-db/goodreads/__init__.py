import os

from flask import Flask, render_template, request
from flask_cors import CORS

from .postgres import connect

BASE_DIR = os.path.dirname(os.path.abspath(__file__))

goodreads = Flask(__name__, template_folder="templates")
goodreads.json.sort_keys = False
CORS(goodreads, resources={r"/*": {"origins": "http://localhost:5173"}})


@goodreads.route("/")
def create_database():
    """Cria o banco de dados e as tabelas necessária,

    Returns:
        str: Renderiza o template index.html
    """
    try:
        ddl_path = os.path.join(BASE_DIR, "..", "ddl.sql")
        with open(ddl_path, "r") as f:
            ddl_commands = f.read()
            connect(ddl_commands)
        instancias_path = os.path.join(BASE_DIR, "..", "instancias.sql")
        with open(instancias_path, "r") as f:
            instances = f.read()
            connect(instances)
        visao_path = os.path.join(BASE_DIR, "..", "consultas", "view.sql")
        with open(visao_path, "r") as f:
            visao = f.read()
            try:
                connect(visao)
            except Exception as e:
                print(f"Error: {e}")
    except Exception as e:
        print(f"Error creating database or tables: {e}")

    # Renderiza o template index.html
    return render_template("index.html")


@goodreads.post("/api/v1/POST/consultas")
def consultas():
    """Executa as consultas da etapa 2

    Returns:
        tuple[str, int]: Retorna uma tupla com uma resposta e um código de retorno HTTP.
    """
    query_id = request.args.get("query_id")

    content_type = request.headers.get("Content-Type")
    if content_type == "application/json":
        query_params = request.json
    else:
        query_params = None

    try:
        consulta_path = os.path.join(BASE_DIR, "..", "consultas", f"{query_id}.sql")
        with open(consulta_path, "r") as f:
            consultas = f.read()
            try:
                query_result = connect(consultas, query_params)
                result = (query_result, 200)
            except Exception as e:
                exception_msg = f"Error: {e}"
                result = (exception_msg, 500)
    except Exception as e:
        exception_msg = f"Error: {e}"
        result = (exception_msg, 501)

    return result


@goodreads.post("/api/v1/POST/query")
def sql():
    """Executa uma consulta SQL fornecida pelo usuário

    Returns:
        tuple[str, int]: Retorna uma tupla com uma resposta e um código de retorno HTTP.
    """
    content_type = request.headers.get("Content-Type")
    if content_type == "application/json":
        json = request.json
        print(json["query"], json["params"])
        try:
            query_result = connect(json["query"], json["params"])
            result = (query_result, 200)
        except Exception as e:
            exception_msg = f"Error: {e}"
            result = (exception_msg, 500)
    else:
        result = ("No result", 501)

    return result
