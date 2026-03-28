#!/bin/sh

rm .hugo_build.lock

# 执行 Hugo 构建和部署
commit_date=$(date +"%Y-%m-%d %H:%M:%S")
cd ~/blog/
hugo --cleanDestinationDir --gc --minify
cd ~/blog/public || exit 1
git add .
git commit -m "auto update: $commit_date"
git push origin main

echo "部署完成！"
