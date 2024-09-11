#!/bin/bash

username=$1
password=$2

# www.msftconnecttest.com will be redirected to 1.1.1.1.
# The campus network has hijacked the DNS of this and the IP of 1.1.1.1

# 使用 nslookup 查询域名的解析结果, 检查解析结果是否不包含目标 IP
if [ "$(nslookup "www.msftconnecttest.com" | awk '/^Address: / { print $2 }')" != "1.1.1.1" ]; then
  echo "Not connected to campus network (turn off if VPN is used)"
  exit 1
fi

# 直接在 if 语句中检查 ping 命令的结果
if ! ping -c 1 "www.msftconnecttest.com" > /dev/null 2>&1 || ! ping -c 1 "192.168.253.3" > /dev/null 2>&1; then
  echo "The campus network cannot be pinged"
  exit 1
fi

content=$(curl -s http://www.msftconnecttest.com/redirect)

if [ "$content" = "" ]; then
  echo "Can't connect to http://www.msftconnecttest.com/redirect"
  echo "Please confirm that you have connected to the campus network (or have connected and logged in successfully)."
  exit 1
fi

parsed_url=$(echo "$content" | sed -n "s/.*href='\([^']*\)'.*/\1/p")

parsed_params=$(echo "$parsed_url" | sed -n "s/.*?\(.*\)/\1/p")

encode_params=$(echo "$parsed_params" | sed 's/=/\%3D/g; s/&/\%26/g')
# 登录的数据
data="userId=$username&password=$password&service=&queryString=$encode_params&operatorPwd=&operatorUserId=&validcode=&passwordEncrypt=false"

# 登录的接口url
if curl -s -X POST "http://192.168.253.3/eportal/InterFace.do?method=login" --data "$data"; then
  echo -e "\nThe login request is successfully sent. Check whether the result is success"
  exit 0
else
  echo -e "\nThe login request failed to be sent, possibly because the connection was disconnected"
  exit 1
fi

