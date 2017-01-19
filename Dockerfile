FROM ubuntu:16.04
MAINTAINER Francisco Carmona <fcarmona.olmedo@gmail.com>

# Environments vars
ENV TERM=xterm

RUN apt-get update
RUN apt-get -y upgrade

# Packages installation
RUN DEBIAN_FRONTEND=noninteractive apt-get -y --fix-missing install php-cli \
      curl \
      php-curl \
      cron \
      nano

# Update php.ini
ADD config/php/php.conf /etc/php/7.0/cli/php.ini

# Composer install
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

RUN touch /var/log/cron.log

# Set the timezone.
RUN echo "Europe/Madrid" > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata

RUN mkdir /app
RUN chmod -R 755 /app
WORKDIR /app/php-tasks

# Volumes
VOLUME ["/etc/cron.d","/app/php-tasks"]

CMD /usr/sbin/cron && tail -f /var/log/cron.log