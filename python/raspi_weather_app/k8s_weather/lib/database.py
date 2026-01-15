import os
import time
from datetime import date, datetime

import mysql.connector

from lib.weather import get_weather

# Pod data for session...
POD_USER = os.getenv("MYSQL_USER")
POD_PASSWORD = os.getenv("MYSQL_PASSWORD")
POD_HOST = os.getenv("MYSQL_HOST")
POD_DATABASE = os.getenv("MYSQL_DATABASE")


def get_time():
    ts = time.time()

    local_time = time.localtime(ts)

    formatted = time.strftime("%Y-%m-%d %H:%M:%S", local_time)

    return formatted


def create_table(cursor: mysql.connector):
    cursor.execute(
        "CREATE TABLE IF NOT EXISTS weather_table (temp int(3), humidity int(3), pressure int(3))"
    )
    print(f"{get_time()}: TABLE CREATED!")


def add_weather(cursor: mysql.connector, temp, humidity, pressure):
    weather_data = (
        "INSERT INTO weather_table"
        "(temp, humidity, pressure) "
        "VALUES (%(temp)s, %(humidity)s,%(pressure)s)"
    )
    data_weather = {
        "temp": temp,
        "humidity": humidity,
        "pressure": pressure,
    }
    cursor.execute(weather_data, data_weather)
    print(f"{get_time()}: Data added!")


class mysqlDatabase:
    def insert_weather(self):
        db = mysql.connector.connect(
            user=POD_USER,
            password=POD_PASSWORD,
            host=POD_HOST,
            port="3306",
            database=POD_DATABASE,
        )
        cursor = db.cursor()
        create_table(cursor)
        while True:
            weather_call = get_weather()
            add_weather(
                cursor,
                weather_call["temperature"],
                weather_call["humidity"],
                weather_call["pressure"],
            )
            # print(f"{weather_call["temperature"], weather_call["humidity"], weather_call["pressure"]}")
            weather_id = cursor.lastrowid
            db.commit()
            time.sleep(300)
