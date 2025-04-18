FROM flashlight13/godot:4.4 AS base
RUN apt-get update && apt-get install -y \
    libx11-6 \
    libx11-xcb1 \
    libxcursor1 \
    libxinerama1 \
    libxrandr2 \
    libxss1 \
    libxi6 \
    libfontconfig1 \
    libwayland-client0 \
    libwayland-cursor0 \
    libxkbcommon0 \
    libxcb1 \
    libxcb-keysyms1 \
    libxcb-icccm4 \
    libxcb-image0 \
    libxcb-shm0 \
    libxcb-util1 \
    libxcb-xinerama0 \
    libxcb-xkb1 \
    libxkbcommon-x11-0 \
    libxext6  \
    libxrender1  \
    libxtst6  \
    libxi6  \
    libxrandr2  \
    libgl1-mesa-glx x11-apps   

WORKDIR /app

COPY . /app/

ENV DISPLAY=:0

CMD ["godot", "--editor", "--path", "/app"]

