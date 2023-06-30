#!/bin/bash


VERSION_DUO_UNIV=1.1.3
VERSION_DUO_CLIENT=0.5.0

CERTPIN=sha256/C5+lpZ7tcVwmwQIMcRtPbsQtWLABXhQzejna0wHFr8M=

SCRIPT_PATH=$PWD
PATH_DUO_UNIV=$SCRIPT_PATH/duo_universal_java
PATH_DUO_CLIENT=$SCRIPT_PATH/duo_client_java

function downloadFromGit() {
    REPO_URL=$1
    REPO_PATH=$2
    REPO_BRANCH=$3

    rm -rf $REPO_PATH

    git clone -b $REPO_BRANCH $REPO_URL $REPO_PATH
}

function modifyCerts(){
    FPATH=$1
    MODIFY_FILE=$2

    sed -i "/.*DEFAULT_CA_CERTS = {/a \"$CERTPIN\"," $FPATH/$MODIFY_FILE
}

function uploadToGit() {
    FPATH=$1
    VERSION=$2
    PREFX=$3
    cd $FPATH

    rm -rf .git

    git init && git add . 

    git commit -m "Change certificate commit for v$VERSION at `date`"

    git branch $PREFX$VERSION

    git remote add origin git@github.com:ajtyauth/duo-plugins.git

    git push -u -f origin $PREFX$VERSION

    cd $SCRIPT_PATH
}

function removeRepo() {
    FPATH=$1

    rm -rf $FPATH
}

downloadFromGit "https://github.com/duosecurity/duo_universal_java.git" "$PATH_DUO_UNIV" "$VERSION_DUO_UNIV"
modifyCerts "$PATH_DUO_UNIV" "duo-universal-sdk/src/main/java/com/duosecurity/Client.java"
uploadToGit "$PATH_DUO_UNIV" "$VERSION_DUO_UNIV" "du"
removeRepo  "$PATH_DUO_UNIV"

downloadFromGit "https://github.com/duosecurity/duo_client_java.git" "$PATH_DUO_CLIENT" "$VERSION_DUO_CLIENT"
modifyCerts "$PATH_DUO_CLIENT" "duo-client/src/main/java/com/duosecurity/client/Http.java"
uploadToGit "$PATH_DUO_CLIENT" "$VERSION_DUO_CLIENT" "dc"
removeRepo  "$PATH_DUO_CLIENT"