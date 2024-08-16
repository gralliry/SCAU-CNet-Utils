#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Description:
import re
import requests
import urllib.parse

# 示例
username = ""
password = ""
username = username or input("输入用户名: ")
password = password or input("输入密码: ")
user_agent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.6533.89 Safari/537.36"

response = requests.get("http://1.1.1.1")
script_content = response.content.decode("utf-8")
# 使用正则表达式匹配并提取URL
match = re.search(r"href='(.*?)'", script_content)
if not match:
    print("未找到匹配的返回")
    exit(1)

parsed_url_str = match.group(1)
parsed_url = urllib.parse.urlparse(parsed_url_str)

protocol = parsed_url.scheme  # 协议，例如 'http'
domain = parsed_url.netloc    # 域名，例如 '192.168.253.3'
path = parsed_url.path        # 路径，例如 '/eportal/index.jsp'
query = parsed_url.query      # 查询字符串，例如 'wlanuserip=edfbb74a7c17f5727b1f9de97e182f17&wlanacname=
print(f"{query=}")

# base_url = "http://192.168.253.3"
base_url = urllib.parse.urlunparse((protocol, domain, '', '', '', ''))
# login_url = "http://192.168.253.3/eportal/InterFace.do?method=login"
login_url = urllib.parse.urlunparse((protocol, domain, "/eportal/InterFace.do", '', 'method=login', ''))
# session_url
session_url = urllib.parse.urlunparse((protocol, domain, "/eportal/index.jsp", '', query, ''))

response = requests.get(session_url)

sessionid = response.cookies['JSESSIONID']
print(f"{sessionid=}")


response = requests.post(
    login_url,
    cookies={
        "EPORTAL_COOKIE_PASSWORD": "",
        "EPORTAL_COOKIE_USERNAME": "",
        "EPORTAL_COOKIE_OPERATORPWD": "",
        "JSESSIONID": sessionid,
    },
    data={
        "userId": username,
        "password": password,
        "service": "",
        "queryString": urllib.parse.quote(query),
        "operatorPwd": "",
        "operatorUserId": "",
        "validcode": "",
        "passwordEncrypt": "false",
    }
)
print(response.status_code)
print(response.content)

exit(0)
