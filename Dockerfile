FROM debian:bullseye

WORKDIR /

ENV DEBIAN_FRONTEND=noninteractive \
    INST_SCRIPTS=/app/install \
    NO_VNC_PORT=6081 \
    VNC_PORT=5901 \
    VNC_PASSWORD=1234 \
    DISPLAY=:1 \
    VNC_RESOLUTION=1280x800 \
    VNC_COL_DEPTH=24

EXPOSE $VNC_PORT $NO_VNC_PORT

ADD ./tools/ /app/install
RUN chmod +x /app/install/tools_app.sh
RUN /app/install/tools_app.sh

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
