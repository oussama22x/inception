FROM debian:11

RUN mkdir -p etc/nginx/ssl

RUN apt-get update && apt install -y nginx && apt install  openssl -y

COPY ./conf.conf /etc/nginx/conf.d/default.conf

EXPOSE 443

COPY ./tools/sc.sh /
 
RUN chmod +x /sc.sh

ENTRYPOINT ["./sc.sh"]
