FROM dnhsoft/shopware-base:php72

ARG SHOPWARE_VERSION

COPY swtools /swtools

RUN chmod a+x /swtools/*

# ENV COMPOSER_HOME /shopware
WORKDIR /shopware

# RUN curl -s https://getcomposer.org/installer | php

# RUN touch /var/log/swcron.log /var/log/swcron-errors.log


ENV SWDB_USER root
ENV SWDB_PASS 123456
ENV SWDB_DATABASE shopware
ENV SWDB_HOST db
ENV SWDB_PORT 3306
ENV SW_CRON 0
ENV SW_HTTPS on
ENV SWSNIPPET_READ_FROM_DB 1
ENV SWSNIPPET_WRITE_TO_DB 1
ENV SWSNIPPET_READ_FROM_INI 0
ENV SWSNIPPET_WRITE_TO_INI 0
ENV SWSNIPPET_SHOW_SNIPPET_PLACE_HOLDER 0
ENV SWFRONT_NO_ERROR_HANDLER 0
ENV SWFRONT_THROW_EXCEPTIONS 0
ENV SWFRONT_DISABLE_OUTPUT_BUFFERING 0
ENV SWFRONT_SHOW_EXCEPTION 0
ENV SWPHPSETTINGS_DATE_TIMEZONE UTC
ENV SWPHPSETTINGS_DISPLAY_ERRORS 1
ENV SWPHP_IONCUBE_ENABLE 0

ENV SWCSRFPROTECTION_FRONTEND 1
ENV SWCSRFPROTECTION_BACKEND 1
ENV SWFRONT_CHARSET "utf-8"
ENV SWHTTPCACHE_ENABLED 1
ENV SWHTTPCACHE_LOOKUP_OPTIMIZATION 1
ENV SWHTTPCACHE_DEBUG 0
ENV SWHTTPCACHE_DEFAULT_TTL 0
ENV SWHTTPCACHE_ALLOW_RELOAD 0
ENV SWHTTPCACHE_ALLOW_REVALIDATE 0
ENV SWHTTPCACHE_STALE_WHILE_REVALIDATE 2
ENV SWHTTPCACHE_STALE_IF_ERROR 0
ENV SWHTTPCACHE_CACHE_COOKIES "shop|currency|x-cache-context-hash"


RUN echo ${SHOPWARE_VERSION}

# download, unzip and override some Shopware files

RUN /swtools/download-shopware.sh
RUN /swtools/unzip-shopware.sh

COPY assets/config.php /shopware/config.php
RUN chmod 644 /shopware/config.php

COPY assets/configs-default.php /shopware/engine/Shopware/Configs/Default.php
RUN chmod 644 /shopware/engine/Shopware/Configs/Default.php
