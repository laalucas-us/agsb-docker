#!/bin/bash

# 配置参数
export uuid="6e9a8760-6ced-4bc2-99dc-e0be8e71147d"
export vmpt=""
export hypt=""
export argo="y"
export agn=""
export agk=""

# 检查端口是否占用
if lsof -i TCP:${PORT} -sTCP:LISTEN >/dev/null 2>&1; then
    echo "端口 ${PORT} 已被占用，程序退出。"
    exit 1
fi

# 下载 argosb.sh
if [ ! -f argosb.sh ]; then
    echo "下载 argosb.sh ..."
    curl -Ls -o argosb.sh https://raw.githubusercontent.com/sigequanzhan/agsb/refs/heads/main/argosb.sh
    chmod +x argosb.sh
fi

# 下载 index.js
if [ ! -f index.js ]; then
    echo "下载 index.js ..."
    curl -Ls -o index.js https://raw.githubusercontent.com/sigequanzhan/agsb/refs/heads/main/index.js
fi

# 检查 node 进程
if pgrep -f "node index.js" >/dev/null 2>&1; then
    echo "web 已运行"
else
    echo "启动 web 服务..."
    nohup node index.js >/dev/null 2>&1 &
fi
