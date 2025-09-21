FROM arm64v8/ubuntu

COPY k8s_weather/sensehat_mysql.py /mnt/host-data/

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

ENTRYPOINT ["python3", "/mnt/host-data/sensehat_mysql.yaml"]
# ENTRYPOINT [ "sleep", "infinity" ]