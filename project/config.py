import os

USER = os.environ.get('DB_USER')
PASSWORD = os.environ.get('DB_PASSWORD')
SERVER = os.environ.get('DB_SERVER')

class ProductionConfig():
    """Production configuration"""
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    SQLALCHEMY_DATABASE_URI = f'postgres://{USER}:{PASSWORD}@{SERVER}:5432/users_db'
