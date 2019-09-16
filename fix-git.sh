java -jar bfg.jar --strip-blobs-bigger-than 100M $(pwd) ; 
git reflog expire --expire=now --all && git gc --prune=now --aggressive ; 

git push origin --force --all ; 
git push origin --force --tags ;


