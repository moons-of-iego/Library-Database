from pathlib import Path
import os
from dotenv import load_dotenv

load_dotenv()

CODE_ROOT = Path(__file__).parent.parent
SQL_DIR = CODE_ROOT / "sql"


def _load_sql_query(path: Path | str) -> str:
    if isinstance(path, str):
        path = CODE_ROOT / path
    with path.open("r", encoding="utf-8") as f:
        return f.read()


# database config
DB_NAME = os.getenv("DB_NAME")
DB_HOST = os.getenv("DB_HOST")
DB_PORT = os.getenv("DB_PORT")
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")
