import os

class Config:
    
    # Вимикаємо функцію SQLAlchemy, яка відстежує зміни і надсилає сигнали
    SQLALCHEMY_TRACK_MODIFICATIONS = False

    # --- НАЛАШТУВАННЯ ПІДКЛЮЧЕННЯ ДО БАЗИ ДАНИХ ---
    DB_USER = "root"
    DB_PASSWORD = "root"
    DB_HOST = "127.0.0.1:3336"
    DB_NAME = "Security_system"

    # Формуємо рядок підключення (Connection String)
    SQLALCHEMY_DATABASE_URI = f"mysql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}/{DB_NAME}"