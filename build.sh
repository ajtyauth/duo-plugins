#!/bin/bash

VERSION=1.1.3

git branch b$VERSION

git checkout b$VERSION

git clone -b $VERSION https://github.com/duosecurity/duo_universal_java.git

rm -rf ./duo_universal_java/.git

cp -r ./duo_universal_java .

git add .

git commit -m "Change certificate commit for v$VERSION"

git push origin b$VERSION

git checkout master

git reset --hard 

git clean -f -d