FROM nginx:1.18-alpine

COPY ./html /usr/share/nginx/html
COPY ./conf/default.conf /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]
