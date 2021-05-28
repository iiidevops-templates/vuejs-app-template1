#### 使用 Node 的版本(作為編譯)
FROM dockerhub/library/node:12-stretch AS builder
# Node 在容器內的位置
WORKDIR /home/node
# 編譯與安裝環境
COPY . / /home/node/
RUN ls && \
    npm install && \
    npm run build

# 正式伺服器
FROM dockerhub/library/nginx:1.19
COPY --from=builder /home/node/app/dist/ /usr/share/nginx/html/
COPY --from=builder /home/node/app/default.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]