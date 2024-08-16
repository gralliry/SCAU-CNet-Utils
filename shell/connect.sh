#!/bin/bash

username=$1
password=$2

# # www.msftconnecttest.com 会被重定向到1.1.1.1, 校园网劫持了这个的DNS和1.1.1.1的IP
content=$(curl -s http://www.msftconnecttest.com/redirect)

if [ "$content" = "" ]; then
  echo "无法连接到http://www.msftconnecttest.com/redirect，请确认已经连接了校园网（或者已经连接并登录成功了）"
  exit 1
fi

parsed_url=$(echo "$content" | sed -n "s/.*href='\([^']*\)'.*/\1/p")

parsed_params=$(echo "$parsed_url" | sed -n "s/.*?\(.*\)/\1/p")

encode_params=$(echo "$parsed_params" | sed 's/=/\%3D/g; s/&/\%26/g')
# 登录的数据
data="userId=$username&password=$password&service=&queryString=$encode_params&operatorPwd=&operatorUserId=&validcode=&passwordEncrypt=false"
# 登录的接口url
login_url="http://192.168.253.3/eportal/InterFace.do?method=login"

if curl -s -X POST "$login_url" --data "$data"; then
  echo -e "\n登录请求发送成功，请自行检查result是否为success"
  exit 0
else
  echo -e "\n登录请求发送失败，可能是连接断开了"
  exit 1
fi

