from sense_hat import SenseHat


def get_weather():
    sense = SenseHat()
    sensehat = {
        "temperature": int(sense.get_temperature()),
        "humidity": int(sense.get_humidity()),
        "pressure": int(sense.get_pressure()),
    }
    return sensehat
