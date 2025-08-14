# 使用 Node 20 alpine 镜像
FROM node:20-alpine

ENV uuid="6e9a8760-6ced-4bc2-99dc-e0be8e71147d" \
    vmpt="29344" \
    hypt="12345" \
    argo="y" \
    agn=""  \ #argo 域名
    agk="" \ #argo tokens
    HOME=/home/node

WORKDIR /app

# 安装依赖 & 下载脚本
RUN apk add --no-cache curl bash \
 && npm install -g npm@11.5.2 \
 && curl -LOs https://raw.githubusercontent.com/laalucas-us/agsb-docker/refs/heads/main/argosb.sh \
 && curl -LOs https://raw.githubusercontent.com/laalucas-us/agsb-docker/refs/heads/main/index.js \
 && curl -LOs https://raw.githubusercontent.com/laalucas-us/agsb-docker/refs/heads/main/package.json \
 && curl -LOs https://raw.githubusercontent.com/laalucas-us/agsb-docker/refs/heads/main/package-lock.json \
 && curl -LOs https://raw.githubusercontent.com/laalucas-us/agsb-docker/refs/heads/main/start.sh \
 && chmod +x argosb.sh start.sh \
 && npm install --production ws \
 && npm cache clean --force

# 创建运行目录并移动脚本
RUN mkdir -p "$HOME/agsb" \
 && mv argosb.sh "$HOME/agsb/argosb.sh" \
 && chmod -R 777 "$HOME/agsb"

# 给 node 用户权限
RUN mkdir -p /app/node_modules "$HOME/bin" \
 && chmod -R 777 /app "$HOME/bin"

# 切换到 node 用户
USER node

# 暴露端口
EXPOSE 3000

# 默认启动 index.js
CMD ["node", "index.js"]
