FROM nginx:alpine
# Move to the production ready directory
COPY . /usr/share/nginx/html

# Enable compression
RUN sed -i 's|/var/log/nginx/error.log|/dev/stderr|' \
    /etc/nginx/nginx.conf
RUN sed -i 's|/var/log/nginx/access.log|/dev/stdout|' \
    /etc/nginx/nginx.conf
RUN sed -i '/index.html;/ a \
            gzip on; \
            gzip_proxied no-cache no-store private expired auth; \
            gzip_min_length 1000; \
            gunzip on;' \
    /etc/nginx/conf.d/default.conf
# Add expire headers gzip and make sure 404s end up on index.html
RUN sed -i '/location \// a \
            # Send missing to 404.html \
            try_files $uri $uri/ /404.html; \
            # Enable gzip compression \
            gzip_static on; \
            gzip on; \
            gunzip on; \
            gzip_proxied no-cache no-store private expired auth; \
            gzip_types text/plain application/xml application/javascript image/svg+xml text/css image/png; \
            # Cache assets \
            if ($request_uri ~* ".(ico|css|js|gif|jpe?g|png|svg|ttf)$") {\
                expires 30d;\
                access_log off;\
                add_header Pragma public;\
                add_header Cache-Control "public";\
                break;\
            }\
            gzip_min_length 1000;' \
    /etc/nginx/conf.d/default.conf

