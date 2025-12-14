#!/bin/sh

#word_counter=$(find ~/blog/content/ -type f -name "*.md" -exec cat {} + | \
#perl -CSD -pe 's/[\p{P}\p{S}\s\p{M}\p{C}\p{Z}]//g; s/$$.*?$$$$.*?$$//g; s/[*#_\-`~=+|><\^]//g; s/\!$$.*?$$$$.*?$$//g' | \
#grep -oP '[\p{Han}a-zA-Z]' | \
#wc -m)

commit_date=$(date +"%Y-%m-%d %H:%M:%S")
cd ~/blog/
hugo --cleanDestinationDir --gc
cd ~/blog/public || exit 1
git add .
git commit -m "auto update: $commit_date"
git push origin main
