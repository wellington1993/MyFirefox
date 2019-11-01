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
ps auxf |egrep -i "Firefox|Defunct" |egrep -v "grep|kill|chown|sudo|python|git|bash|python|\.sh" |awk '{print $2}' |xargs kill -9 -1 ;
ps auxf |egrep -i "Firefox|Defunct" |egrep -v "grep|kill|chown|sudo|python|git|bash|python|\.sh" |awk '{print $2}' |xargs kill -9 -1 ;
killall -g -9 firefox 2>/dev/null

echo 'Rust Backtrace: On, Debug, Webrender, Git'
export DEBUG=1; export RUST_BACKTRACE=1 ;
export MOZ_WEBRENDER=1; export MOZ_ACCELERATED=1 ; export MOZ_LOG=Widget:5 ;
export GIT_CURL_VERBOSE=1 ; export GIT_TRACE=2;
# export DISPLAY=:0 ;

echo 'Starting Firefox' ;
echo 'Iniciando Firefox' ;
nice -n 19 -- ionice -c 3 ./firefox -g --sync --browser --setDefaultBrowser --display=$DISPLAY ;

echo 'Kill Defunct and not closed firefox'

echo 'Compressing libux...'
# Prevent libxul.so add
pbzip2 -p8 -vvv -2 libxul.so 2>/dev/null ;
bzip2 -2 libxul.so 2>/dev/null ;
rm -f libxul.so 2>/dev/null ;

# Git add
echo 'Git add All, commit, push, merge & push again'
git add -A -v;
git commit -s -m "'$(date)'" -v;
# Important
git push --set-upstream origin master -v ;
git push -f origin master -v ;
git merge --allow-unrelated -v ;
git push --all -v ;
git push -f origin master -v ;

# Fix 1
echo 'Git Remove libxul, commit, pull, push'
git rm -v --cached libxul.so 2>/dev/null ;
git commit -v --amend -CHEAD ;
git pull -v --no-edit ;
git push -v ;

# Fix 2
echo 'Git Reset Mixed, add, commit & push'
git reset --mixed origin/master ;
git add -v . ;
git commit -v -m "'$(date)'" ;
git push -v origin master ;
git push -v -f origin master ;

# Remove Git lock
echo 'remove Git log' ;
rm -f ./.git/index.lock ;

cd .. ; 
exit 0

