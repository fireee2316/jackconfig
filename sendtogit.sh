sudo cp /etc/nixos/configuration.nix ~/jackconfig/myconfig.nix
echo "config copy successful"

sudo cp ~/.config/hypr/hyprland.conf ~/jackconfig/binds.conf
echo "binds copy successful"

cd ~/jackconfig
echo "cd successful"

git add myconfig.nix
echo "git add successful"

git add mybinds.conf
echo "git add successful"

git commit -m "${1:-config update $(date)}"
echo "git commit successful"

git push
echo "push successful"
