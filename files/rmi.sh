#!/bin/bash

cd /tools/
pass=$(sqlite3 /opt/steam/wurm/server/sqlite/wurmlogin.db 'select intraserverpassword from servers')
port=$(sqlite3 /opt/steam/wurm/server/sqlite/wurmlogin.db 'select rmiport from servers')
name=$(sqlite3 /opt/steam/wurm/server/sqlite/wurmlogin.db 'select name from servers')
ip=$(sqlite3 /opt/steam/wurm/server/sqlite/wurmlogin.db 'select intraserveraddress from servers')

if [[ -n "$1" ]]; then
  if [[ "$1" == "shutdown" ]]; then
    /opt/steam/wurm/runtime/jre1.8.0_172/bin/java -jar rmitool.jar $ip $port $pass $1 "$@"
  elif [[ "$1" == "broadcast" ]]; then
    /opt/steam/wurm/runtime/jre1.8.0_172/bin/java -jar rmitool.jar $ip $port $pass "$@"
  elif [[ "$1" == "isrunning" ]]; then
    /opt/steam/wurm/runtime/jre1.8.0_172/bin/java -jar rmitool.jar $ip $port $pass $1
  elif [[ "$1" == "playercount" ]]; then
    /opt/steam/wurm/runtime/jre1.8.0_172/bin/java -jar rmitool.jar $ip $port $pass $1
  fi
fi
