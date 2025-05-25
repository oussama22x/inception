#!/bin/bash

openssl req -x509 -nodes -out $SSL_CRL -keyout $SSL_KEY -subj "/CN=$DOMAIN_NAME"

nginx -g "daemon off;"

