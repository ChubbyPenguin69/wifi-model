#!/bin/bash

# Configurable values
SSID="ShopShop"
REPO_PATH="/repo"
GITHUB_URL="git@github.com:ChubbyPenguin69/wifi-model.git"


# Ask for password
read -sp "Enter new Wi-Fi password: " PASSWORD
echo

# Clone the repo fresh every time (optional clean setup)
rm -rf "$REPO_PATH"
git clone "$GITHUB_URL" "$REPO_PATH"
cd "$REPO_PATH" || exit 1

# Update index.html with new password
sed -i "s/Password:.*/Password: $PASSWORD/" index.html

# Generate new QR code
qrencode -o wifi-qr.png "WIFI:T:WPA;S:$SSID;P:$PASSWORD;;"

# Commit and push
git config user.name "ChubbyPenguin69"
git config user.email "patbat690@proton.me"
git add index.html wifi-qr.png
git commit -m "Update Wi-Fi password and QR code"
git push
