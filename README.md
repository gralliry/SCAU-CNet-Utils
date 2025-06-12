# 华南农业大学-WIFI校园网连接脚本

## 介绍

SCAU-CNet-Utils(South China Agricultural University - Campus Network - UTILS)

（背景）在使用openwrt(或其他Linux)对华农校园网进行连接时没有图形化，无法进入Web端进行连接，遂随手开发出简易脚本

旨在全面开发多种环境、多种方法、多种语言

该脚本不能完全模拟真实的web端连接情况，且随时间推移，官方可能对接口、内容、方式等等做出改变，本项目不能及时更新

若有想法、建议或指正请提交[Issues](https://github.com/gralliry/scau-cn-utils/issues)或[Pull requests](https://github.com/gralliry/scau-cn-utils/pulls)

## 安装
```shell
git clone https://github.com/gralliry/SCAU-CNet-Utils.git
cd SCAU-CNet-Utils
```

## 使用

实际使用可能需要你会看代码

### 例:

#### Shell

```shell
bash ./scaunet_login_by_web.sh youraccount yourpassword
```

#### Windows

Windows系统中可以使用浏览器来打开web进行连接
* 需要开启密码自动填充，以便在打开网站时自动登录
* 防止电脑睡眠（让任务在熄屏时能运行）
```
控制面板设置：
  打开控制面板 → 电源选项
  进入“更改计划设置”
  设置为：
    关闭显示器：5 分钟（随意）
    使计算机进入睡眠状态：从不
  点击“更改高级电源设置”
  找到“睡眠” → “允许唤醒定时器” → 设为“启用”
```

```shell
"C:\Program Files\Google\Chrome\Application\chrome.exe\" http://192.168.253.3
```

方法二：使用命令行创建（可复制粘贴）
```shell
schtasks /create /tn "OpenWebsite" /tr "\"C:\Program Files\Google\Chrome\Application\chrome.exe\" http://192.168.253.3" /sc daily /st 06:10 /rl HIGHEST /f
```

## 声明

本项目仅供学习交流使用，因使用本项目造成一切后果由使用者承担
