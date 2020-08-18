FROM wordpress:5.1.1

# install dos2unix (fix problem between CRLF and LF) and increase upload limit
RUN apt-get update -y && \
    apt-get install -y dos2unix && \
    touch /usr/local/etc/php/conf.d/uploads.ini \
    && echo "upload_max_filesize = 10M;" >> /usr/local/etc/php/conf.d/uploads.ini && \
    chown -R www-data:www-data /var/www/html/wp-content

# fix permissions issues
COPY entrypoint.sh /
RUN dos2unix /entrypoint.sh && \
    chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
