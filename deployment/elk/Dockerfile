FROM logstash:5.6.9
ENV http_proxy=http://127.0.0.1:3128
ENV https_proxy=http://127.0.0.1:3128

RUN bin/logstash-plugin install logstash-output-influxdb

ENV http_proxy=
ENV https_proxy=