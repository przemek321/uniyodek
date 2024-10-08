FROM arm64v8/debian:latest

# Instalacja zależności systemowych
RUN apt-get update && apt-get install -y \
    chromium \
    xserver-xorg \
    xinit \
    && rm -rf /var/lib/apt/lists/*

# Skopiowanie skryptów
COPY start_kiosk.sh /app/start_kiosk.sh
COPY .xinitrc /app/.xinitrc

# Nadanie uprawnień do uruchamiania skryptów
RUN chmod +x /app/start_kiosk.sh

# Ustawienie zmiennych środowiskowych
ENV DISPLAY=:0
ENV XDG_RUNTIME_DIR=/tmp/%u-runtime-dir

# Uruchomienie Chrome w trybie kiosku
CMD ["/bin/bash", "-c", "/app/start_kiosk.sh"]
