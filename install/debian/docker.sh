#!/bin/

funtion pull() {
    docker pull logstash:5.6.9
    docker pull elasticsearch:5.6.9
    docker pull kibana:5.6.9
    docker pull influxdb:1.5.2
    docker pull shakr/statsd-influxdb
    docker pull grafana/grafana
}

funtion install_elk(){
    
}
