#### 使用 Node 的版本(作為編譯)
FROM dockerhub/library/node:11-stretch AS builder
# Node 在容器內的位置
WORKDIR /home/node
# 編譯與安裝環境
COPY . / /home/node/
RUN ls && \
    npm install -D vuepress && \
    npm run build
# 正式伺服器
#FROM dockerhub/library/httpd:2.4
#COPY --from=builder /home/node/dist/ /usr/local/apache2/htdocs/
FROM dockerhub/library/httpd:2.4
COPY --from=builder /home/node/app/.vuepress/dist/ /usr/local/apache2/htdocs/
