git pull origin master:master
rake update_published
git commit -a -m "Publishing post-dated entries"
git push origin master:master   # send back to master branch
git push origin master:gh-pages # and publish
