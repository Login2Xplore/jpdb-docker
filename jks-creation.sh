#!/bin/sh
# 
# File:   jks-creation.sh
# Author: coder4
#
# Created on 6 Dec, 2023, 6:59:57 PM
#
# $1 = .cert file
# $2 = .key file
# $3 = password

openssl pkcs12 -export -in $1 -inkey $2 -out ssl.pkcs12 -password pass:$3

keytool -importkeystore -srckeystore ssl.pkcs12 -srcstoretype pkcs12 -srcalias 1 -srcstorepass $3 -destkeystore ssl.jks -deststoretype jks -deststorepass $3