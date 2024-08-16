# 华南农业大学-WIFI校园网连接脚本

## 介绍

SCAU-CN-UTILS(South China Agricultural University - Campus Network - UTILS)

在使用openwrt(或其他Linux)对华农校园网进行连接时没有图形化，无法进入Web端进行连接，遂随手开发出简易脚本

旨在全面开发多种环境、多种方法、多种语言

该脚本不能完全模拟真实的web端连接情况，且随时间推移，官方可能对接口、内容、方式等等做出改变，本项目不能及时更新

若有想法、建议或指正请提交[Issues](https://github.com/gralliry/scau-cn-utils/issues)或[Pull requests](https://github.com/gralliry/scau-cn-utils/pulls)

## 安装
```shell
git clone https://github.com/gralliry/scau-cn-utils.git
cd scau-cn-utils
```

## 使用

实际使用可能需要你会看代码

### 例:

#### Shell

```shell
bash ./shell/connect.sh youraccount yourpassword
```