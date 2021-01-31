FROM p5ych0/php-fpm:v7.4.14-fpm

RUN wget http://browscap.org/stream?q=Full_PHP_BrowsCapINI -O /usr/local/etc/php/browscap.ini \
    && wget 'https://caddyserver.com/api/download?os=linux&arch=amd64' -O /usr/local/bin/caddy \
    && echo -e "[global]\ndaemonize = no\n" > /usr/local/etc/php-fpm.d/zz-docker.conf

COPY ./www.conf /usr/local/etc/php-fpm.d/www.conf
COPY ./php.ini /usr/local/etc/php/php.ini
COPY ./Caddyfile /etc/caddy/Caddyfile
COPY /supervisor/laravel.ini /etc/supervisor.d/laravel.ini

ENTRYPOINT ["/usr/bin/supervisord", "-n", "-j", "/run/supervisord.pid"]
