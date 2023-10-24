### 写一个日志归档脚本，类似于系统的logrotate程序做日志归档。
### 假如服务的输出日志是1.log,要求每天归档一个，1.log第二天就变成1.log.1,
### 第三天1.log.2,第四天1.log.3一直到1.log.5

#!/bin/bash

# Define the log file path
LOG_FILE=./1.log

# Define the archive directory
ARCHIVE_DIR=./archive

# Define the maximum number of archive files to keep
MAX_ARCHIVE_FILES=5

# Check if the log file exists
if [ ! -f "$LOG_FILE" ]; then
  echo "Log file does not exist"
  exit 1
fi

# Create the archive directory if it does not exist
if [ ! -d "$ARCHIVE_DIR" ]; then
  mkdir -p "$ARCHIVE_DIR"
fi

# Archive the log file
ARCHIVE_FILE="$ARCHIVE_DIR/1.log.1"
if [ -f "$ARCHIVE_FILE" ]; then
  for i in $(seq $MAX_ARCHIVE_FILES -1 2); do
    mv "$ARCHIVE_DIR/1.log.$(($i-1))" "$ARCHIVE_DIR/1.log.$i"
  done
  mv "$ARCHIVE_DIR/1.log.1" "$ARCHIVE_DIR/1.log.2"
fi
cp "$LOG_FILE" "$ARCHIVE_FILE"
echo "" > "$LOG_FILE"