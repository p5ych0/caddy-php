FROM p5ych0/php-fpm:v7.4-fpm

ENV PHP_OPCACHE_FREQ=0

RUN wget http://browscap.org/stream?q=Full_PHP_BrowsCapINI -O /usr/local/etc/php/browscap.ini \
    && wget 'https://caddyserver.com/api/download?os=linux&arch=amd64' -O /usr/local/bin/caddy \
    && echo -e "[global]\ndaemonize = no\n\n[browscap]\nbrowscap = /usr/local/etc/php/browscap.ini\n" > /usr/local/etc/php-fpm.d/zz-docker.conf \
    && chmod 0775 /usr/local/bin/caddy

COPY ./www.conf /usr/local/etc/php-fpm.d/www.conf
COPY ./Caddyfile /etc/caddy/Caddyfile
COPY /supervisor/laravel.ini /etc/supervisor.d/laravel.ini

ENTRYPOINT ["/usr/bin/supervisord", "-n", "-j", "/run/supervisord.pid"]
