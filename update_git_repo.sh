#!/bin/bash
#test zmiany 2
# Przejdź do katalogu z repozytorium
while ! ping -c 1 -W 1 github.com; do
    echo "Czekam na połączenie z internetem..."
    sleep 10
done

cd /home/n1copl/

# Zaktualizuj repozytorium
git fetch origin
git reset --hard origin/main

# (Opcjonalnie) Restart aplikacji po aktualizacji, np. za pomocą PM2
# pm2 restart kiosk-app
