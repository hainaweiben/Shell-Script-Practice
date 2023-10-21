### 多人抽签游戏，每人执行脚本产生一个随机数，具体要求如下
### 1) 脚本执行后，输入人名，产生1-99之间的数字；
### 2) 相同的名字重复执行，抓到的数字应该和之前保持一致；
### 3) 前面已经出现过的数字，下次不能再出现；
### 4) 需要将名字和对应的数字记录到一个文件里；
### 5) 脚本一旦运行，除非按ctrl+C停止，否则要一直运行。
#!/bin/bash

# Define the file to store the name and corresponding number
FILE="numbers.txt"

# Define a function to retrieve the number for a given name from the file
function get_number() {
    grep "^$1 " "$FILE" | cut -d " " -f 2
}

# Define a function to write the name and corresponding number to the file
function write_number() {
    echo "$1 $2" >> "$FILE"
}

# Catch the "ctrl+c" signal and exit the script
trap "exit" INT

# Use an infinite loop to keep the script running
while true; do
    # Prompt the user to input their name
    read -p "Please enter your name: " name

    # Generate a random number between 1 and 99
    number=$(shuf -i 1-99 -n 1)

    # Check if the name has already been recorded in the file
    existing_number=$(get_number "$name")
    if [[ -n "$existing_number" ]]; then
        # Use the existing number as the generated number
        number="$existing_number"
    else
        # Write the name and generated number to the file
        write_number "$name" "$number"
    fi

    # Print the name and generated number
    echo "Hello, $name! Your number is $number."
done