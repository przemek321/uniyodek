#!/bin/bash

# Unikalny identyfikator urządzenia
deviceId="1727360373086"

# Pobierz aktualny adres IP
ip_address=$(hostname -I | awk '{print $1}')

echo "Device ID: $deviceId"
echo "IP Address: $ip_address"


# Wyślij dane do serwera zarządzającego
curl -X POST -H "Content-Type: application/json" \
  -d '{"deviceId": "'"$deviceId"'", "ip": "'"$ip_address"'"}' \
  http://192.168.0.157:3001/update-ip
