#!/usr/bin/env bash

set +e

if [ "$#" -eq 0 ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    echo "Usage: goci <Project Name> <App Name> <Author>"
    exit 1
fi

PROJECT=
APP=
AUTHOR=

if [ "$#" -eq 1 ]; then
    PROJECT=$1
    APP=$1
    AUTHOR=`whoami`
elif [ "$#" -eq 2 ]; then
    PROJECT=$1
    APP=$2
    AUTHOR=`whoami`
elif [ "$#" -gt 2 ]; then
    PROJECT=$1
    APP=$2
    AUTHOR=$3
fi


BASE=$(dirname $0)

if [ "$0" != "./goci.sh" ]; then
    which goci &> /dev/null
    if [ $? -eq 0 ];then
        BASE=/usr/local/rpm/goci/
    fi
fi

set -e

CREATED_AT=`date "+%Y-%m-%d %H:%M:%S"`

echo "Initialize -> project: $PROJECT, app: $APP, author: $AUTHOR, created_at: $CREATED_AT"

FILES="
main.go
Dockerfile
Makefile
rancher-catalog-template/{PROJECT}/0/docker-compose.yml
rancher-catalog-template/{PROJECT}/0/rancher-compose.yml
rancher-catalog-template/{PROJECT}/catalogIcon-{PROJECT}.png
rancher-catalog-template/{PROJECT}/config.yml
rancher-catalog-template/{PROJECT}/README.md
scripts/ci
scripts/goget
scripts/govendor
scripts/godep
scripts/build
scripts/pack
scripts/test
scripts/review
scripts/rancherize
scripts/git
Gopkg.lock
Gopkg.toml
"

for i in $FILES; do
    mkdir -p $APP/$(dirname $i)

    echo "Creating ./$APP/$i"

    sed -e "s/{APP}/$APP/g;s/{PROJECT}/$PROJECT/g;s/{AUTHOR}/$AUTHOR/g;s/{CREATED_AT}/$CREATED_AT/g" $BASE/$i > $APP/$i

    if echo $i | grep -q scripts; then
        chmod +x $APP/$i
    fi
done

mkdir -p $APP/rancher-catalog-template/$PROJECT/0/
mv $APP/rancher-catalog-template/{PROJECT}/0/docker-compose.yml $APP/rancher-catalog-template/$PROJECT/0/docker-compose.yml
mv $APP/rancher-catalog-template/{PROJECT}/0/rancher-compose.yml  $APP/rancher-catalog-template/$PROJECT/0/rancher-compose.yml
mv $APP/rancher-catalog-template/{PROJECT}/catalogIcon-{PROJECT}.png  $APP/rancher-catalog-template/$PROJECT/catalogIcon-$PROJECT.png
mv $APP/rancher-catalog-template/{PROJECT}/config.yml  $APP/rancher-catalog-template/$PROJECT/config.yml
mv $APP/rancher-catalog-template/{PROJECT}/README.md  $APP/rancher-catalog-template/$PROJECT/README.md
rm -rf $APP/rancher-catalog-template/{PROJECT}

cp -R $BASE/vendor $APP/

cd ./$APP

#git init
#git add -A
#git commit -m "Initial Commit"

echo "Created <$APP> in ./$APP"

echo ""

echo " --- We are done! ---

  ^
  |.-.   .-.   .-.   .-.   .-.   .-.   .-.   .-.   .->  $PROJECT/$APP
  |   '-'   '-'   '-'   '-'   '-'   '-'   '-'   '-'    is ready now!
  +----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+----->

  enjoy it...
"