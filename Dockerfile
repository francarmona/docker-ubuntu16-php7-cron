FROM ubuntu:16.04
MAINTAINER Francisco Carmona <fcarmona.olmedo@gmail.com>

# Environments vars
ENV TERM=xterm

RUN apt-get update
RUN apt-get -y upgrade

# Packages installation
RUN DEBIAN_FRONTEND=noninteractive apt-get -y --fix-missing install php-cli \
      wget \
      curl \
      php-curl \
      cron \
      ca-certificates \
      nano

# Gosu
ENV GOSU_VERSION 1.7
RUN set -x \
	&& wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
	&& wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
	&& gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
	&& rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
	&& chmod +x /usr/local/bin/gosu \
	&& gosu nobody true

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


COPY config/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x  /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Volumes
VOLUME ["/etc/cron.d/tasks","/app/php-tasks"]

CMD /usr/sbin/cron && tail -f /var/log/cron.log