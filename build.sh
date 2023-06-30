#!/bin/bash

VERSION=1.1.3

PATH_DUO_UNIV=./duo_universal_java
rm -rf $PATH_DUO_UNIV
git clone -b $VERSION https://github.com/duosecurity/duo_universal_java.git $PATH_DUO_UNIV

cd $PATH_DUO_UNIV

rm -rf .git

git init

git add .

git commit 

git commit -m "Change certificate commit for v$VERSION"

git push -u -f origin b$VERSION

cd ../

rm -rf $PATH_DUO_UNIV