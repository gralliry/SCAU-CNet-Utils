#!/bin/bash

# 测试的地址
address="baidu.com"
# ping成功的指令
command=""
# ping失败的测试次数
count=3

# 使用 getopts 解析命令行选项
while getopts "a:d:c:" opt; do
  case $opt in
  a)
    # ping地址
    address="$OPTARG"
    ;;
  d)
    # 如果提供了 -t 选项，更新 TARGET_IP
    command="$OPTARG"
    ;;
  c)
    # 如果提供了 -t 选项，更新 TARGET_IP
    count="$OPTARG"
    ;;
  \?)
    echo "Invalid option: -$OPTARG" >&2
    exit 1
    ;;
  esac
done

# 初始化重试计数
retry_count=0

# 开始重试循环
while [ $retry_count -lt "$count" ]; do
  # 尝试 ping DOMAIN
  if ping -c 1 "$address" >/dev/null 2>&1; then
    echo "Ping successfully..."
    eval "$command"
    exit 0
  else
    echo "Ping failed, retrying... ($((retry_count + 1))/$count)"
    retry_count=$((retry_count + 1))
  fi
done

exit 1
