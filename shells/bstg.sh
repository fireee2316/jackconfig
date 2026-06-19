sudo cp /etc/nixos/configuration.nix ~/jackconfig/configs/myconfig.nix || echo "config copy successful"

sudo cp ~/.config/hypr/hyprland.conf ~/jackconfig/configs/mybinds.conf || echo "binds copy successful"

cd ~/jackconfig

git add configs/myconfig.nix || echo "git add config failed"

git add configs/mybinds.conf || echo "git add binds failed"

git commit -m "${1:-config update $(date)}" && echo "git commit successful"

git push && echo "push successful"
