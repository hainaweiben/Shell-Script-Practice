### 今日脚本需求：
### 写一个脚本实现如下功能：
### 输入一个数字，
### 然后运行对应的一个命令。
### 显示命令如下：
### *cmd meau** 1-date 2-ls 3-who 4-pwd
### 当输入1时，会运行date,输入2时运行ls,依此类推。

#!/bin/bash

# 显示菜单
echo "命令菜单:"
echo "1-date 2-ls 3-who 4-pwd"

# 提示用户输入数字
read -p "请输入一个数字: " choice

# 根据用户输入的数字执行相应的命令
case $choice in
  1)
    date
    ;;
  2)
    ls
    ;;
  3)
    who
    ;;
  4)
    pwd
    ;;
  *)
    echo "无效的选择"
    ;;
esac

