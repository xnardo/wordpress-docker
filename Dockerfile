FROM wordpress:5.1.1

# install dos2unix (fix problem between CRLF and LF)
RUN apt-get update
RUN apt-get install -y dos2unix

# increase upload limit
RUN touch /usr/local/etc/php/conf.d/uploads.ini \
    && echo "upload_max_filesize = 10M;" >> /usr/local/etc/php/conf.d/uploads.ini

# fix permissions issues
COPY entrypoint.sh /
RUN dos2unix /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
