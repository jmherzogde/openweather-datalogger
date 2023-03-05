# OpenWeather Datalogger

Weather data logger with an interface to OpenWeathermap. Retrieves the current weather data for arbitary locations with a Python script and stores the data in a MongoDB database.

## Openweathermap.org API

The openweathermap organisation provide there API for free with the restriction of 1000 requests per day with a limit of 60 calls per hour. Other plans are available. There are no limitations for generating individuakl API keys.

Further informations:
[1] https://openweathermap.org/current

## Docker Container

docker-compose will generate two containers. A container including the mongodb database and another will provide the python3 environment to fetch weather informations. The container can be generated with the _docker-compose_ command.

```
docker-compose build
```

After the container have been built. You can start them with the following command:

```
docker-compose up -d
```

### Database

The database container is based on a compatible ARM image for mongodb V2. Access cover the port 21017. No further user credentials needed.

### Python3 Container

This container is based on a Ubuntu image and provides a Python3 environment. Furthermore some python libraries will be installed like pymongo and requests.
Note: Maybe the timezone of the container have to be changed. Sometimes wrong timestamps will be generated.

#### Python3 Container - Change timezone

The time zone can be configured in the Dockerfile. Here the time zone Europe/Berlin is preconfigured.

#### Update weather locations and API key

Please update your weather locations and API key in the _get_weather.py_ file. 

```
api_code = ''
lang = 'de'
weather_locations = []
base_url = 'http://api.openweathermap.org/data/2.5/weather?'
req_recon_time = 10  # seconds
```

#### Update database credentials

Please update the MongoDB database credentials in the file _get_weather.py_.

```
db_host = "database"
db_port = "27017"
db_user = ''
db_pass = ''
```

## Fetch weather informations

The weather from openweathermap can be fetched and saved with the python script _get_weather.py_. It is helpful to create a cronjob for this action.

### Cronjob anlegen

A corresponding cron job can be set up so that the weather informations can be fetched automatically. The following command must be entered in the terminal:

```
crontab -e
```

In the example below, the weather data is retrieved every 30 minutes:

```
LANG=de_DE.UTF-8
LANGUAGE=de
LC_TYPE=de_DE.UTF-8
PYTHONENCODING=utf8

*/30 * * * * python3 /home/src/get_weather.py >> /home/sc/logfile 2&>1
```

All screen outputs of the programm are saved in the log file located at _/home/src/logfile_.

Finally the crontab service has to be started.

```
service cron start
```
