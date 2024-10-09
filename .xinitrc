# Wyłączenie DPMS (oszczędzanie energii monitora) i wygaszacza ekranu
export XDG_RUNTIME_DIR=/tmp/runtime-$USER
xset s off
xset -dpms
xset s noblank

xrandr --output HDMI-1 --mode 2560x1440 --rate 60

#Uruchomienie Openbox
exec openbox-session &

/usr/lib/chromium-browser/chromium-browser --kiosk --start-fullscreen --no-cursor --disable-infobars http://localhost:3000
