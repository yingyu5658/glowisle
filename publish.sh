#!/bin/sh

SRC="./public"

# 安装必要的工具（如果未安装）
if ! command -v uglifyjs &> /dev/null; then
    echo "安装 uglify-js..."
    npm install -g uglify-js
fi

if ! command -v cleancss &> /dev/null; then
    echo "安装 clean-css-cli..."
    npm install -g clean-css-cli
fi

if ! command -v html-minifier &> /dev/null; then
    echo "安装 html-minifier-terser..."
    npm install -g html-minifier-terser
fi

echo "开始原地压缩文件..."

# 创建临时目录用于备份
BACKUP_DIR=$(mktemp -d)

# 先备份原文件
echo "备份原文件..."
find "$SRC" -type f \( -name "*.js" -o -name "*.css" -o -name "*.html" \) | while read file; do
    rel_path="${file#$SRC/}"
    backup_path="$BACKUP_DIR/$rel_path"
    mkdir -p "$(dirname "$backup_path")"
    cp "$file" "$backup_path"
done

# 压缩文件（原地覆盖）
find "$SRC" -type f \( -name "*.js" -o -name "*.css" -o -name "*.html" \) | while read file; do
    case "$file" in
        *.js)
            # 跳过已经是 .min.js 的文件
            if [[ "$file" != *.min.js ]]; then
                echo "压缩 JS: ${file#$SRC/}"
                uglifyjs "$file" -c -m -o "${file}.tmp" && mv "${file}.tmp" "$file"
            fi
            ;;
        *.css)
            # 跳过已经是 .min.css 的文件
            if [[ "$file" != *.min.css ]]; then
                echo "压缩 CSS: ${file#$SRC/}"
                cleancss "$file" -o "${file}.tmp" && mv "${file}.tmp" "$file"
            fi
            ;;
        *.html)
            echo "压缩 HTML: ${file#$SRC/}"
            html-minifier "$file" \
                --collapse-whitespace \
                --remove-comments \
                --minify-css \
                --minify-js \
                -o "${file}.tmp" && mv "${file}.tmp" "$file"
            ;;
    esac
done

echo "压缩完成！"

# 执行 Hugo 构建和部署
commit_date=$(date +"%Y-%m-%d %H:%M:%S")
cd ~/blog/
hugo --cleanDestinationDir --gc
cd ~/blog/public || exit 1
git add .
git commit -m "auto update: $commit_date"
git push origin main

echo "部署完成！"
