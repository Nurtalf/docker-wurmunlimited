# docker-wurmunlimited

Docker container for Wurm Unlimited server.

## Prerequisite

First of all you need to create the game folder with the Wurm Unlimited Dedicated Server tool in Steam (you will find it under Library - tools in Steam). Adjust the settings to your liking and copy the files to the  `</path/to/server/folder>`  mentioned below. You will find the files under your Steam folder  `"steamapps\common\Wurm Unlimited Dedicated Server\Adventure"`  (if you used the "Adventure" folder as template).

More info about server settings and ports here:  
[http://www.wurmpedia.com/index.php/Server_administration_(Wurm_Unlimited)](http://www.wurmpedia.com/index.php/Server_administration_(Wurm_Unlimited))

## Running the container

```
docker run -d --name wurm \
    -p 3724:3724 \
    -p 8766:8766 \
    -p 27016-27030:27016-27030/udp \
    -p 8766:8766/udp \
    -v </path/to/server/folder>:/opt/steam/wurm/server \
nurtalf/wurmunlimited
```

The container configures the server IPs automatically, but if you have any issues, you can manually specify them by using the following environmental variables when creating the container:

```
-e EXTERNALIP=x.x.x.x
-e INTRAIP=x.x.x.x
```

Keep in mind that the docker container have its own internal IP address unless you use the  `--net=host`  when creating the container.

It is not necessary to specify UID and GID, as the wurm server will run as the same user as the owner of the server files. You will get issues if the server files are owned by root. I could work around this, but it is generally not recommended to run stuff as root anyways.

## Howto

Connect to to shell:  `docker exec -it wurm /bin/bash`  
Logs:  `docker logs -f wurm`  
Verify if server is up:  `docker exec -it wurm /tools/rmi.sh isrunning`  
Online player count:  `docker exec -it wurm /tools/rmi.sh playercount`  
Broadcast message:  `docker exec -it wurm /tools/rmi.sh broadcast "Hello everyone"`  
Shutdown server in 1 minute:  `docker exec -it wurm /tools/rmi.sh shutdown 60 "Quick server maintenance."`

The server will not update on restart, as it might be necessary to do manual adjustments in the Wurm SQLite database when updating to a new version. Remember to always backup your server files, you'll never know when something could break.
