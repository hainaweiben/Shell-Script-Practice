### 写一个监控脚本，监控统负载，如果系统负载超过10，需要记录系统状态信息。
### 提示：
### 系统负载命令使用uptime看，过去1分钟的平均负载
### 系统状态使用如下工具标记：top、vmstat、 ss
### 要求每隔20s监控一次
### 系统状态信息需要保存到/opt/logs/下面，保留一个月，文件名建议带有date+%s后缀或者前缀
### ---------------------------------------------------
#!/bin/bash

LOG_DIR="./logs"
LOG_PREFIX="system_status_$(date +%s)"
LOG_FILE="$LOG_DIR/$LOG_PREFIX.log"

# 检查日志目录是否存在，如果不存在则创建它
if [ ! -d "$LOG_DIR" ]; then
  mkdir -p "$LOG_DIR"
fi

while true; do
  # 获取系统负载的1分钟平均值，并将其转换为整数
  load_average=$(uptime | awk -F'[ ,]' '{print $11}' | cut -d '.' -f 1)
  load_average=$((load_average))

  # 检查系统负载是否超过10
  if [ "$load_average" -gt 10 ]; then
    # 记录系统状态信息
    top -n 1 > "$LOG_FILE.top"
    vmstat > "$LOG_FILE.vmstat"
    ss -tuln > "$LOG_FILE.ss"
    echo "System load exceeded 10 at $(date)" >> "$LOG_FILE"
  fi

  # 每隔20秒监控一次
  sleep 20
done

