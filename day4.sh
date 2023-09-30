### 检查./data目录下的所有文件和目录：观察是否满足下面的条件
### 1) 所有文件的权限为644
### 2) 所有目录的权限为755
### 3) 文件和目录的所有者为www,所属组为root
### 如果不满足，改成符合要求
### 需要给出判断的结果

#!/bin/bash

cd ./data

## 遍历所有的目录和文件，使用find .
for f in $(find .)
do
    ## 查看文件权限
    f_p=$(stat -c %a "$f")
    ## 查看文件所有者
    f_u=$(stat -c %U "$f")
    ## 查看文件所属组
    f_g=$(stat -c %G "$f")

    ## 判断是否为目录
    if [ -d "$f" ] && [ "$f_p" != '755' ]; then
        chmod 755 "$f"
    elif [ -f "$f" ] && [ "$f_p" != '644' ]; then
        chmod 644 "$f"
    fi

    [ "$f_u" != 'www' ] && chown www: "$f"
    [ "$f_g" != 'root' ] && chown :root "$f"
done

