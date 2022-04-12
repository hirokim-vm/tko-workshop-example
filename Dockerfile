FROM nginxinc/nginx-unprivileged:latest

# copy static content to nginx
COPY ./site /usr/share/nginx/html
