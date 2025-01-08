#!/bin/bash

SSID='SCAUNET'
# SSID='SCAUNET-2.4G'

# 如果WiFi状态不是“enabled”，则启用WiFi
if [ "$(sudo nmcli radio wifi)" != "enabled" ]; then
    # 启动wifi
    echo "WiFi is not enabled. Enabling WiFi..."
    sudo nmcli radio wifi on
else
    echo "WiFi is already enabled."
fi

# 列出所有wifi
wifilist=$(sudo nmcli device wifi list)
echo "---------------The List of Wifi-----------------"
echo "$wifilist"
echo "------------------------------------------------"
if sudo nmcli connection delete "$SSID"; then
    echo "Connection record $SSID have been deleted"
fi
# 尝试连接wifi
echo "Trying to connect $SSID"
sudo nmcli device wifi connect "$SSID" # password <password>
#
# 获取当前活动的网络连接
result=$(sudo nmcli connection show --active)
echo "-----------------Actived Wifi-------------------"
echo "$result"
echo "------------------------------------------------"
# 检查指定的SSID是否在活动连接中
if echo "$result" | grep -q "$SSID"; then
    echo "Connection Success"
    exit 0
else
    echo "Connection Failed"
    exit 1
fi