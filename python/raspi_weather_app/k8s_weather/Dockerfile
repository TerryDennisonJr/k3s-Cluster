FROM arm64v8/ubuntu

# COPY k8s_weather/ /mnt/host-data/

WORKDIR /tmp

 
COPY k8s_weather/requirements.txt /tmp

RUN apt-get update \
&& apt-get install -y python3 \
curl \
python3-pip \
librtimulib7 \
git \
libopenjp2-7 \
build-essential \
sense-hat \
nano \ 
python3-apt 

RUN pip install -r requirements.txt --break-system-packages

RUN rm -f /tmp/*.deb && apt-get clean

WORKDIR /

RUN mkdir weather_app 
RUN chmod 777 weather_app
COPY k8s_weather weather_app

# ENTRYPOINT ["python3", "/mnt/host-data/sensehat_mysql.py"]
ENTRYPOINT [ "sleep", "infinity" ]