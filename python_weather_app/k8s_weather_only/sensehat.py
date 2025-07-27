from datetime import date, datetime
import random, time
from sense_hat import SenseHat

sense = SenseHat()


class Weather:

    def __init__(self, temp_val, humi_val, press_val):
        self.temp_val = temp_val
        self.humi_val = humi_val
        self.press_val = press_val


# TABLES={}
# TABLES['weather_table'] = (
#  "CREATE TABLE 'weather_table' ("
#  " 'temp' int(3) NOT NULL,"
#  " 'humidity' int(3) NOT NULL,"
#  " 'pressure' int(3) NOT NULL,")


current = datetime.now()
my_weather = Weather(
    int(sense.get_temperature()),
    int(sense.get_humidity()),
    int(sense.get_pressure()),
)

# print(
#     current,
#     "\t",
#     my_weather.temp_val,
#     "\t\t",
#     my_weather.humi_val,
#     "\t\t",
#     my_weather.press_val,
# )
# time.sleep(3)

# add_weather = (
#     "INSERT INTO weather_table"
#     "(temp, humidity, pressure) "
#     "VALUES (%(temp)s, %(humidity)s,%(pressure)s)"
# )

data_weather = {
    "temp": my_weather.temp_val,
    "humidity": my_weather.humi_val,
    "pressure": my_weather.press_val,
}
print(data_weather)
