#!/bin/sh
set -e

exec java $@ -Dfile.encoding=UTF-8 -Dlog4j2.formatMsgNoLookups=true -jar /app/app.jar
