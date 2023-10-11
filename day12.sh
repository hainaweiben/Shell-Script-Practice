### 编写一个带参数的脚本，实现下载文件的效果，参数有两个：
### 1)第一个参数为文件下载链接：
### 2)第二个参数为目录，即下载后保存的位置：
### 注意要考虑目录不存在的情况，脚本需要提示用户是否创建目录

#!/bin/bash

# 检查参数数量
if [ $# -ne 2 ]; then
    echo "Usage: $0 <file_url> <directory>"
    exit 1
fi

# 提取参数
file_url=$1
directory=$2

# 检查目录是否存在
if [ ! -d $directory ]; then
    read -p "Directory does not exist. Do you want to create it? (y/n): " choice
    if [ $choice = "y" ]; then
        mkdir -p $directory
    else
        exit 1
    fi
fi

# 下载文件
wget -P $directory $file_url

echo "File downloaded successfully."
