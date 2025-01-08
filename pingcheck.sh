#!/bin/bash

# 测试的地址
address="baidu.com"
# ping成功的指令
command=""

if ping -c 1 "$address" >/dev/null 2>&1; then
    eval "$command"
    exit 0
else
    echo "Ping failed"
    exit 1
fi