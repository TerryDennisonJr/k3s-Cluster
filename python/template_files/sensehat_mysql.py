import os
import random
import time
import mysql.connector
import logging
from sense_hat import SenseHat
from datetime import date, datetime
from datadog import initialize, statsd

ip = os.environ.get("DD_AGENT_HOST")

options = {
    'statsd_host':ip,
    'statsd_port':8125
}

initialize(**options)

sense = SenseHat()

logger = logging.getLogger(__name__)
console_handler = logging.StreamHandler()
logger.addHandler(console_handler)


print("Initializing Weahter App...")
# Pod data for session...
pod_user = os.getenv("MYSQL_USER")
pod_password = os.getenv("MYSQL_PASSWORD")
pod_host = os.getenv("MYSQL_HOST")
pod_database = os.getenv("MYSQL_DATABASE")


class Weather:

    def __init__(self, temp_val, humi_val, press_val):
        self.temp_val = temp_val
        self.humi_val = humi_val
        self.press_val = press_val


db = mysql.connector.connect(
    user=pod_user,
    password=pod_password,
    host=pod_host,
    port="3306",
    database=pod_database,
)
cursor = db.cursor()

cursor.execute(
    "CREATE TABLE IF NOT EXISTS weather_table (temp int(3), humidity int(3), pressure int(3))"
)

while True:
    current = datetime.now()
    db = mysql.connector.connect(
        user=pod_user,
        password=pod_password,
        host=pod_host,
        port="3306",
        database=pod_database,
    )
    cursor = db.cursor()

    my_weather = Weather(
        int(sense.get_temperature()), int(sense.get_humidity()), int(sense.get_pressure())
    )

    add_weather = (
        "INSERT INTO weather_table"
        "(temp, humidity, pressure) "
        "VALUES (%(temp)s, %(humidity)s,%(pressure)s)"
    )

    data_weather = {
        "temp": my_weather.temp_val,
        "humidity": my_weather.humi_val,
        "pressure": my_weather.press_val,
    }
    print(data_weather)
    logger.info(data_weather)
    cursor.execute(add_weather, data_weather)
    weather_id = cursor.lastrowid

    db.commit()

    # Submit Dogstatsd Gauge Metrics
    statsd.gauge('temperature.gauge', my_weather.temp_val,tags=["device:raspi4"])
    statsd.gauge('humidity.gauge',  my_weather.humi_val, tags=["device:raspi4"])
    statsd.gauge('pressure.gauge', my_weather.press_val, tags=["device:raspi4"])
    
    time.sleep(60)