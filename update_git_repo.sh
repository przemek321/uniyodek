#!/bin/bash
#test zmiany 2
# Przejdź do katalogu z repozytorium
cd /home/n1copl/

# Zaktualizuj repozytorium
git fetch origin
git reset --hard origin/main

# (Opcjonalnie) Restart aplikacji po aktualizacji, np. za pomocą PM2
# pm2 restart kiosk-app
