FROM node:20-alpine

WORKDIR /app

COPY . .

EXPOSE 3000

RUN apk add --no-cache curl && \
    npm install -g npm@11.5.2 && \
    curl -LOs https://raw.githubusercontent.com/yonggekkk/ArgoSB/main/argosb.sh && \
    chmod +x argosb.sh && \
    npm install --production && \
    npm cache clean --force && \
    rm -rf /tmp/* /root/.npm

CMD ["node", "index.js"]
