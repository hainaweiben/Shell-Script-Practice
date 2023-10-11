### 使用传参的方法写个脚本，实现加减乘除的功能
### 例如：
### sh a.sh 1 2,这样会分别计算加、减、乘、除的结果。
### 要求：
### 脚本需判断提供的两个数字必须为整数
### 当做减法或者除法时，需要判断哪个数字大
### 减法时需要用大的数字减小的数字
### 除法时需要用大的数字除以小的数字，并且结果需要保留两个小数点。
#!/bin/bash

# 判断参数数量是否正确
if [ "$#" -ne 2 ]; then
  echo "用法: $0 <数字1> <数字2>"
  exit 1
fi

# 获取两个数字
num1="$1"
num2="$2"

# 判断数字是否为整数
if ! [ "$num1" -eq "$num1" ] 2>/dev/null || ! [ "$num2" -eq "$num2" ] 2>/dev/null; then
  echo "数字必须为整数"
  exit 1
fi

# 加法
add_result=$((num1 + num2))
echo "加法结果: $add_result"

# 减法
if [ "$num1" -ge "$num2" ]; then
  sub_result=$((num1 - num2))
else
  sub_result=$((num2 - num1))
fi
echo "减法结果: $sub_result"

# 乘法
mul_result=$((num1 * num2))
echo "乘法结果: $mul_result"

# 除法
if [ "$num2" -eq 0 ]; then
  echo "除数不能为0"
  exit 1
fi
if [ "$num1" -ge "$num2" ]; then
  div_result=$(awk "BEGIN {printf \"%.2f\", $num1 / $num2}")
else
  div_result=$(awk "BEGIN {printf \"%.2f\", $num2 / $num1}")
fi
echo "除法结果: $div_result"

