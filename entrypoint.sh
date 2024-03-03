#!/bin/bash

mkdir -p "/app/logs"

echo -e "\n------------------ set VNC password  ----------------------------"
mkdir -p "/app/vnc"
PASSWD_PATH="/app/vnc/passwd"
rm -f $PASSWD_PATH
echo "$VNC_PASSWORD" | vncpasswd -f >> $PASSWD_PATH
chmod 600 $PASSWD_PATH

echo -e "\n------------------ start VNC server ------------------------"
vncserver -kill $DISPLAY &> /app/logs/vnc_startup.log \
    || rm -rfv /tmp/.X*-lock /tmp/.X11-unix &> /app/logs/vnc_startup.log \
    || echo "no locks present"

vncserver $DISPLAY -depth $VNC_COL_DEPTH -geometry $VNC_RESOLUTION PasswordFile=/app/vnc/passwd > /app/logs/no_vnc_startup.log 2>&1

echo -e "\n------------------ startup xfce window manager ------------------"
xset -dpms &
xset s noblank &
xset s off &
/usr/bin/startxfce4 --replace > /app/logs/wm.log &

echo -e "\n------------------ start noVNC  ----------------------------"
/app/noVNC/utils/novnc_proxy --vnc localhost:$VNC_PORT --listen $NO_VNC_PORT > /app/logs/no_vnc_startup.log 2>&1
