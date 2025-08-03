from datetime import date, datetime
import random, time, mysql.connector, logging
from sense_hat import SenseHat

sense = SenseHat()

logger = logging.getLogger(__name__)
console_handler = logging.StreamHandler()
logger.addHandler(console_handler)


print("Initializing Weahter App...")


class Weather:

    def __init__(self, temp_val, humi_val, press_val):
        self.temp_val = temp_val
        self.humi_val = humi_val
        self.press_val = press_val


db = mysql.connector.connect(
    user="dd_earl",
    password="password_weather",
    host="mysql-svc",
    port="3306",
    database="weather_database",
)
cursor = db.cursor()

cursor.execute(
    "CREATE TABLE IF NOT EXISTS weather_table (temp int(3), humidity int(3), pressure int(3))"
)

current = datetime.now()
db = mysql.connector.connect(
    user="dd_earl",
    password="password_weather",
    host="mysql-svc",
    port="3306",
    database="weather_database",
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
