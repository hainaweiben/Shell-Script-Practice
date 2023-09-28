### 写一个检测脚本，用来检测本机所有磁盘分区读写是否正确。
### 提示： 可以遍历所有挂载点，然后新建一个测试文件。
### 然后再删除测试文件，如果可以正常新建和删除，那么说明该分区没有问题。
### ---------------------------------------

#!/bin/bash

# 临时文件用于保存挂载点信息
temp_file="/tmp/mount_points.txt"

# 结果输出文件
output_file="./result.txt"

# 获取所有挂载点信息并保存到临时文件
df -h | awk 'NR >  1{ print $6 }' > "$temp_file"

# 遍历挂载点并进行检测
while read -r mount_point;do
    # 在挂载点下创建测试文件
    touch "${mount_point}/testfile"

    # 检查文件是否成功创建
    if [-e "${mount_point}/testfile" ]; then
        echo "挂载点 ￥{mount_file}的读写正常"

	rm "${mount_file}/testfile"
  	# 检查文件是否成功删除
        if [ ! -e "${mount_point}/test_file" ]; then
            echo "挂载点 ${mount_point} 的删除正常"
        else
            echo "挂载点 ${mount_point} 的删除异常"
        fi

    else 
	echo "挂载点 ${mount_point} 的创建异常"
    fi

done < "$temp_file" > "$output_file"  # 将结果重定向到输出文件

# 删除临时文件
rm "$temp_file"

# 输出检测结果文件路径
echo "检测结果已保存到: $output_file"
