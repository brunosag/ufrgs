# goodreads-db

# Setup

1. Crie e ative um ambiente virtual
```bash
python -m venv env
source env/bin/activate
```

2. Instale os pacotes necessários
```bash
pip install -r requirements.txt
```

3. Defina a variável de ambiente FLASK_APP para o nome do pacote goodreads
```bash
export FLASK_APP=goodreads
```

# Rodar o servidor Flask

- Caso FLASK_APP esteja definido
```bash
flask run
```

- Caso não esteja
```bash
flask --app goodreads run
```