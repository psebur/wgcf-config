#!/bin/bash

# clome and build wgcf
git clone https://github.com/ViRb3/wgcf

cd wgcf

go build -o wgcf

chmod +x wgcf

# register and generate
./wgcf register

./wgcf generate

# update license key
update_license_key() {
  local new_license_key=$1
  sed -i "s/^license_key = '.*'/license_key = '$new_license_key'/" "wgcf-account.toml"
  echo "License key has been updated successfully."
}

# prompt
read -p "Enter the new license key: " new_license_key

# update license key function with the key
update_license_key "$new_license_key"

# update profilr
./wgcf update

./wgcf generate

./wgcf status

# move back to directory
mv wgcf wgcf-copy

mv wgcf-account.toml ..

mv wgcf-profile.conf ..

mv wgcf-copy ..

cd ..

sudo rm -r wgcf

mv wgcf-copy wgcf

clear

echo "Download wgcf-profile.conf and inport into WireGuard"