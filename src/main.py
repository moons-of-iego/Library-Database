from src.database_manager import DatabaseManager

if __name__ == "__main__":
    print("Updating schema ...")
    DatabaseManager.initialize(pool_size=3)
    DatabaseManager.update_database_scheme("sql/00_drop_test_table.sql")
    print("schema successfully updated.")
