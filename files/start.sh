#!/bin/bash

SUID=$(stat -c "%u" /opt/steam/wurm/server)
SGID=$(stat -c "%g" /opt/steam/wurm/server)
usermod -u $SUID steam
#usermod -g $SGID steam
chown -R steam /opt/steam
chmod +x /opt/steam/wurm/WurmServerLauncher
if [ -n "$EXTERNALIP" ]; then
  sqlite3 /opt/steam/wurm/server/sqlite/wurmlogin.db "UPDATE SERVERS SET EXTERNALIP=\"$EXTERNALIP\""
else
  sqlite3 /opt/steam/wurm/server/sqlite/wurmlogin.db "UPDATE SERVERS SET EXTERNALIP=\"$(hostname -i)\""
fi

if [ -n "$INTRAIP" ]; then
  sqlite3 /opt/steam/wurm/server/sqlite/wurmlogin.db "UPDATE SERVERS SET INTRASERVERADDRESS=\"$INTRAIP\""
else
  sqlite3 /opt/steam/wurm/server/sqlite/wurmlogin.db "UPDATE SERVERS SET INTRASERVERADDRESS=\"127.0.0.1\""
fi
runuser -l steam -c 'cd /opt/steam/wurm; ./WurmServerLauncher start=server'
