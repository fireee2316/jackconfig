sudo cp /etc/nixos/configuration.nix ~/jackconfig/myconfig.nix
cd ~/jackconfig
git add myconfig.nix
git commit -m "${1:-config update $(date)}"
git push
