#!/usr/bin/env bash

set -e

APP=goci

chmod +x goci.sh
dos2unix goci.sh

mkdir -p ./rpm/$APP
cp Dockerfile ./rpm/$APP
cp goci.sh ./rpm/$APP
cp main.go ./rpm/$APP
cp Makefile ./rpm/$APP
cp README.md ./rpm/$APP
cp Gopkg.lock ./rpm/$APP
cp Gopkg.toml ./rpm/$APP
cp -R vendor ./rpm/$APP
cp -R scripts ./rpm/$APP
cp -R rancher-catalog-template ./rpm/$APP


VERSION=1.0.0
tar cvf ./rpm/$APP-$VERSION.tar ./rpm/$APP

PKGNAME=$APP-$VERSION-$(date +%Y.%m.%d+%H%M).x86_64.rpm
PKGNAME_MINI=$APP-$VERSION.x86_64.rpm

#打包成rpm
t2r ./rpm/$APP-$VERSION.tar -n $APP -v $VERSION -t /usr/local --summary "A CI Flow builder for Go applications based on yourdomain's repository."

#上传到安装包仓库
PKGPATH=/home/yourname/workspace/rpm/RPMS/x86_64/$PKGNAME
PKGPATH_MINI=/home/yourname/workspace/rpm/RPMS/x86_64/$PKGNAME_MINI
cp -f $PKGPATH $PKGPATH_MINI

curl -F file=@$PKGPATH_MINI http://agent.ops.yourdomain.com:8000/$APP -H 'authorization: Basic eWZvcHM6d2hvbW92ZWRteWNoZWVzZQ=='

#输出安装包地址
echo ": http://agent.ops.yourdomain.com:8000/$APP/$PKGPATH_MINI"
echo "Done!"

echo "----------------------------------------"
echo "Use below script to install the rpm:"
echo "bash <(curl -s http://agent.ops.yourdomain.com/static/$APP/install.sh)"