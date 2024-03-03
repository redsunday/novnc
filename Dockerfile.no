# This is Lechcher's VPS on Hugging face or OpenXLab! (Lxde version)
FROM debian:sid

# This is user's part:
RUN useradd -m -u 1000 user

# Upgrade and update your system:
RUN apt update
RUN apt install software-properties-common apt-transport-https curl -y

# This is desktop environment and dependents part:
RUN apt install xfce4-terminal lxde aqemu sudo curl wget aria2 qemu-system-x86 htop chromium screen tigervnc-standalone-server python3-pip python3-websockify python3 git -y && rm -rf /var/lib/apt/lists/*

# This is set default graphical target:
RUN systemctl get-default
RUN systemctl set-default graphical.target

# Emable 32bit support:
RUN dpkg --add-architecture i386

# This is part that you can install your apps by: RUN apt install <repositories>:

# This is VNC viewer part:
RUN git clone https://github.com/novnc/noVNC.git noVNC
ENV HOME=/home/user \
    PATH=/home/user/.local/bin:$PATH

# This is the command to run VPS:
CMD vncserver -SecurityTypes None -geometry 1280x600 && ./noVNC/utils/novnc_proxy --vnc localhost:5901 --listen 0.0.0.0:7860
