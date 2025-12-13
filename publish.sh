#!/bin/sh

#word_counter=$(find ~/blog/content/ -type f -name "*.md" -exec cat {} + | \
#perl -CSD -pe 's/[\p{P}\p{S}\s\p{M}\p{C}\p{Z}]//g; s/$$.*?$$$$.*?$$//g; s/[*#_\-`~=+|><\^]//g; s/\!$$.*?$$$$.*?$$//g' | \
#grep -oP '[\p{Han}a-zA-Z]' | \
#wc -m)

commit_date=$(date +"%Y-%m-%d %H:%M:%S")

if [ "$1" = "-b" ] || [ "$1" = "--blog" ]; then
    cd ~/blog || exit 1
    hugo
    git add .
    git commit -m "自动提交：$commit_date"
    echo "pushing hugo-blog-backup"
    git push origin main
    
    cd ~/blog/public || exit 1
    html-minifier index.html --output index.html --collapse-whitespace --remove-comments
    git add .
    git commit -m "自动提交：$commit_date"
    echo "pushing yingyu5658.github.io"
    git push origin main

elif [ "$1" = "-n" ] || [ "$1" = "--newsgroup" ]; then
    echo "git clone https://gitee.com/yingyu5658/newsgroup_archives.git"
    cd ~/blog || exit 1
    rm -rf newsgroup_archives  # Cleanup any existing clone
    git clone https://gitee.com/yingyu5658/newsgroup_archives.git
    mv newsgroup_archives/index.html ~/newsgroup_archives/index.html
    rm -rf newsgroup_archives

    cd ~/newsgroup_archives/ || exit 1
    git add .
    git commit -m "$commit_date"
    echo "pushing newsgroup_archives"
    git pull origin main   # Pull latest changes before pushing
    git push origin main

else
    echo "No argument!"
	exit 1
fi


cd ~/blog || exit 1
echo "========="
echo "操作完成！"
