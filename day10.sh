### 写一个监控脚本，监控某站点访问是否正常。
### 提示：
### 1)可以将访问的站点以参数的形式提供，例如sh xxx.shww.aminglinux.com
### 2)状态码为2XX或者3xX表示正常
### 3)正常时echo正常，不正常时echo不正常
### ---------------------------------------
#!/bin/bash

# 获取参数中的站点地址
site=$1

# 发送GET请求并获取状态码
status_code=$(curl -o /dev/null --silent --head --write-out '%{http_code}\n' $site)

# 判断状态码是否为2XX或者3XX
if [ $status_code -ge 200 ] && [ $status_code -lt 400 ]; then
    echo "正常"
else
    echo "不正常"
fi

