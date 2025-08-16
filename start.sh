#!/bin/bash

# 检查端口是否占用
if lsof -i TCP:${PORT} -sTCP:LISTEN >/dev/null 2>&1; then
    echo "端口 ${PORT} 已被占用，程序退出。"
    exit 1
fi

# 检查 node 进程
if pgrep -f "node index.js" >/dev/null 2>&1; then
    echo "web 已运行"
else
    echo "启动 web 服务..."
    nohup node index.js >/dev/null 2>&1 &
fi
