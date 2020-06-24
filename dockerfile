FROM ubuntu:latest
MAINTAINER Abhishek Maharjan

RUN apt-get update
RUN apt-get install -y apache2
RUN mkdir -p /var/lock/apache2
RUN mkdir -p /var/run/apache2
ENV APAHCE_RUN_USER=cloud_user
ENV APACHE_RUN_GROUP=cloud_user
ENV APACHE_PID_FILE=/var/run/apache2.APACHE_PID_FILE
ENV APACHE_RUN_DIR=/var/run/apache2
ENV APACHE_LOCK_DIR=/var/lock/apache2
ENV APACHE_LOG_DIR=/var/lof/apache2

CMD [ "/usr/sbin/apache2","-D","FOREGROUND" ]

EXPOSE 80

RUN mkdir -p /usr/src/trc
RUN cd /usr/src/trc
RUN git clone https://github.com/avsek94/TRC_Assessment.git
COPY /usr/src/trc/web/inde.html /var/www/html