sudo cp /etc/nixos/configuration.nix ~/jackconfig/configs/myconfig.nix > /dev/null || echo "config copy successful"

sudo cp ~/.config/hypr/hyprland.conf ~/jackconfig/configs/mybinds.conf > /dev/null || echo "binds copy successful"

cd ~/jackconfig

git add configs/myconfig.nix > /dev/null || echo "git add config failed"

git add configs/mybinds.conf > /dev/null || echo "git add binds failed"

git commit -m "${1:-config update $(date)}" > /dev/null && echo "git commit successful"

git push > /dev/null && echo "push successful"
