FROM php:7.4-apache

LABEL maintainer="Micah Mitchell <code@mitchell.dev>"
ARG Version=latest

WORKDIR /src

RUN	apt-get update \
	&& apt-get -qqy install wget bind9 bind9utils dnsutils sudo \
	&& wget http://www.facilemanager.com/download/facilemanager-complete-$Version.tar.gz \
	&& tar -xvf facilemanager-complete-$Version.tar.gz \
	&& mv facileManager/client/facileManager /usr/local \
	&& ln -s /usr/local/facileManager/www /var/www/html/fM

COPY config.inc.php /usr/local/facileManager/
COPY entrypoint.sh /
COPY php.ini /usr/local/etc/php/

# Patches that are part of https://github.com/WillyXJ/facileManager/pull/552
COPY functions.php.patch /usr/local/facileManager/
COPY functions.php-fmDNS.patch /usr/local/facileManager/fmDNS/
RUN patch /usr/local/facileManager/functions.php /usr/local/facileManager/functions.php.patch
RUN patch /usr/local/facileManager/fmDNS/functions.php /usr/local/facileManager/fmDNS/functions.php-fmDNS.patch
# End patches

RUN mkdir /var/log/bind \
    && chown bind:bind /var/log/bind

ENV FACILE_MANAGER_HOST=localhost/
ENV FACILE_MANAGER_AUTHKEY=default
ENV FACILE_CLIENT_SERIAL_NUMBER=

CMD ["apache2-foreground"]
ENTRYPOINT ["/entrypoint.sh"]

RUN rm -rf /var/lib/apt/lists/* \
    && rm -rf /src/facileManager/
