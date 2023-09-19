# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aaammari <aaammari@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/09/03 11:47:37 by aaammari          #+#    #+#              #
#    Updated: 2023/09/18 13:24:36 by aaammari         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.17

RUN apk update && apk --no-cache add nginx && apk add openssl 

RUN mkdir -p /var/run/nginx

RUN mkdir -p /etc/nginx/ssl

# Generate a self-signed SSL certificate and key
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -subj "/C=MA/ST=Khouribga/L=Khouribga/O=1337/CN=aaammari.42.fr/UID=aaammari" \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt

COPY ./conf/default.conf /etc/nginx/conf.d/default.conf
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# COPY ./html /var/www/html

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
