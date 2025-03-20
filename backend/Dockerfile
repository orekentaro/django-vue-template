FROM python:3.11-slim

ENV POETRY_VERSION=1.8.2 \
    POETRY_VIRTUALENVS_CREATE=false \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y curl gcc libpq-dev netcat-openbsd && \
    curl -sSL https://install.python-poetry.org | python3 -

RUN pip install poetry

WORKDIR /app

# 1. Poetryの依存ファイルをコピー
COPY backend/pyproject.toml backend/poetry.lock* ./

# 2. Poetry 依存インストール
RUN poetry install --no-root

# 3. プロジェクト全体をコピー
COPY ./backend /app/

ENV DEBUG_MODE=true

CMD ["scripts/wait_for_it.sh", "db:5432", "--", "python", "-m", "debugpy", "--listen", "0.0.0.0:5678", "manage.py", "runserver", "0.0.0.0:8080"]