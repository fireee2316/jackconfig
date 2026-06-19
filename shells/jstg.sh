sudo cp /etc/nixos/configuration.nix ~/jackconfig/configs/jackconfig.nix || echo "config copy failed"

# sudo cp ~/.config/hypr/hyprland.conf ~/jackconfig/configs/mybinds.conf || echo "binds copy successful"

cd ~/jackconfig

git add configs/jackconfig.nix || echo "git add config failed"

# git add configs/jackbinds.conf || echo "git add binds failed"

git commit -m "${1:-config update $(date)}" && echo "git commit successful"

git push && echo "push successful"
