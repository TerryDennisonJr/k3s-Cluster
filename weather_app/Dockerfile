FROM arm64v8/ubuntu

WORKDIR /tmp

RUN apt-get update \
&& apt-get install -y python3 \
python3-pip \
python3-apt \
&& python3 -m pip install setuptools --break-system-packages \
&& pip install mysql-connector-python --break-system-packages \
&& apt-get install -y curl \
librtimulib7 \
git \
libopenjp2-7 \
build-essential \
sense-hat \
nano 

ADD ./sensehat_mysql.py \
./sensehat.py /home/

RUN rm -f /tmp/*.deb && apt-get clean

WORKDIR /

ENTRYPOINT ["python3", "/home/sensehat_mysql.py"]