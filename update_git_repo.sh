#!/bin/bash
# test zmiany 2
# Przejdź do katalogu z repozytorium
sudo journalctl --vacuum-time=7d 
sleep 5
cd /home/n1copl/
sleep 10

# Zaktualizuj repozytorium
git fetch origin
git reset --hard origin/main

# (Opcjonalnie) Restart aplikacji po aktualizacji, np. za pomocą PM2
# pm2 restart kiosk-app
