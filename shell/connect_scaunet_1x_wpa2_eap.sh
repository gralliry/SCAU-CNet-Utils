#!/bin/bash

# 定义变量
SSID="your_ssid"
USERNAME="your_username"
PASSWORD="your_password"
INTERFACE="wlan0"
EAP_TYPE="peap"

# 删除现有的连接（如果存在）
nmcli con delete "$SSID"

# 创建新的连接
nmcli con add type wifi ifname "$INTERFACE" con-name "$SSID" ssid "$SSID"

# 配置 WPA2-Enterprise 设置
nmcli con modify "$SSID" wifi-sec.key-mgmt wpa-eap
nmcli con modify "$SSID" 802-1x.eap "$EAP_TYPE"
nmcli con modify "$SSID" 802-1x.identity "$USERNAME"
nmcli con modify "$SSID" 802-1x.password "$PASSWORD"
nmcli con modify "$SSID" 802-1x.phase2-auth mschapv2

# 连接到网络
nmcli con up "$SSID"

# 设置自动连接（可选）
nmcli con modify "$SSID" connection.autoconnect yes

echo "Connection to $SSID has been configured and activated."
