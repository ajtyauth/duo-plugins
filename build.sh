#!/bin/bash

VERSION=1.1.3

git checkout -b b$VERSION

git clone -b $VERSION https://github.com/duosecurity/duo_universal_java.git

rm -rf ./duo_universal_java/.git

cp -r ./duo_universal_java .

git commit -m "Change certificate commit for v $VERSION"

git push

git checkout -b master

git reset --hard 

git clean -f -d