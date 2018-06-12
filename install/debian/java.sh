#!/bin/bash
export JAVA_VERSION="1.8.0"
export JAVA_BUILD="171"

#Download
#wget http://download.oracle.com/otn-pub/java/jdk/8u171-b11/512cd62ec5174c3487ac17c61aaa89e8/jdk-8u171-linux-x64.tar.gz?AuthParam=1528787029_b8ce7443db5a3620c073fa91d9ea3a52

mkdir /opt/jdk
tar -zxf jdk-8u$JAVA_BUILD-linux-x64.tar.gz -C /opt/jdk 
update-alternatives --install /usr/bin/java java /opt/jdk/jdk$JAVA_VERSION"_"$JAVA_BUILD/bin/java 100
update-alternatives --install /usr/bin/javac javac /opt/jdk/jdk$JAVA_VERSION"_"$JAVA_BUILD/bin/javac 100