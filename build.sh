#!/bin/bash

CERTPIN=sha256/C5+lpZ7tcVwmwQIMcRtPbsQtWLABXhQzejna0wHFr8M=
VERSION_DUO_UNIV=1.1.3
VERSION_DUO_CLIENT=0.5.0


PATH_DUO_UNIV=$PWD/duo_universal_java
PATH_DUO_CLIENT=$PWD/duo_client_java

## DUO UNIVERSAL
rm -rf $PATH_DUO_UNIV

git clone -b $VERSION_DUO_UNIV https://github.com/duosecurity/duo_universal_java.git $PATH_DUO_UNIV

cd $PATH_DUO_UNIV

rm -rf .git

sed -i "/.*DEFAULT_CA_CERTS = {/a \"$CERTPIN\"," duo-universal-sdk/src/main/java/com/duosecurity/Client.java

git init && git add .

git commit -m "Change certificate commit for v$VERSION_DUO_UNIV at `date`"

git branch du$VERSION_DUO_UNIV

git remote add origin-duo-universal git@github.com:ajtyauth/duo-plugins.git

git push -u -f origin-duo-universal du$VERSION_DUO_UNIV




## DUO CLIENT
git clone -b $VERSION_DUO_CLIENT https://github.com/duosecurity/duo_client_java.git $PATH_DUO_CLIENT

cd $PATH_DUO_CLIENT

rm -rf .git

sed -i "/.*DEFAULT_CA_CERTS = {/a \"$CERTPIN\"," duo-client/src/main/java/com/duosecurity/client/Http.java

git init && git add . 

git commit -m "Change certificate commit for v$VERSION_DUO_CLIENT at `date`"

git branch dc$VERSION_DUO_CLIENT

git remote add origin-duo-client git@github.com:ajtyauth/duo-plugins.git

git push -u -f origin-duo-client dc$VERSION_DUO_CLIENT


rm -rf $PATH_DUO_UNIV $PATH_DUO_CLIENT