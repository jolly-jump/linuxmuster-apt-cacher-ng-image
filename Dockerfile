FROM debian:stable-slim
LABEL maintainer="Tobias Küchel <devel@zukuul.de>"

# apt install packages
RUN apt-get update && apt-get -y full-upgrade
RUN apt-get -y install --no-install-recommends apt-cacher-ng cron rsyslog
RUN mkdir /app
COPY entrypoint.sh /app/
#COPY apt-cacher-ng-shrink /etc/cron.weekly/
#RUN chmod 755 /etc/cron.weekly/apt-cacher-ng-shrink && chmod 755 /app/entrypoint.sh
RUN chmod 755 /app/entrypoint.sh

EXPOSE 3142
VOLUME /var/cache/apt-cacher-ng

# start in foreground
#ENTRYPOINT ["/usr/sbin/apt-cacher-ng", "-c", "/etc/apt-cacher-ng", "foreground=1"]
ENTRYPOINT ["/app/entrypoint.sh"]
