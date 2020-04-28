FROM centos:7

RUN yum update -y &&  yum install -y glibc.i686 libstdc++.i686 libgcc_s.so.1 wget xorg-x11-server-Xvfb nano sqlite && yum clean all
RUN Xvfb :99 & export DISPLAY=:99
RUN useradd -m steam; \
        mkdir -p /opt/steam/wurm/server; \
        chown -R steam /opt/steam;

USER steam
WORKDIR /opt/steam
RUN wget http://media.steampowered.com/installer/steamcmd_linux.tar.gz; \
        tar -xvzf steamcmd_linux.tar.gz; \
        ./steamcmd.sh +login anonymous +force_install_dir /opt/steam/wurm +app_update 402370 validate +quit; \
        cp /opt/steam/wurm/linux64/steamclient.so /opt/steam/wurm/nativelibs/; \
        rm -fr steamcmd_linux.tar.gz;

USER root
COPY files/ /root/
RUN chmod +x /root/*.sh; \
    mkdir /tools; \
    mv /root/rmitool.jar /tools/; \
    mv /root/rmi.sh /tools/;

VOLUME /opt/steam/wurm/server
EXPOSE 3724/tcp 8766 27016-27030/udp

#HEALTHCHECK --interval=5m --timeout=5s --start-period=15s CMD /tools/rmi.sh isrunning || exit 1
CMD ["/root/start.sh"]
