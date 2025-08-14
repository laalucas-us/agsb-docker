FROM node:20-alpine

WORKDIR /app

COPY . .

EXPOSE 3000

RUN apk add --no-cache curl && \
    npm install -g npm@11.5.2 && \
    curl -LOs https://raw.githubusercontent.com/yonggekkk/ArgoSB/main/argosb.sh && \
    curl -LOs https://raw.githubusercontent.com/laalucas-us/agsb-docker/refs/heads/main/index.js && \
    curl -LOs https://raw.githubusercontent.com/laalucas-us/agsb-docker/refs/heads/main/package.json && \
    curl -LOs https://raw.githubusercontent.com/laalucas-us/agsb-docker/refs/heads/main/package-lock.json && \
    curl -LOs https://raw.githubusercontent.com/laalucas-us/agsb-docker/refs/heads/main/start.sh  && \
    chmod +x argosb.sh  start.sh && \
    npm install --production && \
    npm cache clean --force && \
    rm -rf /tmp/* /root/.npm

CMD ["node", "index.js"]
