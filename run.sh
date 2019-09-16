#!/bin/bash

echo 'Permissao de root necessaria para matar processos.'
echo 'Root privelege necessary to kill processes'
sudo echo ''

# Maybe
# dconf-WARNING **: 18:49:33.923: Unable to open /var/lib/menu-xdg/dconf/profile/user: Permissão negada
# Unable to open /var/lib/menu-xdg/dconf/profile/user
# Unless ForwardX11
# export DISPLAY=:0

# MOZ_NO_REMOTE=0
# export MOZ_NO_REMOTE
# MOZ_SANDBOX_LOGGING=0
# export MOZ_SANDBOX_LOGGING

# Set current directory
mkdir -p ~/softwares/firefox ;
cd ~/softwares/firefox ;

# install dependencies
#sudo echo 'Installing Ubuntu dependencies in background'
#sudo echo 'Instalando dependencias do Ubuntu em segundo plano'
#sudo chmod +x ./libs.sh
#sudo ./libs.sh  &>/dev/null &

#sudo echo 'Fixing folders permissions... Wait...'
#sudo echo 'Ajustando permissões de pastas... Aguarde...'

#sudo mkdir -p /var/lib/menu-xdg/dconf/profile &>/dev/null
#sudo mkdir -p /var/lib/flatpak/exports/share/dconf/profile &>/dev/null
#sudo mkdir -p ~/.local/share/ &>/dev/null
#sudo mkdir -p /run/user/1000/dconf &>/dev/null
#sudo touch ~/.local/share/recently-used.xbel &>/dev/null &
#sudo touch /etc/ld.so.nohwcap
#sudo touch ~/.local/share/recently-used.xbel &>/dev/null &
#sudo touch /var/lib/flatpak/exports/share/dconf/profile/user &>/dev/null &

#sudo chown -cfvR $USER:$(id -gn $USER) /home/wellington/.config &>/dev/null &

# sudo chown -cfvR $(whoami):$(whoami) ~/.mozilla &>/dev/null &
#sudo chown -cfvR $USER:$USER /etc/ld.so.nohwcap &>/dev/null &
#sudo chown -cfvR $USER:$USER /var/lib/menu-xdg/dconf/profile/user &>/dev/null &
#sudo chown -cfvR $USER:$USER ~/.cache* &>/dev/null &
#sudo chown -cfvR $USER:$USER ~/.config* &>/dev/null &
#sudo chown -cfvR $USER:$USER ~/.local/share/ &>/dev/null &
#sudo chown -cfvR $USER:$USER ~/.local/share/recently-used.xbel &>/dev/null &
#sudo chown -cfvR $USER:$USER ~/.moz* &>/dev/null &
#sudo chown -cfvR $USER:$USER ~/Cache* &>/dev/null &
#sudo chown -cfvR $USER:$USER ~/Local* &>/dev/null &
#sudo chown -cfvR $USER:$USER /run/user/1000/dconf &>/dev/null &

# Fix libxul.so
sudo echo 'Extracting libxul.so.*'
sudo echo 'Descomprimindo libxul.so.*'
pbzip2 -p8 -vvv -2 libxul.so 2>/dev/null ;
pbzip2 -d -p8 -vvv libxul.so* 2>/dev/null ;
bunzip2 -vvv libxul.so* 2>/dev/null ;

echo 'Git Init, remove and add again origin'
git init ;
git remote remove origin ;
git remote add origin "git@github.com:wellington1993/MyFirefox.git" ;
git remote prune origin ;

# echo 'Git Reflog expire'
# git reflog expire --expire-unreachable=now --all ;
# git reflog expire --expire=now --all  ;
# echo 'Git GC Prune aggressive'
# git gc --prune=now --aggressive ;

echo 'Git Pull and merge'
git pull origin master ;
git pull origin master --allow-unrelated-histories ;
git branch --set-upstream-to=origin/master master ;
git merge --allow-unrelated ;

echo 'Git Checkout pull and merge'
git checkout master ;
git pull --all ;
git merge --allow-unrelated ;

echo 'Git Add All'
git add -f -A &

echo 'Kill non closed firefox'
echo 'Matando firefox nao fechados'
sudo ps auxf |egrep -i "Firefox|Defunct" |egrep -v "grep|kill|chown|sudo|python|git|bash|python|\.sh" |awk '{print $2}' |xargs sudo kill -9 -1 ;
sudo ps auxf |egrep -i "Firefox|Defunct" |egrep -v "grep|kill|chown|sudo|python|git|bash|python|\.sh" |awk '{print $2}' |xargs sudo kill -9 -1 ;
sudo killall -g -9 firefox 2>/dev/null

echo 'Rust Backtrace: On, Debug, Webrender'
export DEBUG=1; export RUST_BACKTRACE=1; export MOZ_WEBRENDER=1; export MOZ_ACCELERATED=1 ; 
# export DISPLAY=:0 ;

echo 'Starting Firefox' ;
echo 'Iniciando Firefox' ;
nice -n 19 -- ionice -c 3 ./firefox -g --sync --browser --setDefaultBrowser --display=$DISPLAY ;
# --no-remote --jsconsole --wait-for-jsdebugger --jsdebugger
# --g-fatal-warnings ;

echo 'Kill Defunct and not closed firefox'
# ps auxf |egrep -i "Firefox|Defunct" |egrep -v "grep|kill|chown|sudo|python|git|bash|python|\.sh" |awk '{print $2}' |xargs  kill -9 &>/dev/null ;
# ps auxf |egrep -i "Firefox|Defunct" |egrep -v "grep|kill|chown|sudo|python|git|bash|python|\.sh" |awk '{print $2}' |xargs  kill -9 &>/dev/null ;
# killall -g -9 firefox 2>/dev/null

echo 'Compressing libux...'
# Prevent libxul.so add
pbzip2 -p8 -vvv -2 libxul.so 2>/dev/null ;
bzip2 -2 libxul.so 2>/dev/null ;
rm -f libxul.so 2>/dev/null ;

# Git add
echo 'Git add All, commit, push, merge & push again'
git add -A ;
git commit -s -m "'$(date)'" ;
# Important
git push --set-upstream origin master ;
git push -f origin master ;
git merge --allow-unrelated ;
git push --all ;
git push -f origin master ;

# Fix 1
echo 'Git Remove libxul, commit, pull, push'
git rm --cached libxul.so 2>/dev/null ;
git commit --amend -CHEAD ;
git pull --no-edit ;
git push ;

# Fix 2
echo 'Git Reset Mixed, add, commit & push'
git reset --mixed origin/master ;
git add . ;
git commit -m "'$(date)'" ;
git push origin master ;
git push -f origin master ;

# Fix 3
# echo 'Git Garbage Collector Aggressive and Git Repack'
# git gc ;
# git gc --aggressive ;
# git repack -a -d ;

# Remove Git lock
echo 'remove Git log' ;
rm -f ./.git/index.lock ;

cd .. ; 
exit 0

