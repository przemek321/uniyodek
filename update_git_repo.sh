#!/bin/bash
# test zmiany 2
# Przejdź do katalogu z repozytorium
cd /home/n1copl/

# Funkcja do sprawdzania połączenia z internetem
check_internet() {
    while ! curl -s --head https://github.com | grep "200 OK" > /dev/null; do
        echo "Czekam na połączenie z internetem..."
        sleep 10
    done
}

# Sprawdź połączenie z internetem
check_internet

# Zaktualizuj repozytorium
git fetch origin
git reset --hard origin/main

# (Opcjonalnie) Restart aplikacji po aktualizacji, np. za pomocą PM2
# pm2 restart kiosk-app
