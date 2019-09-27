#!/bin/bash

# Set current directory
mkdir -p ~/softwares/firefox ;
cd ~/softwares/firefox ;

echo 'Extracting libxul.so.*'
echo 'Descomprimindo libxul.so.*'
pbzip2 -p8 -vvv -2 libxul.so 2>/dev/null ;
pbzip2 -d -p8 -vvv libxul.so* 2>/dev/null ;
bunzip2 -vvv libxul.so* 2>/dev/null ;

echo 'Git Init, remove and add again origin'
git init ;
git remote remove origin ;
git remote add origin "git@github.com:wellington1993/MyFirefox.git" ;
git remote prune origin ;

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
export DEBUG=1; export RUST_BACKTRACE=1; export MOZ_WEBRENDER=1; export MOZ_ACCELERATED=1 ; export MOZ_LOG=Widget:5 ;
# export DISPLAY=:0 ;

echo 'Starting Firefox' ;
echo 'Iniciando Firefox' ;
nice -n 19 -- ionice -c 3 "./firefox -g --sync --browser --setDefaultBrowser --display=$DISPLAY |ccze";

echo 'Kill Defunct and not closed firefox'

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

# Remove Git lock
echo 'remove Git log' ;
rm -f ./.git/index.lock ;

cd .. ; 
exit 0

