#!/usr/bin/env bash

GOCI_PKG=goci-1.0.0.x86_64.rpm

echo "GOCI_PKG: "$GOCI_PKG
rpm -Uvh --force http://agent.ops.yunfancdn.com/static/goci/$GOCI_PKG

ln -sf /usr/local/rpm/goci/goci.sh /usr/bin/goci