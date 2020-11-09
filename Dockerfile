FROM ubuntu:latest
MAINTAINER Abhishek Maharjan

# Environmental variable added to disble the interactive mode to prevent installation from halting
ENV DEBIAN_FRONTEND=noninteractive

# Installtion of webserver and setting up the variables
RUN apt-get update
RUN apt-get install -y apache2
RUN apt-get install -y git
RUN mkdir -p /var/lock/apache2
RUN mkdir -p /var/run/apache2
ENV APACHE_RUN_USER=www-data
ENV APACHE_RUN_GROUP=www-data
ENV APACHE_PID_FILE=/var/run/apache2.APACHE_PID_FILE
ENV APACHE_RUN_DIR=/var/run/apache2
ENV APACHE_LOCK_DIR=/var/lock/apache2
ENV APACHE_LOG_DIR=/var/log/apache2

#Firing off a webserver
CMD [ "/usr/sbin/apache2","-D","FOREGROUND" ]
EXPOSE 80

#Clonning the webcontent from the git-hub and copying to the root directory of webserver
RUN mkdir -p /usr/src/trc \
&& cd /usr/src/trc \
&& git clone https://github.com/avsek94/TRC_Assessment.git \
&& mv /usr/src/trc/TRC_Assessment/web/index.html /var/www/html

test  test stwes twts st st s ts t st s wasdfpksadfl ;jasif

fkjasd fjasd;flas/
DEBIAN_FRONTENDkdfh asidkf sa]fsadfsa foi

