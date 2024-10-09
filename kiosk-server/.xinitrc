# Wyłączenie DPMS (oszczędzanie energii monitora) i wygaszacza ekranu
xset s off
xset -dpms
xset s noblank

xrandr --output HDMI-1 --mode 2560x1440 --rate 60

#Uruchomienie Openbox
exec openbox-session &

unclutter -idle 0 &

/usr/lib/chromium-browser/chromium-browser --kiosk --start-fullscreen --disable-infobars http://localhost:3000
