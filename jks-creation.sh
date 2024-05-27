# !/bin/sh
# 
# File:   jks-creation.sh
# Author: coder4
#
# Created on 6 Dec, 2023, 6:59:57 PM
#
# $1 = .cert file
# $2 = .key file
# $3 = password

# CMD #1
openssl pkcs12 -export -in $1 -inkey $2 -out ssl.pkcs12 -password pass:$3

# CMD #2
keytool -importkeystore -srckeystore ssl.pkcs12 -srcstoretype pkcs12 -srcalias 1 -srcstorepass $3 -destkeystore ssl.jks -deststoretype jks -deststorepass $3

# CMD #3
# Following is added as Ubuntu shows the above command will generate a properietory jks and so the following 
# should be used with password used in the first command to generate a generalized jks.
keytool -importkeystore -srckeystore ssl.jks -destkeystore ssl.jks -deststoretype pkcs12