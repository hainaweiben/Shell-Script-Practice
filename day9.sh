### 写一个脚本，执行后，打印一行提示“Please：input a number:”
### 要求用户输入数值，然后打印出该数值，然后再次要求用户输入数值。
### 直到用户输入"end"停止。
### ----------------------------------------

#!/bin/bash

while true; do
    read -p "Please input a number: " input
    
    if [ "$input" = "end" ]; then
        break
    fi

    echo "You entered: $input"
done

