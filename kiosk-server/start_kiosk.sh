#!/bin/bash
#export DISPLAY=:0
#export XDG_RUNTIME_DIR=/tmp/$(id -u)-runtime-dir
#mkdir -p $XDG_RUNTIME_DIR
#chmod 700 $XDG_RUNTIME_DIR
#xrandr --output HDMI-1 --mode 2560x1440 --rate 60  # lub dostosuj do swojej rozdzielczości
#!/bin/bash

# Sprawdzenie, czy X jest już uruchomione
if pgrep -x "Xorg" > /dev/null
then
    echo "X server already running."
    exit 0
fi

#cd /home/n1copl/kiosk-server
#pm2 start server.js --name "kiosk-server"
# Uruchomienie sesji X
#sleep 3
exec startx







