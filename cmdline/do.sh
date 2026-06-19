cd ~/jackconfig/cmdline
./cmdshell.sh > output.txt 

git add output.txt > /dev/null || echo "git add output failed"

git commit -m "${1:-config update $(date)}" > /dev/null || echo "git commit failed"

git push > /dev/null && echo "push successful"

git restore ~/jackconfig/cmdline > /dev/null
