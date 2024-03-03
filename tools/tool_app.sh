#!/bin/bash
set -e
set -u

echo "Install common tools"
apt-get update
# python3-numpy used for websockify/novnc
apt-get install -y vim wget net-tools locales bzip2 procps python3-numpy
apt-get clean -y

echo "generate locales für en_US.UTF-8"
locale-gen en_US.UTF-8

echo "Install xfce"
apt-get update
apt-get install -y xfce4 dbus-x11
apt-get clean -y

echo "Installing ttf-wqy-zenhei"
apt-get install -y ttf-wqy-zenhei
apt-get clean -y

echo "Install tigervnc"
apt-get install -y tigervnc-standalone-server
apt-get clean -y
printf '\n$localhost = "no";\n1;\n' >>/etc/tigervnc/vncserver-config-defaults

echo "Install Chrome"
apt-get install fonts-liberation libu2f-udev xdg-utils -y
apt-get clean -y
wget -qO- https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O /google-chrome-stable_current_amd64.deb
dpkg -i /google-chrome-stable_current_amd64.deb
rm -f /google-chrome-stable_current_amd64.deb

echo "Install Firefox"
apt-get install firefox-esr -y
apt-get clean -y

echo "Install noVNC"
mkdir -p /app/noVNC/utils/websockify
wget -qO- https://github.com/novnc/noVNC/archive/refs/tags/v1.4.0.tar.gz | tar xz --strip 1 -C /app/noVNC
wget -qO- https://github.com/novnc/websockify/archive/refs/tags/v0.11.0.tar.gz | tar xz --strip 1 -C /app/noVNC/utils/websockify
ln -s /app/noVNC/vnc.html /app/noVNC/index.html
