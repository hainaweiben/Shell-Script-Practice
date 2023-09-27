### 创建10个用户，并且给他们随机生成密码，密码记录到一个文件中，命名为userinfo.txt
### 用户从user_01到user_09
### 密码要求：包括大小写字母，以及数字

### ----------------------------------------------------------------
#!/bin/bash
# 判断是否存在文件userinfo.txt,存在需要删除
if [ -f  ./userinfo.txt ]
then
    rm -f ./userinfo.txt
fi

# 创建10个用户并生成随机密码
for i in $(seq -w 0 09)
do
    username="user_$i"
    # 设置用户密码
    # 生成密码（包括大小写字母和数字，但不包括特殊字符）
    password=$(openssl rand -base64 15 )
    sudo useradd -m $username
    echo "$username:$password" | sudo chpasswd
    echo "用户名: $username, 密码: $password" >> userinfo.txt
done

