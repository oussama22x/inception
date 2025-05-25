FROM debian:11

RUN apt-get update && \
    apt-get install -y wget

    
RUN apt-get update && apt-get upgrade -y && apt-get install -y php7.4 \
    php7.4-fpm \
    php-mysql \
    mariadb-client
    
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

RUN sed -i "s#listen = /run/php/php7.4-fpm.sock#listen = wordpress:9000#g" /etc/php/7.4/fpm/pool.d/www.conf

RUN mkdir /run/php

COPY ./tools/sc.sh /

EXPOSE 9000

RUN chmod +x /sc.sh

ENTRYPOINT ["./sc.sh"]
