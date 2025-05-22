#!/bin/bash
# test zmiany 2
# czyscimy logi, w pamieci sprawdzic jeszcze bledy z xwin
sudo journalctl --vacuum-time=7d 
sleep 5
cd /home/n1copl/
sleep 10


git fetch origin
git reset --hard origin/main


# pm2 restart kiosk-app
