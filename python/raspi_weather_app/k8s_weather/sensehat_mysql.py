import logging

from lib.database import mysqlDatabase

logger = logging.getLogger(__name__)


def main():
    logger.info("Initializing Weahter App...")

    sense_data = mysqlDatabase()
    sense_data.insert_weather()


if __name__ == "__main__":
    main()
