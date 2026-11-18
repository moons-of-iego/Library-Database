import logging
import mysql.connector
import src.config as config

logger = logging.getLogger(__name__)


def test_db_connection():
    logger.info(f"Tentative de connexion à {config.DB_HOST}...")
    connexion = None
    cursor = None
    try:
        connexion = mysql.connector.connect(
            host=config.DB_HOST,
            port=config.DB_PORT,
            user=config.DB_USER,
            password=config.DB_PASSWORD,
            database=config.DB_NAME,
        )

        assert connexion.is_connected(), "Erreur de connexion"
        if connexion.is_connected():
            logger.info("Connecté au container")
            cursor = connexion.cursor()
            cursor.execute("SHOW TABLES;")
            res = cursor.fetchall()
            logger.info(f"Liste des tables dans la base de données: {res}")

    finally:
        if "connexion" in locals() and connexion.is_connected():
            cursor.close()
            connexion.close()
            logger.info("Connexion fermée proprement")
