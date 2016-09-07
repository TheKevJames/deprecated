FROM nginx:1.11.3-alpine
MAINTAINER Kevin James <KevinJames@thekev.in>

COPY . /usr/share/nginx/html

ARG api_url="http:\/\/127.0.0.1:8880"
RUN sed -i 's/API_URL/'"$api_url"'/' /usr/share/nginx/html/js/app.js

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
