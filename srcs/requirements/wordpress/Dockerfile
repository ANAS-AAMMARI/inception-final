# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aaammari <aaammari@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/09/05 11:02:27 by aaammari          #+#    #+#              #
#    Updated: 2023/09/19 10:35:20 by aaammari         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Use the official Alpine Linux base image
FROM alpine:3.17

# Update package lists and install necessary packages
RUN apk update && apk upgrade && apk add php php-fpm php-mysqli php-phar php-mbstring

# Create the directory for your web application
RUN mkdir -p /var/www/html

# Copy the PHP-FPM configuration file
COPY ./conf/www.conf /etc/php81/php-fpm.d/www.conf

# Create the folder to enable PHP-FPM to start
RUN mkdir -p /run/php

COPY ./tools/script.sh /usr/local/bin/script.sh
# COPY ./tools/test.sh /usr/local/bin/test.sh

# Expose the port that PHP-FPM will listen on (default: 9000)
EXPOSE 9000

# Change ownership of the web directory to root
RUN chown -R root:root /var/www/html

# Start PHP-FPM in foreground mode
# CMD ["php-fpm81", "-F"]

# RUN chmod +x /usr/local/bin/script.sh
RUN chmod +x /usr/local/bin/script.sh

# CMD ./usr/local/bin/script.sh
CMD ./usr/local/bin/script.sh
