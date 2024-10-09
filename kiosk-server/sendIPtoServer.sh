#!/bin/bash

# Unikalny identyfikator urządzenia
#deviceId="1727360373086"
deviceId=$(grep -oP '(?<=device_id=)\d+' /boot/config.txt)

# Pobierz aktualny adres IP
ip_address=$(hostname -I | awk '{print $1}')
server_ip=$(grep -oP '(?<=server_ip=)[^\s]+' /boot/config.txt)

echo "Device ID: $deviceId"
echo "IP Address: $ip_address"
echo "Server IP: $server_ip"


# Wyślij dane do serwera zarządzającego
#curl -X POST -H "Content-Type: application/json" \
#  -d '{"deviceId": "'"$deviceId"'", "ip": "'"$ip_address"'"}' \
#  http://192.168.0.157:3001/update-ip
curl -X POST -H "Content-Type: application/json" \
  -d '{"deviceId": "'"$deviceId"'", "ip": "'"$ip_address"'"}' \
  http://$server_ip:3001/update-ip
