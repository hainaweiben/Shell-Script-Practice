### 有一个目录/data/att/。该目录下有数百个子目录
### 比如/data/att/aming, /data/att/linux
### 然后再深入一层为以日期命名的目录，例如/data/att/aming/20231001
### 每天都会生成一个日期新目录，由于/data所在磁盘快满了
### 所以需要将老文件（一年以前的）挪到另一个目录/data1/att/aming/20211001
### 挪完之后还需要做软连接
### 示例：ln -s /data/att/aming/20211001 /data1/att/aming/20211001
### 写一个脚本，要求/data/att/下所有子目录都按此操作。
### 提醒：要确保老文件成功挪到/data1/att下之后才能做软链接，需要有日志

### ---------------------------------------------------------------
#!/bin/bash
## 先定义一个main函数，目的是后面调用函数，方便记录日志

main()
{
    cd data/att
    ## 遍历第一层目录
    for dir in 'ls'
    do
        ## 遍历第二层目录，用find只找目录下一年以前的子目录
	for dir2 in 'find $dir -maxdepth 1 -type d -mtime +365'
        do
	    ## 将目标目录下的文件同步到/data1/att/目录下，注意这里的-R可以自动创建目录结构
	    rsync -aR $dir2/ /data1/att/
	    if [ $? -eq 0 ]
            then
                ## 如果同步成功，会将/data/att/下的目录删除
		rm -rf $dir2
		echo "/data/att/$dir2移动成功"
		## 做软链接
		ln -s /data1/att/"$dir2" /data/att/$dir2 && \
		echo "/data/att/$dir2软链接创建成功"
		echo
	    else
		echo "创建软链接未成功"
	    fi
	done
    done
}

## 调用main函数，并将输出写入日志，日志每天一个
main &> /tmp/move_old_data_`data +%F`.log 
